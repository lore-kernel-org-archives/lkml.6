Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeECLD6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:03:58 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18364 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECLDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:03:55 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180503110353epoutp0213bb8d8c183923a73c21fac0a24dbe72~rHZcki4jD2737827378epoutp02M
X-AuditID: b6c32a4a-a61ff700000010d4-3a-5aeaec990e79
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 10/13] drm/kms/mode/ti-lcdc: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 16:33:18 +0530
Message-Id: <5371bd6a689b350ce5d3f06d27f6711800d56b5f.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUhTYRTu3b27XqXJZRq9Cem4KaLg2samV3OVH8Qyfxj+W4nd9G1KbrPd
        +RX9ENN0zoWCQaV9kSyb+IGJirVMjcwoKzJpUmaRllMyU0NKos076d/znPOc8zwcDomJ/whD
        yHyDGZkMbAFNBOC9I1GRMVcW3VrZ88fBjG18TMBMrC0RjPvlIsZYLTVC5s1AM8GMXGohmPaX
        VTjTeWOKOEhq+n7NCDUfraMCzcUeB9CMvusTaFa6QzOEWpSYh9hcZJIgQ44xN9+gU9NHMrNT
        slWxMnmMPJ6JoyUGVo/UdGp6Rsyh/AJPFlpSzBYUeUoZLMfRe/cnmoxFZiTJM3JmNX1MLldI
        5bI4qUKhkCpVWQkKlUdyAuVZqz4ICt9Hl152vRWWg0G6FviTkFLC3/frBLUggBRT9wHcuNbu
        Iz8BrJqqxHjyC8DRoSF8a6S9rs3XcAK4PtXvG1kDcKWxeVNFeFRfmy8LvY1gygGgY64S9xKM
        sgJoc3oX+5NBVDmA1z8d9mKcioBL7V0CLxZRx6Gl7YuA9wuFrnGLR0+S/lQCfLB60rsHUq0E
        /LleIeQ1qXB5rdqPx0HQPdrjwyFw5buT4AfOAzjTccuPJ3UA1lie+FQHYGXjI9zrgFFRsHNg
        L19WQ8f5gc0QGBUIbX+8gUhPXQRrLoh5STi8+20E2/LauFnry6OBk10TPpwElybv4PyJbADW
        1bzC60HY1f9uNwFwgF2okNPrEKcqVBhQiZRj9VyRQSfNMeq7webjRaf1A/t4+jCgSEBvFz16
        Ma8VC9lirkw/DCCJ0cGiRqtbKxblsmVnkcmYbSoqQNwwUHku24CF7Mgxet7YYM6WK+NlytjY
        OLlMFq+kd4pcY9NaMaVjzeg0QoXItDUnIP1DykHy04U+4+cFtSViMaWi97rk2V/7w9rOpMxb
        aW67xWlb/7G6U73RMiuW7B6cb3WdrkyaUH1OeD2oDmwamrxNfWrVbaSFuUq4e/sjpiNLM8NT
        sswLb6gr5tZt1RENE/YP9vdzc+6oU8vJZ9ZHytIj6xcW950jnGNHmzpehM2Gx5zdQ+NcHiuP
        xkwc+w/CZN5GjgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO70N6+iDLbcsbToPXeSyeLK1/ds
        Fq/Ov2G26O7sYLW4vGsOm8XhqUvYLNaeb2WxWD//FpsDh8f2bw9YPe53H2fy6NuyitHj+I3t
        TB6fN8kFsEZx2aSk5mSWpRbp2yVwZXS33mUquKNVMePmVdYGxv1KXYycHBICJhJre1YzdzFy
        cQgJ7GaUOLS3kR0iISWx7M02NghbWGLlv+fsEEWfGSX+/NgAVsQG1P18zgxWkISIwDqgxOLt
        LCAOs0Avo8SL/fvBqoQF6iRWP/7OCmKzCKhKvF+7gQnE5hWIkehc/YQJYoWcxM1znUB3cHBw
        ClhJ7PmSBBIWErCUaO87zDqBkW8BI8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg
        ENTS3MF4eUn8IUYBDkYlHt6M0y+jhFgTy4orcw8xSnAwK4nwTul+FSXEm5JYWZValB9fVJqT
        WnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDY+M700YxNaOF7j/CMzLsl2fKbp7B
        kRq1rCJkueGzdzc9fLKKbixJSzBew/XIrH1N+DqOJu27185NOT17rtC6NSdX9p1oCJ1iVymv
        NnnS4p+GF/vnaVtZBvqrK5feZ/yVOM1nWueC/Jnta+eWPW1VYudbFjw3ujh70cO3Vt+ezAl4
        abls54rVH5VYijMSDbWYi4oTAfc476M9AgAA
