Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8957C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71760206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kKyCQJpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfBWQtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 11:49:17 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:58798 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfBWQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 11:49:16 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x1NGn3xU008650;
        Sun, 24 Feb 2019 01:49:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x1NGn3xU008650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550940544;
        bh=9BkLbEnqdm8PkqFphgSuATjdVV/6y9Ene/3MDbEy+gk=;
        h=From:To:Cc:Subject:Date:From;
        b=kKyCQJpIF4LjwcGe3YsIsW1UfRxgqCZFm5Oyi4vgPboPbYGhGL/JpWjykHeFRopJg
         pVim0PNIrV+yNiXO2PA5qJNdMcHEI/uTlo1n1WI3hxhPqgDqxo0lxLbnsUxJ1/2xr2
         5KBA7LipWXryoBLnLd9AJpgN/2c59Txe3taF52jae/KVPQAjgoQCV2ypUZIuvokL02
         JvOLYPpURlXxe4ZB+ucndhh/2Tjc1F31t6sWLSB5yjQMpzPGuJoVtMQU43PiEGb02C
         iUAbFN1/WkA5Mdg70JS/o7U/QiHMN22zP0sbWU3gjcvDAwDR3T6Vr9JwuxrQqzP6UQ
         FtY4o4S7tWDPQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: fix checkpatch warnings/errors in gconf.c
Date:   Sun, 24 Feb 2019 01:48:59 +0900
Message-Id: <1550940540-28932-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following reports from checkpatch.pl:

  ERROR: do not initialise globals to NULL
  ERROR: "foo * bar" should be "foo *bar"
  ERROR: trailing whitespace
  ERROR: else should follow close brace '}'
  ERROR: space required after that ',' (ctx:VxV)
  ERROR: do not initialise statics to 0
  WARNING: Missing a blank line after declarations
  WARNING: braces {} are not necessary for single statement blocks
  WARNING: labels should not be indented
  WARNING: else is not generally useful after a break or return
  WARNING: braces {} are not necessary for single statement blocks
  WARNING: line over 80 characters
  CHECK: No space is necessary after a cast
  CHECK: Please don't use multiple blank lines
  CHECK: 'resizeable' may be misspelled - perhaps 'resizable'?
  CHECK: 'childs' may be misspelled - perhaps 'children'?
  CHECK: Blank lines aren't necessary after an open brace '{'
  CHECK: Blank lines aren't necessary before a close brace '}'
  CHECK: Comparison to NULL could be written "!path"
  CHECK: Logical continuations should be on the previous line
  CHECK: Unnecessary parentheses around 'view_mode != FULL_VIEW'
  CHECK: braces {} should be used on all arms of this statement

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/gconf.c | 297 ++++++++++++++++++++----------------------------
 1 file changed, 121 insertions(+), 176 deletions(-)

diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 5d4ecf3..a316f6a 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -35,18 +35,18 @@ static gint view_mode = FULL_VIEW;
 static gboolean show_name = TRUE;
 static gboolean show_range = TRUE;
 static gboolean show_value = TRUE;
-static gboolean resizeable = FALSE;
+static gboolean resizable = FALSE;
 static int opt_mode = OPT_NORMAL;
 
-GtkWidget *main_wnd = NULL;
-GtkWidget *tree1_w = NULL;	// left  frame
-GtkWidget *tree2_w = NULL;	// right frame
-GtkWidget *text_w = NULL;
-GtkWidget *hpaned = NULL;
-GtkWidget *vpaned = NULL;
-GtkWidget *back_btn = NULL;
-GtkWidget *save_btn = NULL;
-GtkWidget *save_menu_item = NULL;
+GtkWidget *main_wnd;
+GtkWidget *tree1_w;	// left  frame
+GtkWidget *tree2_w;	// right frame
+GtkWidget *text_w;
+GtkWidget *hpaned;
+GtkWidget *vpaned;
+GtkWidget *back_btn;
+GtkWidget *save_btn;
+GtkWidget *save_menu_item;
 
 GtkTextTag *tag1, *tag2;
 GdkColor color;
@@ -69,8 +69,8 @@ enum {
 static void display_list(void);
 static void display_tree(struct menu *menu);
 static void display_tree_part(void);
-static void update_tree(struct menu *src, GtkTreeIter * dst);
-static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** row);
+static void update_tree(struct menu *src, GtkTreeIter *dst);
+static void set_node(GtkTreeIter *node, struct menu *menu, gchar **row);
 static gchar **fill_row(struct menu *menu);
 static void conf_changed(void);
 
