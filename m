Return-Path: <sam@ravnborg.org>
X-Google-Smtp-Source: AB8JxZpJpC3ZGJ5owVcVOKN2wdyL6ZfcUWnUY2XyeRmct144JkliAFRlLxrDpph2IGU7OBa3WYqz
ARC-Seal: i=1; a=rsa-sha256; t=1527018570; cv=none;
        d=google.com; s=arc-20160816;
        b=mm0a7+IPmOdFwIo4iZxjZmyFw8sTgM3NxBP2lIzWb6rFtrtEZFqogq2MBmqGHVL8wr
         4OOuWVse4BYBxM8999zNf3BY53PNwvpe/1l+tIiL/uPheb4Z5hjjl3tSQE2nYjpLve3u
         CfxJI9cF5eiuZ1cmF2pZ7s9Mh+eXIVICuVsd4LBo3MsM/3kic+Qjt/x4u8lkqYMtVFgf
         N3Mrk5a7fXnJnG5gFyqlB1LIgPDFZhx7LfiYKYZI1Aj6S45jScutzklhg5X3gnycVxXr
         eBBna4vJikICWwl+vG9jDho3u6HNC4hP4UUAXPYQb75MMC9Xab7ifN0TVLOPEcmYEiB6
         7lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:arc-authentication-results;
        bh=PD+ARaH2yYiBm8XOe0xgVJt9Fl5FZqqk3MrP2MgAZd8=;
        b=QLz9etx5aQ1eUkmQT9sjAA89M+pet9xmoRFf534/jCJApXk2KAqk6lE+kRURmhkLS8
         Fg7n2Vtld/bZG1M2pKF3iarikVrYMcC3lZaVUiZ9BJhv01aL8K5sdad3SzAjudndQDYJ
         RKTZ9Lxu9U9PrHLCSWIhs8+7VJUO+OtTCvMRodKlxlv2r/ynQ9oCU9JUQl2zPT/FYu9o
         ZbN6pK4/WuvR477jCibbPWUC35iryM1LSZhfGcIBTaQsmgokvsBgXxLthSf1XiDW/JBs
         5LjBucYPTdFRERzO/JSUajEiz1ta2ObMUWr+dA0PXP/wSjEYyaGY+uxgrkTQx/DGQng9
         qYLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Date: Tue, 22 May 2018 21:49:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kbuild@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
	Michal Marek <michal.lkml@markovi.net>
Subject: [RFC PATCH 1/1] kconfig: drop localization support
Message-ID: <20180522194928.GA29900@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
	a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
	a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=c-n4J4-pAAAA:8 a=GesxV3utAAAA:8
	a=inoG4m36AAAA:8 a=Xie9NPzdAAAA:8 a=tBb2bbeoAAAA:8 a=pGLkceISAAAA:8
	a=VwQbUJbxAAAA:8 a=EWZ8g9oewqFsJggY5hMA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
	a=k-upJDkdfJYGHzUm:21 a=tMnhTCXOOePNSUeY:21 a=jgQOzURZBj6flGnG:21
	a=CjuIK1q_8ugA:10 a=dPUuVCEKqe8A:10 a=E9Po1WZjFZOl8hwRPBS3:22
	a=L0NDqeB7ZLmQzAogN4cw:22 a=uk6sXpt3-L7zBD3mjNla:22
	a=_Qgj-RFg6mImvLaOgLPg:22 a=vUoOGYJDS1_Kmot3Fv_X:22
	a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601195024335317921?=
X-GMAIL-MSGID: =?utf-8?q?1601195024335317921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>From b243b06da1417efe01ca7041371f4597584f8a10 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 May 2018 21:36:12 +0200
Subject: [PATCH 1/1] kconfig: drop localization support

The localization support is broken and appears unused.
There is no google hits on the update-po-config target.
And there is no recent (5 years) activity related to the localization.

So lets just drop this as it is no longer used.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

The patch is on top of the series "kconfig: refactor package checks for GUI frontends"
It was triggerd by a comment by Masahiro.

I have compile time checked all targets - and checkted that they starts.
diffstat looks nice, and the simplification of the Makefile was worth it all.

I considered a stepwise approach, but changes are all simple so ended
up with this "all-in-one-go" approach.

	Sam

 scripts/kconfig/.gitignore           |   3 -
 scripts/kconfig/Makefile             |  42 +------
 scripts/kconfig/POTFILES.in          |  12 --
 scripts/kconfig/check.sh             |  14 ---
 scripts/kconfig/conf.c               |  51 ++++----
 scripts/kconfig/confdata.c           |   4 +-
 scripts/kconfig/gconf.c              |  46 ++++---
 scripts/kconfig/kxgettext.c          | 235 -----------------------------------
 scripts/kconfig/lkc.h                |  14 ---
 scripts/kconfig/lxdialog/checklist.c |   4 +-
 scripts/kconfig/lxdialog/dialog.h    |   6 -
 scripts/kconfig/lxdialog/inputbox.c  |   4 +-
 scripts/kconfig/lxdialog/menubox.c   |  10 +-
 scripts/kconfig/lxdialog/textbox.c   |   2 +-
 scripts/kconfig/lxdialog/yesno.c     |   4 +-
 scripts/kconfig/mconf.c              | 141 ++++++++++-----------
 scripts/kconfig/menu.c               |  20 +--
 scripts/kconfig/nconf.c              | 148 +++++++++++-----------
 scripts/kconfig/nconf.h              |   1 -
 scripts/kconfig/qconf.cc             | 104 +++++++---------
 scripts/kconfig/zconf.y              |   2 +-
 21 files changed, 257 insertions(+), 610 deletions(-)
 delete mode 100644 scripts/kconfig/POTFILES.in
 delete mode 100755 scripts/kconfig/check.sh
 delete mode 100644 scripts/kconfig/kxgettext.c

diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index 2da579edcbaf..54266f3bef6b 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -2,8 +2,6 @@
 # Generated files
 #
 *.moc
-gconf.glade.h
-*.pot
 *.mo
 
 #
@@ -14,4 +12,3 @@ mconf
 nconf
 qconf
 gconf
-kxgettext
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index e4ac102068c1..da6ae2565ccc 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -55,29 +55,6 @@ localyesconfig localmodconfig: $(obj)/conf
 	fi
 	$(Q)rm -f .tmp.config
 
-# Create new linux.pot file
-# Adjust charset to UTF-8 in .po file to accept UTF-8 in Kconfig files
-update-po-config: $(obj)/kxgettext $(obj)/gconf.glade.h
-	$(Q)$(kecho) "  GEN     config.pot"
-	$(Q)xgettext --default-domain=linux                         \
-	    --add-comments --keyword=_ --keyword=N_                 \
-	    --from-code=UTF-8                                       \
-	    --files-from=$(srctree)/scripts/kconfig/POTFILES.in     \
-	    --directory=$(srctree) --directory=$(objtree)           \
-	    --output $(obj)/config.pot
-	$(Q)sed -i s/CHARSET/UTF-8/ $(obj)/config.pot
-	$(Q)(for i in `ls $(srctree)/arch/*/Kconfig      \
-	    $(srctree)/arch/*/um/Kconfig`;               \
-	    do                                           \
-		$(kecho) "  GEN     $$i";                    \
-		$(obj)/kxgettext $$i                     \
-		     >> $(obj)/config.pot;               \
-	    done )
-	$(Q)$(kecho) "  GEN     linux.pot"
-	$(Q)msguniq --sort-by-file --to-code=UTF-8 $(obj)/config.pot \
-	    --output $(obj)/linux.pot
-	$(Q)rm -f $(obj)/config.pot
-
 # These targets map 1:1 to the commandline options of 'conf'
 simple-targets := oldconfig allnoconfig allyesconfig allmodconfig \
 	alldefconfig randconfig listnewconfig olddefconfig
@@ -179,19 +156,11 @@ help:
 # object files used by all kconfig flavours
 
 conf-objs	:= conf.o  zconf.tab.o
-kxgettext-objs	:= kxgettext.o zconf.tab.o
 
-hostprogs-y := conf kxgettext
+hostprogs-y := conf
 
 targets		+= zconf.lex.c
-clean-files	+= gconf.glade.h
-clean-files     += config.pot linux.pot
-
-# Add environment specific flags
-HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCC) $(HOSTCFLAGS)) \
-		    -DLOCALE
-HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCXX) $(HOSTCXXFLAGS)) \
-		    -DLOCALE
+
 # generated files seem to need this to find local include files
 HOSTCFLAGS_zconf.lex.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
@@ -244,13 +213,6 @@ $(obj)/gconf.o: $(obj)/.gconf-cfg
 
 $(obj)/zconf.tab.o: $(obj)/zconf.lex.c
 
-# Extract gconf menu items for i18n support
-quiet_cmd_intl = INTL    $@
-      cmd_intl = intltool-extract --type=gettext/glade --srcdir=$(srctree) $<
-
-$(obj)/gconf.glade.h: $(obj)/gconf.glade
-	$(call cmd,intl)
-
 # check if necessary packages are available, and configure build flags
 define filechk_conf_cfg
 	$(CONFIG_SHELL) $<
diff --git a/scripts/kconfig/POTFILES.in b/scripts/kconfig/POTFILES.in
deleted file mode 100644
index 967457396990..000000000000
--- a/scripts/kconfig/POTFILES.in
+++ /dev/null
@@ -1,12 +0,0 @@
-scripts/kconfig/lxdialog/checklist.c
-scripts/kconfig/lxdialog/inputbox.c
-scripts/kconfig/lxdialog/menubox.c
-scripts/kconfig/lxdialog/textbox.c
-scripts/kconfig/lxdialog/util.c
-scripts/kconfig/lxdialog/yesno.c
-scripts/kconfig/mconf.c
-scripts/kconfig/conf.c
-scripts/kconfig/confdata.c
-scripts/kconfig/gconf.c
-scripts/kconfig/gconf.glade.h
-scripts/kconfig/qconf.cc
diff --git a/scripts/kconfig/check.sh b/scripts/kconfig/check.sh
deleted file mode 100755
index 97f0fee7d173..000000000000
--- a/scripts/kconfig/check.sh
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Needed for systems without gettext
-$* -x c -o /dev/null - > /dev/null 2>&1 << EOF
-#include <libintl.h>
-int main()
-{
-	gettext("");
-	return 0;
-}
-EOF
-if [ ! "$?" -eq "0"  ]; then
-	echo -DKBUILD_NO_NLS;
-fi
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 283eeedaa4fa..671ff5364497 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -3,7 +3,6 @@
  * Released under the terms of the GNU GPL v2.0.
  */
 
-#include <locale.h>
 #include <ctype.h>
 #include <limits.h>
 #include <stdio.h>
@@ -86,7 +85,7 @@ static int conf_askvalue(struct symbol *sym, const char *def)
 	enum symbol_type type = sym_get_type(sym);
 
 	if (!sym_has_value(sym))
-		printf(_("(NEW) "));
+		printf("(NEW) ");
 
 	line[0] = '\n';
 	line[1] = 0;
