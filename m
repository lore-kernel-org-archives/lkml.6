Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeEDIYK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:24:10 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:56822 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeEDIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:24:08 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180504082406epoutp022e7cfe38abaadf8a3c7d06a0663151e9~rY3OChZ6k1545915459epoutp02r
X-AuditID: b6c32a4a-a61ff700000010d4-ef-5aec18a5c828
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: madhur.verma@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH v1 09/13] drm/kms/mode/sun4i-tv: using helper func
 drm_display_mode_from_videomode for calculating timing parameters
Date: Fri,  4 May 2018 13:53:25 +0530
Message-Id: <1525422205-2915-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180503110216.63bg3kw7cwppqbzx@flea>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTQRh2dtvtglbXqjhUxWaDCYfUtrawGOoR0Kw30SchBjdl0hJpi93W
        C7wiFkVbvDWIIPG+FVAr4pHWIx6BB1E0RiWKooAS5fIgwS0L8e37v2O+mT9D4ooiQklm2ZzI
        YeOyaSJUcj0QHRV3Eralae4UTWA8tY8xpr6rnWBa6tpwpuLjSynzvLqEYAIHThBM49e7gLlY
        t03CnH7agDO//XXYzFC29EIue+XDeSl7s/itjL3R3Shl3+98hLGVJzax3qpzgO2oiEgl01CS
        BXGZyKFCNpM9M8tmNtLzl2YkZxjiNdo4bSKTQKtsnBUZ6ZQFqXFzsrKFK9Kq1Vy2S6BSOZ6n
        p0xPcthdTqSy2HmnkU7XanVqrSZBrdPp1HrD8mk6g2BZgSzfnnRKcraMX1vjeYNvBmVhhSCE
        hJQeej6UgCBWULcA9HnDC0GogH8C2PzrgUwUugGsL80bDJQ2N0lF/jaAZQ0jxEAXgGcKfJKg
        QAim5pLD0qAwmmoAsCpQJAkOOFUE4JeWff3KKMoN4O58d/9ZEmoS3HO8rz8up2bD7rbPmNgX
        AV/X7sALAUmGUFPhix4umIXUMwJ6e08PeFJgZetlmYhHwZZHVQNYCTu+3ybEwFYAGy+Vy8Rh
        F4DbdzwccM2A+fvvSYINOBUNL1dPEWkjrCx/SQQxTg2Hnr9NWNACKTnc7laIlkh49ksAH+zq
        PVYoFS0s7PSMFOlZsOZ+mUxckfDemoNPsd1gYvH/smMAnAPhKIe3mhFvyNHZ0Bo1z1l5l82s
        NtmtFaD/M8bM84FTtQv8gCIBPUzuM7amKaTcan6d1Q8gidOj5cV+gZJncuvWI4c9w+HKRrwf
        GITF7sGVY0x24WvbnBlafaJGHx+foNVoEvX0WPnrx+/SFJSZc6KVCOUgx2AOI0OUm8GqqPSN
        V5KivePrl73/E3ekwYWNxSJM7lu/UdhVxd6hpemTve0b3hiT513bNCa3p8P6KWXLQe7QyLsF
        fVETlgTcLXOV0mTgWvmq2hymygy/MfVq7J/Wn7nG8CGLllVQPybXpTYnZi1eEmvXjLPELIx3
        pXgik0xHY3f56tfnXWh3NUXREt7CaWNwB8/9AzjbgAqiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSvO4SiTdRBo9+mFj0njvJZHHl63s2
        i1fn3zBbbHp8jdXi8q45bBaHpy5hs3jwcj+jxdrzrSwWy09fZ7b4eeg8kwOXx7w11R4bHq1m
        9dg56y67x/ZvD1g97ncfZ/LYvKTeo2/LKkaPz5vkAjiiuGxSUnMyy1KL9O0SuDLenvrCUtAo
        U7Gn9zZzA+N8sS5GTg4JAROJec+fsHYxcnEICexmlJhx6jgrREJKYtmbbWwQtrDEyn/P2SGK
        PgMVnXvBDpJgA+p+PmcGWLeIwG1GieUv14JVMQtMZpRomfgMzBEWaGGUONN5gxmkhUVAVWLi
        4v8sIDavgKvEtzfPmCB2yEncPNcJVMPBwSlgLHH1eyJIWEjASOL29UlMExj5FjAyrGKUTC0o
        zk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5ZLc0djJeXxB9iFOBgVOLhFXB4HSXEmlhWXJl7
        iFGCg1lJhHfWIaAQb0piZVVqUX58UWlOavEhRmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwc
        nFINjBoOW186nrwbfnz9jWSV2IOn3FeYXw/T61l/80we28GzM/eqHPx9a2HtknUHL9x0mPyr
        wYg5zibm/c332uHxriH739n+UnTfGXJq+69CsyyGCyuFuZ8nrORU3btIPmLFlI+rvWq3piqL
        1DGm2t+rt1K9VNeguoZLpH6Xxrpyy3X3n5x9yhlvf0WJpTgj0VCLuag4EQA+ii+mVQIAAA==