@@ -149,16 +149,13 @@ static void init_main_window(const gchar *glade_file)
 	gtk_widget_set_sensitive(back_btn, FALSE);
 
 	widget = glade_xml_get_widget(xml, "show_name1");
-	gtk_check_menu_item_set_active((GtkCheckMenuItem *) widget,
-				       show_name);
+	gtk_check_menu_item_set_active((GtkCheckMenuItem *)widget, show_name);
 
 	widget = glade_xml_get_widget(xml, "show_range1");
-	gtk_check_menu_item_set_active((GtkCheckMenuItem *) widget,
-				       show_range);
+	gtk_check_menu_item_set_active((GtkCheckMenuItem *)widget, show_range);
 
 	widget = glade_xml_get_widget(xml, "show_data1");
-	gtk_check_menu_item_set_active((GtkCheckMenuItem *) widget,
-				       show_value);
+	gtk_check_menu_item_set_active((GtkCheckMenuItem *)widget, show_value);
 
 	save_btn = glade_xml_get_widget(xml, "button3");
 	save_menu_item = glade_xml_get_widget(xml, "save1");
@@ -168,11 +165,11 @@ static void init_main_window(const gchar *glade_file)
 	widget = glade_xml_get_widget(xml, "toolbar1");
 
 	replace_button_icon(xml, main_wnd->window, style,
-			    "button4", (gchar **) xpm_single_view);
+			    "button4", (gchar **)xpm_single_view);
 	replace_button_icon(xml, main_wnd->window, style,
-			    "button5", (gchar **) xpm_split_view);
+			    "button5", (gchar **)xpm_split_view);
 	replace_button_icon(xml, main_wnd->window, style,
-			    "button6", (gchar **) xpm_tree_view);
+			    "button6", (gchar **)xpm_tree_view);
 
 	txtbuf = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_w));
 	tag1 = gtk_text_buffer_create_tag(txtbuf, "mytag1",
@@ -204,7 +201,7 @@ static void init_tree_model(void)
 	model2 = GTK_TREE_MODEL(tree2);
 
 	for (parents[0] = NULL, i = 1; i < 256; i++)
-		parents[i] = (GtkTreeIter *) g_malloc(sizeof(GtkTreeIter));
+		parents[i] = (GtkTreeIter *)g_malloc(sizeof(GtkTreeIter));
 
 	tree1 = gtk_tree_store_new(COL_NUMBER,
 				   G_TYPE_STRING, G_TYPE_STRING,
@@ -257,8 +254,8 @@ static void init_left_tree(void)
 }
 
 static void renderer_edited(GtkCellRendererText * cell,
-			    const gchar * path_string,
-			    const gchar * new_text, gpointer user_data);
+			    const gchar *path_string,
+			    const gchar *new_text, gpointer user_data);
 
 static void init_right_tree(void)
 {
@@ -347,7 +344,7 @@ static void init_right_tree(void)
 	column = gtk_tree_view_get_column(view, COL_VALUE);
 	gtk_tree_view_column_set_visible(column, show_value);
 
-	if (resizeable) {
+	if (resizable) {
 		for (i = 0; i < COL_VALUE; i++) {
 			column = gtk_tree_view_get_column(view, i);
 			gtk_tree_view_column_set_resizable(column, TRUE);
@@ -358,10 +355,8 @@ static void init_right_tree(void)
 	gtk_tree_selection_set_mode(sel, GTK_SELECTION_SINGLE);
 }
 
-
 /* Utility Functions */
 
-
 static void text_insert_help(struct menu *menu)
 {
 	GtkTextBuffer *buffer;
@@ -386,7 +381,6 @@ static void text_insert_help(struct menu *menu)
 	str_free(&help);
 }
 
-
 static void text_insert_msg(const char *title, const char *message)
 {
 	GtkTextBuffer *buffer;
@@ -407,11 +401,10 @@ static void text_insert_msg(const char *title, const char *message)
 					 NULL);
 }
 
-
 /* Main Windows Callbacks */
 
 void on_save_activate(GtkMenuItem * menuitem, gpointer user_data);
-gboolean on_window1_delete_event(GtkWidget * widget, GdkEvent * event,
+gboolean on_window1_delete_event(GtkWidget *widget, GdkEvent *event,
 				 gpointer user_data)
 {
 	GtkWidget *dialog, *label;
@@ -455,16 +448,13 @@ gboolean on_window1_delete_event(GtkWidget * widget, GdkEvent * event,
 	return FALSE;
 }
 
-
-void on_window1_destroy(GtkObject * object, gpointer user_data)
+void on_window1_destroy(GtkObject *object, gpointer user_data)
 {
 	gtk_main_quit();
 }
 
-
-void
-on_window1_size_request(GtkWidget * widget,
-			GtkRequisition * requisition, gpointer user_data)
+void on_window1_size_request(GtkWidget *widget, GtkRequisition *requisition,
+			     gpointer user_data)
 {
 	static gint old_h;
 	gint w, h;
@@ -481,12 +471,9 @@ on_window1_size_request(GtkWidget * widget,
 	gtk_paned_set_position(GTK_PANED(vpaned), 2 * h / 3);
 }
 
-
 /* Menu & Toolbar Callbacks */
 
-
-static void
-load_filename(GtkFileSelection * file_selector, gpointer user_data)
+static void load_filename(GtkFileSelection *file_selector, gpointer user_data)
 {
 	const gchar *fn;
 
@@ -499,36 +486,32 @@ load_filename(GtkFileSelection * file_selector, gpointer user_data)
 		display_tree(&rootmenu);
 }
 
-void on_load1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_load1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	GtkWidget *fs;
 
 	fs = gtk_file_selection_new("Load file...");
 	g_signal_connect(GTK_OBJECT(GTK_FILE_SELECTION(fs)->ok_button),
-			 "clicked",
-			 G_CALLBACK(load_filename), (gpointer) fs);
+			 "clicked", G_CALLBACK(load_filename), (gpointer)fs);
 	g_signal_connect_swapped(GTK_OBJECT
 				 (GTK_FILE_SELECTION(fs)->ok_button),
 				 "clicked", G_CALLBACK(gtk_widget_destroy),
-				 (gpointer) fs);
+				 (gpointer)fs);
 	g_signal_connect_swapped(GTK_OBJECT
 				 (GTK_FILE_SELECTION(fs)->cancel_button),
 				 "clicked", G_CALLBACK(gtk_widget_destroy),
-				 (gpointer) fs);
+				 (gpointer)fs);
 	gtk_widget_show(fs);
 }
 
-
-void on_save_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_save_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	if (conf_write(NULL))
 		text_insert_msg("Error", "Unable to save configuration !");
 	conf_write_autoconf(0);
 }
 
