Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E188ECDE48
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2B820834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t7i9Tbw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2B820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeJZAzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:55:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58704 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJZAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:55:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181025162206euoutp01d0ccfef7bb3e5e6e4b74ec448f984199~g5oPO-dLP2459424594euoutp01C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:22:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181025162206euoutp01d0ccfef7bb3e5e6e4b74ec448f984199~g5oPO-dLP2459424594euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540484526;
        bh=hXJ051cChNGXvuI4QzFnjwn2F3TWPij8FoDPZapjYm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7i9Tbw4KTuapoBGOJDBf+z8Rd/AeEfxgcdjERSFRkm5sD6iKqhO9o6k7S68ML86y
         XkwNn0MdH/ShkxJSomD/HKtW+BKMmvJzljKJETHt5U+MjpxjRlbvaWLft9mLah047T
         +D4sE/sefKNP2DJ8PF1v54YRBKtkec3HPm8w5HXs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181025162205eucas1p2a727d8e575b9b9cb81fc8d80d9bc1635~g5oOcy5nd0694706947eucas1p2E;
        Thu, 25 Oct 2018 16:22:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 65.13.04806.DADE1DB5; Thu, 25
        Oct 2018 17:22:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181025162204eucas1p1e53a6081e5251ba3419c0a996ff055cc~g5oNlZp252803828038eucas1p1h;
        Thu, 25 Oct 2018 16:22:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181025162204eusmtrp1512d2c9e4a0bdf42c9121e7f37b42286~g5oNKzIIR1775517755eusmtrp1x;
        Thu, 25 Oct 2018 16:22:04 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-78-5bd1edad7f1a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.E9.04128.CADE1DB5; Thu, 25
        Oct 2018 17:22:04 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181025162203eusmtip19780886b62b0edf0b2787c337318618b~g5oMdaMA60665906659eusmtip1i;
        Thu, 25 Oct 2018 16:22:03 +0000 (GMT)
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
Subject: [PATCH v4 2/2] drm/exynos: decon: Make pixel blend mode
 configurable
Date:   Thu, 25 Oct 2018 18:21:53 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540484513-24274-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSd0xTURTGc/smjTXPguEGnDUYbQQ1qLlx4oqPOFBJJEgcFV6ACBVbwT0x
        hiGWISkaUsGAYtmlgFRFC2hx0IJFrRDQOBIECVYsSmKNPJ7jv9/9zvnOd8/NpTGplfChY5WH
        OJVSEScjxXjdo1Grf/lgR8SCs3YadVVYCZRhfSxC1XmVBLLcKQao0zVEooa3Jgplv8nEUV9v
        B4407wcwZLNVUajt3GcKGd6/JJDdlE+iPFujCGlumwlU3tJDoUJnLY56cloAysv5RAZ5smW6
        MsAa9KkkWz/ylmB1j7exb9ItIram6DTbkH1PxFpMXRR7yagH7LBh2lbxTvHyKC4uNolTzV+5
        VxyTc+UClVDtf0TndpNnwC+/NOBBQ2YRbHOMUDxLmRIAe81T04B4jL8B6P7RiQuFYQAv/6DT
        AD1uSLmmEnpuAphZ7MD+GQae1wLeQDKLYXfPV5JnL2YWdGfpAd+EMXYC2q4Xjk/1ZELgeVMR
        wTPO+MEvpRpcuNI0+NqaivHswQRDp7OG4s2QcVJQa28enyphkqAx9z4lGNbBK/1DpMCesN9i
        /KNPgU9zLuKCORnArm8vCeGQCaC5NO1P3DJocPSL+OUwZi6sNM0X5NVQeyuPFHaeCB2Dk3gZ
        G8PsOi0myBKYckEqdM+GA0Yj+Te2b9gFBGZhVkU5LrxQPoAfaluJTDD96v+wAgD0wJtLVMdH
        c+pAJXc4QK2IVycqowMiD8QbwNgve/rL4roNGn/uawIMDWQTJK1V7RFSQpGkPhrfBCCNybwk
        97o7IqSSKMXRY5zqwB5VYhynbgK+NC7zltzQVUdImWjFIW4/xyVwqr9VEe3hcwYEPcE0gWtj
        fj5sODiSuqGqN9xatf7kEjvKT17z6EQGDH7XMHPC8dYC+doZU0pWSR64Ip/5mnOrdfV9e3es
        dBxOR4Nh2t1Gp3YRu+K7Zsn2WE2AYsg/fEtQojyj/0QuZOV9Hze/mJccEtocGqbc5XfXb9PS
        7DbtxvbiOa+iJp8aHb0sw9UxioVyTKVW/AaFTbDEYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7pr3l6MNlh7h8Xi1rpzrBa9504y
        WWycsZ7V4vjupYwWV76+Z7PY+WAXu8Wk+xNYLF7cu8hi0f/4NbPF+fMb2C3ONr1ht9j0+Bqr
        xeVdc9gsZpzfx2TRv+Mgq8XaI3fZLRZ+3MpicXfyEUaLGZNfsjkIe6yZt4bRY9OqTjaP7d8e
        sHrMOxnocb/7OJPH5iX1Hjsn7WXyOL7rFrtH35ZVjB6fN8kFcEXp2RTll5akKmTkF5fYKkUb
        WhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZUye2cZesFG3Yt7fv2wNjP9Uuxg5
        OCQETCQ65hd1MXJxCAksZZSYcWwPaxcjJ1BcRmLe2T42CFtY4s+1LjaIok+MEqsW3WcHSbAJ
        mErcvvsJrEhEQFni78RVjCBFzAIPWSXeL+wESwgL+Eo82boDbCqLgKrEh9X9LCA2r4CHxJXu
        PSwQG+Qkbp7rZAaxOQU8JT5+3MwOcp0QUM2FG74TGPkWMDKsYhRJLS3OTc8tNtIrTswtLs1L
        10vOz93ECIysbcd+btnB2PUu+BCjAAejEg/viQ0XooVYE8uKK3MPMUpwMCuJ8O69fTFaiDcl
        sbIqtSg/vqg0J7X4EKMp0E0TmaVEk/OBUZ9XEm9oamhuYWlobmxubGahJM573qAySkggPbEk
        NTs1tSC1CKaPiYNTqoHxiFbX2fZ3XvaXe/TSM48uLNy9dJVFweuHzrGqNStiFwnWzPcru/XN
        QydbY7vppDezr3gaxMefMC7r/3StWUO7/vmfjatl49/xTe72fyKq9fuv+yP+I/c1NpZN6uwy
        LQniEeqcvTt6YVMku0JOt8yOgA+OynrHJYPyDDae/H9rlbf6ZI7mC5OVWIozEg21mIuKEwHa
        62wrwgIAAA==
