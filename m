Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeECLKM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:10:12 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:47204 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeECLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:10:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180503111009epoutp03b5136479165cbf0f0fc5cbec536a7121~rHe60UjcX0437404374epoutp030
X-AuditID: b6c32a49-583ff700000010df-0b-5aeaee105471
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 12/13] drm/kms/mode/mtk_dpi_dsi: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 16:39:46 +0530
Message-Id: <986995915d004bf99936eaf380da6113a974b639.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmuq7gu1dRBh/WMVr0njvJZNG4exu7
        xZWv79ksXp1/w2yx6fE1VovLu+awWVxuvshocXjqEjaLphZji7v3TrBYrD3fyuLA7bFz1l12
        j+3fHrB63O8+zuSxeUm9R8vJ/Swe/X8NPPq2rGL0+LxJLoAjKtUmIzUxJbVIITUvOT8lMy/d
        Vsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hMJYWyxJxSoFBAYnGxkr6dTVF+aUmq
        QkZ+cYmtUrShoZGeoYG5npGRkZ6JaayVkSlQSUJqxulH+QXbTSt6Vn1mbWB8pNPFyMEhIWAi
        8XWdfxcjF4eQwG5GiVvbJ7FBOJ8YJQ61L2KBcL4xSmz+3AbkcIJ1tPYeZ4ZI7GWUeN6zmAkk
        ISTwlVFi5upaEJsNqOj5nBmsIEUiAguZJO4dfMUO4jALdDNK9O5tAWsXFmhhlFh1biEjSAuL
        gKrE5f+HmUFsXoEYie3/e5kh9slJ3DzXyQxyLaeAlcSeL0kgvRICZ9gkDi3cygpR4yKxoukB
        E4QtLPHq+BZ2CFtK4vO7vWwQDc2MEg/WLWSHcHoYJTo6j0FV2Uu0TDnAArKBWUBTYv0ufYiw
        rcSyWV1gTzML8En0/n7CBAkyXomONiGIEhWJlS8OM8Ps+rOgC+oeD4m5E09B3eMocWz3NGhA
        9jJKfLq2kGkCo/wshG0LGBlXMUqmFhTnpqcWmxYY5qWW6xUn5haX5qXrJefnbmIEp0gtzx2M
        s875HGIU4GBU4uE9cPZllBBrYllxZe4hRgkOZiUR3indr6KEeFMSK6tSi/Lji0pzUosPMZoC
        Q3Yis5Rocj4wfeeVxBuaWBqYmJmZGxoYWJooifPePHkvSkggPbEkNTs1tSC1CKaPiYNTqoGR
        68cqLZ9/M8r26Jc9PLX+bt5yT27ZYK0XB88cz1vz5fnP8o0HAxs2HubdHsDKITcr5vDUmGab
        r4eecfbEdEgdCvx56O9Xnb17jjAt3TX1/v9l7w7E3tvyx5/x6DJTdc6siLyb3QbZUxT3G2+f
        EKAduujWA7vZ58KUmuQVVDIVeCf7BFr/iHGfqsRSnJFoqMVcVJwIAG4z7yinAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnK7Au1dRBgduM1r0njvJZNG4exu7
        xZWv79ksXp1/w2yx6fE1VovLu+awWVxuvshocXjqEjaLphZji7v3TrBYrD3fyuLA7bFz1l12
        j+3fHrB63O8+zuSxeUm9R8vJ/Swe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugSvj9KP8
        gu2mFT2rPrM2MD7S6WLk5JAQMJFo7T3O3MXIxSEksJtR4vn1lewQCSmJZW+2sUHYwhIr/z1n
        hyj6zChxYOIHZpAEG1D38zkzWEFsEYGVTBK/WqVBipgFehklXuzfD9YhLNDEKLGv6T7YWBYB
        VYnL/w+DdfMKxEhs/9/LDLFCTuLmuU4gm4ODU8BKYs+XJJCwkIClRHvfYdYJjHwLGBlWMUqm
        FhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEh62W1g7GEyfiDzEKcDAq8fAeOPsySog1say4
        MvcQowQHs5II75TuV1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbB
        ZJk4OKUaGJkeK75bec5L+b556CSOFUrcByMjhZOnXXvzOqV6iv3MK8/dueKWHrz1SP/OsfCP
        yx4zmm4K8Im8cz0wQeOve4FZwvb9kYzn9Nc+l+81lFt6RPDxxPQYI4XLl01uGajtmJ4h2Mv8
        fc1JPvfmwvQvk/SuGD9dz1SZ1aVX+qPF2fawwnn/H6npv5VYijMSDbWYi4oTAZJRBGJXAgAA