-
-static void
-store_filename(GtkFileSelection * file_selector, gpointer user_data)
+static void store_filename(GtkFileSelection *file_selector, gpointer user_data)
 {
 	const gchar *fn;
 
@@ -541,34 +524,31 @@ store_filename(GtkFileSelection * file_selector, gpointer user_data)
 	gtk_widget_destroy(GTK_WIDGET(user_data));
 }
 
-void on_save_as1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_save_as1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	GtkWidget *fs;
 
 	fs = gtk_file_selection_new("Save file as...");
 	g_signal_connect(GTK_OBJECT(GTK_FILE_SELECTION(fs)->ok_button),
-			 "clicked",
-			 G_CALLBACK(store_filename), (gpointer) fs);
+			 "clicked", G_CALLBACK(store_filename), (gpointer)fs);
 	g_signal_connect_swapped(GTK_OBJECT
 				 (GTK_FILE_SELECTION(fs)->ok_button),
 				 "clicked", G_CALLBACK(gtk_widget_destroy),
-				 (gpointer) fs);
+				 (gpointer)fs);
 	g_signal_connect_swapped(GTK_OBJECT
 				 (GTK_FILE_SELECTION(fs)->cancel_button),
 				 "clicked", G_CALLBACK(gtk_widget_destroy),
-				 (gpointer) fs);
+				 (gpointer)fs);
 	gtk_widget_show(fs);
 }
 
-
-void on_quit1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_quit1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	if (!on_window1_delete_event(NULL, NULL, NULL))
 		gtk_widget_destroy(GTK_WIDGET(main_wnd));
 }
 
-
-void on_show_name1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_show_name1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	GtkTreeViewColumn *col;
 
@@ -578,8 +558,7 @@ void on_show_name1_activate(GtkMenuItem * menuitem, gpointer user_data)
 		gtk_tree_view_column_set_visible(col, show_name);
 }
 
-
-void on_show_range1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_show_range1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	GtkTreeViewColumn *col;
 
@@ -593,11 +572,9 @@ void on_show_range1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	col = gtk_tree_view_get_column(GTK_TREE_VIEW(tree2_w), COL_YES);
 	if (col)
 		gtk_tree_view_column_set_visible(col, show_range);
-
 }
 
-
-void on_show_data1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_show_data1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	GtkTreeViewColumn *col;
 
