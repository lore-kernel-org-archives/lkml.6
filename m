Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeBYXyx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 18:54:53 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:42035 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeBYXyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 18:54:49 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.101.1) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Abel <rabel@robertabel.eu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 1/4] auxdisplay: charlcd: fix two-line command ^[[LN not
 marked as processed
Date: Mon, 26 Feb 2018 00:54:29 +0100
Message-Id: <20180225235432.31209-2-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225235432.31209-1-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
X-PPP-Message-ID: <20180225235447.31386.96825@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 drivers/auxdisplay/charlcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index a3486db03d81..e3b2fd15c5a3 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -362,6 +362,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		break;
 	case 'N':	/* Two Lines */
 		priv->flags |= LCD_FLAG_N;
+		processed = 1;
 		break;
 	case 'l':	/* Shift Cursor Left */
 		if (priv->addr.x > 0) {
-- 
2.11.0
