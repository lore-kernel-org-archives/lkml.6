Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F80C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A681204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="loj066Rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A681204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJHQoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:44:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54498 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeJHQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:44:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008093330euoutp015a4ec50f7c120bbf332ecd120bc99835~bmFoVdqBT0989709897euoutp01d
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 09:33:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008093330euoutp015a4ec50f7c120bbf332ecd120bc99835~bmFoVdqBT0989709897euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538991210;
        bh=2S59xOC/+wTN9XMCigxSAaYWZSnJEnKPlC3CXZCx6vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loj066RtrlPOjzS8CJ4LQ8VR6HQol2U/eIpHpmrauAYXhLi4M+3O2CeX56MJfVdTD
         OnwnGnjRh09X5p2IakQ1bHMLZga6uKtwZ/gYimTQlswOSc5G1j+DbONTJyT5D4hxwh
         GdlslrBHUAF08NcKkaziEI4wFJgpHtA5jQB5DJLk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008093329eucas1p29d8f6e2ac20fe3717db1da46e4ea11cb~bmFncN-581151211512eucas1p23;
        Mon,  8 Oct 2018 09:33:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 88.ED.04294.9642BBB5; Mon,  8
        Oct 2018 10:33:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181008093328eucas1p2c00d65c7f8451f7628f630934c992185~bmFmklSgF0357503575eucas1p25;
        Mon,  8 Oct 2018 09:33:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008093328eusmtrp1769f6136fea171d4336fcc4b8cd803e9~bmFmSzBvx0079300793eusmtrp16;
        Mon,  8 Oct 2018 09:33:28 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-e2-5bbb2469d927
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AA.7B.04128.8642BBB5; Mon,  8
        Oct 2018 10:33:28 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181008093327eusmtip28d701c1abd561954c98e3046356579e3~bmFlsZfmV0447104471eusmtip23;
        Mon,  8 Oct 2018 09:33:27 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 1/2] drm/exynos: fimd: Make plane alpha configurable
Date:   Mon,  8 Oct 2018 11:33:01 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538991182-12961-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djPc7qZKrujDe42s1jcWneO1aL33Ekm
        i40z1rNaHN+9lNHiytf3bBaT7k9gsXhx7yKLRf/j18wW589vYLc42/SG3WLT42usFpd3zWGz
        mHF+H5PF2iN32S1mTH7J5sDvsWlVJ5vH9m8PWD3udx9n8ti8pN6jb8sqRo/Pm+QC2KK4bFJS
        czLLUov07RK4MjZM2sNacFej4tvh66wNjEcVuxg5OSQETCQezOtl6mLk4hASWMEosWjlNWYI
        5wujxKkbHawgVUICnxklfp9hg+loOneWFaJoOaPEusc9bHAdz5+/BKtiEzCVuH33E5gtIqAs
        8XfiKkaQImaBrSwSe0/eYAJJCAu4SPyYu5kFxGYRUJW4un43E8QKOYmb5zqZQWxOAU+Jg3tW
        sIA0SwhsYpe49uAhWIJXoEzi4mGIZgmgQRNXrYVqFpZ4dXwLO4QtI3F6cg9UczOjxK0v11gh
        nAmMEgdXd0F1W0tsuvEKqJsD6D5NifW79CHCjhJHpvWxgIQlBPgkbrwVBAkzA5mTtk1nhgjz
        SnS0CUFUq0m83rKFDWbti89fGSFsD4nVvw+yQ0Kok0ni8pZL7BMY5WchLFvAyLiKUTy1tDg3
        PbXYKC+1XK84Mbe4NC9dLzk/dxMjMAGd/nf8yw7GXX+SDjEKcDAq8fCuCNgVLcSaWFZcmXuI
        UYKDWUmEV3Q7UIg3JbGyKrUoP76oNCe1+BCjNAeLkjjvsnkbo4UE0hNLUrNTUwtSi2CyTByc
        Ug2M8zhfTas3a7dj6shLLNBOXdh4d3WnYfT+Q2pJXXZXdoV0bAk/dehvO8Pv0/lx35ofPOlY
        sPX2TemXKTPF8v7vq6y23i95OcxO0+nOPLbW31nmc4MCzmnrfY1xaLBgnHo8cEFW+a7qic25
        V/dvVJ7yy2zRjIZCmZTJdyzF/+d8lv31NXzPk9Y8JZbijERDLeai4kQA9xbudzwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Pd0Mld3RBle3sFncWneO1aL33Ekm
        i40z1rNaHN+9lNHiytf3bBaT7k9gsXhx7yKLRf/j18wW589vYLc42/SG3WLT42usFpd3zWGz
        mHF+H5PF2iN32S1mTH7J5sDvsWlVJ5vH9m8PWD3udx9n8ti8pN6jb8sqRo/Pm+QC2KL0bIry
        S0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MjZM2sNacFej
        4tvh66wNjEcVuxg5OSQETCSazp1l7WLk4hASWMooce5iNwtEQkZi3tk+NghbWOLPtS42iKJP
        jBK/H7czgyTYBEwlbt/9BFYkIqAs8XfiKkaQImaBgywSLRvPMIIkhAVcJH7M3Qw2lUVAVeLq
        +t1MIDavgIfEyeUHmCA2yEncPNcJNpRTwFPi4J4VLBDbtjJKzNnbyDqBkW8BI8MqRpHU0uLc
        9NxiI73ixNzi0rx0veT83E2MwIjYduznlh2MXe+CDzEKcDAq8fCuCNgVLcSaWFZcmXuIUYKD
        WUmEV3Q7UIg3JbGyKrUoP76oNCe1+BCjKdBVE5mlRJPzgdGaVxJvaGpobmFpaG5sbmxmoSTO
        e96gMkpIID2xJDU7NbUgtQimj4mDU6qBkV1/+zLWg3xtP5QLHHMn3K7YlPlnanAgd+cVJc87
        TS2WKyz09GWz3lw4ZVo/6b8G2/Rl762mODQ1/WnbLflELft2atq9lRbSb4KnPWvs80t4VPOh
        WJWZa9/frij2A3f9+jj2Nx/nOnHLQT+61DQ78c7dBuN7J05Na7m7yX933h0hD59dCpL3lViK
        MxINtZiLihMB01pxdJ4CAAA=