@@ -133,7 +132,7 @@ static int conf_string(struct menu *menu)
 	const char *def;
 
 	while (1) {
-		printf("%*s%s ", indent - 1, "", _(menu->prompt->text));
+		printf("%*s%s ", indent - 1, "", menu->prompt->text);
 		printf("(%s) ", sym->name);
 		def = sym_get_string_value(sym);
 		if (sym_get_string_value(sym))
@@ -166,7 +165,7 @@ static int conf_sym(struct menu *menu)
 	tristate oldval, newval;
 
 	while (1) {
-		printf("%*s%s ", indent - 1, "", _(menu->prompt->text));
+		printf("%*s%s ", indent - 1, "", menu->prompt->text);
 		if (sym->name)
 			printf("(%s) ", sym->name);
 		putchar('[');
@@ -251,7 +250,7 @@ static int conf_choice(struct menu *menu)
 		case no:
 			return 1;
 		case mod:
-			printf("%*s%s\n", indent - 1, "", _(menu_get_prompt(menu)));
+			printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
 			return 0;
 		case yes:
 			break;
@@ -261,7 +260,7 @@ static int conf_choice(struct menu *menu)
 	while (1) {
 		int cnt, def;
 
-		printf("%*s%s\n", indent - 1, "", _(menu_get_prompt(menu)));
+		printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
 		def_sym = sym_get_choice_value(sym);
 		cnt = def = 0;
 		line[0] = 0;
@@ -269,7 +268,7 @@ static int conf_choice(struct menu *menu)
 			if (!menu_is_visible(child))
 				continue;
 			if (!child->sym) {
-				printf("%*c %s\n", indent, '*', _(menu_get_prompt(child)));
+				printf("%*c %s\n", indent, '*', menu_get_prompt(child));
 				continue;
 			}
 			cnt++;
@@ -278,14 +277,14 @@ static int conf_choice(struct menu *menu)
 				printf("%*c", indent, '>');
 			} else
 				printf("%*c", indent, ' ');
-			printf(" %d. %s", cnt, _(menu_get_prompt(child)));
+			printf(" %d. %s", cnt, menu_get_prompt(child));
 			if (child->sym->name)
 				printf(" (%s)", child->sym->name);
 			if (!sym_has_value(child->sym))
-				printf(_(" (NEW)"));
+				printf(" (NEW)");
 			printf("\n");
 		}
-		printf(_("%*schoice"), indent - 1, "");
+		printf("%*schoice", indent - 1, "");
 		if (cnt == 1) {
 			printf("[1]: 1\n");
 			goto conf_childs;
@@ -372,7 +371,7 @@ static void conf(struct menu *menu)
 			if (prompt)
 				printf("%*c\n%*c %s\n%*c\n",
 					indent, '*',
-					indent, '*', _(prompt),
+					indent, '*', prompt,
 					indent, '*');
 		default:
 			;
@@ -437,7 +436,7 @@ static void check_conf(struct menu *menu)
 				}
 			} else {
 				if (!conf_cnt++)
-					printf(_("*\n* Restart config...\n*\n"));
+					printf("*\n* Restart config...\n*\n");
 				rootEntry = menu_get_parent_menu(menu);
 				conf(rootEntry);
 			}
@@ -498,10 +497,6 @@ int main(int ac, char **av)
 	const char *name, *defconfig_file = NULL /* gcc uninit */;
 	struct stat tmpstat;
 
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-
 	tty_stdio = isatty(0) && isatty(1);
 
 	while ((opt = getopt_long(ac, av, "s", long_opts, NULL)) != -1) {
@@ -559,7 +554,7 @@ int main(int ac, char **av)
 		}
 	}
 	if (ac == optind) {
-		fprintf(stderr, _("%s: Kconfig file missing\n"), av[0]);
+		fprintf(stderr, "%s: Kconfig file missing\n", av[0]);
 		conf_usage(progname);
 		exit(1);
 	}
@@ -569,12 +564,12 @@ int main(int ac, char **av)
 	if (sync_kconfig) {
 		name = conf_get_configname();
 		if (stat(name, &tmpstat)) {
-			fprintf(stderr, _("***\n"
+			fprintf(stderr, "***\n"
 				"*** Configuration file \"%s\" not found!\n"
 				"***\n"
 				"*** Please run some configurator (e.g. \"make oldconfig\" or\n"
 				"*** \"make menuconfig\" or \"make xconfig\").\n"
-				"***\n"), name);
+				"***\n", name);
 			exit(1);
 		}
 	}
@@ -585,9 +580,9 @@ int main(int ac, char **av)
 			defconfig_file = conf_get_default_confname();
 		if (conf_read(defconfig_file)) {
 			fprintf(stderr,
-				_("***\n"
+				"***\n"
 				  "*** Can't find default configuration \"%s\"!\n"
-				  "***\n"),
+				  "***\n",
 				defconfig_file);
 			exit(1);
 		}
@@ -611,7 +606,7 @@ int main(int ac, char **av)
 		if ((strcmp(name, "") != 0) && (strcmp(name, "1") != 0)) {
 			if (conf_read_simple(name, S_DEF_USER)) {
 				fprintf(stderr,
-					_("*** Can't read seed configuration \"%s\"!\n"),
+					"*** Can't read seed configuration \"%s\"!\n",
 					name);
 				exit(1);
 			}
@@ -628,7 +623,7 @@ int main(int ac, char **av)
 		if (conf_read_simple(name, S_DEF_USER) &&
 		    conf_read_simple("all.config", S_DEF_USER)) {
 			fprintf(stderr,
-				_("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
+				"*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n",
 				name);
 			exit(1);
 		}
@@ -642,7 +637,7 @@ int main(int ac, char **av)
 			name = getenv("KCONFIG_NOSILENTUPDATE");
 			if (name && *name) {
 				fprintf(stderr,
-					_("\n*** The configuration requires explicit update.\n\n"));
+					"\n*** The configuration requires explicit update.\n\n");
 				return 1;
 			}
 		}
