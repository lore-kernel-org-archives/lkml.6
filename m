Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeBIX6p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:58:45 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:57517 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbeBIX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:58:43 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.123.133) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: miguel.ojeda.sandonis@gmail.com
Cc: linux-kernel@vger.kernel.org, Robert Abel <rabel@robertabel.eu>
Subject: [PATCH 2/3] auxdisplay: charlcd: use null character instead of zero
 literal to terminate strings
Date: Sat, 10 Feb 2018 00:50:11 +0100
Message-Id: <20180209235012.4993-3-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180209235012.4993-2-rabel@robertabel.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu>
 <20180209235012.4993-2-rabel@robertabel.eu>
X-PPP-Message-ID: <20180209235040.28621.29407@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using '\0' instead of plain 0 makes the intent clearer that this is indeed a string and not a series of integers.

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 drivers/auxdisplay/charlcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 324d02f9f1c5..92549c8344a4 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -527,7 +527,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 	if ((c != '\n') && priv->esc_seq.len >= 0) {
 		/* yes, let's add this char to the buffer */
 		priv->esc_seq.buf[priv->esc_seq.len++] = c;
-		priv->esc_seq.buf[priv->esc_seq.len] = 0;
+		priv->esc_seq.buf[priv->esc_seq.len] = '\0';
 	} else {
 		/* aborts any previous escape sequence */
 		priv->esc_seq.len = -1;
@@ -536,7 +536,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 		case LCD_ESCAPE_CHAR:
 			/* start of an escape sequence */
 			priv->esc_seq.len = 0;
-			priv->esc_seq.buf[priv->esc_seq.len] = 0;
+			priv->esc_seq.buf[priv->esc_seq.len] = '\0';
 			break;
 		case '\b':
 			/* go back one char and clear it */
-- 
2.11.0