Message-Id: <20181008093328eucas1p2c00d65c7f8451f7628f630934c992185~bmFmklSgF0357503575eucas1p25@eucas1p2.samsung.com>
X-CMS-MailID: 20181008093328eucas1p2c00d65c7f8451f7628f630934c992185
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181008093328eucas1p2c00d65c7f8451f7628f630934c992185
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008093328eucas1p2c00d65c7f8451f7628f630934c992185
References: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
        <1538991182-12961-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181008093328eucas1p2c00d65c7f8451f7628f630934c992185@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fimd hardware supports variable plane alpha. Currently planes
are opaque, make this configurable.

Tested on TRATS2 with Exynos 4412 CPU, on top of exynos-drm-next.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 69 +++++++++++++++++++++++---------
 include/video/samsung_fimd.h             |  1 +
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index b7f56935a46b..06d5d2422246 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -229,6 +229,21 @@ static const uint32_t fimd_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
+static const unsigned int capabilities[WINDOWS_NR] = {
+	0,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+};
+
+static inline void fimd_set_bits(struct fimd_context *ctx, u32 reg, u32 mask,
+				 u32 val)
+{
+	val = (val & mask) | (readl(ctx->regs + reg) & ~mask);
+	writel(val, ctx->regs + reg);
+}
+
 static int fimd_enable_vblank(struct exynos_drm_crtc *crtc)
 {
 	struct fimd_context *ctx = crtc->ctx;
@@ -552,10 +567,38 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
 	writel(val, ctx->regs + VIDCON0);
 }
 
+static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
+				struct drm_framebuffer *fb)
+{
+	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane_state *state =
+		to_exynos_plane_state(plane.base.state);
+	unsigned int alpha = state->base.alpha;
+	u32 win_alpha = alpha >> 8;
+	u32 val = 0;
+
+	/* OSD alpha */
+	val = VIDISD14C_ALPHA0_R(alpha >> 4) |
+		VIDISD14C_ALPHA0_G(win_alpha >> 4) |
+		VIDISD14C_ALPHA0_B(win_alpha >> 4) |
+		VIDISD14C_ALPHA1_R(win_alpha >> 4) |
+		VIDISD14C_ALPHA1_G(win_alpha >> 4) |
+		VIDISD14C_ALPHA1_B(win_alpha >> 4);
+
+	writel(val, ctx->regs + VIDOSD_C(win));
+
+	val = VIDW_ALPHA_R(win_alpha & 0xf) | VIDW_ALPHA_G(win_alpha & 0xf) |
+		VIDW_ALPHA_G(win_alpha & 0xf);
+	writel(val, ctx->regs + VIDWnALPHA0(win));
+	writel(val, ctx->regs + VIDWnALPHA1(win));
+	fimd_set_bits(ctx, BLENDCON, BLENDCON_NEW_MASK,
+			BLENDCON_NEW_8BIT_ALPHA_VALUE);
+}
 
 static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
