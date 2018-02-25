Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeBYXy5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 18:54:57 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:57542 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeBYXyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 18:54:51 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.101.1) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Abel <rabel@robertabel.eu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 2/4] auxdisplay: charlcd: name x/y address struct
Date: Mon, 26 Feb 2018 00:54:30 +0100
Message-Id: <20180225235432.31209-3-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225235432.31209-2-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
X-PPP-Message-ID: <20180225235449.31404.53783@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 drivers/auxdisplay/charlcd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index e3b2fd15c5a3..a3d364e6c666 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -67,6 +67,11 @@
 #define LCD_ESCAPE_LEN		24	/* Max chars for LCD escape command */
 #define LCD_ESCAPE_CHAR		27	/* Use char 27 for escape command */
 
+struct charlcd_priv_addr {
+	unsigned long int x;
+	unsigned long int y;
+};
+
 struct charlcd_priv {
 	struct charlcd lcd;
 
@@ -80,12 +85,9 @@ struct charlcd_priv {
 	unsigned long int flags;
 
 	/* Contains the LCD X and Y offset */
-	struct {
-		unsigned long int x;
-		unsigned long int y;
-	} addr;
+	struct charlcd_priv_addr addr;
 
-	/* Current escape sequence and it's length or -1 if outside */
+	/* Current escape sequence and its length or -1 if outside */
 	struct {
 		char buf[LCD_ESCAPE_LEN + 1];
 		int len;
-- 
2.11.0
