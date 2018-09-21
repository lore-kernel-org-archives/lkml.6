Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C13ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D069E21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NEy6nt7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D069E21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389986AbeIUSO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:14:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47698 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389910AbeIUSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:14:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180921122618euoutp029656f71cb038d71ba83b45c6a90cbcae~WaeqMXkCG2217422174euoutp02N
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:26:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180921122618euoutp029656f71cb038d71ba83b45c6a90cbcae~WaeqMXkCG2217422174euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537532778;
        bh=T59ti9Ug5BqCYqp8sra8DJ1fKLQ73dUj8tuniH46HQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEy6nt7F64MID7w+Q2uYq1bri3uJMkCpgl0QfGe0rhd8eO+gj1xZ6uEBAJkr5TzXv
         JoVpX9P3FH4p0e9/AUyWtDPsCl7ZR9DIQLpvvBjObeQ6wRowbq4WCNuFoLlb3TX9rm
         CDWsvtiK+dhTARMRGuPMEq3pRo9SwC9hVsCjZW4Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180921122618eucas1p10afe58c59930e16713f2487516bec993~Waepb-hAa1146811468eucas1p1a;
        Fri, 21 Sep 2018 12:26:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8B.9F.04441.963E4AB5; Fri, 21
        Sep 2018 13:26:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180921122617eucas1p1c167a8ea2aeca02fb3927aa3660ff540~WaeojFnZu1309513095eucas1p1G;
        Fri, 21 Sep 2018 12:26:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180921122616eusmtrp1e98426defbdd8c1adabf44ee024d4a7b~WaeoRbQBn2872728727eusmtrp1M;
        Fri, 21 Sep 2018 12:26:16 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c9-5ba4e3697b8e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C7.69.04284.863E4AB5; Fri, 21
        Sep 2018 13:26:16 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180921122616eusmtip1a4c04bb741e9d7657c6b0e1c1e54a465~WaensUlaU2106721067eusmtip1b;
        Fri, 21 Sep 2018 12:26:16 +0000 (GMT)
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
Subject: [PATCH 2/3] drm/exynos: mixer: Make pixel blend mode configurable
Date:   Fri, 21 Sep 2018 14:24:37 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7qZj5dEG7TO17O4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
        MeP8PiaLtUfuslvMmPySzYHfY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEVx2aSk
        5mSWpRbp2yVwZby81sxScFKl4seGz6wNjMfluhg5OSQETCT2zfvM2sXIxSEksIJRYuFSEIcT
        yPnCKPFrZxGE/ZlR4nW/EUzDpn372SAaljNKXNiyDKobqKHt8wtGkCo2AVOJ23c/sYHYIgLK
        En8nrmIEKWIW2MoisffkDSaQhLCAl8TL45+AbA4OFgFViQ+rwiE2yEncPNfJDGJzCnhIrPvx
        jAUivo1d4tOZCBCbV6BMYsm52YwQcReJi8/PQNnCEq+Ob2GHsGUkTk/uYQHZKyHQzChx68s1
        VghnAqPEwdVdUFOtJTbdeAV2BLOApsT6XfoQYUeJ+89usIKEJQT4JG68FQQJMwOZk7ZNZ4YI
        80p0tAlBVKtJvN6yhQ1m7YvPX6HO8ZB4ufkLNEBnM0o8POcxgVF+FsKuBYyMqxjFU0uLc9NT
        iw3zUsv1ihNzi0vz0vWS83M3MQITz+l/xz/tYPx6KekQowAHoxIPr8HixdFCrIllxZW5hxgl
        OJiVRHj3dS2JFuJNSaysSi3Kjy8qzUktPsQozcGiJM7Lp5UWLSSQnliSmp2aWpBaBJNl4uCU
        amDk6dGfznv8rlhTQIy8e8QMp93qrMyhlv8dl23/JhV7ViBe8YRAawjfith35/xlLpwy/eec
        ISK27Wzg9E1nig++u1PYaJxglGa3X15froV5bc+rE9H997wXJZmt/sD/1vJZLf/Ha459k+Nz
        qg5bHu1/sTZgwY3z3e3lix6z3HOz2OrSIrk9/KwSS3FGoqEWc1FxIgAZ4C13OAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Xd2Mx0uiDVadNrC4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
        MeP8PiaLtUfuslvMmPySzYHfY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEXp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZby81sxScFKl
        4seGz6wNjMfluhg5OSQETCQ27dvP1sXIxSEksJRRYlH/SzaIhIzEvLN9ULawxJ9rXVBFnxgl
        Vh54xQySYBMwlbh99xNYkYiAssTfiasYQYqYBQ6ySLRsPMMIkhAW8JJ4efwTUxcjBweLgKrE
        h1XhIGFeAXeJw2cnMkEskJO4ea4TbCangIfEuh/PWEDKhYBqTq03mcDIt4CRYRWjSGppcW56
        brGhXnFibnFpXrpecn7uJkZgLGw79nPzDsZLG4MPMQpwMCrx8BosXhwtxJpYVlyZe4hRgoNZ
        SYR3X9eSaCHelMTKqtSi/Pii0pzU4kOMpkAnTWSWEk3OB8ZpXkm8oamhuYWlobmxubGZhZI4
        73mDyighgfTEktTs1NSC1CKYPiYOTqkGRuelR16+kno9y+uvwIVLs2WFPPwem1y06F7A+uOX
        itH0SqWnJ54yhJZ/1XnPsXvW5dVvd84PiE1sa3NffWDpqkUrj2eelNSTuNxv9+Z7Y08ww+Iu
        uQlTxWOC9279IKLM45U4bfOH+7sXFQXbX53DVCsgsuGLUtyTrx1TTzt5Tvvv9eFpwr19V1uV
        WIozEg21mIuKEwGVUg6gmwIAAA==