X-CMS-MailID: 20180503110352epcas5p32d2bbf72da59a6e2183c9eb67c58f1ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503110352epcas5p32d2bbf72da59a6e2183c9eb67c58f1ba
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503110352epcas5p32d2bbf72da59a6e2183c9eb67c58f1ba
X-RootMTR: 20180503110352epcas5p32d2bbf72da59a6e2183c9eb67c58f1ba
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503110352epcas5p32d2bbf72da59a6e2183c9eb67c58f1ba@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 60 ++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 1b278a2..6becdaf 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/of_graph.h>
 #include <linux/math64.h>
+#include <video/videomode.h>
 
 #include "tilcdc_drv.h"
 #include "tilcdc_regs.h"
@@ -284,9 +285,10 @@ static void tilcdc_crtc_set_mode(struct drm_crtc *crtc)
 	struct drm_device *dev = crtc->dev;
 	struct tilcdc_drm_private *priv = dev->dev_private;
 	const struct tilcdc_panel_info *info = tilcdc_crtc->info;
-	uint32_t reg, hbp, hfp, hsw, vbp, vfp, vsw;
+	uint32_t reg;
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 	struct drm_framebuffer *fb = crtc->primary->state->fb;
+	struct videomode vm;
 
 	if (WARN_ON(!info))
 		return;
@@ -320,15 +322,12 @@ static void tilcdc_crtc_set_mode(struct drm_crtc *crtc)
 	tilcdc_write(dev, LCDC_DMA_CTRL_REG, reg);
 
 	/* Configure timings: */
-	hbp = mode->htotal - mode->hsync_end;
-	hfp = mode->hsync_start - mode->hdisplay;
-	hsw = mode->hsync_end - mode->hsync_start;
-	vbp = mode->vtotal - mode->vsync_end;
-	vfp = mode->vsync_start - mode->vdisplay;
-	vsw = mode->vsync_end - mode->vsync_start;
+	drm_display_mode_to_videomode(mode, &vm);
 
-	DBG("%dx%d, hbp=%u, hfp=%u, hsw=%u, vbp=%u, vfp=%u, vsw=%u",
-	    mode->hdisplay, mode->vdisplay, hbp, hfp, hsw, vbp, vfp, vsw);
+	DBG("%dx%d, vm.hback_porch=%u, vm.hfront_porch=%u, vm.hsync_len=%u,"
+		" vm.vback_porch=%u, vm.vfront_porch=%u, vm.vsync_len=%u",
+		vm.hactive, vm.vactive, vm.hback_porch, vm.hfront_porch,
+		vm.hsync_len, vm.vback_porch, vm.vfront_porch, vm.vsync_len);
 
 	/* Set AC Bias Period and Number of Transitions per Interrupt: */
 	reg = tilcdc_read(dev, LCDC_RASTER_TIMING_2_REG) & ~0x000fff00;
@@ -336,30 +335,30 @@ static void tilcdc_crtc_set_mode(struct drm_crtc *crtc)
 		LCDC_AC_BIAS_TRANSITIONS_PER_INT(info->ac_bias_intrpt);
 
 	/*
-	 * subtract one from hfp, hbp, hsw because the hardware uses
-	 * a value of 0 as 1
+	 * subtract one from vm.hfront_porch, vm.hback_porch, vm.hsync_len
+	 * because the hardware uses a value of 0 as 1
 	 */
 	if (priv->rev == 2) {
 		/* clear bits we're going to set */
 		reg &= ~0x78000033;
-		reg |= ((hfp-1) & 0x300) >> 8;
-		reg |= ((hbp-1) & 0x300) >> 4;
-		reg |= ((hsw-1) & 0x3c0) << 21;
+		reg |= ((vm.hfront_porch-1) & 0x300) >> 8;
+		reg |= ((vm.hback_porch-1) & 0x300) >> 4;
+		reg |= ((vm.hsync_len-1) & 0x3c0) << 21;
 	}
 	tilcdc_write(dev, LCDC_RASTER_TIMING_2_REG, reg);
 
 	reg = (((mode->hdisplay >> 4) - 1) << 4) |
