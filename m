Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3D2C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD9E213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SCkSslDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD9E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJCQ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:28:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47013 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeJCQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:28:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181003094100euoutp0211be97cfdca97f6e2f4c47b7491c2cbc~aD9wPWSmf0171601716euoutp02k
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 09:41:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181003094100euoutp0211be97cfdca97f6e2f4c47b7491c2cbc~aD9wPWSmf0171601716euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538559660;
        bh=pzF5Sk1a0Vc4W02m0vKSgITDLayUTAW8U8/p7KTgPMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCkSslDiQogl9wabhvyXFkmP+fElNc82bvHYp6Pd1nfZiak1l96r0TCJZeBP59OZj
         ZkM0WEJRQI0ZphycClaiM9BvtZhS36QmcjR073da9NWJ4ogYjcjLbHZi/xtsCvRY3A
         x/4P2+dYenlOna+wn9GADlsKrQwNBPaSlkjvgs0M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181003094059eucas1p22317e4700639c3e510c78c8b36f90e76~aD9vSXcEj1805918059eucas1p2j;
        Wed,  3 Oct 2018 09:40:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 83.EA.04441.BAE84BB5; Wed,  3
        Oct 2018 10:40:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181003094058eucas1p10dba450852a4ce8dc521b15e63ebabfa~aD9ubxJ5A1867918679eucas1p1K;
        Wed,  3 Oct 2018 09:40:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181003094058eusmtrp2e4fef2c2292649c7f22691b8ec4fdb3c~aD9uKB1jZ0629006290eusmtrp2M;
        Wed,  3 Oct 2018 09:40:58 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-9e-5bb48eabf19a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.4C.04128.AAE84BB5; Wed,  3
        Oct 2018 10:40:58 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181003094057eusmtip14a842d6c4efc6f22307e92c2e744437e~aD9tMaRoV0809708097eusmtip1C;
        Wed,  3 Oct 2018 09:40:57 +0000 (GMT)
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
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Lowry Li <lowry.li@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 1/2] drm/exynos: decon: Make plane alpha configurable
Date:   Wed,  3 Oct 2018 11:40:43 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538559644-30269-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjm27m6Whyn4NeFVdOuYMsu+EFXoeJkP7LoRpZ5qoNmzmRTKyHS
        IvGSc2mi2Zi67nNpzqVzWeIyh4QbaUUpZtF+mJe0pkaRltvp8u95n8v3vLx8NCZ1EXPoE0kp
        vCqJS5STYry+7bsztEpjiV5pfkqi7mongfKd7SJUW1pDIMejWwC9HB8hUeN7G4UK+7Q46n/3
        AkcFHwcx5HI9oFDHhSEKmT++JlCXTUeiUtcTESqwthDofmsvhSq/PMRRb1ErQKVFn8jNAaxJ
        bwKs2ZhDsg0T7wlW376L7ctziNi6m+fZxsLHItZh66ZYjcUIWI9ZFiU+KF5/nE88kcarFBtj
        xfHXrZlEcrbsTHuRlsoAxtm5gKYhswbevLotF4hpKXMXwLaBfFIYxgBsassjhMED4I+ePCwX
        +PkSuuIuIAh3ABztdhP/Is5nWsrrIpm1sKf3K+nFgUwwnLxi9CUwpouALkMl7hUCmK0wo20K
        9y6CM4tgg3mJ0CCDb505vjY/Zjs02W2+AsgMU9B9LdsnSJg0WKYZJYXAFqgZNYoEHAAHHBZK
        wPPgr8ZykRC+CGD32Os/L2kBbKnKxQXXOmh+MyDyboExy2CNTSHQEdBtqAfClWbBN8P+Xhqb
        hoX1JZhAS2B2llRwL4aDFgv5t7bfMw4EzMKSn3pMOJAOwKK+alIL5pf9L6sAwAiC+FS1Mo5X
        hyXxp1eoOaU6NSluxbFTSjOY/mbPpxxfrWC886gdMDSQz5RYK+uipQSXpj6rtANIY/JAiYab
        piTHubPpvOrUEVVqIq+2g7k0Lg+S3NbXRkuZOC6FP8nzybzqryqi/eZkAI6ef+CbrCOmVZse
        bq26vCFjsmNT7SHGvF88GZr5Oa6HL3duPNfcHLrPHVabXLDn4YzAkCfjI0cid8TGxC+8sca0
        uvPDpb2HpUvvVRhm7Ov3k3kiF0wkfDME++sUQ+nrm1Y2NCt2Pn1lUqpKf1KKuojirN3pCbtj
        lOF4i+5VUFTIKjmujufClmMqNfcbM+QuxWIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7qr+rZEG9y8ymVxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1nsfLCL3WLS/QksFi/uXWSx6H/8mtni/PkN7BZnm96wW2x6fI3V
        4vKuOWwWM87vY7Lo33GQ1WLtkbvsFgs/bmWxuDv5CKPFjMkv2RyEPdbMW8PosWlVJ5vH9m8P
        WD3mnQz0uN99nMlj85J6j52T9jJ5HN91i92jb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MmbvaGQt6JCrODl5AnsD4yrJLkZO
        DgkBE4k5Uy8zdjFycQgJLGWUmD77OzNEQkZi3tk+NghbWOLPtS42iKJPjBJnTuwGK2ITMJW4
        ffcTWJGIgLLE34mrwCYxCzxklXi/sBMsISzgKtFw7B9LFyMHB4uAqsT2TeogYV4BD4mN206x
        QCyQk7h5rhNsJqeAp8SaQ7tYQWwhoJqvvzYwTmDkW8DIsIpRJLW0ODc9t9hIrzgxt7g0L10v
        OT93EyMwtrYd+7llB2PXu+BDjAIcjEo8vAnzN0cLsSaWFVfmHmKU4GBWEuHtSwQK8aYkVlal
        FuXHF5XmpBYfYjQFumkis5Rocj4w7vNK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqem
        FqQWwfQxcXBKNTBy/DMJydt+/iSnA6v1PYl9V9qni9/Q2OGWpZzucCPeZpXovJpH1+8sk5N4
        a/c85e8q0V/fnlXL/HPs0UuSkVQIWWLtIln6+saCHTLmPrumndli/+ZE3LWqD5HXXyy8+n5P
        +ulcyZYJLpwS66X3Wt7fGS7DnuQkttT2mNw3IYPz96Rs9uncKrVXYinOSDTUYi4qTgQAbjYu
        cMMCAAA=