@@ -607,38 +584,31 @@ void on_show_data1_activate(GtkMenuItem * menuitem, gpointer user_data)
 		gtk_tree_view_column_set_visible(col, show_value);
 }
 
-
-void
-on_set_option_mode1_activate(GtkMenuItem *menuitem, gpointer user_data)
+void on_set_option_mode1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	opt_mode = OPT_NORMAL;
 	gtk_tree_store_clear(tree2);
 	display_tree(&rootmenu);	/* instead of update_tree to speed-up */
 }
 
-
-void
-on_set_option_mode2_activate(GtkMenuItem *menuitem, gpointer user_data)
+void on_set_option_mode2_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	opt_mode = OPT_ALL;
 	gtk_tree_store_clear(tree2);
 	display_tree(&rootmenu);	/* instead of update_tree to speed-up */
 }
 
-
-void
-on_set_option_mode3_activate(GtkMenuItem *menuitem, gpointer user_data)
+void on_set_option_mode3_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	opt_mode = OPT_PROMPT;
 	gtk_tree_store_clear(tree2);
 	display_tree(&rootmenu);	/* instead of update_tree to speed-up */
 }
 
-
-void on_introduction1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_introduction1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
-	const gchar *intro_text = 
+	const gchar *intro_text =
 	    "Welcome to gkc, the GTK+ graphical configuration tool\n"
 	    "For each option, a blank box indicates the feature is disabled, a\n"
 	    "check indicates it is enabled, and a dot indicates that it is to\n"
@@ -665,8 +635,7 @@ void on_introduction1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	gtk_widget_show_all(dialog);
 }
 
-
-void on_about1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_about1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
 	const gchar *about_text =
@@ -683,8 +652,7 @@ void on_about1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	gtk_widget_show_all(dialog);
 }
 
-
-void on_license1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_license1_activate(GtkMenuItem *menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
 	const gchar *license_text =
@@ -702,8 +670,7 @@ void on_license1_activate(GtkMenuItem * menuitem, gpointer user_data)
 	gtk_widget_show_all(dialog);
 }
 
-
-void on_back_clicked(GtkButton * button, gpointer user_data)
+void on_back_clicked(GtkButton *button, gpointer user_data)
 {
 	enum prop_type ptype;
 
@@ -717,14 +684,12 @@ void on_back_clicked(GtkButton * button, gpointer user_data)
 		gtk_widget_set_sensitive(back_btn, FALSE);
 }
 
-
-void on_load_clicked(GtkButton * button, gpointer user_data)
+void on_load_clicked(GtkButton *button, gpointer user_data)
 {
 	on_load1_activate(NULL, user_data);
 }
 
-
-void on_single_clicked(GtkButton * button, gpointer user_data)
+void on_single_clicked(GtkButton *button, gpointer user_data)
 {
 	view_mode = SINGLE_VIEW;
 	gtk_widget_hide(tree1_w);
@@ -732,10 +697,10 @@ void on_single_clicked(GtkButton * button, gpointer user_data)
 	display_tree_part();
 }
 
-
-void on_split_clicked(GtkButton * button, gpointer user_data)
+void on_split_clicked(GtkButton *button, gpointer user_data)
 {
 	gint w, h;
+
 	view_mode = SPLIT_VIEW;
 	gtk_widget_show(tree1_w);
 	gtk_window_get_default_size(GTK_WINDOW(main_wnd), &w, &h);
@@ -748,8 +713,7 @@ void on_split_clicked(GtkButton * button, gpointer user_data)
 	gtk_widget_set_sensitive(back_btn, FALSE);
 }
 
-
-void on_full_clicked(GtkButton * button, gpointer user_data)
+void on_full_clicked(GtkButton *button, gpointer user_data)
 {
 	view_mode = FULL_VIEW;
 	gtk_widget_hide(tree1_w);
@@ -759,25 +723,21 @@ void on_full_clicked(GtkButton * button, gpointer user_data)
 	gtk_widget_set_sensitive(back_btn, FALSE);
 }
 
-
-void on_collapse_clicked(GtkButton * button, gpointer user_data)
+void on_collapse_clicked(GtkButton *button, gpointer user_data)
 {
 	gtk_tree_view_collapse_all(GTK_TREE_VIEW(tree2_w));
 }
 
-
-void on_expand_clicked(GtkButton * button, gpointer user_data)
+void on_expand_clicked(GtkButton *button, gpointer user_data)
 {
 	gtk_tree_view_expand_all(GTK_TREE_VIEW(tree2_w));
 }
 
-
 /* CTree Callbacks */
 
 /* Change hex/int/string value in the cell */
