Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F75ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103A620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tTTeVpZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103A620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJYX5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:57:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45617 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJYX5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:57:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181025152413euoutp018d67d6e7eed91ca0270767c9161af1c5~g41s-qQuI2938329383euoutp01c
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:24:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181025152413euoutp018d67d6e7eed91ca0270767c9161af1c5~g41s-qQuI2938329383euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540481053;
        bh=mJUmXaZnw5BEg2u9J6N3MDm2EjO3bWOTFj1Iq5MnKrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTTeVpZEFTkpmAlaTLuoG33JwF5BVeiEW7Ky9XoDkKKaNbQeqebWrZ2MjSHlkzcEV
         ZSiHu7ubCzDXbO8PEfdgHEjsberwDT0YfreBSoXKxNNra7IKsWi0PqG0GBPlDcOo2F
         74cincBNxjyhhC85Nx1C0GOgCH7sWCci/gScyu8w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181025152412eucas1p13376daf8397f1a4e96748cb4689c57e4~g41sD8yoT0737507375eucas1p19;
        Thu, 25 Oct 2018 15:24:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 46.6E.04806.C10E1DB5; Thu, 25
        Oct 2018 16:24:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181025152411eucas1p1d9c15aaa67585ac888b72ef67c258b44~g41qpKjGp2269722697eucas1p1G;
        Thu, 25 Oct 2018 15:24:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181025152410eusmtrp2b167e82c786bd9af34fe7b8649218391~g41qZ0rY02641026410eusmtrp2A;
        Thu, 25 Oct 2018 15:24:10 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-1d-5bd1e01c3560
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.84.04284.A10E1DB5; Thu, 25
        Oct 2018 16:24:10 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181025152410eusmtip13133810def9796948b3cbbca6fd21c75~g41p1K4Y02539125391eusmtip1k;
        Thu, 25 Oct 2018 15:24:10 +0000 (GMT)
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
Subject: [PATCH v2 1/2] drm/exynos: fimd: Make plane alpha configurable
Date:   Thu, 25 Oct 2018 17:23:49 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540481030-15019-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djPc7oyDy5GG8x4LWpxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1lMuj+BxeLFvYssFv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN
        Ysb5fUwWa4/cZbeYMfklmwO/x6ZVnWwe2789YPW4332cyWPzknqPvi2rGD0+b5ILYIvisklJ
        zcksSy3St0vgyvjV8paxYIdGxbNXOxgbGJcpdjFyckgImEh8OPWcGcQWEljBKPHmTRGE/YVR
        4txD1i5GLiD7M6PEsffz2WEarvVvY4RILGeU2PJ4NhuEA9TxcPlMsFFsAqYSt+9+YgOxRQSU
        Jf5OXAXWwSywlUVi78kbTCAJYQF3ieWb/4E1sAioSky+2s8KsUJO4ua5TqA4BwengKfEgZv6
        IL0SAtvYJWbsbgIbyitQJtH7dhIzRL2LROeGZ1DnCUu8Or4FypaR+L9zPhNEczOjxK0v11gh
        nAmMEgdXd7FAVFlLbLrxiglkG7OApsT6XfoQYUeJls/zWEHCEgJ8EjfeCoKEmYHMSdumM0OE
        eSU62oQgqtUkXm/Zwgaz9sXnr4wQtodE46NlzJAAmgMM0vcz2Scwys9CWLaAkXEVo3hqaXFu
        emqxcV5quV5xYm5xaV66XnJ+7iZGYPI5/e/41x2M+/4kHWIU4GBU4uE9seFCtBBrYllxZe4h
        RgkOZiUR3r23L0YL8aYkVlalFuXHF5XmpBYfYpTmYFES5102b2O0kEB6YklqdmpqQWoRTJaJ
        g1OqgTHYJ0rN9u7WR9ebZj78qc09vbDy02x+eckbySaXlmYs+bOKc6VvjdrsL+cfJhWss9vC
        7+u1U2hRzLQ5khmK67+WvBc9/s20cWPWgk+1/zc7sDQV8fmkxv3suc60iO3zx3eFHKlnPL4z
        7zRbIzdpVdDxBP3CSOWNCxbbPuyXFwhaIns2wrMkeo4SS3FGoqEWc1FxIgDkE1Z0OgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4XV2pBxejDRb9NLC4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
        MeP8PiaLtUfuslvMmPySzYHfY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEXp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfxqectYsEOj
        4tmrHYwNjMsUuxg5OSQETCSu9W9j7GLk4hASWMoosenPeiaIhIzEvLN9bBC2sMSfa11sEEWf
        GCVO/9nNCpJgEzCVuH33E1iRiICyxN+Jq8AmMQscZJFo2XiGESQhLOAusXzzP2YQm0VAVWLy
        1X6wZl4BD4mNt3sZITbISdw81wlUw8HBKeApceCmPkhYCKjk9cknrBMY+RYwMqxiFEktLc5N
        zy021CtOzC0uzUvXS87P3cQIjIZtx35u3sF4aWPwIUYBDkYlHt4TGy5EC7EmlhVX5h5ilOBg
        VhLh3Xv7YrQQb0piZVVqUX58UWlOavEhRlOgmyYyS4km5wMjNa8k3tDU0NzC0tDc2NzYzEJJ
        nPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUAyPvZLNgLu3ubft2yklPauzt73uq03SEwW5ep/J2
        t3mVQlP1qpZqhu6bv5tnKfejezPqFpxxvLuDr+e2VuGmt/enr13I0HtYkuGOxGad6KVrHlmt
        llacxuL1aXbN1Gm/ty/T4n7JMNFfeJPJ91amW4wqe+WvhUQwCZrvKrfU7Tyy6IR5fXu9xhYl
        luKMREMt5qLiRAAG1+5LnAIAAA==
