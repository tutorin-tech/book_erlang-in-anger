all: epub pdf

html: html/index.html

html/index.html: text.tex
	sed 's/\t/    /g' text.tex > text-for-ht.tex
	make4ht --shell-escape --utf8 --format html5 --output-dir html text-for-ht.tex "fn-in"
	mv text-for-ht.html html/index.html
	mv text-for-ht.css html/style.css
	cp graphics/* html/
	rm -f *.aux text-for-ht.* graphics/*-.png

epub: html
	pandoc \
	--resource-path=html \
	--standalone \
	--css=html/style.css \
	--css=text.css \
	--to epub3 \
	html/index.html \
	--epub-title-page=false \
	--epub-cover-image graphics/cover.png \
	--metadata title="Stuff Goes Bad: Erlang in Anger" \
	--output Stuff_Goes_Bad_Erlang_in_Anger.epub

pdf: text.tex
	pdflatex --jobname=Stuff_Goes_Bad_Erlang_in_Anger text.tex
	rm -f *.aux Stuff_Goes_Bad_Erlang_in_Anger.lof Stuff_Goes_Bad_Erlang_in_Anger.log Stuff_Goes_Bad_Erlang_in_Anger.toc

clean:
	rm -rf html *.epub *.pdf

.PHONY: html