X-CMS-MailID: 20180503111008epcas5p26088af1ff767ac0bf06cae934f1da339
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503111008epcas5p26088af1ff767ac0bf06cae934f1da339
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503111008epcas5p26088af1ff767ac0bf06cae934f1da339
X-RootMTR: 20180503111008epcas5p26088af1ff767ac0bf06cae934f1da339
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503111008epcas5p26088af1ff767ac0bf06cae934f1da339@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Duplicate logic for the timing params is avoided
-Arithmatic operator *,/ are replaced by logical >>, << operators
-The flags DRM_MODE_FLAG_* are replaced with DISPLAY_FLAGS_* flags

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 60 +++++++++++++++++++-------------------
 drivers/gpu/drm/mediatek/mtk_dsi.c | 14 ++-------
 2 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index e80a603..76dd3b9 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/clk.h>
+#include <video/videomode.h>
 
 #include "mtk_dpi_regs.h"
 #include "mtk_drm_ddp_comp.h"
@@ -429,34 +430,35 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	struct mtk_dpi_sync_param vsync_leven = { 0 };
 	struct mtk_dpi_sync_param vsync_rodd = { 0 };
 	struct mtk_dpi_sync_param vsync_reven = { 0 };
-	unsigned long pix_rate;
+	struct videomode vm;
 	unsigned long pll_rate;
 	unsigned int factor;
 
 	/* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
-	pix_rate = 1000UL * mode->clock;
+
 	if (mode->clock <= 27000)
-		factor = 16 * 3;
+		factor = 3 << 4;
 	else if (mode->clock <= 84000)
-		factor = 8 * 3;
+		factor = 3 << 3;
 	else if (mode->clock <= 167000)
-		factor = 4 * 3;
+		factor = 3 << 2;
 	else
-		factor = 2 * 3;
-	pll_rate = pix_rate * factor;
+		factor = 3 << 1;
+	drm_display_mode_to_videomode(mode, &vm);
+	pll_rate = vm.pixelclock * factor;
 
 	dev_dbg(dpi->dev, "Want PLL %lu Hz, pixel clock %lu Hz\n",
-		pll_rate, pix_rate);
+		pll_rate, vm.pixelclock);
 
 	clk_set_rate(dpi->tvd_clk, pll_rate);
 	pll_rate = clk_get_rate(dpi->tvd_clk);
 
-	pix_rate = pll_rate / factor;
-	clk_set_rate(dpi->pixel_clk, pix_rate);
-	pix_rate = clk_get_rate(dpi->pixel_clk);
+	vm.pixelclock = pll_rate / factor;
+	clk_set_rate(dpi->pixel_clk, vm.pixelclock);
+	vm.pixelclock = clk_get_rate(dpi->pixel_clk);
 
 	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
-		pll_rate, pix_rate);
+		pll_rate, vm.pixelclock);
 
 	limit.c_bottom = 0x0010;
 	limit.c_top = 0x0FE0;
@@ -465,33 +467,31 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 
 	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
 	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
-	dpi_pol.hsync_pol = mode->flags & DRM_MODE_FLAG_PHSYNC ?
+	dpi_pol.hsync_pol = vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ?
 			    MTK_DPI_POLARITY_FALLING : MTK_DPI_POLARITY_RISING;
-	dpi_pol.vsync_pol = mode->flags & DRM_MODE_FLAG_PVSYNC ?
+	dpi_pol.vsync_pol = vm.flags & DISPLAY_FLAGS_VSYNC_HIGH ?
 			    MTK_DPI_POLARITY_FALLING : MTK_DPI_POLARITY_RISING;
-
-	hsync.sync_width = mode->hsync_end - mode->hsync_start;
-	hsync.back_porch = mode->htotal - mode->hsync_end;
-	hsync.front_porch = mode->hsync_start - mode->hdisplay;
+	hsync.sync_width = vm.hsync_len;
+	hsync.back_porch = vm.hback_porch;
+	hsync.front_porch = vm.hfront_porch;
 	hsync.shift_half_line = false;
-
-	vsync_lodd.sync_width = mode->vsync_end - mode->vsync_start;
-	vsync_lodd.back_porch = mode->vtotal - mode->vsync_end;
-	vsync_lodd.front_porch = mode->vsync_start - mode->vdisplay;
+	vsync_lodd.sync_width = vm.vsync_len;
+	vsync_lodd.back_porch = vm.vback_porch;
+	vsync_lodd.front_porch = vm.vfront_porch;
 	vsync_lodd.shift_half_line = false;
 
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
+	if (vm.flags & DISPLAY_FLAGS_INTERLACED &&
 	    mode->flags & DRM_MODE_FLAG_3D_MASK) {
 		vsync_leven = vsync_lodd;
 		vsync_rodd = vsync_lodd;
 		vsync_reven = vsync_lodd;
 		vsync_leven.shift_half_line = true;
 		vsync_reven.shift_half_line = true;
-	} else if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
+	} else if (vm.flags & DISPLAY_FLAGS_INTERLACED &&
 		   !(mode->flags & DRM_MODE_FLAG_3D_MASK)) {
 		vsync_leven = vsync_lodd;
 		vsync_leven.shift_half_line = true;
-	} else if (!(mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+	} else if (!(vm.flags & DISPLAY_FLAGS_INTERLACED) &&
 		   mode->flags & DRM_MODE_FLAG_3D_MASK) {
 		vsync_rodd = vsync_lodd;
 	}
@@ -505,12 +505,12 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	mtk_dpi_config_vsync_reven(dpi, &vsync_reven);
 
 	mtk_dpi_config_3d(dpi, !!(mode->flags & DRM_MODE_FLAG_3D_MASK));
-	mtk_dpi_config_interface(dpi, !!(mode->flags &
-					 DRM_MODE_FLAG_INTERLACE));
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-		mtk_dpi_config_fb_size(dpi, mode->hdisplay, mode->vdisplay / 2);
+	mtk_dpi_config_interface(dpi, !!(vm.flags &
+					 DISPLAY_FLAGS_INTERLACED));
+	if (vm.flags & DISPLAY_FLAGS_INTERLACED)
+		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive >> 1);
 	else
-		mtk_dpi_config_fb_size(dpi, mode->hdisplay, mode->vdisplay);
+		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive);
 
 	mtk_dpi_config_channel_limit(dpi, &limit);
 	mtk_dpi_config_bit_num(dpi, dpi->bit_num);
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 7e5e24c..aa0943e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -551,13 +551,12 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	}
 
 	/**
-	 * vm.pixelclock is in kHz, pixel_clock unit is Hz, so multiply by 1000
 	 * htotal_time = htotal * byte_per_pixel / num_lanes
 	 * overhead_time = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
 	 * mipi_ratio = (htotal_time + overhead_time) / htotal_time
 	 * data_rate = pixel_clock * bit_per_pixel * mipi_ratio / num_lanes;
 	 */
