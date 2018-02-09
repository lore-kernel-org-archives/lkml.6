Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbeBIX6t (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:58:49 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:41240 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753355AbeBIX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:58:43 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.123.133) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: miguel.ojeda.sandonis@gmail.com
Cc: linux-kernel@vger.kernel.org, Robert Abel <rabel@robertabel.eu>
Subject: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for graphics
 command
Date: Sat, 10 Feb 2018 00:50:10 +0100
Message-Id: <20180209235012.4993-2-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180209235012.4993-1-rabel@robertabel.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu>
X-PPP-Message-ID: <20180209235039.28608.58738@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The graphics command expects 16 hexadecimal literals, but would allow characters in range [0-9a-zA-Z] instead of [0-9a-fA-F].

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 drivers/auxdisplay/charlcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 642afd88870b..324d02f9f1c5 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -441,9 +441,9 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 			shift ^= 4;
 			if (*esc >= '0' && *esc <= '9') {
 				value |= (*esc - '0') << shift;
-			} else if (*esc >= 'A' && *esc <= 'Z') {
+			} else if (*esc >= 'A' && *esc <= 'F') {
 				value |= (*esc - 'A' + 10) << shift;
-			} else if (*esc >= 'a' && *esc <= 'z') {
+			} else if (*esc >= 'a' && *esc <= 'f') {
 				value |= (*esc - 'a' + 10) << shift;
 			} else {
 				esc++;
-- 
2.11.0
