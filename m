Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeECJBa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:01:30 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10596 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeECJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:01:25 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180503090124epoutp01dc8f4753d24a077c5ca670eba51a671e~rFufpw_JD3167531675epoutp01S
X-AuditID: b6c32a4b-185ff70000001094-05-5aeacfe389c5
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>, David Airlie <airlied@linux.ie>,
        John Stultz <john.stultz@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        Satendra Singh Thakur <satendra.t@samsung.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philippe Cornu <philippe.cornu@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, Ben Widawsky <ben@bwidawsk.net>,
        Peter Griffin <peter.griffin@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 06/13] drm/kms/mode/hisilicon-kirin-dsi-ade: using helper
 function drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 14:31:02 +0530
Message-Id: <389527ff7cd74fb864ea620e351741a13740830d.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa0xTVxzP6X0Vty7X4uaxH4DduQ+wUNrawsGIm9Ox63QJ2eZmqgu70puW
        2Fd6Keo+EBBFWoePgKLAEhCzhfqkVIdYwMEmw4wW3GDD8Zq6absRHAxkQdhaLmTf/r9Xfuf8
        c44Uk0+RCmmuNY93WDkzQ67Ar3cmJiY/CIb1qj8G4lFZoFuC+u/VSlCJp02C6n4dxtCP0xMk
        Cgf/xND3c8lodr6NQCcPDuHoh5YaEnWeOk+ia95WDA2PfIejq2cWcDR26DGBRk9X4ehffzOF
        LgUP42j4ag9AU3duk6hpohhH90NfEm+8xPYWNRJsdWEfzrbO1OLsQ28fYG9UDVPsg88bKba6
        9CzBej0ukh0a8JPsVzNjBDt6tEvCHp9XsRNt/SR7zOcB7G+zrRg75Y3LWqnnN5h4zsA7Enhr
        js2QazVmMNvez96crUtVqZPV6SiNSbByFj6D2bI9Kzkz1xxZA5OQz5mdESqLEwQmZeMGh82Z
        xyeYbEJeBrNLrdYo1ao0pUajUWp1H6/X6CKWT3iTu3qatNek7390IwwKwbUUN5BKIa2FFUXI
        DVZI5fRNAO9dCOEimASwrsclcYOYCJgBcHxy93IgcH+d6GkF8PDTUUoE0wCW/zJBRANkxPSo
        5gwRFVbRTSRsGC8lowJG74Kn7zZjUSGWrgCwOXB2MYHTr8LWr31UdJbRu+GRqYbFakjHwcGA
        C4tWx9Drof/vPdEspEcouFB/ghI9W2BvMAzEORaGu3xLvAKGjpdQYqAYwLHLdUvgMwBLXbeX
        XK/DQxW38GgDRifCKy0pIp0Bu9sPAvHUL8CyuYcS8f4yWFoiFy1rYcPjTmy561mtmxBnFj45
        NrnEb4JuX/nSTssA/OvbDskJEF/1f1stAB6whrcLFiMv6OzrrPw+pcBZBKfVqMyxWbxg8cEn
        bWsG3sD2DkBLAfO87FZPSC8nuHzhgKUDQCnGrJJVHA3r5TIDd+BT3mHLdjjNvNABdJHNnsQU
        L+bYIt/Hmpet1qartKmpaWqVKl3LrJYNdo/o5bSRy+P38ryddyznJNIYRSFYPf/7kwJ77J2G
        rs0fVP6zg6ovcLteC+ynrnwTul5pvLjw3LsmflbzyppLLTvXbi0oeDb0IW/ZeHfHwHi8v//N
        rIv5irfnRjUliV/07a1UOGPfynzvlMdQtMkX0Gdetg6uLG5M6fW3c0/jcj66aQj+vCcrPan9
        nPmnd45QeH3Tvgs7y19mcMHEqZMwh8D9BxB4So0GBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnO6j86+iDLZ1WVn0njvJZHH11gIm
        i7ZV+5gsFj68y2xx5et7NotX598wW5z5rWvx4+8+VouJTXdYLC7vmsNmcXjqEjaLrZv2Mlvc
        vXeCxWLDjH8sFg9aXrBa3J82i8Xi/54d7BZrz7eyWNzdcJbR4vOpY2wWm983s1g8ermc1UHM
        40LjRlaP2Q0XWTz2flvA4vFk00VGj52z7rJ7PJ67kd1jdsdMVo9NqzrZPO5c28Pmsf3bA1aP
        +93HmTz6/xp4vN93lc2jb8sqRo+nP/Yye3zeJBcgGMVlk5Kak1mWWqRvl8CV0TX7K1vBHMuK
        5ztfMTYwbtXvYuTgkBAwkTj3yLiLkYtDSGA3o8TDm5vYuxg5geJSEsvebGODsIUlVv57DhYX
        EvjMKDFpNiOIzQbU+3zODFaQZhGBw2wSGy9cBStiFoiWeHfjLhNIQlhgEqPEr7sbwBIsAqoS
        ew9uAbN5BWIk2j+vZILYICdx81wnM8hFnAJWEnu+JEEss5Ro7zvMOoGRbwEjwypGydSC4tz0
        3GLDAqO81HK94sTc4tK8dL3k/NxNjOCo09LawXjiRPwhRgEORiUe3gNnX0YJsSaWFVfmHmKU
        4GBWEuGd0v0qSog3JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwen
        VAPjktqIFS5JjSrVV8T97q9X2SVq8vaxu17vJ8vr9xYrHJ3U+VRrb5NrM+fX3+puHMmnJM3u
        eeVzRoUrSRhFJhizGWXJXxRd7v3lX5SUdqhY6wuZjkt3v9l+7T7ec+Pwynkq2yP6Zxh8anJV
        iNqW/iTkyGpPIaHwI1X/zYKX53nf8fv8vfj999NKLMUZiYZazEXFiQANYMFEtgIAAA==