@@ -694,22 +689,22 @@ int main(int ac, char **av)
 		 * All other commands are only used to generate a config.
 		 */
 		if (conf_get_changed() && conf_write(NULL)) {
-			fprintf(stderr, _("\n*** Error during writing of the configuration.\n\n"));
+			fprintf(stderr, "\n*** Error during writing of the configuration.\n\n");
 			exit(1);
 		}
 		if (conf_write_autoconf()) {
-			fprintf(stderr, _("\n*** Error during update of the configuration.\n\n"));
+			fprintf(stderr, "\n*** Error during update of the configuration.\n\n");
 			return 1;
 		}
 	} else if (input_mode == savedefconfig) {
 		if (conf_write_defconfig(defconfig_file)) {
-			fprintf(stderr, _("n*** Error while saving defconfig to: %s\n\n"),
+			fprintf(stderr, "n*** Error while saving defconfig to: %s\n\n",
 				defconfig_file);
 			return 1;
 		}
 	} else if (input_mode != listnewconfig) {
 		if (conf_write(NULL)) {
-			fprintf(stderr, _("\n*** Error during writing of the configuration.\n\n"));
+			fprintf(stderr, "\n*** Error during writing of the configuration.\n\n");
 			exit(1);
 		}
 	}
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index df26c7b0fe13..569217168e96 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -277,7 +277,7 @@ int conf_read_simple(const char *name, int def)
 			name = conf_expand_value(prop->expr->left.sym->name);
 			in = zconf_fopen(name);
 			if (in) {
-				conf_message(_("using defaults found in %s"),
+				conf_message("using defaults found in %s",
 					 name);
 				goto load;
 			}
@@ -831,7 +831,7 @@ int conf_write(const char *name)
 			return 1;
 	}
 
-	conf_message(_("configuration written to %s"), newname);
+	conf_message("configuration written to %s", newname);
 
 	sym_set_change_count(0);
 
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index cfddddb9c9d7..610c4ab54d76 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -137,7 +137,7 @@ void init_main_window(const gchar * glade_file)
 
 	xml = glade_xml_new(glade_file, "window1", NULL);
 	if (!xml)
-		g_error(_("GUI loading failed !\n"));
+		g_error("GUI loading failed !\n");
 	glade_xml_signal_autoconnect(xml);
 
 	main_wnd = glade_xml_get_widget(xml, "window1");
@@ -233,7 +233,7 @@ void init_left_tree(void)
 
 	column = gtk_tree_view_column_new();
 	gtk_tree_view_append_column(view, column);
-	gtk_tree_view_column_set_title(column, _("Options"));
+	gtk_tree_view_column_set_title(column, "Options");
 
 	renderer = gtk_cell_renderer_toggle_new();
 	gtk_tree_view_column_pack_start(GTK_TREE_VIEW_COLUMN(column),
@@ -276,7 +276,7 @@ void init_right_tree(void)
 
 	column = gtk_tree_view_column_new();
 	gtk_tree_view_append_column(view, column);
-	gtk_tree_view_column_set_title(column, _("Options"));
+	gtk_tree_view_column_set_title(column, "Options");
 
 	renderer = gtk_cell_renderer_pixbuf_new();
 	gtk_tree_view_column_pack_start(GTK_TREE_VIEW_COLUMN(column),
@@ -305,7 +305,7 @@ void init_right_tree(void)
 
 	renderer = gtk_cell_renderer_text_new();
 	gtk_tree_view_insert_column_with_attributes(view, -1,
-						    _("Name"), renderer,
+						    "Name", renderer,
 						    "text", COL_NAME,
 						    "foreground-gdk",
 						    COL_COLOR, NULL);
@@ -329,7 +329,7 @@ void init_right_tree(void)
 						    COL_COLOR, NULL);
 	renderer = gtk_cell_renderer_text_new();
 	gtk_tree_view_insert_column_with_attributes(view, -1,
-						    _("Value"), renderer,
+						    "Value", renderer,
 						    "text", COL_VALUE,
 						    "editable",
 						    COL_EDIT,
@@ -368,7 +368,7 @@ static void text_insert_help(struct menu *menu)
 {
 	GtkTextBuffer *buffer;
 	GtkTextIter start, end;
-	const char *prompt = _(menu_get_prompt(menu));
+	const char *prompt = menu_get_prompt(menu);
 	struct gstr help = str_new();
 
 	menu_get_ext_help(menu, &help);
@@ -422,7 +422,7 @@ gboolean on_window1_delete_event(GtkWidget * widget, GdkEvent * event,
 	if (!conf_get_changed())
 		return FALSE;
 
-	dialog = gtk_dialog_new_with_buttons(_("Warning !"),
+	dialog = gtk_dialog_new_with_buttons("Warning !",
 					     GTK_WINDOW(main_wnd),
 					     (GtkDialogFlags)
 					     (GTK_DIALOG_MODAL |
@@ -436,7 +436,7 @@ gboolean on_window1_delete_event(GtkWidget * widget, GdkEvent * event,
 	gtk_dialog_set_default_response(GTK_DIALOG(dialog),
 					GTK_RESPONSE_CANCEL);
 
-	label = gtk_label_new(_("\nSave configuration ?\n"));
+	label = gtk_label_new("\nSave configuration ?\n");
 	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), label);
 	gtk_widget_show(label);
 
@@ -496,7 +496,7 @@ load_filename(GtkFileSelection * file_selector, gpointer user_data)
 					     (user_data));
 
 	if (conf_read(fn))
-		text_insert_msg(_("Error"), _("Unable to load configuration !"));
+		text_insert_msg("Error", "Unable to load configuration !");
 	else
 		display_tree(&rootmenu);
 }
@@ -505,7 +505,7 @@ void on_load1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkWidget *fs;
 
-	fs = gtk_file_selection_new(_("Load file..."));
+	fs = gtk_file_selection_new("Load file...");
 	g_signal_connect(GTK_OBJECT(GTK_FILE_SELECTION(fs)->ok_button),
 			 "clicked",
 			 G_CALLBACK(load_filename), (gpointer) fs);
@@ -524,7 +524,7 @@ void on_load1_activate(GtkMenuItem * menuitem, gpointer user_data)
 void on_save_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	if (conf_write(NULL))
-		text_insert_msg(_("Error"), _("Unable to save configuration !"));
+		text_insert_msg("Error", "Unable to save configuration !");
 }
 
 
@@ -537,7 +537,7 @@ store_filename(GtkFileSelection * file_selector, gpointer user_data)
 					     (user_data));
 
 	if (conf_write(fn))
-		text_insert_msg(_("Error"), _("Unable to save configuration !"));
+		text_insert_msg("Error", "Unable to save configuration !");
 
 	gtk_widget_destroy(GTK_WIDGET(user_data));
 }
@@ -546,7 +546,7 @@ void on_save_as1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkWidget *fs;
 
-	fs = gtk_file_selection_new(_("Save file as..."));
+	fs = gtk_file_selection_new("Save file as...");
 	g_signal_connect(GTK_OBJECT(GTK_FILE_SELECTION(fs)->ok_button),
 			 "clicked",
 			 G_CALLBACK(store_filename), (gpointer) fs);
@@ -639,7 +639,7 @@ on_set_option_mode3_activate(GtkMenuItem *menuitem, gpointer user_data)
 void on_introduction1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
-	const gchar *intro_text = _(
+	const gchar *intro_text = 
 	    "Welcome to gkc, the GTK+ graphical configuration tool\n"
 	    "For each option, a blank box indicates the feature is disabled, a\n"
 	    "check indicates it is enabled, and a dot indicates that it is to\n"
@@ -654,7 +654,7 @@ void on_introduction1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	    "option.\n"
 	    "\n"
 	    "Toggling Show Debug Info under the Options menu will show \n"
-	    "the dependencies, which you can then match by examining other options.");
+	    "the dependencies, which you can then match by examining other options.";
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
 					GTK_DIALOG_DESTROY_WITH_PARENT,
@@ -671,8 +671,8 @@ void on_about1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
 	const gchar *about_text =
-	    _("gkc is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
-	      "Based on the source code from Roman Zippel.\n");
+	    "gkc is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
+	      "Based on the source code from Roman Zippel.\n";
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
 					GTK_DIALOG_DESTROY_WITH_PARENT,
@@ -689,9 +689,9 @@ void on_license1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
 	const gchar *license_text =
-	    _("gkc is released under the terms of the GNU GPL v2.\n"
+	    "gkc is released under the terms of the GNU GPL v2.\n"
 	      "For more information, please see the source code or\n"
-	      "visit http://www.fsf.org/licenses/licenses.html\n");
+	      "visit http://www.fsf.org/licenses/licenses.html\n";
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
 					GTK_DIALOG_DESTROY_WITH_PARENT,
@@ -1049,7 +1049,7 @@ static gchar **fill_row(struct menu *menu)
 	bzero(row, sizeof(row));
 
 	row[COL_OPTION] =
-	    g_strdup_printf("%s %s", _(menu_get_prompt(menu)),
+	    g_strdup_printf("%s %s", menu_get_prompt(menu),
 			    sym && !sym_has_value(sym) ? "(NEW)" : "");
 
 	if (opt_mode == OPT_ALL && !menu_is_visible(menu))
@@ -1102,7 +1102,7 @@ static gchar **fill_row(struct menu *menu)
 
 		if (def_menu)
 			row[COL_VALUE] =
-			    g_strdup(_(menu_get_prompt(def_menu)));
+			    g_strdup(menu_get_prompt(def_menu));
 	}
 	if (sym->flags & SYMBOL_CHOICEVAL)
 		row[COL_BTNRAD] = GINT_TO_POINTER(TRUE);
@@ -1447,10 +1447,6 @@ int main(int ac, char *av[])
 	char *env;
 	gchar *glade_file;
 
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	bind_textdomain_codeset(PACKAGE, "UTF-8");
-	textdomain(PACKAGE);
-
 	/* GTK stuffs */
 	gtk_set_locale();
 	gtk_init(&ac, &av);
diff --git a/scripts/kconfig/kxgettext.c b/scripts/kconfig/kxgettext.c
deleted file mode 100644
index 240880a89111..000000000000
--- a/scripts/kconfig/kxgettext.c
+++ /dev/null
@@ -1,235 +0,0 @@
-/*
- * Arnaldo Carvalho de Melo <acme@conectiva.com.br>, 2005
- *
- * Released under the terms of the GNU GPL v2.0
- */
-
-#include <stdlib.h>
-#include <string.h>
-
-#include "lkc.h"
-
-static char *escape(const char* text, char *bf, int len)
-{
-	char *bfp = bf;
-	int multiline = strchr(text, '\n') != NULL;
-	int eol = 0;
-	int textlen = strlen(text);
-
-	if ((textlen > 0) && (text[textlen-1] == '\n'))
-		eol = 1;
-
-	*bfp++ = '"';
-	--len;
-
-	if (multiline) {
-		*bfp++ = '"';
-		*bfp++ = '\n';
-		*bfp++ = '"';
-		len -= 3;
-	}
-
-	while (*text != '\0' && len > 1) {
-		if (*text == '"')
-			*bfp++ = '\\';
-		else if (*text == '\n') {
-			*bfp++ = '\\';
-			*bfp++ = 'n';
-			*bfp++ = '"';
-			*bfp++ = '\n';
-			*bfp++ = '"';
-			len -= 5;
-			++text;
-			goto next;
-		}
-		else if (*text == '\\') {
-			*bfp++ = '\\';
-			len--;
-		}
-		*bfp++ = *text++;
-next:
-		--len;
-	}
-
-	if (multiline && eol)
-		bfp -= 3;
-
-	*bfp++ = '"';
-	*bfp = '\0';
-
-	return bf;
-}
-
-struct file_line {
-	struct file_line *next;
-	const char *file;
-	int lineno;
-};
-
-static struct file_line *file_line__new(const char *file, int lineno)
-{
-	struct file_line *self = malloc(sizeof(*self));
-
-	if (self == NULL)
-		goto out;
-
-	self->file   = file;
-	self->lineno = lineno;
-	self->next   = NULL;
-out:
-	return self;
-}
-
-struct message {
-	const char	 *msg;
-	const char	 *option;
-	struct message	 *next;
-	struct file_line *files;
-};
-
-static struct message *message__list;
-
-static struct message *message__new(const char *msg, char *option,
-				    const char *file, int lineno)
-{
-	struct message *self = malloc(sizeof(*self));
-
-	if (self == NULL)
-		goto out;
-
-	self->files = file_line__new(file, lineno);
-	if (self->files == NULL)
-		goto out_fail;
-
-	self->msg = xstrdup(msg);
-	if (self->msg == NULL)
-		goto out_fail_msg;
-
-	self->option = option;
-	self->next = NULL;
-out:
-	return self;
-out_fail_msg:
-	free(self->files);
-out_fail:
-	free(self);
-	self = NULL;
-	goto out;
-}
-
-static struct message *mesage__find(const char *msg)
-{
-	struct message *m = message__list;
-
-	while (m != NULL) {
-		if (strcmp(m->msg, msg) == 0)
-			break;
-		m = m->next;
-	}
-
-	return m;
-}
-
-static int message__add_file_line(struct message *self, const char *file,
-				  int lineno)
-{
-	int rc = -1;
-	struct file_line *fl = file_line__new(file, lineno);
-
-	if (fl == NULL)
-		goto out;
-
-	fl->next    = self->files;
-	self->files = fl;
-	rc = 0;
-out:
-	return rc;
-}
-
-static int message__add(const char *msg, char *option, const char *file,
-			int lineno)
-{
-	int rc = 0;
-	char bf[16384];
-	char *escaped = escape(msg, bf, sizeof(bf));
-	struct message *m = mesage__find(escaped);
-
-	if (m != NULL)
-		rc = message__add_file_line(m, file, lineno);
-	else {
-		m = message__new(escaped, option, file, lineno);
-
-		if (m != NULL) {
-			m->next	      = message__list;
-			message__list = m;
-		} else
-			rc = -1;
-	}
-	return rc;
-}
-
-static void menu_build_message_list(struct menu *menu)
-{
-	struct menu *child;
-
-	message__add(menu_get_prompt(menu), NULL,
-		     menu->file == NULL ? "Root Menu" : menu->file->name,
-		     menu->lineno);
-
-	if (menu->sym != NULL && menu_has_help(menu))
-		message__add(menu_get_help(menu), menu->sym->name,
-			     menu->file == NULL ? "Root Menu" : menu->file->name,
-			     menu->lineno);
-
-	for (child = menu->list; child != NULL; child = child->next)
-		if (child->prompt != NULL)
-			menu_build_message_list(child);
-}
-
-static void message__print_file_lineno(struct message *self)
-{
-	struct file_line *fl = self->files;
-
-	putchar('\n');
-	if (self->option != NULL)
-		printf("# %s:00000\n", self->option);
-
-	printf("#: %s:%d", fl->file, fl->lineno);
-	fl = fl->next;
-
-	while (fl != NULL) {
-		printf(", %s:%d", fl->file, fl->lineno);
-		fl = fl->next;
-	}
-
-	putchar('\n');
-}
-
-static void message__print_gettext_msgid_msgstr(struct message *self)
-{
-	message__print_file_lineno(self);
-
-	printf("msgid %s\n"
-	       "msgstr \"\"\n", self->msg);
-}
-
-static void menu__xgettext(void)
-{
-	struct message *m = message__list;
-
-	while (m != NULL) {
-		/* skip empty lines ("") */
-		if (strlen(m->msg) > sizeof("\"\""))
-			message__print_gettext_msgid_msgstr(m);
-		m = m->next;
-	}
-}
-
-int main(int ac, char **av)
-{
-	conf_parse(av[1]);
-
-	menu_build_message_list(menu_get_root_menu(NULL));
-	menu__xgettext();
-	return 0;
-}
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index f4394af6e4b8..2628bc6a2141 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -8,15 +8,6 @@
 
 #include "expr.h"
 
-#ifndef KBUILD_NO_NLS
-# include <libintl.h>
-#else
-static inline const char *gettext(const char *txt) { return txt; }
-static inline void textdomain(const char *domainname) {}
-static inline void bindtextdomain(const char *name, const char *dir) {}
-static inline char *bind_textdomain_codeset(const char *dn, char *c) { return c; }
-#endif
-
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -29,11 +20,6 @@ extern "C" {
 #define PACKAGE "linux"
 #endif
 
-#define LOCALEDIR "/usr/share/locale"
-
-#define _(text) gettext(text)
-#define N_(text) (text)
-
 #ifndef CONFIG_
 #define CONFIG_ "CONFIG_"
 #endif
diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index 8d016faa28d7..2e96323ad11b 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -103,8 +103,8 @@ static void print_buttons(WINDOW * dialog, int height, int width, int selected)
 	int x = width / 2 - 11;
 	int y = height - 2;
 
-	print_button(dialog, gettext("Select"), y, x, selected == 0);
-	print_button(dialog, gettext(" Help "), y, x + 14, selected == 1);
+	print_button(dialog, "Select", y, x, selected == 0);
+	print_button(dialog, " Help ", y, x + 14, selected == 1);
 
 	wmove(dialog, y, x + 1 + 14 * selected);
 	wrefresh(dialog);
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 52e30a0012f1..0b00be5abaa6 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -26,12 +26,6 @@
 #include <string.h>
 #include <stdbool.h>
 
-#ifndef KBUILD_NO_NLS
-# include <libintl.h>
-#else
-# define gettext(Msgid) ((const char *) (Msgid))
-#endif
-
 #ifdef __sun__
 #define CURS_MACROS
 #endif
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index d58de1dc5360..fe82ff6d744e 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -31,8 +31,8 @@ static void print_buttons(WINDOW * dialog, int height, int width, int selected)
 	int x = width / 2 - 11;
 	int y = height - 2;
 
-	print_button(dialog, gettext("  Ok  "), y, x, selected == 0);
-	print_button(dialog, gettext(" Help "), y, x + 14, selected == 1);
+	print_button(dialog, "  Ok  ", y, x, selected == 0);
+	print_button(dialog, " Help ", y, x + 14, selected == 1);
 
 	wmove(dialog, y, x + 1 + 14 * selected);
 	wrefresh(dialog);
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 11ae9ad7ac7b..d70cab36137e 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -157,11 +157,11 @@ static void print_buttons(WINDOW * win, int height, int width, int selected)
 	int x = width / 2 - 28;
 	int y = height - 2;
 
-	print_button(win, gettext("Select"), y, x, selected == 0);
-	print_button(win, gettext(" Exit "), y, x + 12, selected == 1);
-	print_button(win, gettext(" Help "), y, x + 24, selected == 2);
-	print_button(win, gettext(" Save "), y, x + 36, selected == 3);
-	print_button(win, gettext(" Load "), y, x + 48, selected == 4);
+	print_button(win, "Select", y, x, selected == 0);
+	print_button(win, " Exit ", y, x + 12, selected == 1);
+	print_button(win, " Help ", y, x + 24, selected == 2);
+	print_button(win, " Save ", y, x + 36, selected == 3);
+	print_button(win, " Load ", y, x + 48, selected == 4);
 
 	wmove(win, y, x + 1 + 12 * selected);
 	wrefresh(win);
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 1773319b95e7..88d2818ed956 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -129,7 +129,7 @@ int dialog_textbox(const char *title, char *tbuf, int initial_height,
 
 	print_title(dialog, title, width);
 
-	print_button(dialog, gettext(" Exit "), height - 2, width / 2 - 4, TRUE);
+	print_button(dialog, " Exit ", height - 2, width / 2 - 4, TRUE);
 	wnoutrefresh(dialog);
 	getyx(dialog, cur_y, cur_x);	/* Save cursor position */
 
diff --git a/scripts/kconfig/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
index 676fb2f824a3..cd1223c903d1 100644
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -29,8 +29,8 @@ static void print_buttons(WINDOW * dialog, int height, int width, int selected)
 	int x = width / 2 - 10;
 	int y = height - 2;
 
-	print_button(dialog, gettext(" Yes "), y, x, selected == 0);
-	print_button(dialog, gettext("  No  "), y, x + 13, selected == 1);
+	print_button(dialog, " Yes ", y, x, selected == 0);
+	print_button(dialog, "  No  ", y, x + 13, selected == 1);
 
 	wmove(dialog, y, x + 1 + 13 * selected);
 	wrefresh(dialog);
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index c829be8bb19f..5294ed159b98 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -17,12 +17,11 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
-#include <locale.h>
 
 #include "lkc.h"
 #include "lxdialog/dialog.h"
 
-static const char mconf_readme[] = N_(
+static const char mconf_readme[] =
 "Overview\n"
 "--------\n"
 "This interface lets you select features and parameters for the build.\n"
@@ -171,37 +170,37 @@ static const char mconf_readme[] = N_(
 " blackbg    => selects a color scheme with black background\n"
 " classic    => theme with blue background. The classic look\n"
 " bluetitle  => an LCD friendly version of classic. (default)\n"
-"\n"),
-menu_instructions[] = N_(
+"\n",
+menu_instructions[] =
 	"Arrow keys navigate the menu.  "
 	"<Enter> selects submenus ---> (or empty submenus ----).  "
 	"Highlighted letters are hotkeys.  "
 	"Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
 	"Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
-	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable"),
-radiolist_instructions[] = N_(
+	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable",
+radiolist_instructions[] =
 	"Use the arrow keys to navigate this window or "
 	"press the hotkey of the item you wish to select "
 	"followed by the <SPACE BAR>. "
-	"Press <?> for additional information about this option."),
-inputbox_instructions_int[] = N_(
+	"Press <?> for additional information about this option.",
+inputbox_instructions_int[] =
 	"Please enter a decimal value. "
 	"Fractions will not be accepted.  "
-	"Use the <TAB> key to move from the input field to the buttons below it."),
-inputbox_instructions_hex[] = N_(
+	"Use the <TAB> key to move from the input field to the buttons below it.",
+inputbox_instructions_hex[] =
 	"Please enter a hexadecimal value. "
-	"Use the <TAB> key to move from the input field to the buttons below it."),
-inputbox_instructions_string[] = N_(
+	"Use the <TAB> key to move from the input field to the buttons below it.",
+inputbox_instructions_string[] =
 	"Please enter a string value. "
-	"Use the <TAB> key to move from the input field to the buttons below it."),
-setmod_text[] = N_(
+	"Use the <TAB> key to move from the input field to the buttons below it.",
+setmod_text[] =
 	"This feature depends on another which has been configured as a module.\n"
-	"As a result, this feature will be built as a module."),
-load_config_text[] = N_(
+	"As a result, this feature will be built as a module.",
+load_config_text[] =
 	"Enter the name of the configuration file you wish to load.  "
 	"Accept the name shown to restore the configuration you "
-	"last retrieved.  Leave blank to abort."),
-load_config_help[] = N_(
+	"last retrieved.  Leave blank to abort.",
+load_config_help[] =
 	"\n"
 	"For various reasons, one may wish to keep several different\n"
 	"configurations available on a single machine.\n"
@@ -211,11 +210,11 @@ load_config_help[] = N_(
 	"configuration.\n"
 	"\n"
 	"If you are uncertain, then you have probably never used alternate\n"
-	"configuration files. You should therefore leave this blank to abort.\n"),
-save_config_text[] = N_(
+	"configuration files. You should therefore leave this blank to abort.\n",
+save_config_text[] =
 	"Enter a filename to which this configuration should be saved "
-	"as an alternate.  Leave blank to abort."),
-save_config_help[] = N_(
+	"as an alternate.  Leave blank to abort.",
+save_config_help[] =
 	"\n"
 	"For various reasons, one may wish to keep different configurations\n"
 	"available on a single machine.\n"
@@ -225,8 +224,8 @@ save_config_help[] = N_(
 	"configuration options you have selected at that time.\n"
 	"\n"
 	"If you are uncertain what all this means then you should probably\n"
-	"leave this blank.\n"),
-search_help[] = N_(
+	"leave this blank.\n",
+search_help[] =
 	"\n"
 	"Search for symbols and display their relations.\n"
 	"Regular expressions are allowed.\n"
@@ -271,7 +270,7 @@ search_help[] = N_(
 	"Examples: USB	=> find all symbols containing USB\n"
 	"          ^USB => find all symbols starting with USB\n"
 	"          USB$ => find all symbols ending with USB\n"
-	"\n");
+	"\n";
 
 static int indent;
 static struct menu *current_menu;
@@ -400,19 +399,19 @@ static void search_conf(void)
 	struct subtitle_part stpart;
 
 	title = str_new();
-	str_printf( &title, _("Enter (sub)string or regexp to search for "
-			      "(with or without \"%s\")"), CONFIG_);
+	str_printf( &title, "Enter (sub)string or regexp to search for "
+			      "(with or without \"%s\")", CONFIG_);
 
 again:
 	dialog_clear();
-	dres = dialog_inputbox(_("Search Configuration Parameter"),
+	dres = dialog_inputbox("Search Configuration Parameter",
 			      str_get(&title),
 			      10, 75, "");
 	switch (dres) {
 	case 0:
 		break;
 	case 1:
-		show_helptext(_("Search Configuration"), search_help);
+		show_helptext("Search Configuration", search_help);
 		goto again;
 	default:
 		str_free(&title);
@@ -443,7 +442,7 @@ static void search_conf(void)
 
 		res = get_relations_str(sym_arr, &head);
 		set_subtitle();
-		dres = show_textbox_ext(_("Search Results"), (char *)
+		dres = show_textbox_ext("Search Results", (char *)
 					str_get(&res), 0, 0, keys, &vscroll,
 					&hscroll, &update_text, (void *)
 					&data);
@@ -491,7 +490,7 @@ static void build_conf(struct menu *menu)
 			switch (prop->type) {
 			case P_MENU:
 				child_count++;
-				prompt = _(prompt);
+				prompt = prompt;
 				if (single_menu_mode) {
 					item_make("%s%*c%s",
 						  menu->data ? "-->" : "++>",
@@ -508,7 +507,7 @@ static void build_conf(struct menu *menu)
 			case P_COMMENT:
 				if (prompt) {
 					child_count++;
-					item_make("   %*c*** %s ***", indent + 1, ' ', _(prompt));
+					item_make("   %*c*** %s ***", indent + 1, ' ', prompt);
 					item_set_tag(':');
 					item_set_data(menu);
 				}
@@ -516,7 +515,7 @@ static void build_conf(struct menu *menu)
 			default:
 				if (prompt) {
 					child_count++;
-					item_make("---%*c%s", indent + 1, ' ', _(prompt));
+					item_make("---%*c%s", indent + 1, ' ', prompt);
 					item_set_tag(':');
 					item_set_data(menu);
 				}
@@ -560,10 +559,10 @@ static void build_conf(struct menu *menu)
 			item_set_data(menu);
 		}
 
-		item_add_str("%*c%s", indent + 1, ' ', _(menu_get_prompt(menu)));
+		item_add_str("%*c%s", indent + 1, ' ', menu_get_prompt(menu));
 		if (val == yes) {
 			if (def_menu) {
-				item_add_str(" (%s)", _(menu_get_prompt(def_menu)));
+				item_add_str(" (%s)", menu_get_prompt(def_menu));
 				item_add_str("  --->");
 				if (def_menu->list) {
 					indent += 2;
@@ -575,7 +574,7 @@ static void build_conf(struct menu *menu)
 		}
 	} else {
 		if (menu == current_menu) {
-			item_make("---%*c%s", indent + 1, ' ', _(menu_get_prompt(menu)));
+			item_make("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
 			item_set_tag(':');
 			item_set_data(menu);
 			goto conf_childs;
@@ -618,17 +617,17 @@ static void build_conf(struct menu *menu)
 				tmp = indent - tmp + 4;
 				if (tmp < 0)
 					tmp = 0;
-				item_add_str("%*c%s%s", tmp, ' ', _(menu_get_prompt(menu)),
+				item_add_str("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
 					     (sym_has_value(sym) || !sym_is_changable(sym)) ?
-					     "" : _(" (NEW)"));
+					     "" : " (NEW)");
 				item_set_tag('s');
 				item_set_data(menu);
 				goto conf_childs;
 			}
 		}
-		item_add_str("%*c%s%s", indent + 1, ' ', _(menu_get_prompt(menu)),
+		item_add_str("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
 			  (sym_has_value(sym) || !sym_is_changable(sym)) ?
-			  "" : _(" (NEW)"));
+			  "" : " (NEW)");
 		if (menu->prompt->type == P_MENU) {
 			item_add_str("  %s", menu_is_empty(menu) ? "----" : "--->");
 			return;
@@ -665,8 +664,8 @@ static void conf(struct menu *menu, struct menu *active_menu)
 			break;
 		set_subtitle();
 		dialog_clear();
-		res = dialog_menu(prompt ? _(prompt) : _("Main Menu"),
-				  _(menu_instructions),
+		res = dialog_menu(prompt ? prompt : "Main Menu",
+				  menu_instructions,
 				  active_menu, &s_scroll);
 		if (res == 1 || res == KEY_ESC || res == -ERRDISPLAYTOOSMALL)
 			break;
@@ -708,7 +707,7 @@ static void conf(struct menu *menu, struct menu *active_menu)
 				show_help(submenu);
 			else {
 				reset_subtitle();
-				show_helptext(_("README"), _(mconf_readme));
+				show_helptext("README", mconf_readme);
 			}
 			break;
 		case 3:
@@ -793,13 +792,13 @@ static void show_help(struct menu *menu)
 	help.max_width = getmaxx(stdscr) - 10;
 	menu_get_ext_help(menu, &help);
 
-	show_helptext(_(menu_get_prompt(menu)), str_get(&help));
+	show_helptext(menu_get_prompt(menu), str_get(&help));
 	str_free(&help);
 }
 
 static void conf_choice(struct menu *menu)
 {
-	const char *prompt = _(menu_get_prompt(menu));
+	const char *prompt = menu_get_prompt(menu);
 	struct menu *child;
 	struct symbol *active;
 
@@ -814,9 +813,9 @@ static void conf_choice(struct menu *menu)
 			if (!menu_is_visible(child))
 				continue;
 			if (child->sym)
-				item_make("%s", _(menu_get_prompt(child)));
+				item_make("%s", menu_get_prompt(child));
 			else {
-				item_make("*** %s ***", _(menu_get_prompt(child)));
+				item_make("*** %s ***", menu_get_prompt(child));
 				item_set_tag(':');
 			}
 			item_set_data(child);
@@ -826,8 +825,8 @@ static void conf_choice(struct menu *menu)
 				item_set_tag('X');
 		}
 		dialog_clear();
-		res = dialog_checklist(prompt ? _(prompt) : _("Main Menu"),
-					_(radiolist_instructions),
+		res = dialog_checklist(prompt ? prompt : "Main Menu",
+					radiolist_instructions,
 					MENUBOX_HEIGTH_MIN,
 					MENUBOX_WIDTH_MIN,
 					CHECKLIST_HEIGTH_MIN);
@@ -868,26 +867,26 @@ static void conf_string(struct menu *menu)
 
 		switch (sym_get_type(menu->sym)) {
 		case S_INT:
-			heading = _(inputbox_instructions_int);
+			heading = inputbox_instructions_int;
 			break;
 		case S_HEX:
-			heading = _(inputbox_instructions_hex);
+			heading = inputbox_instructions_hex;
 			break;
 		case S_STRING:
-			heading = _(inputbox_instructions_string);
+			heading = inputbox_instructions_string;
 			break;
 		default:
-			heading = _("Internal mconf error!");
+			heading = "Internal mconf error!";
 		}
 		dialog_clear();
-		res = dialog_inputbox(prompt ? _(prompt) : _("Main Menu"),
+		res = dialog_inputbox(prompt ? prompt : "Main Menu",
 				      heading, 10, 75,
 				      sym_get_string_value(menu->sym));
 		switch (res) {
 		case 0:
 			if (sym_set_string_value(menu->sym, dialog_input_result))
 				return;
-			show_textbox(NULL, _("You have made an invalid entry."), 5, 43);
+			show_textbox(NULL, "You have made an invalid entry.", 5, 43);
 			break;
 		case 1:
 			show_help(menu);
@@ -915,10 +914,10 @@ static void conf_load(void)
 				sym_set_change_count(1);
 				return;
 			}
-			show_textbox(NULL, _("File does not exist!"), 5, 38);
+			show_textbox(NULL, "File does not exist!", 5, 38);
 			break;
 		case 1:
-			show_helptext(_("Load Alternate Configuration"), load_config_help);
+			show_helptext("Load Alternate Configuration", load_config_help);
 			break;
 		case KEY_ESC:
 			return;
@@ -941,10 +940,10 @@ static void conf_save(void)
 				set_config_filename(dialog_input_result);
 				return;
 			}
-			show_textbox(NULL, _("Can't create file!  Probably a nonexistent directory."), 5, 60);
+			show_textbox(NULL, "Can't create file!  Probably a nonexistent directory.", 5, 60);
 			break;
 		case 1:
-			show_helptext(_("Save Alternate Configuration"), save_config_help);
+			show_helptext("Save Alternate Configuration", save_config_help);
 			break;
 		case KEY_ESC:
 			return;
@@ -961,8 +960,8 @@ static int handle_exit(void)
 	dialog_clear();
 	if (conf_get_changed())
 		res = dialog_yesno(NULL,
-				   _("Do you wish to save your new configuration?\n"
-				     "(Press <ESC><ESC> to continue kernel configuration.)"),
+				   "Do you wish to save your new configuration?\n"
+				     "(Press <ESC><ESC> to continue kernel configuration.)",
 				   6, 60);
 	else
 		res = -1;
@@ -972,26 +971,26 @@ static int handle_exit(void)
 	switch (res) {
 	case 0:
 		if (conf_write(filename)) {
-			fprintf(stderr, _("\n\n"
+			fprintf(stderr, "\n\n"
 					  "Error while writing of the configuration.\n"
 					  "Your configuration changes were NOT saved."
-					  "\n\n"));
+					  "\n\n");
 			return 1;
 		}
 		/* fall through */
 	case -1:
 		if (!silent)
-			printf(_("\n\n"
+			printf("\n\n"
 				 "*** End of the configuration.\n"
 				 "*** Execute 'make' to start the build or try 'make help'."
-				 "\n\n"));
+				 "\n\n");
 		res = 0;
 		break;
 	default:
 		if (!silent)
-			fprintf(stderr, _("\n\n"
+			fprintf(stderr, "\n\n"
 					  "Your configuration changes were NOT saved."
-					  "\n\n"));
+					  "\n\n");
 		if (res != KEY_ESC)
 			res = 0;
 	}
@@ -1009,10 +1008,6 @@ int main(int ac, char **av)
 	char *mode;
 	int res;
 
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-
 	signal(SIGINT, sig_handler);
 
 	if (ac > 1 && strcmp(av[1], "-s") == 0) {
@@ -1031,8 +1026,8 @@ int main(int ac, char **av)
 	}
 
 	if (init_dialog(NULL)) {
-		fprintf(stderr, N_("Your display is too small to run Menuconfig!\n"));
-		fprintf(stderr, N_("It must be at least 19 lines by 80 columns.\n"));
+		fprintf(stderr, "Your display is too small to run Menuconfig!\n");
+		fprintf(stderr, "It must be at least 19 lines by 80 columns.\n");
 		return 1;
 	}
 
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 5c5c1374b151..068a4e4db20a 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -711,7 +711,7 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 	struct menu *submenu[8], *menu, *location = NULL;
 	struct jump_key *jump = NULL;
 
-	str_printf(r, _("Prompt: %s\n"), _(prop->text));
+	str_printf(r, "Prompt: %s\n", prop->text);
 	menu = prop->menu->parent;
 	for (i = 0; menu != &rootmenu && i < 8; menu = menu->parent) {
 		bool accessible = menu_is_visible(menu);
@@ -744,16 +744,16 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 	}
 
 	if (i > 0) {
-		str_printf(r, _("  Location:\n"));
+		str_printf(r, "  Location:\n");
 		for (j = 4; --i >= 0; j += 2) {
 			menu = submenu[i];
 			if (jump && menu == location)
 				jump->offset = strlen(r->s);
 			str_printf(r, "%*c-> %s", j, ' ',
-				   _(menu_get_prompt(menu)));
+				   menu_get_prompt(menu));
 			if (menu->sym) {
 				str_printf(r, " (%s [=%s])", menu->sym->name ?
-					menu->sym->name : _("<choice>"),
+					menu->sym->name : "<choice>",
 					sym_get_string_value(menu->sym));
 			}
 			str_append(r, "\n");
@@ -817,23 +817,23 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 
 	prop = get_symbol_prop(sym);
 	if (prop) {
-		str_printf(r, _("  Defined at %s:%d\n"), prop->menu->file->name,
+		str_printf(r, "  Defined at %s:%d\n", prop->menu->file->name,
 			prop->menu->lineno);
 		if (!expr_is_yes(prop->visible.expr)) {
-			str_append(r, _("  Depends on: "));
+			str_append(r, "  Depends on: ");
 			expr_gstr_print(prop->visible.expr, r);
 			str_append(r, "\n");
 		}
 	}
 
-	get_symbol_props_str(r, sym, P_SELECT, _("  Selects: "));
+	get_symbol_props_str(r, sym, P_SELECT, "  Selects: ");
 	if (sym->rev_dep.expr) {
 		expr_gstr_print_revdep(sym->rev_dep.expr, r, yes, "  Selected by [y]:\n");
 		expr_gstr_print_revdep(sym->rev_dep.expr, r, mod, "  Selected by [m]:\n");
 		expr_gstr_print_revdep(sym->rev_dep.expr, r, no, "  Selected by [n]:\n");
 	}
 
-	get_symbol_props_str(r, sym, P_IMPLY, _("  Implies: "));
+	get_symbol_props_str(r, sym, P_IMPLY, "  Implies: ");
 	if (sym->implied.expr) {
 		expr_gstr_print_revdep(sym->implied.expr, r, yes, "  Implied by [y]:\n");
 		expr_gstr_print_revdep(sym->implied.expr, r, mod, "  Implied by [m]:\n");
@@ -852,7 +852,7 @@ struct gstr get_relations_str(struct symbol **sym_arr, struct list_head *head)
 	for (i = 0; sym_arr && (sym = sym_arr[i]); i++)
 		get_symbol_str(&res, sym, head);
 	if (!i)
-		str_append(&res, _("No matches found.\n"));
+		str_append(&res, "No matches found.\n");
 	return res;
 }
 
@@ -867,7 +867,7 @@ void menu_get_ext_help(struct menu *menu, struct gstr *help)
 			str_printf(help, "%s%s:\n\n", CONFIG_, sym->name);
 		help_text = menu_get_help(menu);
 	}
-	str_printf(help, "%s\n", _(help_text));
+	str_printf(help, "%s\n", help_text);
 	if (sym)
 		get_symbol_str(help, sym, NULL);
 }
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 003114779815..97b78445584b 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -15,7 +15,7 @@
 #include "nconf.h"
 #include <ctype.h>
 
-static const char nconf_global_help[] = N_(
+static const char nconf_global_help[] =
 "Help windows\n"
 "------------\n"
 "o  Global help:  Unless in a data entry window, pressing <F1> will give \n"
@@ -130,8 +130,8 @@ static const char nconf_global_help[] = N_(
 "\n"
 "Note that this mode can eventually be a little more CPU expensive than\n"
 "the default mode, especially with a larger number of unfolded submenus.\n"
-"\n"),
-menu_no_f_instructions[] = N_(
+"\n",
+menu_no_f_instructions[] =
 "Legend:  [*] built-in  [ ] excluded  <M> module  < > module capable.\n"
 "Submenus are designated by a trailing \"--->\", empty ones by \"----\".\n"
 "\n"
@@ -147,8 +147,8 @@ menu_no_f_instructions[] = N_(
 "You do not have function keys support.\n"
 "Press <1> instead of <F1>, <2> instead of <F2>, etc.\n"
 "For verbose global help use key <1>.\n"
-"For help related to the current menu entry press <?> or <h>.\n"),
-menu_instructions[] = N_(
+"For help related to the current menu entry press <?> or <h>.\n",
+menu_instructions[] =
 "Legend:  [*] built-in  [ ] excluded  <M> module  < > module capable.\n"
 "Submenus are designated by a trailing \"--->\", empty ones by \"----\".\n"
 "\n"
@@ -163,30 +163,30 @@ menu_instructions[] = N_(
 "\n"
 "Pressing <1> may be used instead of <F1>, <2> instead of <F2>, etc.\n"
 "For verbose global help press <F1>.\n"
-"For help related to the current menu entry press <?> or <h>.\n"),
-radiolist_instructions[] = N_(
+"For help related to the current menu entry press <?> or <h>.\n",
+radiolist_instructions[] =
 "Press <Up>, <Down>, <Home> or <End> to navigate a radiolist, select\n"
 "with <Space>.\n"
 "For help related to the current entry press <?> or <h>.\n"
-"For global help press <F1>.\n"),
-inputbox_instructions_int[] = N_(
+"For global help press <F1>.\n",
+inputbox_instructions_int[] =
 "Please enter a decimal value.\n"
 "Fractions will not be accepted.\n"
-"Press <Enter> to apply, <Esc> to cancel."),
-inputbox_instructions_hex[] = N_(
+"Press <Enter> to apply, <Esc> to cancel.",
+inputbox_instructions_hex[] =
 "Please enter a hexadecimal value.\n"
-"Press <Enter> to apply, <Esc> to cancel."),
-inputbox_instructions_string[] = N_(
+"Press <Enter> to apply, <Esc> to cancel.",
+inputbox_instructions_string[] =
 "Please enter a string value.\n"
-"Press <Enter> to apply, <Esc> to cancel."),
-setmod_text[] = N_(
+"Press <Enter> to apply, <Esc> to cancel.",
+setmod_text[] =
 "This feature depends on another feature which has been configured as a\n"
-"module.  As a result, the current feature will be built as a module too."),
-load_config_text[] = N_(
+"module.  As a result, the current feature will be built as a module too.",
+load_config_text[] =
 "Enter the name of the configuration file you wish to load.\n"
 "Accept the name shown to restore the configuration you last\n"
-"retrieved.  Leave empty to abort."),
-load_config_help[] = N_(
+"retrieved.  Leave empty to abort.",
+load_config_help[] =
 "For various reasons, one may wish to keep several different\n"
 "configurations available on a single machine.\n"
 "\n"
@@ -194,11 +194,11 @@ load_config_help[] = N_(
 "default one, entering its name here will allow you to load and modify\n"
 "that configuration.\n"
 "\n"
-"Leave empty to abort.\n"),
-save_config_text[] = N_(
+"Leave empty to abort.\n",
+save_config_text[] =
 "Enter a filename to which this configuration should be saved\n"
-"as an alternate.  Leave empty to abort."),
-save_config_help[] = N_(
+"as an alternate.  Leave empty to abort.",
+save_config_help[] =
 "For various reasons, one may wish to keep several different\n"
 "configurations available on a single machine.\n"
 "\n"
@@ -206,8 +206,8 @@ save_config_help[] = N_(
 "and use the current configuration as an alternate to whatever\n"
 "configuration options you have selected at that time.\n"
 "\n"
-"Leave empty to abort.\n"),
-search_help[] = N_(
+"Leave empty to abort.\n",
+search_help[] =
 "Search for symbols (configuration variable names CONFIG_*) and display\n"
 "their relations.  Regular expressions are supported.\n"
 "Example:  Search for \"^FOO\".\n"
@@ -244,7 +244,7 @@ search_help[] = N_(
 "USB  => find all symbols containing USB\n"
 "^USB => find all symbols starting with USB\n"
 "USB$ => find all symbols ending with USB\n"
-"\n");
+"\n";
 
 struct mitem {
 	char str[256];
@@ -388,7 +388,7 @@ static void print_function_line(void)
 static void handle_f1(int *key, struct menu *current_item)
 {
 	show_scroll_win(main_window,
-			_("Global help"), _(nconf_global_help));
+			"Global help", nconf_global_help);
 	return;
 }
 
@@ -403,8 +403,8 @@ static void handle_f2(int *key, struct menu *current_item)
 static void handle_f3(int *key, struct menu *current_item)
 {
 	show_scroll_win(main_window,
-			_("Short help"),
-			_(current_instructions));
+			"Short help",
+			current_instructions);
 	return;
 }
 
@@ -412,7 +412,7 @@ static void handle_f3(int *key, struct menu *current_item)
 static void handle_f4(int *key, struct menu *current_item)
 {
 	int res = btn_dialog(main_window,
-			_("Show all symbols?"),
+			"Show all symbols?",
 			2,
 			"   <Show All>   ",
 			"<Don't show all>");
@@ -653,8 +653,8 @@ static int do_exit(void)
 		return 0;
 	}
 	res = btn_dialog(main_window,
-			_("Do you wish to save your new configuration?\n"
-				"<ESC> to cancel and resume nconfig."),
+			"Do you wish to save your new configuration?\n"
+				"<ESC> to cancel and resume nconfig.",
 			2,
 			"   <save>   ",
 			"<don't save>");
@@ -670,15 +670,15 @@ static int do_exit(void)
 		if (res)
 			btn_dialog(
 				main_window,
-				_("Error during writing of configuration.\n"
-				  "Your configuration changes were NOT saved."),
+				"Error during writing of configuration.\n"
+				  "Your configuration changes were NOT saved.",
 				  1,
 				  "<OK>");
 		break;
 	default:
 		btn_dialog(
 			main_window,
-			_("Your configuration changes were NOT saved."),
+			"Your configuration changes were NOT saved.",
 			1,
 			"<OK>");
 		break;
@@ -697,12 +697,12 @@ static void search_conf(void)
 	int dres;
 
 	title = str_new();
-	str_printf( &title, _("Enter (sub)string or regexp to search for "
-			      "(with or without \"%s\")"), CONFIG_);
+	str_printf( &title, "Enter (sub)string or regexp to search for "
+			      "(with or without \"%s\")", CONFIG_);
 
 again:
 	dres = dialog_inputbox(main_window,
-			_("Search Configuration Parameter"),
+			"Search Configuration Parameter",
 			str_get(&title),
 			"", &dialog_input_result, &dialog_input_result_len);
 	switch (dres) {
@@ -710,7 +710,7 @@ static void search_conf(void)
 		break;
 	case 1:
 		show_scroll_win(main_window,
-				_("Search Configuration"), search_help);
+				"Search Configuration", search_help);
 		goto again;
 	default:
 		str_free(&title);
@@ -726,7 +726,7 @@ static void search_conf(void)
 	res = get_relations_str(sym_arr, NULL);
 	free(sym_arr);
 	show_scroll_win(main_window,
-			_("Search Results"), str_get(&res));
+			"Search Results", str_get(&res));
 	str_free(&res);
 	str_free(&title);
 }
@@ -754,7 +754,7 @@ static void build_conf(struct menu *menu)
 			switch (ptype) {
 			case P_MENU:
 				child_count++;
-				prompt = _(prompt);
+				prompt = prompt;
 				if (single_menu_mode) {
 					item_make(menu, 'm',
 						"%s%*c%s",
@@ -775,7 +775,7 @@ static void build_conf(struct menu *menu)
 					item_make(menu, ':',
 						"   %*c*** %s ***",
 						indent + 1, ' ',
-						_(prompt));
+						prompt);
 				}
 				break;
 			default:
@@ -783,7 +783,7 @@ static void build_conf(struct menu *menu)
 					child_count++;
 					item_make(menu, ':', "---%*c%s",
 						indent + 1, ' ',
-						_(prompt));
+						prompt);
 				}
 			}
 		} else
@@ -829,11 +829,11 @@ static void build_conf(struct menu *menu)
 		}
 
 		item_add_str("%*c%s", indent + 1,
-				' ', _(menu_get_prompt(menu)));
+				' ', menu_get_prompt(menu));
 		if (val == yes) {
 			if (def_menu) {
 				item_add_str(" (%s)",
-					_(menu_get_prompt(def_menu)));
+					menu_get_prompt(def_menu));
 				item_add_str("  --->");
 				if (def_menu->list) {
 					indent += 2;
@@ -847,7 +847,7 @@ static void build_conf(struct menu *menu)
 		if (menu == current_menu) {
 			item_make(menu, ':',
 				"---%*c%s", indent + 1,
-				' ', _(menu_get_prompt(menu)));
+				' ', menu_get_prompt(menu));
 			goto conf_childs;
 		}
 		child_count++;
@@ -894,17 +894,17 @@ static void build_conf(struct menu *menu)
 				if (tmp < 0)
 					tmp = 0;
 				item_add_str("%*c%s%s", tmp, ' ',
-						_(menu_get_prompt(menu)),
+						menu_get_prompt(menu),
 						(sym_has_value(sym) ||
 						 !sym_is_changable(sym)) ? "" :
-						_(" (NEW)"));
+						" (NEW)");
 				goto conf_childs;
 			}
 		}
 		item_add_str("%*c%s%s", indent + 1, ' ',
-				_(menu_get_prompt(menu)),
+				menu_get_prompt(menu),
 				(sym_has_value(sym) || !sym_is_changable(sym)) ?
-				"" : _(" (NEW)"));
+				"" : " (NEW)");
 		if (menu->prompt && menu->prompt->type == P_MENU) {
 			item_add_str("  %s", menu_is_empty(menu) ? "----" : "--->");
 			return;
@@ -1086,8 +1086,8 @@ static void conf(struct menu *menu)
 		if (!child_count)
 			break;
 
-		show_menu(prompt ? _(prompt) : _("Main Menu"),
-				_(menu_instructions),
+		show_menu(prompt ? prompt : "Main Menu",
+				menu_instructions,
 				current_index, &last_top_row);
 		keypad((menu_win(curses_menu)), TRUE);
 		while (!global_exit) {
@@ -1227,13 +1227,13 @@ static void show_help(struct menu *menu)
 
 	help = str_new();
 	menu_get_ext_help(menu, &help);
-	show_scroll_win(main_window, _(menu_get_prompt(menu)), str_get(&help));
+	show_scroll_win(main_window, menu_get_prompt(menu), str_get(&help));
 	str_free(&help);
 }
 
 static void conf_choice(struct menu *menu)
 {
-	const char *prompt = _(menu_get_prompt(menu));
+	const char *prompt = menu_get_prompt(menu);
 	struct menu *child = NULL;
 	struct symbol *active;
 	int selected_index = 0;
@@ -1256,13 +1256,13 @@ static void conf_choice(struct menu *menu)
 
 			if (child->sym == sym_get_choice_value(menu->sym))
 				item_make(child, ':', "<X> %s",
-						_(menu_get_prompt(child)));
+						menu_get_prompt(child));
 			else if (child->sym)
 				item_make(child, ':', "    %s",
-						_(menu_get_prompt(child)));
+						menu_get_prompt(child));
 			else
 				item_make(child, ':', "*** %s ***",
-						_(menu_get_prompt(child)));
+						menu_get_prompt(child));
 
 			if (child->sym == active){
 				last_top_row = top_row(curses_menu);
@@ -1270,8 +1270,8 @@ static void conf_choice(struct menu *menu)
 			}
 			i++;
 		}
-		show_menu(prompt ? _(prompt) : _("Choice Menu"),
-				_(radiolist_instructions),
+		show_menu(prompt ? prompt : "Choice Menu",
+				radiolist_instructions,
 				selected_index,
 				&last_top_row);
 		while (!global_exit) {
@@ -1358,19 +1358,19 @@ static void conf_string(struct menu *menu)
 
 		switch (sym_get_type(menu->sym)) {
 		case S_INT:
-			heading = _(inputbox_instructions_int);
+			heading = inputbox_instructions_int;
 			break;
 		case S_HEX:
-			heading = _(inputbox_instructions_hex);
+			heading = inputbox_instructions_hex;
 			break;
 		case S_STRING:
-			heading = _(inputbox_instructions_string);
+			heading = inputbox_instructions_string;
 			break;
 		default:
-			heading = _("Internal nconf error!");
+			heading = "Internal nconf error!";
 		}
 		res = dialog_inputbox(main_window,
-				prompt ? _(prompt) : _("Main Menu"),
+				prompt ? prompt : "Main Menu",
 				heading,
 				sym_get_string_value(menu->sym),
 				&dialog_input_result,
@@ -1381,7 +1381,7 @@ static void conf_string(struct menu *menu)
 						dialog_input_result))
 				return;
 			btn_dialog(main_window,
-				_("You have made an invalid entry."), 0);
+				"You have made an invalid entry.", 0);
 			break;
 		case 1:
 			show_help(menu);
@@ -1410,11 +1410,11 @@ static void conf_load(void)
 				sym_set_change_count(1);
 				return;
 			}
-			btn_dialog(main_window, _("File does not exist!"), 0);
+			btn_dialog(main_window, "File does not exist!", 0);
 			break;
 		case 1:
 			show_scroll_win(main_window,
-					_("Load Alternate Configuration"),
+					"Load Alternate Configuration",
 					load_config_help);
 			break;
 		case KEY_EXIT:
@@ -1441,13 +1441,13 @@ static void conf_save(void)
 				set_config_filename(dialog_input_result);
 				return;
 			}
-			btn_dialog(main_window, _("Can't create file! "
-				"Probably a nonexistent directory."),
+			btn_dialog(main_window, "Can't create file! "
+				"Probably a nonexistent directory.",
 				1, "<OK>");
 			break;
 		case 1:
 			show_scroll_win(main_window,
-				_("Save Alternate Configuration"),
+				"Save Alternate Configuration",
 				save_config_help);
 			break;
 		case KEY_EXIT:
@@ -1480,10 +1480,6 @@ int main(int ac, char **av)
 	int lines, columns;
 	char *mode;
 
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-
 	if (ac > 1 && strcmp(av[1], "-s") == 0) {
 		/* Silence conf_read() until the real callback is set up */
 		conf_set_message_callback(NULL);
@@ -1541,8 +1537,8 @@ int main(int ac, char **av)
 	/* check for KEY_FUNC(1) */
 	if (has_key(KEY_F(1)) == FALSE) {
 		show_scroll_win(main_window,
-				_("Instructions"),
-				_(menu_no_f_instructions));
+				"Instructions",
+				menu_no_f_instructions);
 	}
 
 	conf_set_message_callback(conf_message_callback);
diff --git a/scripts/kconfig/nconf.h b/scripts/kconfig/nconf.h
index 9f6f21d3b0d4..2b9e19f603c4 100644
--- a/scripts/kconfig/nconf.h
+++ b/scripts/kconfig/nconf.h
@@ -14,7 +14,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <locale.h>
 #include <ncurses.h>
 #include <menu.h>
 #include <panel.h>
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index ae6c72546411..ad9c22dd04f5 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -34,10 +34,6 @@
 #include "qconf.moc"
 #include "images.c"
 
-#ifdef _
-# undef _
-# define _ qgettext
-#endif
 
 static QApplication *configApp;
 static ConfigSettings *configSettings;
@@ -46,12 +42,7 @@ QAction *ConfigMainWindow::saveAction;
 
 static inline QString qgettext(const char* str)
 {
-	return QString::fromLocal8Bit(gettext(str));
-}
-
-static inline QString qgettext(const QString& str)
-{
-	return QString::fromLocal8Bit(gettext(str.toLatin1()));
+	return QString::fromLocal8Bit(str);
 }
 
 ConfigSettings::ConfigSettings()
@@ -127,7 +118,7 @@ void ConfigItem::updateMenu(void)
 
 	sym = menu->sym;
 	prop = menu->prompt;
-	prompt = _(menu_get_prompt(menu));
+	prompt = qgettext(menu_get_prompt(menu));
 
 	if (prop) switch (prop->type) {
 	case P_MENU:
@@ -216,7 +207,7 @@ void ConfigItem::updateMenu(void)
 		break;
 	}
 	if (!sym_has_value(sym) && visible)
-		prompt += _(" (NEW)");
+		prompt += " (NEW)";
 set_prompt:
 	setText(promptColIdx, prompt);
 }
@@ -327,7 +318,7 @@ ConfigList::ConfigList(ConfigView* p, const char *name)
 	setVerticalScrollMode(ScrollPerPixel);
 	setHorizontalScrollMode(ScrollPerPixel);
 
-	setHeaderLabels(QStringList() << _("Option") << _("Name") << "N" << "M" << "Y" << _("Value"));
+	setHeaderLabels(QStringList() << "Option" << "Name" << "N" << "M" << "Y" << "Value");
 
 	connect(this, SIGNAL(itemSelectionChanged(void)),
 		SLOT(updateSelection(void)));
@@ -883,7 +874,7 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 			QAction *action;
 
 			headerPopup = new QMenu(this);
-			action = new QAction(_("Show Name"), this);
+			action = new QAction("Show Name", this);
 			  action->setCheckable(true);
 			  connect(action, SIGNAL(toggled(bool)),
 				  parent(), SLOT(setShowName(bool)));
@@ -891,7 +882,7 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 				  action, SLOT(setOn(bool)));
 			  action->setChecked(showName);
 			  headerPopup->addAction(action);
-			action = new QAction(_("Show Range"), this);
+			action = new QAction("Show Range", this);
 			  action->setCheckable(true);
 			  connect(action, SIGNAL(toggled(bool)),
 				  parent(), SLOT(setShowRange(bool)));
@@ -899,7 +890,7 @@ void ConfigList::contextMenuEvent(QContextMenuEvent *e)
 				  action, SLOT(setOn(bool)));
 			  action->setChecked(showRange);
 			  headerPopup->addAction(action);
-			action = new QAction(_("Show Data"), this);
+			action = new QAction("Show Data", this);
 			  action->setCheckable(true);
 			  connect(action, SIGNAL(toggled(bool)),
 				  parent(), SLOT(setShowData(bool)));
@@ -1086,7 +1077,7 @@ void ConfigInfoView::menuInfo(void)
 	if (sym) {
 		if (_menu->prompt) {
 			head += "<big><b>";
-			head += print_filter(_(_menu->prompt->text));
+			head += print_filter(_menu->prompt->text);
 			head += "</b></big>";
 			if (sym->name) {
 				head += " (";
@@ -1117,7 +1108,7 @@ void ConfigInfoView::menuInfo(void)
 		str_free(&help_gstr);
 	} else if (_menu->prompt) {
 		head += "<big><b>";
-		head += print_filter(_(_menu->prompt->text));
+		head += print_filter(_menu->prompt->text);
 		head += "</b></big><br><br>";
 		if (showDebug()) {
 			if (_menu->prompt->visible.expr) {
@@ -1152,7 +1143,7 @@ QString ConfigInfoView::debug_info(struct symbol *sym)
 		case P_PROMPT:
 		case P_MENU:
 			debug += QString().sprintf("prompt: <a href=\"m%p\">", prop->menu);
-			debug += print_filter(_(prop->text));
+			debug += print_filter(prop->text);
 			debug += "</a><br>";
 			break;
 		case P_DEFAULT:
@@ -1234,7 +1225,7 @@ void ConfigInfoView::expr_print_help(void *data, struct symbol *sym, const char
 QMenu* ConfigInfoView::createStandardContextMenu(const QPoint & pos)
 {
 	QMenu* popup = Parent::createStandardContextMenu(pos);
-	QAction* action = new QAction(_("Show Debug Info"), popup);
+	QAction* action = new QAction("Show Debug Info", popup);
 	  action->setCheckable(true);
 	  connect(action, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
 	  connect(this, SIGNAL(showDebugChanged(bool)), action, SLOT(setOn(bool)));
@@ -1261,11 +1252,11 @@ ConfigSearchWindow::ConfigSearchWindow(ConfigMainWindow* parent, const char *nam
 	QHBoxLayout* layout2 = new QHBoxLayout(0);
 	layout2->setContentsMargins(0, 0, 0, 0);
 	layout2->setSpacing(6);
-	layout2->addWidget(new QLabel(_("Find:"), this));
+	layout2->addWidget(new QLabel("Find:", this));
 	editField = new QLineEdit(this);
 	connect(editField, SIGNAL(returnPressed()), SLOT(search()));
 	layout2->addWidget(editField);
-	searchButton = new QPushButton(_("Search"), this);
+	searchButton = new QPushButton("Search", this);
 	searchButton->setAutoDefault(false);
 	connect(searchButton, SIGNAL(clicked()), SLOT(search()));
 	layout2->addWidget(searchButton);
@@ -1387,44 +1378,44 @@ ConfigMainWindow::ConfigMainWindow(void)
 	toolBar = new QToolBar("Tools", this);
 	addToolBar(toolBar);
 
-	backAction = new QAction(QPixmap(xpm_back), _("Back"), this);
+	backAction = new QAction(QPixmap(xpm_back), "Back", this);
 	  connect(backAction, SIGNAL(triggered(bool)), SLOT(goBack()));
 	  backAction->setEnabled(false);
-	QAction *quitAction = new QAction(_("&Quit"), this);
+	QAction *quitAction = new QAction("&Quit", this);
 	quitAction->setShortcut(Qt::CTRL + Qt::Key_Q);
 	  connect(quitAction, SIGNAL(triggered(bool)), SLOT(close()));
-	QAction *loadAction = new QAction(QPixmap(xpm_load), _("&Load"), this);
+	QAction *loadAction = new QAction(QPixmap(xpm_load), "&Load", this);
 	loadAction->setShortcut(Qt::CTRL + Qt::Key_L);
 	  connect(loadAction, SIGNAL(triggered(bool)), SLOT(loadConfig()));
-	saveAction = new QAction(QPixmap(xpm_save), _("&Save"), this);
+	saveAction = new QAction(QPixmap(xpm_save), "&Save", this);
 	saveAction->setShortcut(Qt::CTRL + Qt::Key_S);
 	  connect(saveAction, SIGNAL(triggered(bool)), SLOT(saveConfig()));
 	conf_set_changed_callback(conf_changed);
 	// Set saveAction's initial state
 	conf_changed();
-	QAction *saveAsAction = new QAction(_("Save &As..."), this);
+	QAction *saveAsAction = new QAction("Save &As...", this);
 	  connect(saveAsAction, SIGNAL(triggered(bool)), SLOT(saveConfigAs()));
-	QAction *searchAction = new QAction(_("&Find"), this);
+	QAction *searchAction = new QAction("&Find", this);
 	searchAction->setShortcut(Qt::CTRL + Qt::Key_F);
 	  connect(searchAction, SIGNAL(triggered(bool)), SLOT(searchConfig()));
-	singleViewAction = new QAction(QPixmap(xpm_single_view), _("Single View"), this);
+	singleViewAction = new QAction(QPixmap(xpm_single_view), "Single View", this);
 	singleViewAction->setCheckable(true);
 	  connect(singleViewAction, SIGNAL(triggered(bool)), SLOT(showSingleView()));
-	splitViewAction = new QAction(QPixmap(xpm_split_view), _("Split View"), this);
+	splitViewAction = new QAction(QPixmap(xpm_split_view), "Split View", this);
 	splitViewAction->setCheckable(true);
 	  connect(splitViewAction, SIGNAL(triggered(bool)), SLOT(showSplitView()));
-	fullViewAction = new QAction(QPixmap(xpm_tree_view), _("Full View"), this);
+	fullViewAction = new QAction(QPixmap(xpm_tree_view), "Full View", this);
 	fullViewAction->setCheckable(true);
 	  connect(fullViewAction, SIGNAL(triggered(bool)), SLOT(showFullView()));
 
-	QAction *showNameAction = new QAction(_("Show Name"), this);
+	QAction *showNameAction = new QAction("Show Name", this);
 	  showNameAction->setCheckable(true);
 	  connect(showNameAction, SIGNAL(toggled(bool)), configView, SLOT(setShowName(bool)));
 	  showNameAction->setChecked(configView->showName());
-	QAction *showRangeAction = new QAction(_("Show Range"), this);
+	QAction *showRangeAction = new QAction("Show Range", this);
 	  showRangeAction->setCheckable(true);
 	  connect(showRangeAction, SIGNAL(toggled(bool)), configView, SLOT(setShowRange(bool)));
-	QAction *showDataAction = new QAction(_("Show Data"), this);
+	QAction *showDataAction = new QAction("Show Data", this);
 	  showDataAction->setCheckable(true);
 	  connect(showDataAction, SIGNAL(toggled(bool)), configView, SLOT(setShowData(bool)));
 
@@ -1435,21 +1426,21 @@ ConfigMainWindow::ConfigMainWindow(void)
 	connect(optGroup, SIGNAL(triggered(QAction *)), menuView,
 		SLOT(setOptionMode(QAction *)));
 
-	configView->showNormalAction = new QAction(_("Show Normal Options"), optGroup);
-	configView->showAllAction = new QAction(_("Show All Options"), optGroup);
-	configView->showPromptAction = new QAction(_("Show Prompt Options"), optGroup);
+	configView->showNormalAction = new QAction("Show Normal Options", optGroup);
+	configView->showAllAction = new QAction("Show All Options", optGroup);
+	configView->showPromptAction = new QAction("Show Prompt Options", optGroup);
 	configView->showNormalAction->setCheckable(true);
 	configView->showAllAction->setCheckable(true);
 	configView->showPromptAction->setCheckable(true);
 
-	QAction *showDebugAction = new QAction( _("Show Debug Info"), this);
+	QAction *showDebugAction = new QAction("Show Debug Info", this);
 	  showDebugAction->setCheckable(true);
 	  connect(showDebugAction, SIGNAL(toggled(bool)), helpText, SLOT(setShowDebug(bool)));
 	  showDebugAction->setChecked(helpText->showDebug());
 
-	QAction *showIntroAction = new QAction( _("Introduction"), this);
+	QAction *showIntroAction = new QAction("Introduction", this);
 	  connect(showIntroAction, SIGNAL(triggered(bool)), SLOT(showIntro()));
-	QAction *showAboutAction = new QAction( _("About"), this);
+	QAction *showAboutAction = new QAction("About", this);
 	  connect(showAboutAction, SIGNAL(triggered(bool)), SLOT(showAbout()));
 
 	// init tool bar
@@ -1463,7 +1454,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 	toolBar->addAction(fullViewAction);
 
 	// create config menu
-	QMenu* config = menu->addMenu(_("&File"));
+	QMenu* config = menu->addMenu("&File");
 	config->addAction(loadAction);
 	config->addAction(saveAction);
 	config->addAction(saveAsAction);
@@ -1471,11 +1462,11 @@ ConfigMainWindow::ConfigMainWindow(void)
 	config->addAction(quitAction);
 
 	// create edit menu
-	QMenu* editMenu = menu->addMenu(_("&Edit"));
+	QMenu* editMenu = menu->addMenu("&Edit");
 	editMenu->addAction(searchAction);
 
 	// create options menu
-	QMenu* optionMenu = menu->addMenu(_("&Option"));
+	QMenu* optionMenu = menu->addMenu("&Option");
 	optionMenu->addAction(showNameAction);
 	optionMenu->addAction(showRangeAction);
 	optionMenu->addAction(showDataAction);
@@ -1486,7 +1477,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 
 	// create help menu
 	menu->addSeparator();
-	QMenu* helpMenu = menu->addMenu(_("&Help"));
+	QMenu* helpMenu = menu->addMenu("&Help");
 	helpMenu->addAction(showIntroAction);
 	helpMenu->addAction(showAboutAction);
 
@@ -1534,14 +1525,14 @@ void ConfigMainWindow::loadConfig(void)
 	if (s.isNull())
 		return;
 	if (conf_read(QFile::encodeName(s)))
-		QMessageBox::information(this, "qconf", _("Unable to load configuration!"));
+		QMessageBox::information(this, "qconf", "Unable to load configuration!");
 	ConfigView::updateListAll();
 }
 
 bool ConfigMainWindow::saveConfig(void)
 {
 	if (conf_write(NULL)) {
-		QMessageBox::information(this, "qconf", _("Unable to save configuration!"));
+		QMessageBox::information(this, "qconf", "Unable to save configuration!");
 		return false;
 	}
 	return true;
@@ -1723,11 +1714,11 @@ void ConfigMainWindow::closeEvent(QCloseEvent* e)
 		e->accept();
 		return;
 	}
-	QMessageBox mb("qconf", _("Save configuration?"), QMessageBox::Warning,
+	QMessageBox mb("qconf", "Save configuration?", QMessageBox::Warning,
 			QMessageBox::Yes | QMessageBox::Default, QMessageBox::No, QMessageBox::Cancel | QMessageBox::Escape);
-	mb.setButtonText(QMessageBox::Yes, _("&Save Changes"));
-	mb.setButtonText(QMessageBox::No, _("&Discard Changes"));
-	mb.setButtonText(QMessageBox::Cancel, _("Cancel Exit"));
+	mb.setButtonText(QMessageBox::Yes, "&Save Changes");
+	mb.setButtonText(QMessageBox::No, "&Discard Changes");
+	mb.setButtonText(QMessageBox::Cancel, "Cancel Exit");
 	switch (mb.exec()) {
 	case QMessageBox::Yes:
 		if (saveConfig())
@@ -1746,7 +1737,7 @@ void ConfigMainWindow::closeEvent(QCloseEvent* e)
 
 void ConfigMainWindow::showIntro(void)
 {
-	static const QString str = _("Welcome to the qconf graphical configuration tool.\n\n"
+	static const QString str = "Welcome to the qconf graphical configuration tool.\n\n"
 		"For each option, a blank box indicates the feature is disabled, a check\n"
 		"indicates it is enabled, and a dot indicates that it is to be compiled\n"
 		"as a module.  Clicking on the box will cycle through the three states.\n\n"
@@ -1756,16 +1747,16 @@ void ConfigMainWindow::showIntro(void)
 		"options must be enabled to support the option you are interested in, you can\n"
 		"still view the help of a grayed-out option.\n\n"
 		"Toggling Show Debug Info under the Options menu will show the dependencies,\n"
-		"which you can then match by examining other options.\n\n");
+		"which you can then match by examining other options.\n\n";
 
 	QMessageBox::information(this, "qconf", str);
 }
 
 void ConfigMainWindow::showAbout(void)
 {
-	static const QString str = _("qconf is Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>.\n"
+	static const QString str = "qconf is Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>.\n"
 		"Copyright (C) 2015 Boris Barbulovski <bbarbulovski@gmail.com>.\n\n"
-		"Bug reports and feature request can also be entered at http://bugzilla.kernel.org/\n");
+		"Bug reports and feature request can also be entered at http://bugzilla.kernel.org/\n";
 
 	QMessageBox::information(this, "qconf", str);
 }
@@ -1826,7 +1817,7 @@ static const char *progname;
 
 static void usage(void)
 {
-	printf(_("%s [-s] <config>\n").toLatin1().constData(), progname);
+	printf("%s [-s] <config>\n", progname);
 	exit(0);
 }
 
@@ -1835,9 +1826,6 @@ int main(int ac, char** av)
 	ConfigMainWindow* v;
 	const char *name;
 
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-
 	progname = av[0];
 	configApp = new QApplication(ac, av);
 	if (ac > 1 && av[1][0] == '-') {
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index ad6305b0f40c..8bfaaf853d23 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -546,7 +546,7 @@ void conf_parse(const char *name)
 		modules_sym = sym_find( "n" );
 
 	tmp = rootmenu.prompt->text;
-	rootmenu.prompt->text = _(rootmenu.prompt->text);
+	rootmenu.prompt->text = rootmenu.prompt->text;
 	rootmenu.prompt->text = sym_expand_string_value(rootmenu.prompt->text);
 	free((char*)tmp);
 
-- 
2.12.0