-		(((hbp-1) & 0xff) << 24) |
-		(((hfp-1) & 0xff) << 16) |
-		(((hsw-1) & 0x3f) << 10);
+		(((vm.hback_porch-1) & 0xff) << 24) |
+		(((vm.hfront_porch-1) & 0xff) << 16) |
+		(((vm.hsync_len-1) & 0x3f) << 10);
 	if (priv->rev == 2)
 		reg |= (((mode->hdisplay >> 4) - 1) & 0x40) >> 3;
 	tilcdc_write(dev, LCDC_RASTER_TIMING_0_REG, reg);
 
 	reg = ((mode->vdisplay - 1) & 0x3ff) |
-		((vbp & 0xff) << 24) |
-		((vfp & 0xff) << 16) |
-		(((vsw-1) & 0x3f) << 10);
+		((vm.vback_porch & 0xff) << 24) |
+		((vm.vfront_porch & 0xff) << 16) |
+		(((vm.vsync_len-1) & 0x3f) << 10);
 	tilcdc_write(dev, LCDC_RASTER_TIMING_1_REG, reg);
 
 	/*
@@ -753,7 +752,7 @@ int tilcdc_crtc_mode_valid(struct drm_crtc *crtc, struct drm_display_mode *mode)
 {
 	struct tilcdc_drm_private *priv = crtc->dev->dev_private;
 	unsigned int bandwidth;
-	uint32_t hbp, hfp, hsw, vbp, vfp, vsw;
+	struct videomode vm;
 
 	/*
 	 * check to see if the width is within the range that
@@ -773,39 +772,34 @@ int tilcdc_crtc_mode_valid(struct drm_crtc *crtc, struct drm_display_mode *mode)
 		mode->hdisplay, mode->vdisplay,
 		drm_mode_vrefresh(mode), mode->clock);
 
-	hbp = mode->htotal - mode->hsync_end;
-	hfp = mode->hsync_start - mode->hdisplay;
-	hsw = mode->hsync_end - mode->hsync_start;
-	vbp = mode->vtotal - mode->vsync_end;
-	vfp = mode->vsync_start - mode->vdisplay;
-	vsw = mode->vsync_end - mode->vsync_start;
+	drm_display_mode_to_videomode(mode, &vm);
 
-	if ((hbp-1) & ~0x3ff) {
+	if ((vm.hback_porch-1) & ~0x3ff) {
 		DBG("Pruning mode: Horizontal Back Porch out of range");
 		return MODE_HBLANK_WIDE;
 	}
 
-	if ((hfp-1) & ~0x3ff) {
+	if ((vm.hfront_porch-1) & ~0x3ff) {
 		DBG("Pruning mode: Horizontal Front Porch out of range");
 		return MODE_HBLANK_WIDE;
 	}
 
-	if ((hsw-1) & ~0x3ff) {
+	if ((vm.hsync_len-1) & ~0x3ff) {
 		DBG("Pruning mode: Horizontal Sync Width out of range");
 		return MODE_HSYNC_WIDE;
 	}
 
-	if (vbp & ~0xff) {
+	if (vm.vback_porch & ~0xff) {
 		DBG("Pruning mode: Vertical Back Porch out of range");
 		return MODE_VBLANK_WIDE;
 	}
 
-	if (vfp & ~0xff) {
+	if (vm.vfront_porch & ~0xff) {
 		DBG("Pruning mode: Vertical Front Porch out of range");
 		return MODE_VBLANK_WIDE;
 	}
 
-	if ((vsw-1) & ~0x3f) {
+	if ((vm.vsync_len-1) & ~0x3f) {
 		DBG("Pruning mode: Vertical Sync Width out of range");
 		return MODE_VSYNC_WIDE;
 	}
-- 
2.7.4