X-CMS-MailID: 20180504082405epcas5p212d6a9fbb2a0baac4166cb5b68616055
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180504082405epcas5p212d6a9fbb2a0baac4166cb5b68616055
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180504082405epcas5p212d6a9fbb2a0baac4166cb5b68616055
X-RootMTR: 20180504082405epcas5p212d6a9fbb2a0baac4166cb5b68616055
References: <20180503110216.63bg3kw7cwppqbzx@flea>
        <CGME20180504082405epcas5p212d6a9fbb2a0baac4166cb5b68616055@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for horizonal/vertical sync_start/end
helper func drm_display_mode_from_videomode is used

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Acked-by: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---

 v1: Added acked-by fields

 drivers/gpu/drm/sun4i/sun4i_tv.c | 67 +++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index b070d52..7ffa930 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -21,6 +21,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
+#include <video/videomode.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
@@ -147,16 +148,7 @@ struct tv_mode {
 	u16		front_porch;
 	u16		line_number;
 	u16		vblank_level;
-
-	u32		hdisplay;
-	u16		hfront_porch;
-	u16		hsync_len;
-	u16		hback_porch;
-
-	u32		vdisplay;
-	u16		vfront_porch;
-	u16		vsync_len;
-	u16		vback_porch;
+	struct videomode vm;
 
 	bool		yc_en;
 	bool		dac3_en;
@@ -223,16 +215,16 @@ static const struct tv_mode tv_modes[] = {
 		.back_porch	= 118,
 		.front_porch	= 32,
 		.line_number	= 525,
-
-		.hdisplay	= 720,
-		.hfront_porch	= 18,
-		.hsync_len	= 2,
-		.hback_porch	= 118,
-
-		.vdisplay	= 480,
-		.vfront_porch	= 26,
-		.vsync_len	= 2,
-		.vback_porch	= 17,
+		.vm = {
+			.hactive	= 720,
+			.hfront_porch	= 18,
+			.hsync_len	= 2,
+			.hback_porch	= 118,
+			.vactive	= 480,
+			.vfront_porch	= 26,
+			.vsync_len	= 2,
+			.vback_porch	= 17,
+		},
 
 		.vblank_level	= 240,
 
@@ -249,16 +241,16 @@ static const struct tv_mode tv_modes[] = {
 		.back_porch	= 138,
 		.front_porch	= 24,
 		.line_number	= 625,
-
-		.hdisplay	= 720,
-		.hfront_porch	= 3,
-		.hsync_len	= 2,
-		.hback_porch	= 139,
-
-		.vdisplay	= 576,
-		.vfront_porch	= 28,
-		.vsync_len	= 2,
-		.vback_porch	= 19,
+		.vm = {
+			.hactive	= 720,
+			.hfront_porch	= 3,
+			.hsync_len	= 2,
+			.hback_porch	= 139,
+			.vactive	= 576,
+			.vfront_porch	= 28,
+			.vsync_len	= 2,
+			.vback_porch	= 19,
+		},
 
 		.vblank_level	= 252,
 
@@ -311,9 +303,9 @@ static const struct tv_mode *sun4i_tv_find_tv_by_mode(const struct drm_display_m
 
 		DRM_DEBUG_DRIVER("Comparing mode %s vs %s (X: %d vs %d)",
 				 mode->name, tv_mode->name,
-				 mode->vdisplay, tv_mode->vdisplay);
+				 mode->vdisplay, tv_mode->vm.vactive);
 
-		if (mode->vdisplay == tv_mode->vdisplay)
+		if (mode->vdisplay == tv_mode->vm.vactive)
 			return tv_mode;
 	}
 
@@ -325,19 +317,10 @@ static void sun4i_tv_mode_to_drm_mode(const struct tv_mode *tv_mode,
 {
 	DRM_DEBUG_DRIVER("Creating mode %s\n", mode->name);
 
+	drm_display_mode_from_videomode(&tv_mode->vm, mode);
 	mode->type = DRM_MODE_TYPE_DRIVER;
 	mode->clock = 13500;
 	mode->flags = DRM_MODE_FLAG_INTERLACE;
-
-	mode->hdisplay = tv_mode->hdisplay;
-	mode->hsync_start = mode->hdisplay + tv_mode->hfront_porch;
-	mode->hsync_end = mode->hsync_start + tv_mode->hsync_len;
-	mode->htotal = mode->hsync_end  + tv_mode->hback_porch;
-
-	mode->vdisplay = tv_mode->vdisplay;
-	mode->vsync_start = mode->vdisplay + tv_mode->vfront_porch;
-	mode->vsync_end = mode->vsync_start + tv_mode->vsync_len;
-	mode->vtotal = mode->vsync_end  + tv_mode->vback_porch;
 }
 
 static void sun4i_tv_disable(struct drm_encoder *encoder)
-- 
2.7.4