X-CMS-MailID: 20180503090123epcas5p263afd14e32bc2a50e446bc674f7498d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503090123epcas5p263afd14e32bc2a50e446bc674f7498d7
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503090123epcas5p263afd14e32bc2a50e446bc674f7498d7
X-RootMTR: 20180503090123epcas5p263afd14e32bc2a50e446bc674f7498d7
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503090123epcas5p263afd14e32bc2a50e446bc674f7498d7@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Avoidded duplicate logic for the timing calculations
-Removed func ade_set_pix_clk and combined it with func ade_ldi_set_mode

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    | 42 ++++++++++----------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 52 +++++++++----------------
 2 files changed, 39 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index b4c7af3..902f63f 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -23,6 +23,7 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_encoder_slave.h>
 #include <drm/drm_atomic_helper.h>
+#include <video/videomode.h>
 
 #include "dw_dsi_reg.h"
 
@@ -447,7 +448,7 @@ static void dsi_set_mode_timing(void __iomem *base,
 				struct drm_display_mode *mode,
 				enum mipi_dsi_pixel_format format)
 {
-	u32 hfp, hbp, hsw, vfp, vbp, vsw;
+	struct videomode vm;
 	u32 hline_time;
 	u32 hsa_time;
 	u32 hbp_time;
@@ -467,25 +468,22 @@ static void dsi_set_mode_timing(void __iomem *base,
 	 * The DSI IP accepts vertical timing using lines as normal,
 	 * but horizontal timing is a mixture of pixel-clocks for the
 	 * active region and byte-lane clocks for the blanking-related
-	 * timings.  hfp is specified as the total hline_time in byte-
-	 * lane clocks minus hsa, hbp and active.
+	 * timings.  vm.hfront_porch is specified as the total hline_time
+	 * in byte-lane clocks minus hsa, vm.hback_porch and active.
 	 */
 	pixel_clk_kHz = mode->clock;
 	htot = mode->htotal;
 	vtot = mode->vtotal;
-	hfp = mode->hsync_start - mode->hdisplay;
-	hbp = mode->htotal - mode->hsync_end;
-	hsw = mode->hsync_end - mode->hsync_start;
-	vfp = mode->vsync_start - mode->vdisplay;
-	vbp = mode->vtotal - mode->vsync_end;
-	vsw = mode->vsync_end - mode->vsync_start;
-	if (vsw > 15) {
-		DRM_DEBUG_DRIVER("vsw exceeded 15\n");
-		vsw = 15;
+
+	drm_display_mode_to_videomode(mode, &vm);
+
+	if (vm.vsync_len > 15) {
+		DRM_DEBUG_DRIVER("vm.vsync_len exceeded 15\n");
+		vm.vsync_len = 15;
 	}
 
-	hsa_time = (hsw * lane_byte_clk_kHz) / pixel_clk_kHz;
-	hbp_time = (hbp * lane_byte_clk_kHz) / pixel_clk_kHz;
+	hsa_time = (vm.hsync_len * lane_byte_clk_kHz) / pixel_clk_kHz;
+	hbp_time = (vm.hback_porch * lane_byte_clk_kHz) / pixel_clk_kHz;
 	tmp = (u64)htot * (u64)lane_byte_clk_kHz;
 	hline_time = DIV_ROUND_UP(tmp, pixel_clk_kHz);
 
@@ -494,17 +492,17 @@ static void dsi_set_mode_timing(void __iomem *base,
 	writel(hbp_time, base + VID_HBP_TIME);
 	writel(hline_time, base + VID_HLINE_TIME);
 
-	writel(vsw, base + VID_VSA_LINES);
-	writel(vbp, base + VID_VBP_LINES);
-	writel(vfp, base + VID_VFP_LINES);
+	writel(vm.vsync_len, base + VID_VSA_LINES);
+	writel(vm.vback_porch, base + VID_VBP_LINES);
+	writel(vm.vfront_porch, base + VID_VFP_LINES);
 	writel(mode->vdisplay, base + VID_VACTIVE_LINES);
 	writel(mode->hdisplay, base + VID_PKT_SIZE);
 
-	DRM_DEBUG_DRIVER("htot=%d, hfp=%d, hbp=%d, hsw=%d\n",
-			 htot, hfp, hbp, hsw);
-	DRM_DEBUG_DRIVER("vtol=%d, vfp=%d, vbp=%d, vsw=%d\n",
-			 vtot, vfp, vbp, vsw);
-	DRM_DEBUG_DRIVER("hsa_time=%d, hbp_time=%d, hline_time=%d\n",
+	DRM_DEBUG_DRIVER("htot=%d, vm.hfront_porch=%d, vm.hback_porch=%d, vm.hsync_len=%d\n",
+			 htot, vm.hfront_porch, vm.hback_porch, vm.hsync_len);
+	DRM_DEBUG_DRIVER("vtol=%d, vm.vfront_porch=%d, vm.vback_porch=%d, vm.vsync_len=%d\n",
+			 vtot, vm.vfront_porch, vm.vback_porch, vm.vsync_len);
+	DRM_DEBUG_DRIVER("hsa_time=%d, vm.hback_porch_time=%d, hline_time=%d\n",
 			 hsa_time, hbp_time, hline_time);
 }
 
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 2269be9..c3eea17 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -30,6 +30,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <video/videomode.h>
 
 #include "kirin_drm_drv.h"
 #include "kirin_ade_reg.h"
@@ -190,24 +191,6 @@ static bool ade_crtc_mode_fixup(struct drm_crtc *crtc,
 	return true;
 }
 
-
-static void ade_set_pix_clk(struct ade_hw_ctx *ctx,
-			    struct drm_display_mode *mode,
-			    struct drm_display_mode *adj_mode)
-{
-	u32 clk_Hz = mode->clock * 1000;
-	int ret;
-
-	/*
-	 * Success should be guaranteed in mode_valid call back,
-	 * so failure shouldn't happen here
-	 */
-	ret = clk_set_rate(ctx->ade_pix_clk, clk_Hz);
-	if (ret)
-		DRM_ERROR("failed to set pixel clk %dHz (%d)\n", clk_Hz, ret);
-	adj_mode->clock = clk_get_rate(ctx->ade_pix_clk) / 1000;
-}
-
 static void ade_ldi_set_mode(struct ade_crtc *acrtc,
 			     struct drm_display_mode *mode,
 			     struct drm_display_mode *adj_mode)
@@ -216,28 +199,24 @@ static void ade_ldi_set_mode(struct ade_crtc *acrtc,
 	void __iomem *base = ctx->base;
 	u32 width = mode->hdisplay;
 	u32 height = mode->vdisplay;
-	u32 hfp, hbp, hsw, vfp, vbp, vsw;
+	struct videomode vm;
 	u32 plr_flags;
+	int ret;
 
 	plr_flags = (mode->flags & DRM_MODE_FLAG_NVSYNC) ? FLAG_NVSYNC : 0;
 	plr_flags |= (mode->flags & DRM_MODE_FLAG_NHSYNC) ? FLAG_NHSYNC : 0;
-	hfp = mode->hsync_start - mode->hdisplay;
-	hbp = mode->htotal - mode->hsync_end;
-	hsw = mode->hsync_end - mode->hsync_start;
-	vfp = mode->vsync_start - mode->vdisplay;
-	vbp = mode->vtotal - mode->vsync_end;
-	vsw = mode->vsync_end - mode->vsync_start;
-	if (vsw > 15) {
-		DRM_DEBUG_DRIVER("vsw exceeded 15\n");
-		vsw = 15;
+	drm_display_mode_to_videomode(mode, &vm);
+	if (vm.vsync_len > 15) {
+		DRM_DEBUG_DRIVER("vm.vsync_len exceeded 15\n");
+		vm.vsync_len = 15;
 	}
 
-	writel((hbp << HBP_OFST) | hfp, base + LDI_HRZ_CTRL0);
+	writel((vm.hback_porch << HBP_OFST) | vm.hfront_porch,
+		base + LDI_HRZ_CTRL0);
 	 /* the configured value is actual value - 1 */
-	writel(hsw - 1, base + LDI_HRZ_CTRL1);
-	writel((vbp << VBP_OFST) | vfp, base + LDI_VRT_CTRL0);
+	writel(vm.hsync_len - 1, base + LDI_HRZ_CTRL1);
+	writel((vm.vback_porch << VBP_OFST) | vm.vfront_porch,
+		base + LDI_VRT_CTRL0);
 	 /* the configured value is actual value - 1 */
-	writel(vsw - 1, base + LDI_VRT_CTRL1);
+	writel(vm.vsync_len - 1, base + LDI_VRT_CTRL1);
 	 /* the configured value is actual value - 1 */
 	writel(((height - 1) << VSIZE_OFST) | (width - 1),
 	       base + LDI_DSP_SIZE);
@@ -253,7 +232,14 @@ static void ade_ldi_set_mode(struct ade_crtc *acrtc,
 	writel(width * height - 1, base + ADE_CTRAN_IMAGE_SIZE(ADE_CTRAN6));
 	ade_update_reload_bit(base, CTRAN_OFST + ADE_CTRAN6, 0);
 
-	ade_set_pix_clk(ctx, mode, adj_mode);
+	/*
+	 * Success should be guaranteed in mode_valid call back,
+	 * so failure shouldn't happen here
+	 */
+	ret = clk_set_rate(ctx->ade_pix_clk, vm.pixelclock);
+	if (ret)
+		DRM_ERROR("failed to set pixel clk %dHz (%d)\n",
+				vm.pixelclock, ret);
+	adj_mode->clock = clk_get_rate(ctx->ade_pix_clk) / 1000;
 
 	DRM_DEBUG_DRIVER("set mode: %dx%d\n", width, height);
 }
-- 
2.7.4