Message-Id: <20181025152411eucas1p1d9c15aaa67585ac888b72ef67c258b44~g41qpKjGp2269722697eucas1p1G@eucas1p1.samsung.com>
X-CMS-MailID: 20181025152411eucas1p1d9c15aaa67585ac888b72ef67c258b44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181025152411eucas1p1d9c15aaa67585ac888b72ef67c258b44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181025152411eucas1p1d9c15aaa67585ac888b72ef67c258b44
References: <1540481030-15019-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181025152411eucas1p1d9c15aaa67585ac888b72ef67c258b44@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fimd hardware supports variable plane alpha. Currently planes
are opaque, make this configurable.

Tested on TRATS2 with Exynos 4412 CPU, on top of linux-next-20181019.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
v2 changes:
 - write blue lower ALPHA0 value correctly,
 - set ALPHA1 to zero,
 - move local variables from set_bldmod to set_pixfmt,
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 75 +++++++++++++++++++++++---------
 include/video/samsung_fimd.h             |  1 +
 2 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index b7f56935a46b..9c4ff60326b9 100644
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
@@ -552,13 +567,43 @@ static void fimd_commit(struct exynos_drm_crtc *crtc)
 	writel(val, ctx->regs + VIDCON0);
 }
 
+static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
+				unsigned int alpha)
+{
+	u32 win_alpha_l = (alpha >> 8) & 0xf;
+	u32 win_alpha_h = alpha >> 12;
+	u32 val = 0;
+
+	/* OSD alpha */
+	val = VIDISD14C_ALPHA0_R(win_alpha_h) |
+		VIDISD14C_ALPHA0_G(win_alpha_h) |
+		VIDISD14C_ALPHA0_B(win_alpha_h) |
+		VIDISD14C_ALPHA1_R(0x0) |
+		VIDISD14C_ALPHA1_G(0x0) |
+		VIDISD14C_ALPHA1_B(0x0);
+	writel(val, ctx->regs + VIDOSD_C(win));
+
+	val = VIDW_ALPHA_R(win_alpha_l) | VIDW_ALPHA_G(win_alpha_l) |
+		VIDW_ALPHA_B(win_alpha_l);
+	writel(val, ctx->regs + VIDWnALPHA0(win));
+
+	val = VIDW_ALPHA_R(0x0) | VIDW_ALPHA_G(0x0) |
+		VIDW_ALPHA_B(0x0);
+	writel(val, ctx->regs + VIDWnALPHA1(win));
+
+	fimd_set_bits(ctx, BLENDCON, BLENDCON_NEW_MASK,
+			BLENDCON_NEW_8BIT_ALPHA_VALUE);
+}
 
 static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
-				uint32_t pixel_format, int width)
+				struct drm_framebuffer *fb, int width)
 {
-	unsigned long val;
-
-	val = WINCONx_ENWIN;
+	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane_state *state =
+		to_exynos_plane_state(plane.base.state);
+	uint32_t pixel_format = fb->format->format;
+	unsigned int alpha = state->base.alpha;
+	u32 val = WINCONx_ENWIN;
 
 	/*
 	 * In case of s3c64xx, window 0 doesn't support alpha channel.
@@ -596,6 +641,7 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 			| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
 		val |= WINCONx_WSWP;
 		val |= WINCONx_BURSTLEN_16WORD;
+		val |= WINCON1_ALPHA_MUL;
 		break;
 	}
 
@@ -615,22 +661,8 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
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
+		fimd_win_set_bldmod(ctx, win, alpha);
 }
 
 static void fimd_win_set_colkey(struct fimd_context *ctx, unsigned int win)
@@ -786,7 +818,7 @@ static void fimd_update_plane(struct exynos_drm_crtc *crtc,
 		DRM_DEBUG_KMS("osd size = 0x%x\n", (unsigned int)val);
 	}
 
-	fimd_win_set_pixfmt(ctx, win, fb->format->format, state->src.w);
+	fimd_win_set_pixfmt(ctx, win, fb, state->src.w);
 
 	/* hardware window 0 doesn't support color key. */
 	if (win != 0)
@@ -988,6 +1020,7 @@ static int fimd_bind(struct device *dev, struct device *master, void *data)
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