-static void renderer_edited(GtkCellRendererText * cell,
-			    const gchar * path_string,
-			    const gchar * new_text, gpointer user_data)
+static void renderer_edited(GtkCellRendererText *cell, const gchar *path_string,
+			    const gchar *new_text, gpointer user_data)
 {
 	GtkTreePath *path = gtk_tree_path_new_from_string(path_string);
 	GtkTreeIter iter;
@@ -825,14 +785,14 @@ static void change_sym_value(struct menu *menu, gint col)
 		if (!sym_tristate_within_range(sym, newval))
 			newval = yes;
 		sym_set_tristate_value(sym, newval);
-		if (view_mode == FULL_VIEW)
+		if (view_mode == FULL_VIEW) {
 			update_tree(&rootmenu, NULL);
-		else if (view_mode == SPLIT_VIEW) {
+		} else if (view_mode == SPLIT_VIEW) {
 			update_tree(browsed, NULL);
 			display_list();
-		}
-		else if (view_mode == SINGLE_VIEW)
+		} else if (view_mode == SINGLE_VIEW) {
 			display_tree_part();	//fixme: keep exp/coll
+		}
 		break;
 	case S_INT:
 	case S_HEX:
@@ -848,17 +808,17 @@ static void toggle_sym_value(struct menu *menu)
 		return;
 
 	sym_toggle_tristate_value(menu->sym);
-	if (view_mode == FULL_VIEW)
+	if (view_mode == FULL_VIEW) {
 		update_tree(&rootmenu, NULL);
-	else if (view_mode == SPLIT_VIEW) {
+	} else if (view_mode == SPLIT_VIEW) {
 		update_tree(browsed, NULL);
 		display_list();
-	}
-	else if (view_mode == SINGLE_VIEW)
+	} else if (view_mode == SINGLE_VIEW) {
 		display_tree_part();	//fixme: keep exp/coll
+	}
 }
 
-static gint column2index(GtkTreeViewColumn * column)
+static gint column2index(GtkTreeViewColumn *column)
 {
 	gint i;
 
@@ -873,11 +833,10 @@ static gint column2index(GtkTreeViewColumn * column)
 	return -1;
 }
 
-
 /* User click: update choice (full) or goes down (single) */