-	pixel_clock = dsi->vm.pixelclock * 1000;
+	pixel_clock = dsi->vm.pixelclock;
 	htotal = dsi->vm.hactive + dsi->vm.hback_porch + dsi->vm.hfront_porch +
 			dsi->vm.hsync_len;
 	htotal_bits = htotal * bit_per_pixel;
@@ -725,16 +724,7 @@ static void mtk_dsi_encoder_mode_set(struct drm_encoder *encoder,
 {
 	struct mtk_dsi *dsi = encoder_to_dsi(encoder);
 
-	dsi->vm.pixelclock = adjusted->clock;
-	dsi->vm.hactive = adjusted->hdisplay;
-	dsi->vm.hback_porch = adjusted->htotal - adjusted->hsync_end;
-	dsi->vm.hfront_porch = adjusted->hsync_start - adjusted->hdisplay;
-	dsi->vm.hsync_len = adjusted->hsync_end - adjusted->hsync_start;
-
-	dsi->vm.vactive = adjusted->vdisplay;
-	dsi->vm.vback_porch = adjusted->vtotal - adjusted->vsync_end;
-	dsi->vm.vfront_porch = adjusted->vsync_start - adjusted->vdisplay;
-	dsi->vm.vsync_len = adjusted->vsync_end - adjusted->vsync_start;
+	drm_display_mode_to_videomode(adjusted, &dsi->vm);
 }
 
 static void mtk_dsi_encoder_disable(struct drm_encoder *encoder)
-- 
2.7.4
