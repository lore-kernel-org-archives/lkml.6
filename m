Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4173053-1519689893-2-4876357684665635224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519689892; b=rqbKP6sy3QBS5hzBc34jgQrAb68gOR8ei3x3zdMgx/YQ6kg
    ayJRp2a1l/leBUgwiSmiBG5vV9XTCZSvdSNm57CL7GT42sNMDpyeA/yxH8wcruM8
    chRyXiTlQ5PhnTSbz4zBYgaegpIshh2LH+I+HQ71G2IEYAG8Kp/YZlkp216vnkfV
    umz2YsUTZV9rhFYEYMoh9dcV2BeczPWC1oABNSv/b/cjPFms+Hubg54JY8ufO4v+
    AjxnxKlmzLaFa2UHvo/uph0PvVV6jItkLUUWvYGd/ixjo7cvsnHQIIml8uiCNSiV
    /PTR5krat1weKsQvKN7zItHh6VZaltv6wwBRzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519689892;
    bh=K4H2IS1C14JetQoWTt9nTD6uSBzLDV48IfcVCNojRUU=; b=UHmiiZj0ptBr
    /fjfeug7bSOo+vE+SphxpDBgQm25Vg6MH74B993FJcN3k/pOKlJig7uTujc8uqSI
    Dnpz7VSudcWqMT6YHg/SJt+xkY0R3mosCgMH2tGyq5R36E0LPmOPNLmR4Surddri
    gJp8XQpbtQOQtUkiCdVvGysU/cXwA34Dwy69vmjzX4dR0MrOqrrMAD2yPp4ZnJGp
    27/UDrYlHnzKOnekDVwED3wepV8HPeK1RMAlEqueLu5kZ69/TF4d5p+SIy0lDnbc
    FzZ1eysL2Es07H1AvY0JYkjgeP0T2CCtp85+5l1+1BgC5RO2LrOaV42aiBVq+REO
    NNWAxd+cDg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=oOylwSEe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PhqV0Msr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=oOylwSEe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PhqV0Msr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeB0AEe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 19:04:34 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37443 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeB0AEc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 19:04:32 -0500
X-Google-Smtp-Source: AH8x226DfSniFftAVgU89o9cQx4cEgfpJHq1VT1fNqLL7YOkV0L0mRC9p+gc6TaE6hgH11MsHxKxaA==
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] console: Expand dummy functions for CFI
Date: Mon, 26 Feb 2018 16:04:20 -0800
Message-Id: <1519689860-7421-4-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519689860-7421-1-git-send-email-keescook@chromium.org>
References: <1519689860-7421-1-git-send-email-keescook@chromium.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This expands the no-op dummy functions into full prototypes to avoid
indirect call mismatches when running under Control Flow Integrity
checking, like with Clang's -fsanitize=cfi.

Co-Developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/misc/sisusbvga/sisusb_con.c | 67 +++++++++++++++++++++++++-------
 drivers/video/console/dummycon.c        | 69 +++++++++++++++++++++++++--------
 drivers/video/console/newport_con.c     | 10 ++---
 drivers/video/console/vgacon.c          | 20 +++++-----
 drivers/video/fbdev/core/fbcon.c        |  3 +-
 5 files changed, 121 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 998df891bdde..a0d6e0af957c 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1217,7 +1217,7 @@ sisusbcon_do_font_op(struct sisusb_usb_data *sisusb, int set, int slot,
 /* Interface routine */
 static int
 sisusbcon_font_set(struct vc_data *c, struct console_font *font,
-							unsigned flags)
+		   unsigned int flags)
 {
 	struct sisusb_usb_data *sisusb;
 	unsigned charcount = font->charcount;
@@ -1338,28 +1338,65 @@ static void sisusbdummycon_init(struct vc_data *vc, int init)
 	vc_resize(vc, 80, 25);
 }
 