Message-Id: <20180921122617eucas1p1c167a8ea2aeca02fb3927aa3660ff540~WaeojFnZu1309513095eucas1p1G@eucas1p1.samsung.com>
X-CMS-MailID: 20180921122617eucas1p1c167a8ea2aeca02fb3927aa3660ff540
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180921122617eucas1p1c167a8ea2aeca02fb3927aa3660ff540
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180921122617eucas1p1c167a8ea2aeca02fb3927aa3660ff540
References: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180921122617eucas1p1c167a8ea2aeca02fb3927aa3660ff540@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mixer hardware supports both premultiplied alpha and
non-premultiplied alpha. Currently premultiplied alpha is default, make
this configurable.

Tested on Odroid-U3 with Exynos 4412 CPU, kernel next-20180913
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 +
 drivers/gpu/drm/exynos/exynos_drm_plane.c |  7 +++++++
 drivers/gpu/drm/exynos/exynos_mixer.c     | 27 +++++++++++++++++++++------
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index c737c4bd2c19..1cb26d8c66f9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -92,6 +92,7 @@ struct exynos_drm_plane {
 #define EXYNOS_DRM_PLANE_CAP_SCALE	(1 << 1)
 #define EXYNOS_DRM_PLANE_CAP_ZPOS	(1 << 2)
 #define EXYNOS_DRM_PLANE_CAP_TILE	(1 << 3)
+#define EXYNOS_DRM_PLANE_CAP_PIX_BLEND	(1 << 4)
 
 /*
  * Exynos DRM plane configuration structure.
diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index 755ca0e9ead2..236408906f1f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -298,6 +298,10 @@ int exynos_plane_init(struct drm_device *dev,
 		      const struct exynos_drm_plane_config *config)
 {
 	int err;
+	unsigned int supported_modes = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+				       BIT(DRM_MODE_BLEND_PREMULTI) |
+				       BIT(DRM_MODE_BLEND_COVERAGE);
+	struct drm_plane *plane = &exynos_plane->base;
 
 	err = drm_universal_plane_init(dev, &exynos_plane->base,
 				       1 << dev->mode_config.num_crtc,
@@ -318,5 +322,8 @@ int exynos_plane_init(struct drm_device *dev,
 	exynos_plane_attach_zpos_property(&exynos_plane->base, config->zpos,
 			   !(config->capabilities & EXYNOS_DRM_PLANE_CAP_ZPOS));
 
+	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_PIX_BLEND)
+		drm_plane_create_blend_mode_property(plane, supported_modes);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index ffbf4a950f69..721b63e92b28 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -131,14 +131,16 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.pixel_formats = mixer_formats,
 		.num_pixel_formats = ARRAY_SIZE(mixer_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
-				EXYNOS_DRM_PLANE_CAP_ZPOS,
+				EXYNOS_DRM_PLANE_CAP_ZPOS |
+				EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
 	}, {
 		.zpos = 1,
 		.type = DRM_PLANE_TYPE_CURSOR,
 		.pixel_formats = mixer_formats,
 		.num_pixel_formats = ARRAY_SIZE(mixer_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
-				EXYNOS_DRM_PLANE_CAP_ZPOS,
+				EXYNOS_DRM_PLANE_CAP_ZPOS |
+				EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
 	}, {
 		.zpos = 2,
 		.type = DRM_PLANE_TYPE_OVERLAY,
@@ -309,15 +311,22 @@ static void vp_default_filter(struct mixer_context *ctx)
 }
 
 static void mixer_cfg_gfx_blend(struct mixer_context *ctx, unsigned int win,
-				bool alpha)
+				unsigned int pixel_alpha)
 {
 	u32 val;
 
 	val  = MXR_GRP_CFG_COLOR_KEY_DISABLE; /* no blank key */
-	if (alpha) {
-		/* blending based on pixel alpha */
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+		val |= MXR_GRP_CFG_PIXEL_BLEND_EN;
+		break;
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
 		val |= MXR_GRP_CFG_BLEND_PRE_MUL;
 		val |= MXR_GRP_CFG_PIXEL_BLEND_EN;
+		break;
 	}
 	mixer_reg_writemask(ctx, MXR_GRAPHIC_CFG(win),
 			    val, MXR_GRP_CFG_MISC_MASK);
@@ -553,10 +562,16 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 	unsigned int win = plane->index;
 	unsigned int x_ratio = 0, y_ratio = 0;
 	unsigned int dst_x_offset, dst_y_offset;
+	unsigned int pixel_alpha;
 	dma_addr_t dma_addr;
 	unsigned int fmt;
 	u32 val;
 
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
+
 	switch (fb->format->format) {
 	case DRM_FORMAT_XRGB4444:
 	case DRM_FORMAT_ARGB4444:
@@ -616,7 +631,7 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 	mixer_reg_write(ctx, MXR_GRAPHIC_BASE(win), dma_addr);
 
 	mixer_cfg_layer(ctx, win, priority, true);
-	mixer_cfg_gfx_blend(ctx, win, fb->format->has_alpha);
+	mixer_cfg_gfx_blend(ctx, win, pixel_alpha);
 
 	/* layer update mandatory for mixer 16.0.33.0 */
 	if (ctx->mxr_ver == MXR_VER_16_0_33_0 ||
-- 
2.7.4