Message-Id: <20181025162204eucas1p1e53a6081e5251ba3419c0a996ff055cc~g5oNlZp252803828038eucas1p1h@eucas1p1.samsung.com>
X-CMS-MailID: 20181025162204eucas1p1e53a6081e5251ba3419c0a996ff055cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181025162204eucas1p1e53a6081e5251ba3419c0a996ff055cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181025162204eucas1p1e53a6081e5251ba3419c0a996ff055cc
References: <1540484513-24274-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181025162204eucas1p1e53a6081e5251ba3419c0a996ff055cc@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decon hardware supports different blend modes. Add pixel blend mode
property and make it configurable, by modifying the blend equation.

Tested on TM2 with Exynos 5433 CPU, on top of linux-next-20181019.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
v4 changes:
 - set blend equation for DRM_MODE_BLEND_PIXEL_NONE explicitly,
v3 changes:
 - fix compilation errors (previouslsy wrong patch was sent),
v2 changes:
 - add premultiplied mode by setting blending equation accordingly,
 - remove no longer used blend mode settings from decon_win_set_pixfmt,

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 65 ++++++++++++++++++++++-----
 drivers/gpu/drm/exynos/regs-decon5433.h       | 15 +++++++
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 2578db16750d..68a42079679c 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -86,10 +86,10 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 
 static const unsigned int capabilities[WINDOWS_NR] = {
 	0,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
-	EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
 };
 
 static inline void decon_set_bits(struct decon_context *ctx, u32 reg, u32 mask,
@@ -267,13 +267,51 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	decon_set_bits(ctx, DECON_UPDATE, STANDALONE_UPDATE_F, ~0);
 }
 
