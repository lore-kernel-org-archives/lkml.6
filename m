Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeFCSTD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 14:19:03 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:33048 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeFCSTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 14:19:02 -0400
Date: Sun, 3 Jun 2018 20:18:58 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Anton Zinoviev <anton@lml.bas.bg>
Subject: [PATCH] kbd: complete dead keys definitions
Message-ID: <20180603181858.dtyhhmb7f43cqg3d@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Anton Zinoviev <anton@lml.bas.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This completes dead keys definitions for internationalization
completeness on the console.  The representatives have been chosen
coherently with libx11 compose sequences, which avoid symetry conflicts
(e.g. there is U with caron, but no c with breve).

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-4.15/drivers/s390/char/keyboard.c
===================================================================
--- linux-4.15.orig/drivers/s390/char/keyboard.c
+++ linux-4.15/drivers/s390/char/keyboard.c
@@ -39,8 +39,34 @@ static const int kbd_max_vals[] = {
 };
 static const int KBD_NR_TYPES = ARRAY_SIZE(kbd_max_vals);
 
-static unsigned char ret_diacr[NR_DEAD] = {
-	'`', '\'', '^', '~', '"', ','
+static const unsigned char ret_diacr[NR_DEAD] = {
+	'`',	/* dead_grave */
+	'\'',	/* dead_acute */
+	'^',	/* dead_circumflex */
+	'~',	/* dead_tilda */
+	'"',	/* dead_diaeresis */
+	',',	/* dead_cedilla */
+	'_',	/* dead_macron */
+	'U',	/* dead_breve */
+	'.',	/* dead_abovedot */
+	'*',	/* dead_abovering */
+	'=',	/* dead_doubleacute */
+	'c',	/* dead_caron */
+	'k',	/* dead_ogonek */
+	'i',	/* dead_iota */
+	'#',	/* dead_voiced_sound */
+	'o',	/* dead_semivoiced_sound */
+	'!',	/* dead_belowdot */
+	'?',	/* dead_hook */
+	'+',	/* dead_horn */
+	'-',	/* dead_stroke */
+	')',	/* dead_abovecomma */
+	'(',	/* dead_abovereversedcomma */
+	':',	/* dead_doublegrave */
+	'n',	/* dead_invertedbreve */
+	';',	/* dead_belowcomma */
+	'$',	/* dead_currency */
+	'@',	/* dead_greek */
 };
 
 /*
Index: linux-4.15/drivers/tty/vt/keyboard.c
===================================================================
--- linux-4.15.orig/drivers/tty/vt/keyboard.c
+++ linux-4.15/drivers/tty/vt/keyboard.c
@@ -690,7 +690,35 @@ static void k_dead2(struct vc_data *vc,
  */
 static void k_dead(struct vc_data *vc, unsigned char value, char up_flag)
 {
-	static const unsigned char ret_diacr[NR_DEAD] = {'`', '\'', '^', '~', '"', ',' };
+	static const unsigned char ret_diacr[NR_DEAD] = {
+		'`',	/* dead_grave */
+		'\'',	/* dead_acute */
+		'^',	/* dead_circumflex */
+		'~',	/* dead_tilda */
+		'"',	/* dead_diaeresis */
+		',',	/* dead_cedilla */
+		'_',	/* dead_macron */
+		'U',	/* dead_breve */
+		'.',	/* dead_abovedot */
+		'*',	/* dead_abovering */
+		'=',	/* dead_doubleacute */
+		'c',	/* dead_caron */
+		'k',	/* dead_ogonek */
+		'i',	/* dead_iota */
+		'#',	/* dead_voiced_sound */
+		'o',	/* dead_semivoiced_sound */
+		'!',	/* dead_belowdot */
+		'?',	/* dead_hook */
+		'+',	/* dead_horn */
+		'-',	/* dead_stroke */
+		')',	/* dead_abovecomma */
+		'(',	/* dead_abovereversedcomma */
+		':',	/* dead_doublegrave */
+		'n',	/* dead_invertedbreve */
+		';',	/* dead_belowcomma */
+		'$',	/* dead_currency */
+		'@',	/* dead_greek */
+	};
 
 	k_deadunicode(vc, ret_diacr[value], up_flag);
 }
Index: linux-4.15/include/uapi/linux/keyboard.h
===================================================================
--- linux-4.15.orig/include/uapi/linux/keyboard.h
+++ linux-4.15/include/uapi/linux/keyboard.h
@@ -357,8 +357,29 @@
 #define K_DTILDE	K(KT_DEAD,3)
 #define K_DDIERE	K(KT_DEAD,4)
 #define K_DCEDIL	K(KT_DEAD,5)
+#define K_DMACRON	K(KT_DEAD,6)
+#define K_DBREVE	K(KT_DEAD,7)
+#define K_DABDOT	K(KT_DEAD,8)
+#define K_DABRING	K(KT_DEAD,9)
+#define K_DDBACUTE	K(KT_DEAD,10)
+#define K_DCARON	K(KT_DEAD,11)
+#define K_DOGONEK	K(KT_DEAD,12)
+#define K_DIOTA		K(KT_DEAD,13)
+#define K_DVOICED	K(KT_DEAD,14)
+#define K_DSEMVOICED	K(KT_DEAD,15)
+#define K_DBEDOT	K(KT_DEAD,16)
+#define K_DHOOK		K(KT_DEAD,17)
+#define K_DHORN		K(KT_DEAD,18)
+#define K_DSTROKE	K(KT_DEAD,19)
+#define K_DABCOMMA	K(KT_DEAD,20)
+#define K_DABREVCOMMA	K(KT_DEAD,21)
+#define K_DDBGRAVE	K(KT_DEAD,22)
+#define K_DINVBREVE	K(KT_DEAD,23)
+#define K_DBECOMMA	K(KT_DEAD,24)
+#define K_DCURRENCY	K(KT_DEAD,25)
+#define K_DGREEK	K(KT_DEAD,26)
 
-#define NR_DEAD		6
+#define NR_DEAD		27
 
 #define K_DOWN		K(KT_CUR,0)
 #define K_LEFT		K(KT_CUR,1)
