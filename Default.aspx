<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 
    
    <title></title>
    <link rel="stylesheet" type="text/css" href="Css.css"/>


  
</head>
<body>
   <span><^%!     StripE !%^></span>

       
    <form id="form1" runat="server">

         
         <div id ="Red"><canvas id ="canvas" width="300" height="200"></canvas></div>

        <div id="Blue"   > <canvas  id="canvas2"  width="300" height="200"></canvas>  </div>



  

     
       
        <script>


            ////////////////////////////////////////////////////////////////////
            ///                 Moving Blue Div                             ///
            //////////////////////////////////////////////////////////////////

            var flag = true;


            setInterval(Move, 5);

            function Move() {
                var Blue = document.getElementById('Blue');


                if (flag == true) {
                    if (Blue.style.left != "300px")
                        Blue.style.left = ++Pos + 'px';
                    else
                        flag = false;
                }

                else {
                    if (Blue.style.left != "0px")
                        Blue.style.left = --Pos + 'px';
                    else
                        flag = true;
                }

            }







            ////////////////////////////////////////////////////////////////////
            ///                 Mouse states                                ///
            //////////////////////////////////////////////////////////////////
            // Circle's Objects  - moving dots
            // Objects   - Stores all moving dots
            // counter   - Each moving dot place counter
            // Pos       - Moving Blue div position counter
            // cc        - Global  getElement helper variable
            ///////////////////////////////////////////////////////////////
           
            var mousy = "up";
            
            var Objects = [];
            var Circles;
            var interval;
            var counter = 0;
            var Pos = 0;
            var cc;


            ////////////////////////////---MouseDown----//////////////////////////////
            var mousedown = document.onmousedown = function (e) {

                mousy = "down";
                Current = { 'xStart': e.clientX, 'yStart': e.clientY, 'BluePlace': document.getElementById('Blue').style.left };
                Objects = [];

                cc = e.target.id;


                if (e.target.id == 'canvas')
                    BuildCannon('canvas');
                if (e.target.id == 'canvas2')
                    BuildCannon('canvas2');

       



            };




      


            ////////////////////////////---MouseMove----//////////////////////////////

            var mousemove = document.onmousemove = function (e) {

                if (mousy == "down") {

                    clearInterval(interval);
                    Circles = {
                        'StartX': Current.xStart, 'StartY': Current.yStart, 'CurrentX': Current.xStart, 'CurrentY': Current.yStart, 'xPath': e.clientX, 'yPath': e.clientY, 'eq': e.clientY / e.clientX, 'flag': true, 'Counter'
                        : 0
                    };

                    
                    Objects.push(Circles);
                    interval = setInterval(MakeCanvas, 10);






                }


            };

            ////////////////////////////---MouseUp----//////////////////////////////
            var mouseup = document.onmouseup = function (e) {

                mousy = "up";
            };




            ////////////////////////////////////////////////////////////////////
            ///         Building main firing dot(zero shooting point)       ///
            //////////////////////////////////////////////////////////////////

            function BuildCannon(CanvasIn) {

                var c = document.getElementById('canvas');
                var ctx = c.getContext("2d");
                var c2 = document.getElementById('canvas2');
                var ctx2 = c2.getContext("2d");

                switch (CanvasIn) {


                    case 'canvas':
                        {
                            cc = 'canvas';


                            ctx2.clearRect(0, 0, c.width, c.height);


                            clearInterval(interval);
                            ctx.clearRect(0, 0, c.width, c.height);
                            ctx.beginPath();
                            ctx.arc(Current.xStart, Current.yStart, 7, 0, 2 * Math.PI, true);

                            ctx.fill();
                            ctx.stroke();
                            break;
                        }


                    case 'canvas2':
                        {


                            ctx.clearRect(0, 0, c.width, c.height);
                            ctx2.clearRect(0, 0, c.width, c.height);

                            cc = 'canvas2';

                            clearInterval(interval);

                            ctx2.beginPath();
                            var dx = parseInt(Current.xStart) - parseInt(Current.BluePlace);
                            ctx2.arc(dx, Current.yStart - 260, 7, 0, 2 * Math.PI, true);
                            ctx2.fill();
                            ctx2.stroke();
                            break;
                        }

                }


            }


            ////////////////////////////////////////////////////////////////////
            ///             Create canvas and moving dots                   ///
            //////////////////////////////////////////////////////////////////


            function MakeCanvas() {

                try {
                    var c = document.getElementById(cc);
                    var ctx = c.getContext("2d");
                    ctx.clearRect(0, 0, c.width, c.height);
                    ctx.beginPath();
                    var dxb = parseInt(Current.xStart) - parseInt(Current.BluePlace);
              
                if (cc == 'canvas2') {
                    ctx.arc(dxb, Current.yStart -260, 7, 0, 2 * Math.PI, true);
                }

                else
                    ctx.arc(Current.xStart, Current.yStart, 7, 0, 2 * Math.PI, true);
                
                ctx.fill();
                ctx.stroke();


           





                    ////Iterating Objects (all moving dots)

                for (var i = 0 ; i < Objects.length; i++) {

                 
                    

                    ctx.beginPath();
                    if (cc == 'canvas2') {
                        ctx.arc(Objects[i].CurrentX - parseInt(Current.BluePlace), Objects[i].CurrentY - 260, 3, 0, 2 * Math.PI, true);

                    }
                    else {
                        ctx.arc(Objects[i].CurrentX, Objects[i].CurrentY, 3, 0, 2 * Math.PI, true);
                    }
                        ctx.fill();
                        ctx.stroke();
                        var dx = (Objects[i].xPath - Current.xStart);
                        var dy = Objects[i].yPath - Objects[i].StartY;
                        var Yeter = Math.sqrt(dx * dx + dy * dy);
                        Objects[i].Counter += 0.01;
                      
                        
                            Objects[i].CurrentX += Objects[i].Counter * (dx / Yeter);
                            Objects[i].CurrentY += Objects[i].Counter * (dy / Yeter);

                        

                    

                }
                } catch (err) {
                    var c = document.getElementById('canvas');
                    c.getContext("2d").clearRect(0, 0, c.width, c.height);

                    var c2 = document.getElementById('canvas2');
                    c2.getContext("2d").clearRect(0, 0, c2.width, c2.height);

                };

            }



            </script>
   
    </form>
</body>
</html>
