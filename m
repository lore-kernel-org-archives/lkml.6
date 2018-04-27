Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757642AbeD0LWl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:22:41 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28505 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeD0LWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:22:35 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180427112233epoutp03bf69c02adbd8176beb3ae321a3a115f6~pRyBh7hlM0700507005epoutp03L
X-AuditID: b6c32a37-4f9ff70000001030-c5-5ae307f8953c
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Simon Horman <horms+renesas@verge.net.au>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 2/3] drm: shmobile: remove unused MERAM support
Date: Fri, 27 Apr 2018 13:21:44 +0200
Message-id: <1524828105-26585-3-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCmru4P9sdRBg/+clpsnLGe1eLK1/ds
        FnNnT2K0uPD2A5tF58Ql7BYn+j6wWlzeNYfNYuvLd0wOHB4Tz+p6zO6Yyepxv/s4k0ffllWM
        HnN+fmPx+LxJLoAtissmJTUnsyy1SN8ugStj5ozFLAULXCsW3Z7K1sD4y6KLkZNDQsBEYtr+
        R8xdjFwcQgI7GCV62mawQzjfGSUOHPjGDlO16eEUFojEBkaJ9zemMUE4vxglrp54wQRSxSZg
        JTGxfRUjiC0ikCrRtvMsWAezwHlGiY1Td7CCJIQF7CUWHGkGs1kEVCX6dvxhA7F5BTwknjSc
        ZoJYJydx8thksBpOAU+J+30vwQ6UEJjDJnH16SIWiCIXiRV/L0DdJyzx6vgWIJsDyJaWuHTU
        FqK+mVHi2449zBA1Exgl9qwXgrCtJQ4fvwi2gFmAT+Ld1x5WiF5eiY42qBIPiXv/PkONd5RY
        emgpI8THcxglWla0sE1glFrAyLCKUSy1oDg3PbXYsMBYrzgxt7g0L10vOT93EyM4VrXMdzBu
        OOdziFGAg1GJh1fh3cMoIdbEsuLK3EOMEhzMSiK8O24DhXhTEiurUovy44tKc1KLDzFKc7Ao
        ifM+9TkTJSSQnliSmp2aWpBaBJNl4uCUamCMunxt9w8X7oyIXxcMnY+4H0q5Y3fiyfns6s4O
        T9Hzn3f6i4UzyPXaVF30Vf00R1b+3odbWwI9z2q1/u+tWZ1W8ejTJy9VbnsH3Tu3jnx0nvVy
        XY933NOg2hOz1UtlszLZv6SVLTI7K77gQ2k128rZGRsC2tx9lGbsc5s94YTJke2r3VYe5v6r
        xFKckWioxVxUnAgA+n6jMtECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsVy+t9jQd3v7I+jDLbf0rDYOGM9q8WVr+/Z
        LObOnsRoceHtBzaLzolL2C1O9H1gtbi8aw6bxdaX75gcODwmntX1mN0xk9XjfvdxJo++LasY
        Peb8/Mbi8XmTXABbFJdNSmpOZllqkb5dAlfGzBmLWQoWuFYsuj2VrYHxl0UXIyeHhICJxKaH
        U1i6GLk4hATWMUp82XqVCcL5xSjR82gPI0gVm4CVxMT2VWC2iECqxJw9fewgRcwCZxklbl67
        wAKSEBawl1hwpJkVxGYRUJXo2/GHDcTmFfCQeNJwmglinZzEyWOTwWo4BTwl7ve9ZAaxhYBq
        pna2MU1g5FnAyLCKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10vOT93EyMwtLYd1urbwXh/Sfwh
        RgEORiUeXoV3D6OEWBPLiitzDzFKcDArifDuuA0U4k1JrKxKLcqPLyrNSS0+xCjNwaIkzns7
        71ikkEB6YklqdmpqQWoRTJaJg1OqgdH9s+6UR/YH3SvWRs7J3p+gX3LlAffa5yp8e+9lt608
        7lA+NSpoxZ3gt89mFp0pPWeZsTdabcGSoNnb5zl4fM9stqm49TZOxTz2zAb9nQ659QH64neO
        Ss4+/yjt9tFj3+TarjQdFg1YZSl56FMny2ozzdMXUkwTvrNkVdvFLqxn7Fp9WXSWyAElluKM
        REMt5qLiRACjcjZ5KQIAAA==
