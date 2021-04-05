import 'package:calculator/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _controller = CalculatorController();
  String _showingOperation = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDisplayShowOperation(text: _showingOperation),
          _buildDisplay(text: _controller.result),
          Divider(
            color: Colors.white,
          ),
          _buildKeyBoard(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Calculadora',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.deepOrange,
          ),
          onPressed: () => share(),
        )
      ],
    );
  }

  void share() {
    Share.share('Projetos: https://github.com/volmirjr');
  }

  Widget _buildDisplay({String text}) {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Text(
          text ?? '0',
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.white,
            fontSize: 55,
            fontFamily: 'Calculator',
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayShowOperation({String text}) {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Text(
          text ?? '0',
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'Calculator',
          ),
        ),
      ),
    );
  }

  Widget _buildKeyBoard() {
    return Container(
        height: 400,
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(label: 'AC', color: Colors.deepOrange),
                  _buildButton(label: 'DEL', color: Colors.deepOrange),
                  _buildButton(label: '%', color: Colors.deepOrange),
                  _buildButton(label: '/', color: Colors.deepOrange),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(label: '7'),
                  _buildButton(label: '8'),
                  _buildButton(label: '9'),
                  _buildButton(label: 'x', color: Colors.deepOrange),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(label: '4'),
                  _buildButton(label: '5'),
                  _buildButton(label: '6'),
                  _buildButton(label: '+', color: Colors.deepOrange),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(label: '1'),
                  _buildButton(label: '2'),
                  _buildButton(label: '3'),
                  _buildButton(label: '-', color: Colors.deepOrange),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(label: '0', flex: 2),
                  _buildButton(label: ','),
                  _buildButton(label: '=', color: Colors.deepOrange),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildButton({String label, int flex = 1, Color color = Colors.white}) {
    return Expanded(
      flex: flex,
      child: RaisedButton(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: color,
            ),
          ),
          color: Colors.black,
          onPressed: () {
            setState(() {
              _calculatorLogic(label);
              _showOperation(label);
            });
          }),
    );
  }

  _showOperation(String label) {
    final length = _showingOperation.length;
    if (label == 'AC') {
      _showingOperation = '';
    } else if (label == 'DEL') {
      if (length > 1) {
        _showingOperation = _showingOperation.substring(0, length - 1);
      } else {
        _showingOperation = '';
      }
    } else if (label == '=') {
      _showingOperation += label + _controller.result;
    } else {
      _showingOperation += label;
    }
  }

  _calculatorLogic(String label) {
    _controller.applyCommand(label);
  }
}