+static void decon_win_set_bldeq(struct decon_context *ctx, unsigned int win,
+				unsigned int alpha, unsigned int pixel_alpha)
+{
+	u32 mask = BLENDERQ_A_FUNC_F(0xf) | BLENDERQ_B_FUNC_F(0xf);
+	u32 val = 0;
+
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+	case DRM_MODE_BLEND_COVERAGE:
+		val |= BLENDERQ_A_FUNC_F(BLENDERQ_ALPHA_A);
+		val |= BLENDERQ_B_FUNC_F(BLENDERQ_ONE_MINUS_ALPHA_A);
+		break;
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+			val |= BLENDERQ_A_FUNC_F(BLENDERQ_ALPHA0);
+			val |= BLENDERQ_B_FUNC_F(BLENDERQ_ONE_MINUS_ALPHA_A);
+		} else {
+			val |= BLENDERQ_A_FUNC_F(BLENDERQ_ONE);
+			val |= BLENDERQ_B_FUNC_F(BLENDERQ_ONE_MINUS_ALPHA_A);
+		}
+		break;
+	}
+	decon_set_bits(ctx, DECON_BLENDERQx(win), mask, val);
+}
 
 static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
-				 unsigned int alpha)
+				 unsigned int alpha, unsigned int pixel_alpha)
 {
 	u32 win_alpha = alpha >> 8;
 	u32 val = 0;
 
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
+		val |= WINCONx_ALPHA_SEL_F;
+		val |= WINCONx_BLD_PIX_F;
+		val |= WINCONx_ALPHA_MUL_F;
+		break;
+	}
+	decon_set_bits(ctx, DECON_WINCONx(win), WINCONx_BLEND_MODE_MASK, val);
+
 	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
 		val = VIDOSD_Wx_ALPHA_R_F(win_alpha) |
 		      VIDOSD_Wx_ALPHA_G_F(win_alpha) |
@@ -291,8 +329,14 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	struct exynos_drm_plane_state *state =
 		to_exynos_plane_state(plane.base.state);
 	unsigned int alpha = state->base.alpha;
+	unsigned int pixel_alpha;
 	unsigned long val;
 
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
+
 	val = readl(ctx->addr + DECON_WINCONx(win));
 	val &= WINCONx_ENWIN_F;
 
@@ -315,9 +359,8 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 	case DRM_FORMAT_ARGB8888:
 	default:
 		val |= WINCONx_BPPMODE_32BPP_A8888;
-		val |= WINCONx_WSWP_F | WINCONx_BLD_PIX_F | WINCONx_ALPHA_SEL_F;
+		val |= WINCONx_WSWP_F;
 		val |= WINCONx_BURSTLEN_16WORD;
-		val |= WINCONx_ALPHA_MUL_F;
 		break;
 	}
 
@@ -335,10 +378,12 @@ static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 		val &= ~WINCONx_BURSTLEN_MASK;
 		val |= WINCONx_BURSTLEN_8WORD;
 	}
+	decon_set_bits(ctx, DECON_WINCONx(win), ~WINCONx_BLEND_MODE_MASK, val);
 
-	writel(val, ctx->addr + DECON_WINCONx(win));
-	if (win > 0)
-		decon_win_set_bldmod(ctx, win, alpha);
+	if (win > 0) {
+		decon_win_set_bldmod(ctx, win, alpha, pixel_alpha);
+		decon_win_set_bldeq(ctx, win, alpha, pixel_alpha);
+	}
 }
 
 static void decon_shadow_protect(struct decon_context *ctx, bool protect)
diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index 72648bda3142..63db6974bf14 100644
--- a/drivers/gpu/drm/exynos/regs-decon5433.h
+++ b/drivers/gpu/drm/exynos/regs-decon5433.h
@@ -117,6 +117,7 @@
 #define WINCONx_BPPMODE_16BPP_A4444	(0xe << 2)
 #define WINCONx_ALPHA_SEL_F		(1 << 1)
 #define WINCONx_ENWIN_F			(1 << 0)
+#define WINCONx_BLEND_MODE_MASK		(0xc2)
 
 /* SHADOWCON */
 #define SHADOWCON_PROTECT_MASK		GENMASK(14, 10)
@@ -213,4 +214,18 @@
 /* BLENDCON */
 #define BLEND_NEW			(1 << 0)
 
+/* BLENDERQx */
+#define BLENDERQ_ZERO			0x0
+#define BLENDERQ_ONE			0x1
+#define BLENDERQ_ALPHA_A		0x2
+#define BLENDERQ_ONE_MINUS_ALPHA_A	0x3
+#define BLENDERQ_ALPHA0			0x6
+#define BLENDERQ_Q_FUNC_F(n)		(n << 18)
+#define BLENDERQ_P_FUNC_F(n)		(n << 12)
+#define BLENDERQ_B_FUNC_F(n)		(n << 6)
+#define BLENDERQ_A_FUNC_F(n)		(n << 0)
+
+/* BLENDCON */
+#define BLEND_NEW			(1 << 0)
+
 #endif /* EXYNOS_REGS_DECON5433_H */
-- 
2.7.4

