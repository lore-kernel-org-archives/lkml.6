Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeEGDb6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 23:31:58 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16758 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeEGDbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 23:31:55 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180507033152epoutp01dad897ead7f601aecd0e1bca4b4d14d6~sPz7OU13k2220122201epoutp01W
X-AuditID: b6c32a4a-a79ff700000010d4-b8-5aefc8a7df5d
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: jani.nikula@linux.intel.com, liviu.dudau@arm.com,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        David Airlie <airlied@linux.ie>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc: madhur.verma@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH v2] drm/kms/mode: added a new helper for calculating
 videomode from crtc's display mode
Date: Mon,  7 May 2018 09:01:09 +0530
Message-Id: <1525663870-4119-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <87sh777o63.fsf@intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTbUxbVRj29N7eW4idN910Z/xgzVWzQWxpmxZOdZ1TcbnTJYOYzKTT4A1c
        207akt52DpYF5gcMcGOOLcNCCEjXIkE2gbmVZYzRwIRJy4cDQfkI+AEMrVOLTrfMthfiv+d5
        3+c5z5s375Fgsr+IJInF5uQcNjafJhLxLwMp2xW+r8JGVUeYRCeCAyJU9quXRN2DVTiaHxwG
        6JtImED+uS4SLYdWMHR69hSOfGMXAFqcGcFR1cIdDIVCF0k09N4KidoXxsVorKuOQDWhbhHq
        OV+Go8a7l3AUOOshkPfPr3F0uaMRQ5+HPsTR9MUhgHy3JjBUU71E7NrCtNa3Aqa+9QhTWzKC
        M77vpsWM3z1NMu0t5QRzeXVOzNQPZDOzlTdFTIenmPn+7/OA8Z++JmJOdrYA5o/25KwNRm6H
        mWPzOIecs+Xa8yw2k4F+9bWcl3J06Sq1Qq1HGbTcxlo5A525N0ux25IfXQUtP8Tmu6KlLJbn
        6bSdOxx2l5OTm+2800AfUKs1SrUqQ6nRaJRa3ZvPanRRyVucefXBLVBw/fXDncHbRAk4t6cC
        JEggpYX9N+6KKkCiREZdBXApNAIE8juATTMRsUBWo6RsAV+3eNsGcKFxDcB71x+SsYaMigA4
        NlEcw0RU9HNdTdy9ifIT8Ebkt7gDo6oAXFyuFsdUGykLXP6kJ4olEpx6GnYH82JQSr0MPd8e
        FMKS4WSwHIvhBGob/Gd0NP4MpOZJ2FdaSwiiTBj68eTadBvh8s1OUsBJcKmqlBQM7wM419a4
        Rj4C8Hh5/5rqefjBmR48loxRKfBCV5pQNsCOpuH4nBi1AZ749wdRTAIpKTxeKhMkT8HPFgPY
        etb9hgqxgBl4ryy0hl+AY5XNQFhQEfRf+oI4Bba6/w9rAKAFbOEKeKuJ43UFGhv3rpJnrbzL
        ZlLm2q3tIH70qa9cAd7g3l5ASQD9qLT5TNgoE7OH+EJrL4ASjN4kfawvWpLmsYVFnMOe43Dl
        c3wv0EX3+jGW9HiuPfqFbM4ctVav0qanZ6hVKr2W3iydHJgxyigT6+Te4bgCzrHuE0kSkkpA
        whHZ0M4+g9xc4+l3ZTZtb7O706uLEvVc78OVFU+JvnYyEPrFN8oo+JTE5wp3HYyktcyWOg80
        PFLV3G+6PzVlyby99cEVzfDgk9Kst18M7N9z7I7nmU+Tx7OnXNnFTxwtXlXtP/pTHZRXp47P
        b549vFux0Fj5hndf+Kr77DGr0T1B47yZVadiDp79D7/hD3sKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnO7SE++jDCauMrToPXeSyaL93TJ2
        i32n+lksHp26wGhx5et7NoudD3axW7w6/4bZYtL9CSwWyy+vZ7R4ce8ii0X/49fMFufPb2C3
        ONv0ht1i0+NrrBaXd81hs5hxfh+TxYGl7SwWCz9uZbE4PHUJm8WyL2dYLLZvXshssfZ8K4vF
        3Q1nGS2Wn77ObDFj8ks2B0mPNfPWMHrMW1PtMbvhIovH8tt3WT12zrrL7rFpVSebx/ZvD1g9
        5p0M9LjffZzJY/OSeo87P5YyeuyctJfJo2/LKkaPz5vkAviiuGxSUnMyy1KL9O0SuDK+/T3N
        WLA/vGLLuatsDYzTPbsYOTkkBEwklq07ydLFyMUhJLCbUaKnfy07REJKYtmbbWwQtrDEyn/P
        2SGKPjNKrJz7nhEkwQbU/XzODFaQhIjAaTaJv3sawEYxC0xmlGiZ+AxslLBAusTWyy+BbA4O
        FgFViX3nUkBMXgFXiSU3siAWyEncPNfJDGJzCqhL/Lp0iQXEFhJQk9gx7SPzBEa+BYwMqxgl
        UwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxguNPS2sH44kT8YcYBTgYlXh4V0x5HyXEmlhW
        XJl7iFGCg1lJhJf/KFCINyWxsiq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKY
        LBMHp1QDo1mq8O6ulKgt7icfLdrUrJN0+NSLG5Mee/hf42yOlNduuzLdJX0Km/DTovhU2Wf9
        DhJhyXWyTF9itwWkbPt9re3Pspy/7aXfQjVaAiXjzhr18NmwH6ktmdzSff5Zp6hXaMLStyIa
        uxk8vS7NcE77zfzwieSEKKO+fcu7/X76xtyaaNit9Hq2EktxRqKhFnNRcSIAVhY1kbsCAAA=
