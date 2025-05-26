import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              PageProduct(),
            ],
          ),
        ),
      ),
    );
  }
}

class PageProduct extends StatefulWidget {
  const PageProduct({super.key});

  @override
  State<PageProduct> createState() => _PageProductState();
}

class _PageProductState extends State<PageProduct> {
  String dropdownValue1 = 'Value';
  String dropdownValue2 = 'Value';
  bool isLiked = false;
  final TextEditingController _controller = TextEditingController();
  String? savedNote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://placehold.co/375x327.png',
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black.withOpacity(0.7),
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Text Heading',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFCFF7D3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Tag',
              style: TextStyle(color: Color(0xFF02542D)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                '\$',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 4),
              Text(
                '50',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Text',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _DropdownField(
            label: 'Label',
            value: dropdownValue1,
            onChanged: (value) {
              setState(() {
                dropdownValue1 = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          _DropdownField(
            label: 'Label',
            value: dropdownValue2,
            onChanged: (value) {
              setState(() {
                dropdownValue2 = value!;
              });
            },
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Write something...',
              alignLabelWithHint: true,
              hintText: 'Type your message here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C2C2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  savedNote = _controller.text;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Note saved!')),
                );
              },
              child: const Text(
                'Save Note',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (savedNote != null && savedNote!.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF757575)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white10,
              ),
              child: Text(
                'Saved Note:\n$savedNote',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String value;
  final void Function(String?) onChanged;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: const [
            DropdownMenuItem(value: 'Value', child: Text('Value')),
            DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
            DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
