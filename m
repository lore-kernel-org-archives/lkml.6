Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeBIX6o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:58:44 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:43894 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbeBIX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:58:43 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.123.133) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: miguel.ojeda.sandonis@gmail.com
Cc: linux-kernel@vger.kernel.org, Robert Abel <rabel@robertabel.eu>
Subject: [PATCH 3/3] auxdisplay: charlcd: replace octal literal with form-feed
 escape sequence
Date: Sat, 10 Feb 2018 00:50:12 +0100
Message-Id: <20180209235012.4993-4-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180209235012.4993-3-rabel@robertabel.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu>
 <20180209235012.4993-2-rabel@robertabel.eu>
 <20180209235012.4993-3-rabel@robertabel.eu>
X-PPP-Message-ID: <20180209235040.28635.65214@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to resort to octal escape sequence for the form feed character when an established escape sequence exists.

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 drivers/auxdisplay/charlcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 92549c8344a4..a3486db03d81 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -555,7 +555,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 			/* back one char again */
 			lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
 			break;
-		case '\014':
+		case '\f':
 			/* quickly clear the display */
 			charlcd_clear_fast(lcd);
 			break;
-- 
2.11.0
