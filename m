Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12CCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D248218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yuwRxhc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbeLUIda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:33:30 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:38269 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLUId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:33:29 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id wBL8XAI9008714;
        Fri, 21 Dec 2018 17:33:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com wBL8XAI9008714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545381192;
        bh=6KtmSy+aamATmax2umX8Hgg8oZJ8Fh5fG9A7a5e+JtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuwRxhc4LBqKuRHpR1Pecua2/FjybeOzxhht4RhoDlh9vOoX4MOPFP7YXk2CNRUSK
         djt4g1USNUmG272pOmkw4ltvaYH2m/NiKzcEzhuu2S/g4KGg6MSH8k+hc0/GoAGgvr
         BnfYnTnZHH83plZbnBWYuMlNGEA81WT7P6/ZGDqDy2OuFJaqo27GRzBwKWeMSGzhN0
         nZvRGdAD3ueQOJ8ITOVwDgPqTSXngDZyvRbOo10awjJrFN6DG/RN18Num9iz1Mv+8p
         hebJy6ohokjiD2jtd1O7deTu0vDtSusTx+vpC7/UxsVh9EAqDFfmwZ43HkVTqLg3mx
         KKPiBD7M2+VVg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] kconfig: add static qualifiers to fix gconf warnings
Date:   Fri, 21 Dec 2018 17:33:06 +0900
Message-Id: <1545381188-514-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545381188-514-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545381188-514-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "static" to functions that are locally used in gconf.c
This fixes some "no previous prototype for ..." warnings.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/gconf.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 14fc0fa..2d4e5a1 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -76,7 +76,7 @@ static void conf_changed(void);
 
 /* Helping/Debugging Functions */
 
-const char *dbg_sym_flags(int val)
+static const char *dbg_sym_flags(int val)
 {
 	static char buf[256];
 
@@ -106,8 +106,8 @@ const char *dbg_sym_flags(int val)
 	return buf;
 }
 
-void replace_button_icon(GladeXML * xml, GdkDrawable * window,
-			 GtkStyle * style, gchar * btn_name, gchar ** xpm)
+static void replace_button_icon(GladeXML *xml, GdkDrawable *window,
+				GtkStyle *style, gchar *btn_name, gchar **xpm)
 {
 	GdkPixmap *pixmap;
 	GdkBitmap *mask;
@@ -125,7 +125,7 @@ void replace_button_icon(GladeXML * xml, GdkDrawable * window,
 }
 
 /* Main Window Initialization */
-void init_main_window(const gchar * glade_file)
+static void init_main_window(const gchar *glade_file)
 {
 	GladeXML *xml;
 	GtkWidget *widget;
@@ -187,7 +187,7 @@ void init_main_window(const gchar * glade_file)
 	gtk_widget_show(main_wnd);
 }
 
-void init_tree_model(void)
+static void init_tree_model(void)
 {
 	gint i;
 
@@ -217,7 +217,7 @@ void init_tree_model(void)
 	model1 = GTK_TREE_MODEL(tree1);
 }
 
-void init_left_tree(void)
+static void init_left_tree(void)
 {
 	GtkTreeView *view = GTK_TREE_VIEW(tree1_w);
 	GtkCellRenderer *renderer;
@@ -259,7 +259,7 @@ static void renderer_edited(GtkCellRendererText * cell,
 			    const gchar * path_string,
 			    const gchar * new_text, gpointer user_data);
 
-void init_right_tree(void)
+static void init_right_tree(void)
 {
 	GtkTreeView *view = GTK_TREE_VIEW(tree2_w);
 	GtkCellRenderer *renderer;
@@ -1209,8 +1209,8 @@ static GtkTreeIter found;
 /*
  * Find a menu in the GtkTree starting at parent.
  */
-GtkTreeIter *gtktree_iter_find_node(GtkTreeIter * parent,
-				    struct menu *tofind)
+static GtkTreeIter *gtktree_iter_find_node(GtkTreeIter *parent,
+					   struct menu *tofind)
 {
 	GtkTreeIter iter;
 	GtkTreeIter *child = &iter;
@@ -1421,7 +1421,7 @@ static void display_list(void)
 	tree = tree2;
 }
 
-void fixup_rootmenu(struct menu *menu)
+static void fixup_rootmenu(struct menu *menu)
 {
 	struct menu *child;
 	static int menu_cnt = 0;
-- 
2.7.4

