PImage start1, start2, bg1, bg2, end1,end2,enemy,fighter,hp,treasure;
float bg1X,bg2X,hpRate=0.2,fighterX,fighterY,treasureX,treasureY,enemyX,enemyY;
final int game_start = 1, game_run = 2, game_lose = 3;
int gameState;

void setup () {
 start1 = loadImage("img/start1.png");
 start2 = loadImage("img/start2.png");
 bg1 = loadImage("img/bg1.png");
 bg2 = loadImage("img/bg2.png");
 end1 = loadImage("img/end1.png");
 end2 = loadImage("img/end2.png");
 enemy = loadImage("img/enemy.png");
 fighter = loadImage("/img/fighter.png");
 hp = loadImage("img/hp.png");
 treasure = loadImage("img/treasure.png");
  size(640, 480) ;
   bg1X=0;
   bg2X=-640;
 fighterX=width-52;  
 fighterY=floor(random(20,460)); 
 treasureX=floor(random(30,460));
 treasureY=floor(random(30,450));
 enemyX=0;
 enemyY=floor(random(30,450));
 gameState = game_start;
}

void draw() {
  
 //rect(205,376,253,40);//the area to click to start
 image(start1,0,0);
 switch(gameState){
   case(game_start):
     if(mouseX>=205&&mouseX<=458&&mouseY>=376&&mouseY<=416)
     if(mousePressed) gameState=game_run;
      break;
 
   case(game_run): 
     background(0);
     image(bg1,bg1X++,0);
     if(bg1X>=640) bg1X = -640;
     image(bg2,bg2X++,0);
     if(bg2X>=640) bg2X= -640;
     // hp bar
     noStroke();
     fill(#FF0000);
     rect(35,35,200*hpRate,25);
     image(hp,30,30);//hp bar area
     if(hpRate<=0) {
       hpRate=0;
       gameState=game_lose;
     }
     //fighter appears
     image(fighter,fighterX,fighterY);
     //fighter controlling
     if(mousePressed) {
     fighterX = mouseX;
     fighterY = mouseY;
     }
     //treasure appears
     image(treasure,treasureX,treasureY);
     //enemy appears
     image(enemy,enemyX,enemyY);
   
     //enemy tries to attack fighter
     if(enemyX<=width)
     {
     enemyX+=4;
     if(enemyY<=fighterY) enemyY+=2;
     if(enemyY>=fighterY) enemyY-=2;
     if(enemyX>=width) 
     {
       enemyX=0;
       enemyY=floor(random(30,450));
       }
     }
   
     //enemy touched the fighter
     if((fighterX>=enemyX)&&(fighterX<=enemyX+61)&&(fighterY>=enemyY)&&(fighterY<=enemyY+61)) {
     hpRate=hpRate-0.2;
     
     enemyX=0;
     enemyY=floor(random(30,450));
     }
     //fighter eats treasure
     if((fighterX>=treasureX)&&(fighterX<=treasureX+41)&&(fighterY>=treasureY)&&(fighterY<=treasureY+41))
     { if(hpRate>=1) hpRate = 1;
     
      if(hpRate<1) hpRate = hpRate + 0.1;
     treasureX=floor(random(320,460));
     treasureY=floor(random(30,450));
     
     }
     break;
   
  case(game_lose):
    image(start2,0,0);
    if(mouseX>=205&&mouseX<=458&&mouseY>=376&&mouseY<=416)
    if(mousePressed) {
    hpRate=0.2;
    gameState=game_run;
    }
     break;
     }
}
