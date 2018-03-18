Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeCRLDx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 07:03:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44620 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeCRLDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 07:03:52 -0400
X-Google-Smtp-Source: AG47ELsMg5yc3rpZXiMa2biTSdJhiykQzDpXBbo1sjVrOM1g0LJ0fgQZkHwm+4ZZFtgLzdUIdBivfw==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: arnaud.patard@rtp-net.org
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org,
        Pratik Jain <pratik.jain0509@gmail.com>
Subject: [PATCH] Staging: xgifb: XGI_main_26.c: Fixed multi-line dereference warning
Date: Sun, 18 Mar 2018 16:33:41 +0530
Message-Id: <20180318110341.26230-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style issues detected by checkpatch.pl

Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
---
 drivers/staging/xgifb/XGI_main_26.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
index 10107de0119a..d4d289f6fe87 100644
--- a/drivers/staging/xgifb/XGI_main_26.c
+++ b/drivers/staging/xgifb/XGI_main_26.c
@@ -770,7 +770,9 @@ static void XGIfb_post_setmode(struct xgifb_video_info *xgifb_info)
 				xgifb_reg_and(vb->Part2Port, 0x3a, 0x1f);
 
 				if (xgifb_info->TV_plug == TVPLUG_SVIDEO) {
-					xgifb_reg_and(vb->Part2Port, 0x30, 0xdf);
+					xgifb_reg_and(vb->Part2Port,
+							0x30,
+							0xdf);
 
 				} else if (xgifb_info->TV_plug
 						== TVPLUG_COMPOSITE) {
@@ -826,11 +828,15 @@ static void XGIfb_post_setmode(struct xgifb_video_info *xgifb_info)
 				xgifb_reg_and(vb->Part2Port, 0x3A, 0x1F);
 
 				if (xgifb_info->TV_plug == TVPLUG_SVIDEO) {
-					xgifb_reg_and(vb->Part2Port, 0x30, 0xDF);
+					xgifb_reg_and(vb->Part2Port,
+							0x30,
+							0xDF);
 
 				} else if (xgifb_info->TV_plug
 						== TVPLUG_COMPOSITE) {
-					xgifb_reg_or(vb->Part2Port, 0x30, 0x20);
+					xgifb_reg_or(vb->Part2Port,
+							0x30,
+							0x20);
 
 					switch (xgifb_info->video_width) {
 					case 640:
@@ -1024,7 +1030,9 @@ static int XGIfb_do_set_var(struct fb_var_screeninfo *var, int isactive,
 			xgifb_info->XGI310_AccelDepth = 0x00010000;
 #if defined(__BIG_ENDIAN)
 			cr_data = xgifb_reg_get(vb->P3d4, 0x4D);
-			xgifb_reg_set(vb->P3d4, 0x4D, ((cr_data & 0xE0) | 0x0B));
+			xgifb_reg_set(vb->P3d4,
+					0x4D,
+					((cr_data & 0xE0) | 0x0B));
 #endif
 			xgifb_info->video_cmap_len = 16;
 			break;
@@ -1034,7 +1042,9 @@ static int XGIfb_do_set_var(struct fb_var_screeninfo *var, int isactive,
 			xgifb_info->video_cmap_len = 16;
 #if defined(__BIG_ENDIAN)
 			cr_data = xgifb_reg_get(vb->P3d4, 0x4D);
-			xgifb_reg_set(vb->P3d4, 0x4D, ((cr_data & 0xE0) | 0x15));
+			xgifb_reg_set(vb->P3d4,
+					0x4D,
+					((cr_data & 0xE0) | 0x15));
 #endif
 			break;
 		default:
@@ -1894,7 +1904,8 @@ static int xgifb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	xgifb_info->refresh_rate = refresh_rate;
 	if (xgifb_info->refresh_rate == 0)
 		xgifb_info->refresh_rate = 60;
-	if (XGIfb_search_refresh_rate(xgifb_info, xgifb_info->refresh_rate) == 0) {
+	if (XGIfb_search_refresh_rate(xgifb_info, xgifb_info->refresh_rate)
+			== 0) {
 		xgifb_info->rate_idx = 1;
 		xgifb_info->refresh_rate = 60;
 	}
-- 
2.16.2