X-CMS-MailID: 20180507033149epcas5p4b33b68a21f0883da6aa97419d5114296
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180507033149epcas5p4b33b68a21f0883da6aa97419d5114296
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180507033149epcas5p4b33b68a21f0883da6aa97419d5114296
X-RootMTR: 20180507033149epcas5p4b33b68a21f0883da6aa97419d5114296
References: <87sh777o63.fsf@intel.com>
        <CGME20180507033149epcas5p4b33b68a21f0883da6aa97419d5114296@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.
-Added a new helper drm_display_mode_crtc_to_videomode
-This helper calculates mode parameters like
--horizontal front_porch, back_porch, sync length
--vertical front_porch, back_porch, sync length
-using crtc fields of struct drm_display_mode
-It uses following fields of crtc mode
--horizontal sync start/end, active and total length
--vertical sync start/end, active and total length
2.
-Most of the driver use user-supplied mode for calculating videomode
-However, few drivers use HW (crtc) mode for calculating videomode
-This helper will be useful for such drivers
3.
-Currently following drivers will be using this new helper
-arm hdlcd
-atmel hlcdc
-exynos 5433 decon
-exynos7 decon
-exynos fimd
4.
-This change reduces several redundant lines of code for many drivers

Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Acked-by: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---

 v2: Removed Mr Jani from Reviewed-by field

 drivers/gpu/drm/arm/hdlcd_crtc.c               | 10 ++--------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  9 ++-------
 drivers/gpu/drm/drm_modes.c                    | 19 +++++++++++++++++++
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c  | 22 ++++++++++------------
 drivers/gpu/drm/exynos/exynos7_drm_decon.c     | 23 ++++++++++-------------
 drivers/gpu/drm/exynos/exynos_drm_fimd.c       | 22 +++++++++-------------
 include/drm/drm_modes.h                        |  2 ++
 7 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index cf5cbd6..5cec264 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -127,16 +127,10 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
 	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
 	struct drm_display_mode *m = &crtc->state->adjusted_mode;
-	struct videomode vm;
+	struct videomode vm = {};
 	unsigned int polarities, err;
 
-	vm.vfront_porch = m->crtc_vsync_start - m->crtc_vdisplay;
-	vm.vback_porch = m->crtc_vtotal - m->crtc_vsync_end;
-	vm.vsync_len = m->crtc_vsync_end - m->crtc_vsync_start;
-	vm.hfront_porch = m->crtc_hsync_start - m->crtc_hdisplay;
-	vm.hback_porch = m->crtc_htotal - m->crtc_hsync_end;
-	vm.hsync_len = m->crtc_hsync_end - m->crtc_hsync_start;
-
+	drm_display_mode_crtc_to_videomode(m, &vm);
 	polarities = HDLCD_POLARITY_DATAEN | HDLCD_POLARITY_DATA;
 
 	if (m->flags & DRM_MODE_FLAG_PHSYNC)
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d732810..fb298b8 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -76,17 +76,12 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 	struct drm_display_mode *adj = &c->state->adjusted_mode;
 	struct atmel_hlcdc_crtc_state *state;
 	unsigned long mode_rate;
-	struct videomode vm;
+	struct videomode vm = {};
 	unsigned long prate;
 	unsigned int cfg;
 	int div;
 