-static int sisusbdummycon_dummy(void)
+static void sisusbdummycon_deinit(struct vc_data *vc) { }
+static void sisusbdummycon_clear(struct vc_data *vc, int sy, int sx,
+				 int height, int width) { }
+static void sisusbdummycon_putc(struct vc_data *vc, int c, int ypos,
+				int xpos) { }
+static void sisusbdummycon_putcs(struct vc_data *vc, const unsigned short *s,
+				 int count, int ypos, int xpos) { }
+static void sisusbdummycon_cursor(struct vc_data *vc, int mode) { }
+
+static bool sisusbdummycon_scroll(struct vc_data *vc, unsigned int top,
+				  unsigned int bottom, enum con_scroll dir,
+				  unsigned int lines)
 {
-    return 0;
+	return false;
 }
 
-#define SISUSBCONDUMMY	(void *)sisusbdummycon_dummy
+static int sisusbdummycon_switch(struct vc_data *vc)
+{
+	return 0;
+}
+
+static int sisusbdummycon_blank(struct vc_data *vc, int blank, int mode_switch)
+{
+	return 0;
+}
+
+static int sisusbdummycon_font_set(struct vc_data *vc,
+				   struct console_font *font,
+				   unsigned int flags)
+{
+	return 0;
+}
+
+static int sisusbdummycon_font_default(struct vc_data *vc,
+				       struct console_font *font, char *name)
+{
+	return 0;
+}
+
+static int sisusbdummycon_font_copy(struct vc_data *vc, int con)
+{
+	return 0;
+}
 
 static const struct consw sisusb_dummy_con = {
 	.owner =		THIS_MODULE,
 	.con_startup =		sisusbdummycon_startup,
 	.con_init =		sisusbdummycon_init,
-	.con_deinit =		SISUSBCONDUMMY,
-	.con_clear =		SISUSBCONDUMMY,
-	.con_putc =		SISUSBCONDUMMY,
-	.con_putcs =		SISUSBCONDUMMY,
-	.con_cursor =		SISUSBCONDUMMY,
-	.con_scroll =		SISUSBCONDUMMY,
-	.con_switch =		SISUSBCONDUMMY,
-	.con_blank =		SISUSBCONDUMMY,
-	.con_font_set =		SISUSBCONDUMMY,
-	.con_font_default =	SISUSBCONDUMMY,
-	.con_font_copy =	SISUSBCONDUMMY,
+	.con_deinit =		sisusbdummycon_deinit,
+	.con_clear =		sisusbdummycon_clear,
+	.con_putc =		sisusbdummycon_putc,
+	.con_putcs =		sisusbdummycon_putcs,
+	.con_cursor =		sisusbdummycon_cursor,
+	.con_scroll =		sisusbdummycon_scroll,
+	.con_switch =		sisusbdummycon_switch,
+	.con_blank =		sisusbdummycon_blank,
+	.con_font_set =		sisusbdummycon_font_set,
+	.con_font_default =	sisusbdummycon_font_default,
+	.con_font_copy =	sisusbdummycon_font_copy,
 };
 
 int
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index b90ef96e43d6..f2eafe2ed980 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -41,12 +41,47 @@ static void dummycon_init(struct vc_data *vc, int init)
 	vc_resize(vc, DUMMY_COLUMNS, DUMMY_ROWS);
 }
 
-static int dummycon_dummy(void)
+static void dummycon_deinit(struct vc_data *vc) { }
+static void dummycon_clear(struct vc_data *vc, int sy, int sx, int height,
+			   int width) { }
+static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
+static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
+			   int count, int ypos, int xpos) { }
+static void dummycon_cursor(struct vc_data *vc, int mode) { }
+
+static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
+			    unsigned int bottom, enum con_scroll dir,
+			    unsigned int lines)
+{
+	return false;
+}
+
+static int dummycon_switch(struct vc_data *vc)
 {
-    return 0;
+	return 0;
 }
 