-				uint32_t pixel_format, int width)
+				struct drm_framebuffer *fb, int width)
 {
+	uint32_t pixel_format = fb->format->format;
 	unsigned long val;
 
 	val = WINCONx_ENWIN;
@@ -596,6 +639,7 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 			| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
 		val |= WINCONx_WSWP;
 		val |= WINCONx_BURSTLEN_16WORD;
+		val |= WINCON1_ALPHA_MUL;
 		break;
 	}
 
@@ -607,7 +651,7 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 	 * still better to change dma-burst than displaying garbage.
 	 */
 
-	if (width < MIN_FB_WIDTH_FOR_16WORD_BURST) {
+	if (fb->width < MIN_FB_WIDTH_FOR_16WORD_BURST) {
 		val &= ~WINCONx_BURSTLEN_MASK;
 		val |= WINCONx_BURSTLEN_4WORD;
 	}
@@ -615,22 +659,8 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 	writel(val, ctx->regs + WINCON(win));
 
 	/* hardware window 0 doesn't support alpha channel. */
-	if (win != 0) {
-		/* OSD alpha */
-		val = VIDISD14C_ALPHA0_R(0xf) |
-			VIDISD14C_ALPHA0_G(0xf) |
-			VIDISD14C_ALPHA0_B(0xf) |
-			VIDISD14C_ALPHA1_R(0xf) |
-			VIDISD14C_ALPHA1_G(0xf) |
-			VIDISD14C_ALPHA1_B(0xf);
-
-		writel(val, ctx->regs + VIDOSD_C(win));
-
-		val = VIDW_ALPHA_R(0xf) | VIDW_ALPHA_G(0xf) |
-			VIDW_ALPHA_G(0xf);
-		writel(val, ctx->regs + VIDWnALPHA0(win));
-		writel(val, ctx->regs + VIDWnALPHA1(win));
-	}
+	if (win != 0)
+		fimd_win_set_bldmod(ctx, win, fb);
 }
 
 static void fimd_win_set_colkey(struct fimd_context *ctx, unsigned int win)
@@ -786,7 +816,7 @@ static void fimd_update_plane(struct exynos_drm_crtc *crtc,
 		DRM_DEBUG_KMS("osd size = 0x%x\n", (unsigned int)val);
 	}
 
-	fimd_win_set_pixfmt(ctx, win, fb->format->format, state->src.w);
+	fimd_win_set_pixfmt(ctx, win, fb, state->src.w);
 
 	/* hardware window 0 doesn't support color key. */
 	if (win != 0)
@@ -988,6 +1018,7 @@ static int fimd_bind(struct device *dev, struct device *master, void *data)
 		ctx->configs[i].num_pixel_formats = ARRAY_SIZE(fimd_formats);
 		ctx->configs[i].zpos = i;
 		ctx->configs[i].type = fimd_win_types[i];
+		ctx->configs[i].capabilities = capabilities[i];
 		ret = exynos_plane_init(drm_dev, &ctx->planes[i], i,
 					&ctx->configs[i]);
 		if (ret)
diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index d8fc96ed11e9..f070b7c0d2cf 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -211,6 +211,7 @@
 #define WINCON0_BPPMODE_24BPP_888		(0xb << 2)
 
 #define WINCON1_LOCALSEL_CAMIF			(1 << 23)
+#define WINCON1_ALPHA_MUL			(1 << 7)
 #define WINCON1_BLD_PIX				(1 << 6)
 #define WINCON1_BPPMODE_MASK			(0xf << 2)
 #define WINCON1_BPPMODE_SHIFT			2
-- 
2.7.4

