% Definir la función PWM
f_pwm = 100000;
T_pwm = 1.0 / f_pwm;
tspan = [0 0.01];

% Función PWM
d = @(t) mod(t, T_pwm) < ciclo * T_pwm;

% Definir el sistema de ecuaciones diferenciales
function dxdt = cdcd_system(t, x)
    L = 0.002;
    R = 10;
    C = 0.00001;
    Uin = 32;
    f_pwm = 100000;
    step = 1;

    T_pwm = 1.0 / f_pwm;
    d = @(t) mod(t, T_pwm) < step * T_pwm;
    
    iL = x(1);
    Vc = x(2);
    dxdt = [
        (-1.0/L) * Vc + (Uin/L) * d(t);
        (1.0/C) * iL - (1.0/(R*C)) * Vc
    ];
end

% Condiciones iniciales
x0 = [0.0; 0.0];

% Usar ODE45 para resolver
[t, x] = ode45(@cdcd_system, tspan, x0);

% Graficar resultados
figure;

subplot(2, 1, 1);
plot(t, x(:, 1), 'LineWidth', 1.5);
title('Corriente en la inductancia iL(t)');
xlabel('Tiempo (s)');
ylabel('iL (A)');
grid on;

subplot(2, 1, 2);
plot(t, x(:, 2), 'LineWidth', 1.5);
title('Voltaje en el condensador Vc(t)');
xlabel('Tiempo (s)');
ylabel('Vc (V)');
grid on;



