Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeECK61 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:58:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:43585 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:58:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180503105822epoutp0387f077cc81d9cc65b94d59de009f8475~rHUoOlx1T2879828798epoutp03r
X-AuditID: b6c32a4b-185ff70000001094-10-5aeaeb4d80e0
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 09/13] drm/kms/mode/sun4i-tv: using helper func
 drm_display_mode_from_videomode for calculating timing parameters
Date: Thu,  3 May 2018 16:28:06 +0530
Message-Id: <6919c8943505fe0c1f700e223a77194f85e64a58.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUgTYRzHeXbb7Qxnx1R6nGDrSsiFa7c2d0pqVsSgEiH6ZxXr0oepuZvs
        tuzlD5XMt2kpGJVZGEWUvcmyMnM1tDeLtNA0IctedUvsxZTCgjZv0n+/7/N8Pvf9cTwEJq/A
        FUQe50B2ji2g8AXim90JqsTML36T5mQyU9vbI2IGpr/ijL9vAmPcHwYlTH9HE850Hz2HM6O+
        e4C50ndIzPzu6hOtCTOevnzA2Pr+ksR4a2ZUYnzreiQyXj9XbDzc1gKMU+64LKkJrc5FbA6y
        KxGXbcvJ4yyp1MYt5nVmfZKGTqSTGQOl5FgrSqXWb8pK3JBXENiLUu5hC5yBoyyW56mVaavt
        NqcDKXNtvCOV2kbTWjWtMai1Wq1ap9+RotUHkJ0od6zvNlZ4PnbvTP8oVgL6o6tBGAFJHWxs
        eY5VgwWEnLwDYEnZhVD4AWBpfbNICDMA/jo5KJpXmku9IcoD4MsTPlwI0wBW1YyIgxQeoMaa
        jkuCF1HkEIBt3UfEwYCRLgBrPWVzfiR5EMDZ6u/SoCIm4+Gn1s45XUZuhyXfrkqEwjg43FsV
        EAgijEyBnT93BV1IenHYXnEQF5j18NTnOqkwR0L/o7bQrIBTkx5cEAJlo1fPSIVQA2Bl1cMQ
        lQ7LGrziYANGJsBrHSuF41Q43DkNgjNGRsDa2Y+iIAJJGawslwvIMnhxvBub7/rTXB3a2Qjr
        j9WEdsuAHS9OzX1GTtYCODK5tA4sbvxf1gxAC4hBhbzVgnh94SoOFal51so7OYs622Z1g7lH
        qNrYDty9m7oASQAqXOZ95jPJJewefp+1C0ACo6JkDS6/SS7LYfftR3ab2e4sQHwX0Ad+bD2m
        iM62BZ405zDTumSNLinJQGs0yTpqkWy4541JTlpYB9qNUCGyz3siIkxRAmruH+ttX/5Kprxk
        bS3NnLzzJP9if8tk0d9yl8dw4+9sWrErc1l403vz9IRiYf7mp1tduvgkQ0MUzXiLfEee12W8
        G6BOu9V3l4d/S1eNn13heRxTf1ZV7NTHDIHveekPwiMHJhKiM50P1sbHernLEXGvLTHrdEsG
        p6RLYlOU1xpZSsznsrQKs/PsP1EBZASaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSvK7v61dRBss/qlr0njvJZHHl63s2
        i1fn3zBbbHp8jdXi8q45bBaHpy5hs3jwcj+jxdrzrSwWPw+dZ3Lg9Ji3ptpjw6PVrB7bvz1g
        9bjffZzJY/OSeo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DKeH5+J3PBMumKb5cfMDcwXhbt
        YuTkkBAwkVjQeIC5i5GLQ0hgN6PE4T9HmCASUhLL3mxjg7CFJVb+e84OUfSZUWLau2PsIAk2
        oO7nc2awgiREBG4zSix/uRasilmgl1Hixf79YFXCAo2MEh9vOILYLAKqEk837GEBsXkFYiQa
        PqxjhVghJ3HzXCfQHRwcnAJWEnu+JIGEhQQsJdr7DrNOYORbwMiwilEytaA4Nz232LDAMC+1
        XK84Mbe4NC9dLzk/dxMjODi1NHcwXl4Sf4hRgINRiYc34/TLKCHWxLLiytxDjBIczEoivFO6
        X0UJ8aYkVlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwOhXaulX
        6JZbxqTcuujXzQ2H16jP2ZF8IbFGaeH+U4+2V4WnNk/xmjKNKebHxFtVdUEmcft0pbgvbVr4
        43/sbXnPyRlHZCq4ZlzxVPddFq48KydszvuVDB8klzxxl265fvz47Nqzi3fcOmjVMf/v3bdq
        AbXVkqJnj8oxntWorat3ePDT9dP/g9OVWIozEg21mIuKEwEYMBhxSgIAAA==
X-CMS-MailID: 20180503105821epcas5p21a35d9eb29f83201d337a195d218fdd3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503105821epcas5p21a35d9eb29f83201d337a195d218fdd3
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503105821epcas5p21a35d9eb29f83201d337a195d218fdd3
X-RootMTR: 20180503105821epcas5p21a35d9eb29f83201d337a195d218fdd3
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503105821epcas5p21a35d9eb29f83201d337a195d218fdd3@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for horizonal/vertical sync_start/end
helper func drm_display_mode_from_videomode is used

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
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