-#define DUMMY	(void *)dummycon_dummy
+static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
+{
+	return 0;
+}
+
+static int dummycon_font_set(struct vc_data *vc, struct console_font *font,
+			     unsigned int flags)
+{
+	return 0;
+}
+
+static int dummycon_font_default(struct vc_data *vc,
+				 struct console_font *font, char *name)
+{
+	return 0;
+}
+
+static int dummycon_font_copy(struct vc_data *vc, int con)
+{
+	return 0;
+}
 
 /*
  *  The console `switch' structure for the dummy console
@@ -55,19 +90,19 @@ static int dummycon_dummy(void)
  */
 
 const struct consw dummy_con = {
-    .owner =		THIS_MODULE,
-    .con_startup =	dummycon_startup,
-    .con_init =		dummycon_init,
-    .con_deinit =	DUMMY,
-    .con_clear =	DUMMY,
-    .con_putc =		DUMMY,
-    .con_putcs =	DUMMY,
-    .con_cursor =	DUMMY,
-    .con_scroll =	DUMMY,
-    .con_switch =	DUMMY,
-    .con_blank =	DUMMY,
-    .con_font_set =	DUMMY,
-    .con_font_default =	DUMMY,
-    .con_font_copy =	DUMMY,
+	.owner =		THIS_MODULE,
+	.con_startup =	dummycon_startup,
+	.con_init =		dummycon_init,
+	.con_deinit =	dummycon_deinit,
+	.con_clear =	dummycon_clear,
+	.con_putc =		dummycon_putc,
+	.con_putcs =	dummycon_putcs,
+	.con_cursor =	dummycon_cursor,
+	.con_scroll =	dummycon_scroll,
+	.con_switch =	dummycon_switch,
+	.con_blank =	dummycon_blank,
+	.con_font_set =	dummycon_font_set,
+	.con_font_default =	dummycon_font_default,
+	.con_font_copy =	dummycon_font_copy,
 };
 EXPORT_SYMBOL_GPL(dummy_con);
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 42d02a206059..6897bd0fc00e 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -673,14 +673,14 @@ static bool newport_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 	return true;
 }
 
-static int newport_dummy(struct vc_data *c)
+static int newport_set_origin(struct vc_data *vc)
 {
 	return 0;
 }
 
-#define DUMMY (void *) newport_dummy
+static void newport_save_screen(struct vc_data *vc) { }
 
-const struct consw newport_con = {
+static const struct consw newport_con = {
 	.owner		  = THIS_MODULE,
 	.con_startup	  = newport_startup,
 	.con_init	  = newport_init,
@@ -694,8 +694,8 @@ const struct consw newport_con = {
 	.con_blank	  = newport_blank,
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
-	.con_set_origin	  = DUMMY,
-	.con_save_screen  = DUMMY
+	.con_set_origin	  = newport_set_origin,
+	.con_save_screen  = newport_save_screen
 };
 
 static int newport_probe(struct gio_device *dev,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index a17ba1465815..f09e17b60e45 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1272,7 +1272,8 @@ static int vgacon_adjust_height(struct vc_data *vc, unsigned fontheight)
 	return 0;
 }
 
-static int vgacon_font_set(struct vc_data *c, struct console_font *font, unsigned flags)
+static int vgacon_font_set(struct vc_data *c, struct console_font *font,
+			   unsigned int flags)
 {
 	unsigned charcount = font->charcount;
 	int rc;
@@ -1407,21 +1408,20 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
  *  The console `switch' structure for the VGA based console
  */
 
-static int vgacon_dummy(struct vc_data *c)
-{
-	return 0;
-}
-
-#define DUMMY (void *) vgacon_dummy
+static void vgacon_clear(struct vc_data *vc, int sy, int sx, int height,
+			 int width) { }
+static void vgacon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
+static void vgacon_putcs(struct vc_data *vc, const unsigned short *s,
+			 int count, int ypos, int xpos) { }
 
 const struct consw vga_con = {
 	.owner = THIS_MODULE,
 	.con_startup = vgacon_startup,
 	.con_init = vgacon_init,
 	.con_deinit = vgacon_deinit,
-	.con_clear = DUMMY,
-	.con_putc = DUMMY,
-	.con_putcs = DUMMY,
+	.con_clear = vgacon_clear,
+	.con_putc = vgacon_putc,
+	.con_putcs = vgacon_putcs,
 	.con_cursor = vgacon_cursor,
 	.con_scroll = vgacon_scroll,
 	.con_switch = vgacon_switch,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5baf7bc054e1..3e330e0f56ed 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2595,7 +2595,8 @@ static int fbcon_copy_font(struct vc_data *vc, int con)
  *  is ever implemented.
  */
 
-static int fbcon_set_font(struct vc_data *vc, struct console_font *font, unsigned flags)
+static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
+			  unsigned int flags)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	unsigned charcount = font->charcount;
-- 
2.7.4

