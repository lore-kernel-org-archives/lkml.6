Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeECJf6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:35:58 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:31171 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeECJf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:35:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180503093554epoutp01f349a487bfdb6a11687f18dfe0c5503f~rGMndX_Ze2504025040epoutp018
X-AuditID: b6c32a4b-185ff70000001094-7f-5aead7f909cc
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Satendra Singh Thakur <satendra.t@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: [PATCH 08/13] drm/kms/mode/pl111-display: using helper function
 drm_display_mode_to_videomode for calculating timing parameters
Date: Thu,  3 May 2018 15:05:35 +0530
Message-Id: <554c19f45bc6e716afb05551d6b8c41ad6bb9bc0.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUhTYRjl3d29u1qTy1R6NbBxKclqc1ubXiMzSXKgkJFErcRu7m1K+2J3
        VhqBlUm5DIskMX9MsqDIRipZpja0lKJcZWnRl4voY5laSyMr686r9O+c9znnPYeHh8RkE3gs
        WWR1IoeVNdNEuPhaT8JSxc+hgEF17nU8U9V/V8Q8mRgjGO/BAcAEfCMYM9BeTzA9NY0E0+Q7
        Il4r0R8a6yX0bZPDuP6Nq0+kP9F6CeiDzXE5uAGtLkSsETnkyFpgMxZZTal01qb8dfm6JJVa
        oU5hkmm5lbWgVDojO0exvsjM16Dle1hzMf+Uw3IcnbhmtcNW7ETyQhvnTKW3qdUapVqVrNRo
        NEqtLm+VRsdLdqDCpokTmP1W9L63lVclZeArVQnCSEhpodf/XlwJwkkZdRPA8r9nRQL5BqDr
        WQcQyCSAo/e8kjnLmR9jeAjLqE4AD7VFCqIJAKs9vTMDghd9qK/FQ4Mo6jCAvlPumX8xygVg
        VWc5FiKRfAc46RYsYmoJnAw8IEJYSm2Hfk8vEPLi4PP+Y7yBJMOoVbDj+86QF1KNBGx59ZIQ
        NBmwonkcF3AkDPS1znaNhcHRTkIw8DWGrzRIBHIcwKPHemdVabD8tFccSsCoBOhpTwxBSKVC
        jy8ipMCoCFj1651IeJbCoxUywbgYXvzYg81F/XZXzlbQw1OXB0UCTod1/huEsKIqAN9fGMCr
        waK6/2FuAC6BGGTnLCbE6ewrrWivkmMtXLHVpCywWZrBzMkty7oOmvuzuwFFAnq+1Pvgk0GG
        s3u4Eks3gCRGR0lPuwIGmdTIlpQihy3fUWxGXDfQ8Ys9icVGF9j4A7Y689XaFJU2KSlZrVKl
        aOkF0ud3XxtklIl1ot0I2ZFjziciw2LLgH3oWtaW3EfM3rbM6QhV5ua09If2qS/TR+4wI7uu
        rDEOvnmXppjnac80ddUY73v9RfuV0S8agnXdw1HjuzpfuUZW+DzKdM/ypxum8j4fCDrC1s0j
        ukYrHp7c1pL58a1p4R/md+7j83+GzBL/plpccXvjevloTLi+9G98UPftx0LtVlrMFbLqZZiD
        Y/8Bv/jCWIgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSvO7P66+iDOb9ZbboPXeSyeLK1/ds
        FgcaLzNavDr/htni8q45bBaHpy5hs1h7vpXFgd2j6f0xNo/t3x6wetzvPs7k0bdlFaPH501y
        AaxRXDYpqTmZZalF+nYJXBlrv/YxF+wXrXjUtZG9gfGjQBcjJ4eEgInE9O/vWbsYuTiEBHYz
        Sny//YQRIiElsezNNjYIW1hi5b/n7CC2kMBnRolHp8pAbDag5udzZoA1iwi0M0rsPHyPHcRh
        FuhllHixfz+YIyzQwSixY+MUJpAWFgFViW+vzoKN5RWIkXi4/hjUOjmJm+c6mbsYOTg4Bawk
        9nxJgthmKdHed5h1AiPfAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwYGnpbWD
        8cSJ+EOMAhyMSjy8B86+jBJiTSwrrsw9xCjBwawkwjul+1WUEG9KYmVValF+fFFpTmrxIUZp
        DhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBkZ7pu2rub5c4VqsuuyIhNzUU9NMfSNf/ik/
        5fauJqdzUqkqs77qt/gJ67k/x8fG/yxYuuxi3a99i85kLN8SLa+83W3u5jJ7wRu5ivmmqzpK
        /DwWmXGz/3hUqZ72nt13ctF8wx5Hft4TpT2n8jjvm6WL9hadK5dRcf2qPfGo/sO2F72PLnyM
        Wa/EUpyRaKjFXFScCAAbgUrcOAIAAA==
