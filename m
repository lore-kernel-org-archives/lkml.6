Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeEDHkT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:40:19 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50848 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeEDHkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:40:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180504074015epoutp04004287645728f2514613b33ae8a256d6~rYQ7XOGCp3020830208epoutp04m
X-AuditID: b6c32a4b-185ff70000001094-95-5aec0e5e22b7
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
Subject: [PATCH v1] drm/kms/mode: added a new helper for calculating
 videomode from crtc's display mode
Date: Fri,  4 May 2018 13:10:00 +0530
Message-Id: <1525419600-1774-1-git-send-email-satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180503103639.GH1027@e110455-lin.cambridge.arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFJsWRmVeSWpSXmKPExsWy7bCmpm4c35sog4tNPBa9504yWbS/W8Zu
        se9UP4vFo1MXGC2ufH3PZrHzwS52i1fn3zBbTLo/gcVi+eX1jBYv7l1kseh//JrZ4vz5DewW
        Z5vesFtsenyN1eLyrjlsFjPO72OyOLC0ncVi4cetLBaHpy5hs1j25QyLxfbNC5kt1p5vZbG4
        u+Eso8Xy09eZLWZMfsnmIOmxZt4aRo95a6o9ZjdcZPFYfvsuq8fOWXfZPTat6mTz2P7tAavH
        vJOBHve7jzN5bF5S73Hnx1JGj52T9jJ59G1ZxejxeZNcAF9Uqk1GamJKapFCal5yfkpmXrqt
        kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YOMCiUFMoSc0qBQgGJxcVK+nY2RfmlJakK
        GfnFJbZK0YaGRnqGBuZ6RkZGeiamsVZGpkAlCakZ08+2sBe8jahoW7WSuYFxkVcXIyeHhICJ
        xM/Xa1m7GLk4hAR2M0p87jjGCJIQEvjEKDFluSdE4hujxIbFK9hhOvbPms0MkdjLKPFwy1IW
        COcro8TqbZ/BqtiAqp7PmQE2V0RgJ5vEwa8fwKqYBfoZJV68mswKUiUskCnx6s9+MJtFQFVi
        2vV2ZhCbV8BVomP+NBaIfXISN891gsU5BZwkPr3/ADZVQuARu0Tj+zusEEUuEg3bDzJB2MIS
        r45vgTpWSuLzu71sEA3NjBIP1i1kh3B6GCU6Oo9BVdlLtEw5ALSOA+g+TYn1u/QhwrYSV78u
        AVvALMAn0fv7CRNIiYQAr0RHmxBEiYrEyheHmWF2/VnQBXWPh8SDb4eh7nGUOLd7LzTApjJK
        dK9pYZnAKD8LYdsCRsZVjJKpBcW56anFpgXGeanlesWJucWleel6yfm5mxjB6V7LewfjpnM+
        hxgFOBiVeHh32L6OEmJNLCuuzD3EKMHBrCTCO+sQUIg3JbGyKrUoP76oNCe1+BCjKTBoJzJL
        iSbnA3NRXkm8oYmlgYmZmbmhgYGliZI4782T96KEBNITS1KzU1MLUotg+pg4OKUaGA3yDtum
        bFQqzXv0hj+X0zPnxrsfP6K2nll+1FDVPTJvUVnxi3zBjaoy2n1PDoeGtxbduhayLcjSgG99
        1vZXzPnOOteSpA7GRJ9xaVmosXmizcEp/T9fWW4/dfKzQUak3T572wqxvh81l1Zrr92dOcUo
        /PnFaxcdMqZEtMQp+c8OtXlzgUOST4mlOCPRUIu5qDgRADXuR1ANBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvG4s35sog5fPdC16z51ksmh/t4zd
        Yt+pfhaLR6cuMFpc+fqezWLng13sFq/Ov2G2mHR/AovF8svrGS1e3LvIYtH/+DWzxfnzG9gt
        zja9YbfY9Pgaq8XlXXPYLGac38dkcWBpO4vFwo9bWSwOT13CZrHsyxkWi+2bFzJbrD3fymJx
        d8NZRovlp68zW8yY/JLNQdJjzbw1jB7z1lR7zG64yOKx/PZdVo+ds+6ye2xa1cnmsf3bA1aP
        eScDPe53H2fy2Lyk3uPOj6WMHjsn7WXy6NuyitHj8ya5AL4oLpuU1JzMstQifbsErozpZ1vY
        C95GVLStWsncwLjIq4uRk0NCwERi/6zZzF2MXBxCArsZJfZPusEMkZCSWPZmGxuELSyx8t9z
        doiiz4wSr/73MYIk2IC6n8+ZwQqSEBE4zSbxd08DC4jDLDCZUaJl4jN2kCphgXSJH7cusYDY
        LAKqEtOut4Ot4BVwleiYP40FYoWcxM1znWBxTgEniU/vP7CC2EICjhJrl2xkmsDIt4CRYRWj
        ZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAMamntYDxxIv4QowAHoxIP7w7b11FCrIll
        xZW5hxglOJiVRHhnHQIK8aYkVlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoE
        k2Xi4JRqYJx2qmF9R5lI3KW2fy6/ViY9q1OyYfEve3vmb1+wpWeVSOG0u/ySURqfHr1x1vGt
        MmT7bT+HOaBC/6drgN3u4r+ZPSl3V033Pufop5ejzXdLg23O3eTIFD/9/tNKH1Izzr5UXdnn
        KzzD4r/onznXJEQqOLaK8h1Id+1iDU9gMD0hxNOr8uuwEktxRqKhFnNRcSIAvTQT4L0CAAA=
X-CMS-MailID: 20180504074013epcas5p4564cb7043e1875154469052d097848db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180504074013epcas5p4564cb7043e1875154469052d097848db
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180504074013epcas5p4564cb7043e1875154469052d097848db
X-RootMTR: 20180504074013epcas5p4564cb7043e1875154469052d097848db
References: <20180503103639.GH1027@e110455-lin.cambridge.arm.com>
        <CGME20180504074013epcas5p4564cb7043e1875154469052d097848db@epcas5p4.samsung.com>
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

Reviewed-by: Jani Nikula <jani.nikula@linux.intel.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Acked-by: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---

 v1: Fixed review comments by Mr Jani
     Initialized with 0 the struct videomode so that stack garbage won't come	
     Added Reviewed-by and Acked-by fields

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
