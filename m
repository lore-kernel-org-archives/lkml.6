Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeCNPnZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:43:25 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeCNPnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:43:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 18/47] fbdev: s1d13xxxfb: remove m32r specific hacks
Date: Wed, 14 Mar 2018 16:35:31 +0100
Message-Id: <20180314153603.3127932-19-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:pnCQlRTK4nB2L1CvvzU1b6hzXQZnghdtwfchkoLYZkruC2iiJ24
 c/OOcArLdpXMEJTdqIWVEzp2dYzsa+gkK4EmCEPcmoBfFHcDoeZF9dQodxt9Dy3ml+1EcWN
 x6LsDCOHpQwvPbDke6DtCTNN8uqpHNwtobtIMNTTbqogpcvllXY6aOU6xVwopXoy3/DmX9n
 RapiKhUAQBdyqa4UKOW8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:346y4PUNzGE=:V/ih5/f+nm7y8gTrZrDo0x
 9t9EW75mL3wICqXlleofEf5v0zehVMkZjRySPd21jm0QZEBJTJtlVOZqbN8fZogyAp14P+bDa
 b0mgQl1IYxa8fQLTdP+3IbdrJUn90Sk1rsKIbsT8NMMpwkKIPBHFuOa9pHRta16EJUPK3qcwz
 5CR3uUcX9+i3BK7j+V7Zlv7TEm1ufq+WbHbCgXtAqgelkDjfal44rjYpulugSXZy7H5wDD/ho
 Olwag1v/9ycdN+LG4MDzL/bXYBAuxNqjevYOurqjF4JEG+Avk3tFfy2iWEiGFZVAZikVmqw6E
 R0NV9rBM1vB6AcXXNdMNsQsvAYTMYKXcPKG2C8MHd6IkrUXAuuqjcWmSpmsyfqVOxd5UUhNdO
 S4H/iJxIpEWZFKqWbWFX1o/f+MDsutXzSoAuGVDI260qU3jzHs8oM7qE5joHe7QShF9kwFgvL
 Jnd5msVWc5wBTbUJ4vZqJqwYlxwB6AVBpVow3h0+dU3Yhg454SDWxkpLBeJRsc1BOo6SWdxpB
 BNx2Hm8T9HLsGu6V0Zv1Xni/xdDsvbutvC29b2Zq2c3IjHD9Ilp9ienfksgchu0Scbr29mAMn
 hZ0w8cxnsvijp0LdA29cTRU7lC07oHcAp1TS0lURTCnf8t2DId1WM57Yp4v9sO7BH11PO55te
 xKENmadZp0tRJSCYN8lTSLzYwyr0HJWLd4vh2/R+ZlnIVNFZmXYYCwWxmZ85kWMa6vHdhjx1Q
 uArLJGbnrh2aKbIu/ZyBAxMyK5Ge2wWr2ChtAw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m32r architecture is being removed, so this is no longer needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/s1d13xxxfb.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 5d6179ef0298..e04efb567b5c 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -96,18 +96,12 @@ static const struct fb_fix_screeninfo s1d13xxxfb_fix = {
 static inline u8
 s1d13xxxfb_readreg(struct s1d13xxxfb_par *par, u16 regno)
 {
-#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_OPSPUT) || defined(CONFIG_PLAT_MAPPI3)
-	regno=((regno & 1) ? (regno & ~1L) : (regno + 1));
-#endif
 	return readb(par->regs + regno);
 }
 
 static inline void
 s1d13xxxfb_writereg(struct s1d13xxxfb_par *par, u16 regno, u8 value)
 {
-#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_OPSPUT) || defined(CONFIG_PLAT_MAPPI3)
-	regno=((regno & 1) ? (regno & ~1L) : (regno + 1));
-#endif
 	writeb(value, par->regs + regno);
 }
 
@@ -296,11 +290,7 @@ s1d13xxxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			dbg("s1d13xxxfb_setcolreg: pseudo %d, val %08x\n",
 				    regno, pseudo_val);
 
-#if defined(CONFIG_PLAT_MAPPI)
-			((u32 *)info->pseudo_palette)[regno] = cpu_to_le16(pseudo_val);
-#else
 			((u32 *)info->pseudo_palette)[regno] = pseudo_val;
-#endif
 
 			break;
 		case FB_VISUAL_PSEUDOCOLOR:
-- 
2.9.0