-	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
-	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
-	vm.vsync_len = adj->crtc_vsync_end - adj->crtc_vsync_start;
-	vm.hfront_porch = adj->crtc_hsync_start - adj->crtc_hdisplay;
-	vm.hback_porch = adj->crtc_htotal - adj->crtc_hsync_end;
-	vm.hsync_len = adj->crtc_hsync_end - adj->crtc_hsync_start;
+	drm_display_mode_crtc_to_videomode(adj, &vm);
 
 	regmap_write(regmap, ATMEL_HLCDC_CFG(1),
 		     (vm.hsync_len - 1) | ((vm.vsync_len - 1) << 16));
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index e82b61e..328f771 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -654,6 +654,25 @@ void drm_display_mode_to_videomode(const struct drm_display_mode *dmode,
 		vm->flags |= DISPLAY_FLAGS_DOUBLECLK;
 }
 EXPORT_SYMBOL_GPL(drm_display_mode_to_videomode);
+/**
+ * drm_display_mode_crtc_to_videomode - fill in @vm using crtc fields of @dmode
+ * @dmode: drm_display_mode structure to use as source
+ * @vm: videomode structure to use as destination
+ *
+ * Fills out @vm using the crtc display mode specified in @dmode.
+ */
+void drm_display_mode_crtc_to_videomode(const struct drm_display_mode *dmode,
+				   struct videomode *vm)
+{
+	vm->hfront_porch = dmode->crtc_hsync_start - dmode->crtc_hdisplay;
+	vm->hsync_len = dmode->crtc_hsync_end - dmode->crtc_hsync_start;
+	vm->hback_porch = dmode->crtc_htotal - dmode->crtc_hsync_end;
+	vm->vfront_porch = dmode->crtc_vsync_start - dmode->crtc_vdisplay;
+	vm->vsync_len = dmode->crtc_vsync_end - dmode->crtc_vsync_start;
+	vm->vback_porch = dmode->crtc_vtotal - dmode->crtc_vsync_end;
+
+}
+EXPORT_SYMBOL_GPL(drm_display_mode_crtc_to_videomode);
 
 /**
  * drm_bus_flags_from_videomode - extract information about pixelclk and
diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 1c330f2..2535ebb 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -20,6 +20,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <video/videomode.h>
 
 #include "exynos_drm_drv.h"
 #include "exynos_drm_crtc.h"
@@ -225,26 +226,23 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	writel(val, ctx->addr + DECON_VIDTCON2);
 
 	if (!crtc->i80_mode) {
-		int vbp = m->crtc_vtotal - m->crtc_vsync_end;
-		int vfp = m->crtc_vsync_start - m->crtc_vdisplay;
+		struct videomode vm = {};
 
+		drm_display_mode_crtc_to_videomode(m, &vm);
 		if (interlaced)
-			vbp = vbp / 2 - 1;
-		val = VIDTCON00_VBPD_F(vbp - 1) | VIDTCON00_VFPD_F(vfp - 1);
+			vm.vback_porch = (vm.vback_porch >> 1) - 1;
+		val = VIDTCON00_VBPD_F(vm.vback_porch - 1) |
+			VIDTCON00_VFPD_F(vm.vfront_porch - 1);
 		writel(val, ctx->addr + DECON_VIDTCON00);
 
-		val = VIDTCON01_VSPW_F(
-				m->crtc_vsync_end - m->crtc_vsync_start - 1);
+		val = VIDTCON01_VSPW_F(vm.vsync_len - 1);
 		writel(val, ctx->addr + DECON_VIDTCON01);
 
-		val = VIDTCON10_HBPD_F(
-				m->crtc_htotal - m->crtc_hsync_end - 1) |
-			VIDTCON10_HFPD_F(
-				m->crtc_hsync_start - m->crtc_hdisplay - 1);
+		val = VIDTCON10_HBPD_F(vm.hback_porch - 1) |
+			VIDTCON10_HFPD_F(vm.hfront_porch - 1);
 		writel(val, ctx->addr + DECON_VIDTCON10);
 
-		val = VIDTCON11_HSPW_F(
-				m->crtc_hsync_end - m->crtc_hsync_start - 1);
+		val = VIDTCON11_HSPW_F(vm.hsync_len - 1);
 		writel(val, ctx->addr + DECON_VIDTCON11);
 	}
 
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 3931d5e..5fdd093 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -25,6 +25,7 @@
 
 #include <video/of_display_timing.h>
 #include <video/of_videomode.h>
+#include <video/videomode.h>
 
 #include "exynos_drm_crtc.h"
 #include "exynos_drm_plane.h"
@@ -168,28 +169,24 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 		return;
 
 	if (!ctx->i80_if) {
-		int vsync_len, vbpd, vfpd, hsync_len, hbpd, hfpd;
+		struct videomode vm = {};
+
+		drm_display_mode_crtc_to_videomode(mode, &vm);
 	      /* setup vertical timing values. */