X-CMS-MailID: 20180427112231epcas1p4cd63e2bf9216d7e8810f49e57bcf50c6
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180427112231epcas1p4cd63e2bf9216d7e8810f49e57bcf50c6
X-RootMTR: 20180427112231epcas1p4cd63e2bf9216d7e8810f49e57bcf50c6
References: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180427112231epcas1p4cd63e2bf9216d7e8810f49e57bcf50c6@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a521422ea4ae  ("ARM: shmobile: mackerel: Remove Legacy C
board code") MERAM functionality is unused. Remove it.

Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/gpu/drm/shmobile/Kconfig           |  1 -
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c  | 42 ------------------------------
 drivers/gpu/drm/shmobile/shmob_drm_crtc.h  |  1 -
 drivers/gpu/drm/shmobile/shmob_drm_drv.h   |  2 --
 drivers/gpu/drm/shmobile/shmob_drm_kms.c   | 11 --------
 drivers/gpu/drm/shmobile/shmob_drm_kms.h   |  1 -
 drivers/gpu/drm/shmobile/shmob_drm_plane.c |  2 --
 include/linux/platform_data/shmob_drm.h    |  4 ---
 8 files changed, 64 deletions(-)

diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/shmobile/Kconfig
index c987c82..0426d66 100644
--- a/drivers/gpu/drm/shmobile/Kconfig
+++ b/drivers/gpu/drm/shmobile/Kconfig
@@ -2,7 +2,6 @@ config DRM_SHMOBILE
 	tristate "DRM Support for SH Mobile"
 	depends on DRM && ARM
 	depends on ARCH_SHMOBILE || COMPILE_TEST
-	depends on FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM
 	select BACKLIGHT_CLASS_DEVICE
 	select BACKLIGHT_LCD_SUPPORT
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
index e773893..40df888 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
@@ -21,8 +21,6 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
 
-#include <video/sh_mobile_meram.h>
-
 #include "shmob_drm_backlight.h"
 #include "shmob_drm_crtc.h"
 #include "shmob_drm_drv.h"
@@ -47,20 +45,12 @@ static int shmob_drm_clk_on(struct shmob_drm_device *sdev)
 		if (ret < 0)
 			return ret;
 	}
-#if 0
-	if (sdev->meram_dev && sdev->meram_dev->pdev)
-		pm_runtime_get_sync(&sdev->meram_dev->pdev->dev);
-#endif
 
 	return 0;
 }
 
 static void shmob_drm_clk_off(struct shmob_drm_device *sdev)
 {
-#if 0
-	if (sdev->meram_dev && sdev->meram_dev->pdev)
-		pm_runtime_put_sync(&sdev->meram_dev->pdev->dev);
-#endif
 	if (sdev->clock)
 		clk_disable_unprepare(sdev->clock);
 }
@@ -269,12 +259,6 @@ static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
 	if (!scrtc->started)
 		return;
 
-	/* Disable the MERAM cache. */
-	if (scrtc->cache) {
-		sh_mobile_meram_cache_free(sdev->meram, scrtc->cache);
-		scrtc->cache = NULL;
-	}
-
 	/* Stop the LCDC. */
 	shmob_drm_crtc_start_stop(scrtc, false);
 
