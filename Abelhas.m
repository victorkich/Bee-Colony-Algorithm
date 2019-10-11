% Victor Augusto Kich

funcao = @(x1,x2) 100*(x2-x1^2)^2 + (1-x1)^2;

num_abelhas = 50;
num_pontos = 5;

abelhas_x = 0;
abelhas_y = 0;

abelhas_score = 0;
score = 0;

plotx = NaN;
ploty = NaN;

cont = 0;
while cont ~=  num_abelhas
    cont = cont + 1;
    abelhas_x = [abelhas_x rand(1)*100];
    abelhas_y = [abelhas_y rand(1)*100];
    
    pontos = 0;
    abelhas_score(cont) = 0;
    while pontos ~= num_pontos
        pontos = pontos + 1;
        new_x = abelhas_x(cont)+(rand(1)*5)-(rand(1)*5);
        new_y = abelhas_y(cont)+(rand(1)*5)-(rand(1)*5);
        new_test = funcao(new_x, new_y);
        
        if new_test > abelhas_score(cont) 
            score = new_test;
            abelhas_score(cont) = score;
        end
    end
end

iteracao = 0;
while 1
iteracao = iteracao + 1;

soma = sum(abelhas_score);
pontos = num_abelhas;
novos_pontos = 0;

cont = 0;
while cont ~= num_abelhas
   cont = cont + 1;
   cont2 = 0;
   NA = 0;
   while 1
       cont2 = cont2 + 1;
       %cont2
       %abelhas_score
       probabilidade = (abelhas_score(cont2)/soma)*100;
       aleatorio = rand(1)*100;
       %probabilidade
       if probabilidade >= aleatorio
           novos_pontos = [novos_pontos cont2];
           break;
       end
       if cont2 == pontos
           cont2 = 0;
       end
       
   end
end

cont = 1;
new_abelhas_x = 0;
new_abelhas_y = 0;
while cont ~= num_abelhas
    cont = cont + 1;
    new_abelhas_x = [new_abelhas_x abelhas_x(novos_pontos(cont))];
    new_abelhas_y = [new_abelhas_y abelhas_y(novos_pontos(cont))];
end

novos_pontos = novos_pontos(~ismember(novos_pontos, [0]));
pontos = categorical(novos_pontos);
pontos = categories(pontos);
pontos
    
tamanho_pontos = size(pontos);
tamanho_pontos = tamanho_pontos(1)

abb = abelhas_score;
cont = 0;
while cont ~= num_abelhas
    cont = cont + 1;
    abelhas_score(cont) = 0;
end

flag = 1;
cont = 0;
contg = 1;
while cont ~= tamanho_pontos
    cont = cont + 1;
    abelhas_no_ponto = size(novos_pontos(novos_pontos == cont));
    abelhas_no_ponto = abelhas_no_ponto(2);
    cont2 = 1;
    while cont2 ~= (abelhas_no_ponto+1)
        cont2 = cont2 + 1;
        new_x = new_abelhas_x(contg)+(rand(1)*5)-(rand(1)*5);
        new_y = new_abelhas_y(contg)+(rand(1)*5)-(rand(1)*5);
        new_test = funcao(new_x, new_y);
        
        if new_test > abb(contg) 
            score = new_test;
            flag = 0;
            abelhas_score(contg) = score;
        end
        contg = contg + 1;
    end  
end

plotx = [plotx new_abelhas_x];
ploty = [ploty new_abelhas_y];

if flag == 1
   break; 
end

end

iteracao

uniqueX = unique(new_abelhas_x(:,:));
valcontX = hist(new_abelhas_x(:,:) , uniqueX);
[value index] = max(valcontX);
x = uniqueX(index)

uniqueY = unique(new_abelhas_y(:,:));
valcontY = hist(new_abelhas_y(:,:) , uniqueY);
[value index] = max(valcontY);
y = uniqueY(index)

valor = funcao(x,y)

[value tamanho] = size(plotx);
plotz = 0;
cont = 0;
while cont ~= tamanho
   cont = cont + 1;
   plotz = [plotz funcao(plotx(cont), ploty(cont))];
end

plotz = plotz(~ismember(plotz, [0]));
plot3(plotx, ploty, plotz, 'o');