-		vsync_len = mode->crtc_vsync_end - mode->crtc_vsync_start;
-		vbpd = mode->crtc_vtotal - mode->crtc_vsync_end;
-		vfpd = mode->crtc_vsync_start - mode->crtc_vdisplay;
 
-		val = VIDTCON0_VBPD(vbpd - 1) | VIDTCON0_VFPD(vfpd - 1);
+		val = VIDTCON0_VBPD(vm.vback_porch - 1) |
+			VIDTCON0_VFPD(vm.vfront_porch - 1);
 		writel(val, ctx->regs + VIDTCON0);
 
-		val = VIDTCON1_VSPW(vsync_len - 1);
+		val = VIDTCON1_VSPW(vm.vsync_len - 1);
 		writel(val, ctx->regs + VIDTCON1);
 
 		/* setup horizontal timing values.  */
-		hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
-		hbpd = mode->crtc_htotal - mode->crtc_hsync_end;
-		hfpd = mode->crtc_hsync_start - mode->crtc_hdisplay;
-
-		/* setup horizontal timing values.  */
-		val = VIDTCON2_HBPD(hbpd - 1) | VIDTCON2_HFPD(hfpd - 1);
+		val = VIDTCON2_HBPD(vm.hback_porch - 1) |
+			VIDTCON2_HFPD(vm.hfront_porch - 1);
 		writel(val, ctx->regs + VIDTCON2);
 
-		val = VIDTCON3_HSPW(hsync_len - 1);
+		val = VIDTCON3_HSPW(vm.hsync_len - 1);
 		writel(val, ctx->regs + VIDTCON3);
 	}
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index d42ae2b..c70b9ec 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -25,6 +25,7 @@
 
 #include <video/of_display_timing.h>
 #include <video/of_videomode.h>
+#include <video/videomode.h>
 #include <video/samsung_fimd.h>
 #include <drm/exynos_drm.h>
 
@@ -463,7 +464,7 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
 			return;
 		}
 	} else {
-		int vsync_len, vbpd, vfpd, hsync_len, hbpd, hfpd;
+		struct videomode vm = {};
 		u32 vidcon1;
 
 		/* setup polarity values */
@@ -474,24 +475,19 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
 			vidcon1 |= VIDCON1_INV_HSYNC;
 		writel(vidcon1, ctx->regs + driver_data->timing_base + VIDCON1);
 
+		drm_display_mode_crtc_to_videomode(mode, &vm);
 		/* setup vertical timing values. */
-		vsync_len = mode->crtc_vsync_end - mode->crtc_vsync_start;
-		vbpd = mode->crtc_vtotal - mode->crtc_vsync_end;
-		vfpd = mode->crtc_vsync_start - mode->crtc_vdisplay;
 
-		val = VIDTCON0_VBPD(vbpd - 1) |
-			VIDTCON0_VFPD(vfpd - 1) |
-			VIDTCON0_VSPW(vsync_len - 1);
+		val = VIDTCON0_VBPD(vm.vback_porch - 1) |
+			VIDTCON0_VFPD(vm.vfront_porch - 1) |
+			VIDTCON0_VSPW(vm.vsync_len - 1);
 		writel(val, ctx->regs + driver_data->timing_base + VIDTCON0);
 
 		/* setup horizontal timing values.  */
-		hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
-		hbpd = mode->crtc_htotal - mode->crtc_hsync_end;
-		hfpd = mode->crtc_hsync_start - mode->crtc_hdisplay;
 
-		val = VIDTCON1_HBPD(hbpd - 1) |
-			VIDTCON1_HFPD(hfpd - 1) |
-			VIDTCON1_HSPW(hsync_len - 1);
+		val = VIDTCON1_HBPD(vm.hback_porch - 1) |
+			VIDTCON1_HFPD(vm.hfront_porch - 1) |
+			VIDTCON1_HSPW(vm.hsync_len - 1);
 		writel(val, ctx->regs + driver_data->timing_base + VIDTCON1);
 	}
 
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index 0d310be..9ac764b 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -473,6 +473,8 @@ void drm_display_mode_from_videomode(const struct videomode *vm,
 				     struct drm_display_mode *dmode);
 void drm_display_mode_to_videomode(const struct drm_display_mode *dmode,
 				   struct videomode *vm);
+void drm_display_mode_crtc_to_videomode(const struct drm_display_mode *dmode,
+				   struct videomode *vm);
 void drm_bus_flags_from_videomode(const struct videomode *vm, u32 *bus_flags);
 int of_get_drm_display_mode(struct device_node *np,
 			    struct drm_display_mode *dmode, u32 *bus_flags,
-- 
2.7.4