Message-Id: <20181003094058eucas1p10dba450852a4ce8dc521b15e63ebabfa~aD9ubxJ5A1867918679eucas1p1K@eucas1p1.samsung.com>
X-CMS-MailID: 20181003094058eucas1p10dba450852a4ce8dc521b15e63ebabfa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181003094058eucas1p10dba450852a4ce8dc521b15e63ebabfa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181003094058eucas1p10dba450852a4ce8dc521b15e63ebabfa
References: <1538559644-30269-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181003094058eucas1p10dba450852a4ce8dc521b15e63ebabfa@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decon hardware supports variable plane alpha. Currently planes
are opaque, make this configurable.

Tested on TM2 with Exynos 5433 CPU, on top of exynos-drm-next.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 30 +++++++++++++++++++++++++++
 drivers/gpu/drm/exynos/regs-decon5433.h       |  4 ++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 94529aa82339..dff540160199 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -84,6 +84,14 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	[CURSON_WIN] = DRM_PLANE_TYPE_CURSOR,
 };
 
+static const unsigned int capabilities[WINDOWS_NR] = {
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+};
+
 static inline void decon_set_bits(struct decon_context *ctx, u32 reg, u32 mask,
 				  u32 val)
 {
@@ -259,6 +267,24 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	decon_set_bits(ctx, DECON_UPDATE, STANDALONE_UPDATE_F, ~0);
 }
 
+static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
+				 struct drm_framebuffer *fb)
+{
+	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane_state *state =
+		to_exynos_plane_state(plane.base.state);
+	unsigned int alpha = state->base.alpha;
+	u32 win_alpha = alpha >> 8;
+	u32 val = 0;
+
+	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		val = VIDOSD_Wx_ALPHA_R_F(win_alpha) | VIDOSD_Wx_ALPHA_G_F(win_alpha) |
+			VIDOSD_Wx_ALPHA_B_F(win_alpha);
+		decon_set_bits(ctx, DECON_VIDOSDxC(win), 0xffffff, val);
+		decon_set_bits(ctx, DECON_BLENDCON, BLEND_NEW, BLEND_NEW);
+	}
+}
+
 static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 				 struct drm_framebuffer *fb)
 {
@@ -267,6 +293,8 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	val = readl(ctx->addr + DECON_WINCONx(win));
 	val &= WINCONx_ENWIN_F;
 
+	decon_win_set_bldmod(ctx, win, fb);
+
 	switch (fb->format->format) {
 	case DRM_FORMAT_XRGB1555:
 		val |= WINCONx_BPPMODE_16BPP_I1555;
@@ -288,6 +316,7 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val |= WINCONx_BPPMODE_32BPP_A8888;
 		val |= WINCONx_WSWP_F | WINCONx_BLD_PIX_F | WINCONx_ALPHA_SEL_F;
 		val |= WINCONx_BURSTLEN_16WORD;
+		val |= WINCONx_ALPHA_MUL_F;
 		break;
 	}
 
@@ -561,6 +590,7 @@ static int decon_bind(struct device *dev, struct device *master, void *data)
 		ctx->configs[win].num_pixel_formats = ARRAY_SIZE(decon_formats);
 		ctx->configs[win].zpos = win - ctx->first_win;
 		ctx->configs[win].type = decon_win_types[win];
+		ctx->configs[win].capabilities = capabilities[win];
 
 		ret = exynos_plane_init(drm_dev, &ctx->planes[win], win,
 					&ctx->configs[win]);
diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index 19ad9e47945e..f42d8f0adf5d 100644
--- a/drivers/gpu/drm/exynos/regs-decon5433.h
+++ b/drivers/gpu/drm/exynos/regs-decon5433.h
@@ -104,6 +104,7 @@
 #define WINCONx_BURSTLEN_16WORD		(0x0 << 10)
 #define WINCONx_BURSTLEN_8WORD		(0x1 << 10)
 #define WINCONx_BURSTLEN_4WORD		(0x2 << 10)
+#define WINCONx_ALPHA_MUL_F		(1 << 7)
 #define WINCONx_BLD_PIX_F		(1 << 6)
 #define WINCONx_BPPMODE_MASK		(0xf << 2)
 #define WINCONx_BPPMODE_16BPP_565	(0x5 << 2)
@@ -206,4 +207,7 @@
 #define CRCCTRL_CRCEN			(0x1 << 0)
 #define CRCCTRL_MASK			(0x7)
 
+/* BLENDCON */
+#define BLEND_NEW			(1 << 0)
+
 #endif /* EXYNOS_REGS_DECON5433_H */
-- 
2.7.4