-gboolean
-on_treeview2_button_press_event(GtkWidget * widget,
-				GdkEventButton * event, gpointer user_data)
+gboolean on_treeview2_button_press_event(GtkWidget *widget,
+					 GdkEventButton *event,
+					 gpointer user_data)
 {
 	GtkTreeView *view = GTK_TREE_VIEW(widget);
 	GtkTreePath *path;
@@ -886,9 +845,9 @@ on_treeview2_button_press_event(GtkWidget * widget,
 	struct menu *menu;
 	gint col;
 
-#if GTK_CHECK_VERSION(2,1,4) // bug in ctree with earlier version of GTK
-	gint tx = (gint) event->x;
-	gint ty = (gint) event->y;
+#if GTK_CHECK_VERSION(2, 1, 4) // bug in ctree with earlier version of GTK
+	gint tx = (gint)event->x;
+	gint ty = (gint)event->y;
 	gint cx, cy;
 
 	gtk_tree_view_get_path_at_pos(view, tx, ty, &path, &column, &cx,
@@ -896,7 +855,7 @@ on_treeview2_button_press_event(GtkWidget * widget,
 #else
 	gtk_tree_view_get_cursor(view, &path, &column);
 #endif
-	if (path == NULL)
+	if (!path)
 		return FALSE;
 
 	if (!gtk_tree_model_get_iter(model2, &iter, path))
@@ -906,6 +865,7 @@ on_treeview2_button_press_event(GtkWidget * widget,
 	col = column2index(column);
 	if (event->type == GDK_2BUTTON_PRESS) {
 		enum prop_type ptype;
+
 		ptype = menu->prompt ? menu->prompt->type : P_UNKNOWN;
 
 		if (ptype == P_MENU && view_mode != FULL_VIEW && col == COL_OPTION) {
@@ -921,8 +881,7 @@ on_treeview2_button_press_event(GtkWidget * widget,
 		if (col == COL_VALUE) {
 			toggle_sym_value(menu);
 			gtk_tree_view_expand_row(view, path, TRUE);
-		} else if (col == COL_NO || col == COL_MOD
-			   || col == COL_YES) {
+		} else if (col == COL_NO || col == COL_MOD || col == COL_YES) {
 			change_sym_value(menu, col);
 			gtk_tree_view_expand_row(view, path, TRUE);
 		}
@@ -932,9 +891,8 @@ on_treeview2_button_press_event(GtkWidget * widget,
 }
 
 /* Key pressed: update choice */
-gboolean
-on_treeview2_key_press_event(GtkWidget * widget,
-			     GdkEventKey * event, gpointer user_data)
+gboolean on_treeview2_key_press_event(GtkWidget *widget, GdkEventKey *event,
+				      gpointer user_data)
 {
 	GtkTreeView *view = GTK_TREE_VIEW(widget);
 	GtkTreePath *path;
@@ -975,10 +933,8 @@ on_treeview2_key_press_event(GtkWidget * widget,
 	return FALSE;
 }
 
-
 /* Row selection changed: update help */
-void
-on_treeview2_cursor_changed(GtkTreeView * treeview, gpointer user_data)
+void on_treeview2_cursor_changed(GtkTreeView *treeview, gpointer user_data)
 {
 	GtkTreeSelection *selection;
 	GtkTreeIter iter;
@@ -991,11 +947,10 @@ on_treeview2_cursor_changed(GtkTreeView * treeview, gpointer user_data)
 	}
 }
 
-
 /* User click: display sub-tree in the right frame. */
-gboolean
-on_treeview1_button_press_event(GtkWidget * widget,
-				GdkEventButton * event, gpointer user_data)
+gboolean on_treeview1_button_press_event(GtkWidget *widget,
+					 GdkEventButton *event,
+					 gpointer user_data)
 {
 	GtkTreeView *view = GTK_TREE_VIEW(widget);
 	GtkTreePath *path;
@@ -1003,13 +958,12 @@ on_treeview1_button_press_event(GtkWidget * widget,
 	GtkTreeIter iter;
 	struct menu *menu;
 
-	gint tx = (gint) event->x;
-	gint ty = (gint) event->y;
+	gint tx = (gint)event->x;
+	gint ty = (gint)event->y;
 	gint cx, cy;
 
-	gtk_tree_view_get_path_at_pos(view, tx, ty, &path, &column, &cx,
-				      &cy);
-	if (path == NULL)
+	gtk_tree_view_get_path_at_pos(view, tx, ty, &path, &column, &cx, &cy);
+	if (!path)
 		return FALSE;
 
 	gtk_tree_model_get_iter(model1, &iter, path);
@@ -1031,7 +985,6 @@ on_treeview1_button_press_event(GtkWidget * widget,
 	return FALSE;
 }
 
-
 /* Fill a row of strings */
 static gchar **fill_row(struct menu *menu)
 {
@@ -1062,18 +1015,18 @@ static gchar **fill_row(struct menu *menu)
 	ptype = menu->prompt ? menu->prompt->type : P_UNKNOWN;
 	switch (ptype) {
 	case P_MENU:
-		row[COL_PIXBUF] = (gchar *) xpm_menu;
+		row[COL_PIXBUF] = (gchar *)xpm_menu;
 		if (view_mode == SINGLE_VIEW)
 			row[COL_PIXVIS] = GINT_TO_POINTER(TRUE);
 		row[COL_BTNVIS] = GINT_TO_POINTER(FALSE);
 		break;
 	case P_COMMENT:
-		row[COL_PIXBUF] = (gchar *) xpm_void;
+		row[COL_PIXBUF] = (gchar *)xpm_void;
 		row[COL_PIXVIS] = GINT_TO_POINTER(FALSE);
 		row[COL_BTNVIS] = GINT_TO_POINTER(FALSE);
 		break;
 	default:
-		row[COL_PIXBUF] = (gchar *) xpm_void;
+		row[COL_PIXBUF] = (gchar *)xpm_void;
 		row[COL_PIXVIS] = GINT_TO_POINTER(FALSE);
 		row[COL_BTNVIS] = GINT_TO_POINTER(TRUE);
 		break;
@@ -1086,7 +1039,7 @@ static gchar **fill_row(struct menu *menu)
 	sym_calc_value(sym);
 	sym->flags &= ~SYMBOL_CHANGED;
 
-	if (sym_is_choice(sym)) {	// parse childs for getting final value
+	if (sym_is_choice(sym)) {	// parse children for getting final value
 		struct menu *child;
 		struct symbol *def_sym = sym_get_choice_value(sym);
 		struct menu *def_menu = NULL;
@@ -1094,8 +1047,7 @@ static gchar **fill_row(struct menu *menu)
 		row[COL_BTNVIS] = GINT_TO_POINTER(FALSE);
 
 		for (child = menu->list; child; child = child->next) {
-			if (menu_is_visible(child)
-			    && child->sym == def_sym)
+			if (menu_is_visible(child) && child->sym == def_sym)
 				def_menu = child;
 		}
 
@@ -1156,9 +1108,8 @@ static gchar **fill_row(struct menu *menu)
 	return row;
 }
 
-
 /* Set the node content with a row of strings */
-static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** row)
+static void set_node(GtkTreeIter *node, struct menu *menu, gchar **row)
 {
 	GdkColor color;
 	gboolean success;
@@ -1178,7 +1129,7 @@ static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** row)
 			   COL_MOD, row[COL_MOD],
 			   COL_YES, row[COL_YES],
 			   COL_VALUE, row[COL_VALUE],
-			   COL_MENU, (gpointer) menu,
+			   COL_MENU, (gpointer)menu,
 			   COL_COLOR, &color,
 			   COL_EDIT, GPOINTER_TO_INT(row[COL_EDIT]),
 			   COL_PIXBUF, pix,
@@ -1192,7 +1143,6 @@ static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** row)
 	g_object_unref(pix);
 }
 
-
 /* Add a node to the tree */
 static void place_node(struct menu *menu, char **row)
 {
@@ -1203,7 +1153,6 @@ static void place_node(struct menu *menu, char **row)
 	set_node(node, menu, row);
 }
 
-
 /* Find a node in the GTK+ tree */
 static GtkTreeIter found;
 
@@ -1239,12 +1188,11 @@ static GtkTreeIter *gtktree_iter_find_node(GtkTreeIter *parent,
 	return NULL;
 }
 
-
 /*
  * Update the tree by adding/removing entries
  * Does not change other nodes
  */
-static void update_tree(struct menu *src, GtkTreeIter * dst)
+static void update_tree(struct menu *src, GtkTreeIter *dst)
 {
 	struct menu *child1;
 	GtkTreeIter iter, tmp;
@@ -1259,10 +1207,8 @@ static void update_tree(struct menu *src, GtkTreeIter * dst)
 
 	valid = gtk_tree_model_iter_children(model2, child2, dst);
 	for (child1 = src->list; child1; child1 = child1->next) {
-
 		sym = child1->sym;
-
-	      reparse:
+reparse:
 		menu1 = child1;
 		if (valid)
 			gtk_tree_model_get(model2, child2, COL_MENU,
@@ -1279,7 +1225,6 @@ static void update_tree(struct menu *src, GtkTreeIter * dst)
 		if ((opt_mode == OPT_NORMAL && !menu_is_visible(child1)) ||
 		    (opt_mode == OPT_PROMPT && !menu_has_prompt(child1)) ||
 		    (opt_mode == OPT_ALL    && !menu_get_prompt(child1))) {
-
 			/* remove node */
 			if (gtktree_iter_find_node(dst, menu1) != NULL) {
 				memcpy(&tmp, child2, sizeof(GtkTreeIter));
@@ -1288,14 +1233,14 @@ static void update_tree(struct menu *src, GtkTreeIter * dst)
 				gtk_tree_store_remove(tree2, &tmp);
 				if (!valid)
 					return;		/* next parent */
-				else
-					goto reparse;	/* next child */
-			} else
+				goto reparse;	/* next child */
+			} else {
 				continue;
+			}
 		}
 
 		if (menu1 != menu2) {
-			if (gtktree_iter_find_node(dst, menu1) == NULL) {	// add node
+			if (!gtktree_iter_find_node(dst, menu1)) {  // add node
 				if (!valid && !menu2)
 					sibling = NULL;
 				else
@@ -1304,7 +1249,7 @@ static void update_tree(struct menu *src, GtkTreeIter * dst)
 							     child2,
 							     dst, sibling);
 				set_node(child2, menu1, fill_row(menu1));
-				if (menu2 == NULL)
+				if (!menu2)
 					valid = TRUE;
 			} else {	// remove node
 				memcpy(&tmp, child2, sizeof(GtkTreeIter));
@@ -1313,8 +1258,7 @@ static void update_tree(struct menu *src, GtkTreeIter * dst)
 				gtk_tree_store_remove(tree2, &tmp);
 				if (!valid)
 					return;	// next parent
-				else
-					goto reparse;	// next child
+				goto reparse;	// next child
 			}
 		} else if (sym && (sym->flags & SYMBOL_CHANGED)) {
 			set_node(child2, menu1, fill_row(menu1));
@@ -1328,7 +1272,6 @@ static void update_tree(struct menu *src, GtkTreeIter * dst)
 	}
 }
 
-
 /* Display the whole tree (single/split/full view) */
 static void display_tree(struct menu *menu)
 {
@@ -1350,12 +1293,12 @@ static void display_tree(struct menu *menu)
 		if (sym)
 			sym->flags &= ~SYMBOL_CHANGED;
 
-		if ((view_mode == SPLIT_VIEW)
-		    && !(child->flags & MENU_ROOT) && (tree == tree1))
+		if (view_mode == SPLIT_VIEW && !(child->flags & MENU_ROOT) &&
+		    tree == tree1)
 			continue;
 
-		if ((view_mode == SPLIT_VIEW) && (child->flags & MENU_ROOT)
-		    && (tree == tree2))
+		if (view_mode == SPLIT_VIEW && (child->flags & MENU_ROOT) &&
+		    tree == tree2)
 			continue;
 
 		if ((opt_mode == OPT_NORMAL && menu_is_visible(child)) ||
@@ -1372,11 +1315,11 @@ static void display_tree(struct menu *menu)
 			printf(" | ");
 			printf("%s", dbg_sym_flags(sym->flags));
 			printf("\n");
-		} else
+		} else {
 			printf("\n");
+		}
 #endif
-		if ((view_mode != FULL_VIEW) && (ptype == P_MENU)
-		    && (tree == tree2))
+		if (view_mode != FULL_VIEW && ptype == P_MENU && tree == tree2)
 			continue;
 /*
 		if (((menu != &rootmenu) && !(menu->flags & MENU_ROOT))
@@ -1384,13 +1327,11 @@ static void display_tree(struct menu *menu)
 		    || (view_mode == SPLIT_VIEW))*/
 
 		/* Change paned position if the view is not in 'split mode' */
-		if (view_mode == SINGLE_VIEW || view_mode == FULL_VIEW) {
+		if (view_mode == SINGLE_VIEW || view_mode == FULL_VIEW)
 			gtk_paned_set_position(GTK_PANED(hpaned), 0);
-		}
 
-		if (((view_mode == SINGLE_VIEW) && (menu->flags & MENU_ROOT))
-		    || (view_mode == FULL_VIEW)
-		    || (view_mode == SPLIT_VIEW)) {
+		if ((view_mode == SINGLE_VIEW && (menu->flags & MENU_ROOT)) ||
+		    view_mode == FULL_VIEW || view_mode == SPLIT_VIEW) {
 			indent++;
 			display_tree(child);
 			indent--;
@@ -1425,7 +1366,7 @@ static void display_list(void)
 static void fixup_rootmenu(struct menu *menu)
 {
 	struct menu *child;
-	static int menu_cnt = 0;
+	static int menu_cnt;
 
 	menu->flags |= MENU_ROOT;
 	for (child = menu->list; child; child = child->next) {
@@ -1433,12 +1374,12 @@ static void fixup_rootmenu(struct menu *menu)
 			menu_cnt++;
 			fixup_rootmenu(child);
 			menu_cnt--;
-		} else if (!menu_cnt)
+		} else if (!menu_cnt) {
 			fixup_rootmenu(child);
+		}
 	}
 }
 
-
 /* Main */
 int main(int ac, char *av[])
 {
@@ -1457,11 +1398,13 @@ int main(int ac, char *av[])
 	/* Determine GUI path */
 	env = getenv(SRCTREE);
 	if (env)
-		glade_file = g_strconcat(env, "/scripts/kconfig/gconf.glade", NULL);
+		glade_file = g_strconcat(env, "/scripts/kconfig/gconf.glade",
+					 NULL);
 	else if (av[0][0] == '/')
 		glade_file = g_strconcat(av[0], ".glade", NULL);
 	else
-		glade_file = g_strconcat(g_get_current_dir(), "/", av[0], ".glade", NULL);
+		glade_file = g_strconcat(g_get_current_dir(), "/", av[0],
+					 ".glade", NULL);
 
 	/* Conf stuffs */
 	if (ac > 1 && av[1][0] == '-') {
@@ -1478,8 +1421,9 @@ int main(int ac, char *av[])
 			exit(0);
 		}
 		name = av[2];
-	} else
+	} else {
 		name = av[1];
+	}
 
 	conf_parse(name);
 	fixup_rootmenu(&rootmenu);
@@ -1511,6 +1455,7 @@ int main(int ac, char *av[])
 static void conf_changed(void)
 {
 	bool changed = conf_get_changed();
+
 	gtk_widget_set_sensitive(save_btn, changed);
 	gtk_widget_set_sensitive(save_menu_item, changed);
 }
-- 
2.7.4