X-CMS-MailID: 20180503093553epcas5p35363f1990726114a9079be483cc26d9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503093553epcas5p35363f1990726114a9079be483cc26d9a
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503093553epcas5p35363f1990726114a9079be483cc26d9a
X-RootMTR: 20180503093553epcas5p35363f1990726114a9079be483cc26d9a
References: <cover.1525087679.git.satendra.t@samsung.com>
        <CGME20180503093553epcas5p35363f1990726114a9079be483cc26d9a@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate logic for the same

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/pl111/pl111_display.c | 40 +++++++++++++----------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 3106464..104f318 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -24,6 +24,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <video/videomode.h>
 
 #include "pl111_drm.h"
 
@@ -130,13 +131,14 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 	struct drm_framebuffer *fb = plane->state->fb;
 	struct drm_connector *connector = priv->connector;
 	struct drm_bridge *bridge = priv->bridge;
+	struct videomode vm;
 	u32 cntl;
-	u32 ppl, hsw, hfp, hbp;
-	u32 lpp, vsw, vfp, vbp;
-	u32 cpl, tim2;
+	u32 tim2;
 	int ret;
 
-	ret = clk_set_rate(priv->clk, mode->clock * 1000);
+	drm_display_mode_to_videomode(mode, &vm);
+
+	ret = clk_set_rate(priv->clk, vm.pixelclock);
 	if (ret) {
 		dev_err(drm->dev,
 			"Failed to set pixel clock rate to %d: %d\n",
@@ -145,27 +147,15 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 
 	clk_prepare_enable(priv->clk);
 
-	ppl = (mode->hdisplay / 16) - 1;
-	hsw = mode->hsync_end - mode->hsync_start - 1;
-	hfp = mode->hsync_start - mode->hdisplay - 1;
-	hbp = mode->htotal - mode->hsync_end - 1;
-
-	lpp = mode->vdisplay - 1;
-	vsw = mode->vsync_end - mode->vsync_start - 1;
-	vfp = mode->vsync_start - mode->vdisplay;
-	vbp = mode->vtotal - mode->vsync_end;
-
-	cpl = mode->hdisplay - 1;
-
-	writel((ppl << 2) |
-	       (hsw << 8) |
-	       (hfp << 16) |
-	       (hbp << 24),
+	writel((((vm.hactive >> 4) - 1) << 2) |
+	       ((vm.hsync_len - 1) << 8) |
+	       ((vm.hfront_porch - 1) << 16) |
+	       ((vm.hback_porch - 1) << 24),
 	       priv->regs + CLCD_TIM0);
-	writel(lpp |
-	       (vsw << 10) |
-	       (vfp << 16) |
-	       (vbp << 24),
+	writel((vm.vactive - 1) |
+	       ((vm.vsync_len - 1) << 10) |
+	       ((vm.vfront_porch) << 16) |
+	       ((vm.vback_porch) << 24),
 	       priv->regs + CLCD_TIM1);
 
 	spin_lock(&priv->tim2_lock);
@@ -214,7 +204,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 			tim2 ^= TIM2_IPC;
 	}
 
-	tim2 |= cpl << 16;
+	tim2 |= (vm.hactive - 1) << 16;
 	writel(tim2, priv->regs + CLCD_TIM2);
 	spin_unlock(&priv->tim2_lock);
 
-- 
2.7.4