@@ -305,7 +289,6 @@ static void shmob_drm_crtc_compute_base(struct shmob_drm_crtc *scrtc,
 {
 	struct drm_crtc *crtc = &scrtc->crtc;
 	struct drm_framebuffer *fb = crtc->primary->fb;
-	struct shmob_drm_device *sdev = crtc->dev->dev_private;
 	struct drm_gem_cma_object *gem;
 	unsigned int bpp;
 
@@ -321,11 +304,6 @@ static void shmob_drm_crtc_compute_base(struct shmob_drm_crtc *scrtc,
 			      + y / (bpp == 4 ? 2 : 1) * fb->pitches[1]
 			      + x * (bpp == 16 ? 2 : 1);
 	}
-
-	if (scrtc->cache)
-		sh_mobile_meram_cache_update(sdev->meram, scrtc->cache,
-					     scrtc->dma[0], scrtc->dma[1],
-					     &scrtc->dma[0], &scrtc->dma[1]);
 }
 
 static void shmob_drm_crtc_update_base(struct shmob_drm_crtc *scrtc)
@@ -372,9 +350,7 @@ static int shmob_drm_crtc_mode_set(struct drm_crtc *crtc,
 {
 	struct shmob_drm_crtc *scrtc = to_shmob_crtc(crtc);
 	struct shmob_drm_device *sdev = crtc->dev->dev_private;
-	const struct sh_mobile_meram_cfg *mdata = sdev->pdata->meram;
 	const struct shmob_drm_format_info *format;
-	void *cache;
 
 	format = shmob_drm_format_info(crtc->primary->fb->format->format);
 	if (format == NULL) {
@@ -386,24 +362,6 @@ static int shmob_drm_crtc_mode_set(struct drm_crtc *crtc,
 	scrtc->format = format;
 	scrtc->line_size = crtc->primary->fb->pitches[0];
 
-	if (sdev->meram) {
-		/* Enable MERAM cache if configured. We need to de-init
-		 * configured ICBs before we can re-initialize them.
-		 */
-		if (scrtc->cache) {
-			sh_mobile_meram_cache_free(sdev->meram, scrtc->cache);
-			scrtc->cache = NULL;
-		}
-
-		cache = sh_mobile_meram_cache_alloc(sdev->meram, mdata,
-						    crtc->primary->fb->pitches[0],
-						    adjusted_mode->vdisplay,
-						    format->meram,
-						    &scrtc->line_size);
-		if (!IS_ERR(cache))
-			scrtc->cache = cache;
-	}
-
 	shmob_drm_crtc_compute_base(scrtc, x, y);
 
 	return 0;
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/shmobile/shmob_drm_crtc.h
index f152973..c11f421 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.h
+++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.h
@@ -28,7 +28,6 @@ struct shmob_drm_crtc {
 	int dpms;
 
 	const struct shmob_drm_format_info *format;
-	void *cache;
 	unsigned long dma[2];
 	unsigned int line_size;
 	bool started;
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.h b/drivers/gpu/drm/shmobile/shmob_drm_drv.h
index 02ea315..088a6e55 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_drv.h
+++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.h
@@ -23,7 +23,6 @@
 struct clk;
 struct device;
 struct drm_device;
-struct sh_mobile_meram_info;
 
 struct shmob_drm_device {
 	struct device *dev;
@@ -31,7 +30,6 @@ struct shmob_drm_device {
 
 	void __iomem *mmio;
 	struct clk *clock;
-	struct sh_mobile_meram_info *meram;
 	u32 lddckr;
 	u32 ldmt1r;
 
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
index d36919b..4476385 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_kms.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
@@ -18,8 +18,6 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
-#include <video/sh_mobile_meram.h>
-
 #include "shmob_drm_crtc.h"
 #include "shmob_drm_drv.h"
 #include "shmob_drm_kms.h"
@@ -35,55 +33,46 @@
 		.bpp = 16,
 		.yuv = false,
 		.lddfr = LDDFR_PKF_RGB16,
-		.meram = SH_MOBILE_MERAM_PF_RGB,
 	}, {
 		.fourcc = DRM_FORMAT_RGB888,
 		.bpp = 24,
 		.yuv = false,
 		.lddfr = LDDFR_PKF_RGB24,
-		.meram = SH_MOBILE_MERAM_PF_RGB,
 	}, {
 		.fourcc = DRM_FORMAT_ARGB8888,
 		.bpp = 32,
 		.yuv = false,
 		.lddfr = LDDFR_PKF_ARGB32,
-		.meram = SH_MOBILE_MERAM_PF_RGB,
 	}, {
 		.fourcc = DRM_FORMAT_NV12,
 		.bpp = 12,
 		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_420,
-		.meram = SH_MOBILE_MERAM_PF_NV,
 	}, {
 		.fourcc = DRM_FORMAT_NV21,
 		.bpp = 12,
 		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_420,
-		.meram = SH_MOBILE_MERAM_PF_NV,
 	}, {
 		.fourcc = DRM_FORMAT_NV16,
 		.bpp = 16,
 		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_422,
-		.meram = SH_MOBILE_MERAM_PF_NV,
 	}, {
 		.fourcc = DRM_FORMAT_NV61,
 		.bpp = 16,
 		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_422,
-		.meram = SH_MOBILE_MERAM_PF_NV,
 	}, {
 		.fourcc = DRM_FORMAT_NV24,
 		.bpp = 24,
 		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_444,
-		.meram = SH_MOBILE_MERAM_PF_NV24,
 	}, {
 		.fourcc = DRM_FORMAT_NV42,
 		.bpp = 24,
 		.yuv = true,
 		.lddfr = LDDFR_CC | LDDFR_YF_444,
-		.meram = SH_MOBILE_MERAM_PF_NV24,
 	},
 };
 
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_kms.h b/drivers/gpu/drm/shmobile/shmob_drm_kms.h
index 06d5b7c..753e281 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_kms.h
+++ b/drivers/gpu/drm/shmobile/shmob_drm_kms.h
@@ -24,7 +24,6 @@ struct shmob_drm_format_info {
 	unsigned int bpp;
 	bool yuv;
 	u32 lddfr;
-	unsigned int meram;
 };
 
 const struct shmob_drm_format_info *shmob_drm_format_info(u32 fourcc);
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/shmobile/shmob_drm_plane.c
index 97f6e4a..1d0359f 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_plane.c
@@ -17,8 +17,6 @@
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 
-#include <video/sh_mobile_meram.h>
-
 #include "shmob_drm_drv.h"
 #include "shmob_drm_kms.h"
 #include "shmob_drm_plane.h"
diff --git a/include/linux/platform_data/shmob_drm.h b/include/linux/platform_data/shmob_drm.h
index 7c686d3..ee495d7 100644
--- a/include/linux/platform_data/shmob_drm.h
+++ b/include/linux/platform_data/shmob_drm.h
@@ -18,9 +18,6 @@
 
 #include <drm/drm_mode.h>
 
-struct sh_mobile_meram_cfg;
-struct sh_mobile_meram_info;
-
 enum shmob_drm_clk_source {
 	SHMOB_DRM_CLK_BUS,
 	SHMOB_DRM_CLK_PERIPHERAL,
@@ -93,7 +90,6 @@ struct shmob_drm_platform_data {
 	struct shmob_drm_interface_data iface;
 	struct shmob_drm_panel_data panel;
 	struct shmob_drm_backlight_data backlight;
-	const struct sh_mobile_meram_cfg *meram;
 };
 
 #endif /* __SHMOB_DRM_H__ */
-- 
1.9.1
