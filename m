Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DF2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDE22086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kdZFs2wL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDE22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeK2Cem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:34:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39507 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbeK2Cek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:34:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181128153236euoutp01e8207fbec633f349f03b74c7d16a7a24~rU4u6iiqZ2791927919euoutp01W
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:32:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181128153236euoutp01e8207fbec633f349f03b74c7d16a7a24~rU4u6iiqZ2791927919euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543419156;
        bh=Q4EAez3dyLdQL7NYvZFnS+Fz4/vQPkRhOPuIOX/yhKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdZFs2wLmgvKLbNhPyCGspFtbJwsNmmkO3N/1BLHXCaCNWRdj5Nal2XWGc9pdYqM+
         e0PapDaaqhAW2/hDvSE56ku6EXgFm9v5ZTbFlPRAOcP9y87+DaI3bUGZn6Ie9LvVz8
         RRy4rekSlLiqNxUjJDpgAm+DBtweWh8ni/JcLXUo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181128153236eucas1p11723aad7e1fbe51a680f257e18245b85~rU4uJAs1s2300023000eucas1p1v;
        Wed, 28 Nov 2018 15:32:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.A7.04441.315BEFB5; Wed, 28
        Nov 2018 15:32:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181128153235eucas1p192a346be6aa9ca28a1000238db4c6fc8~rU4tXprlt2300523005eucas1p1m;
        Wed, 28 Nov 2018 15:32:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181128153234eusmtrp1e1ad245354ee7224408a12f537016f23~rU4tHQ--f0810708107eusmtrp1k;
        Wed, 28 Nov 2018 15:32:34 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-4e-5bfeb51391ba
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2A.10.04284.215BEFB5; Wed, 28
        Nov 2018 15:32:34 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181128153234eusmtip2e4d581bebb879a30b8e8cf7c1c3e9a02~rU4sdt2cB2100421004eusmtip2v;
        Wed, 28 Nov 2018 15:32:34 +0000 (GMT)
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
Subject: [PATCH 2/2] drm/exynos: mixer: Fix color range setting
Date:   Wed, 28 Nov 2018 16:32:12 +0100
Message-Id: <1543419132-16099-3-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3YuOw5Xx03Yh4bCTKnMWyacqCzB4gQhQVKQYC09qeSmbWpp
        UJqZad4vuGxFF5djmtM5LQwFxZQlOsprxprkH3lJMp2SRTOPZ9Z/7/t7n+d7Xl4+AhHpMA8i
        SZHGKBWyZCkuQNv71iwB4jZHTHDVyj5qsmkIo4qHzDyqRW3AqP43WkCNrHzHqQpbGUrNfH6P
        UqXT8whlsTTzqcHb3/iUcXoMo4Y7NDiltnTxqJe9Vj6lrpzFj+2gjfoCnH61OoXRtvv9PLq1
        7hZdYtIDetnodRo/LzgczyQnZTDKoPCLgsTZqiYkdURy/XH7b342WBQXAhcCkgdgdY4ZKwQC
        QkTqANS0jvK5xg5g/dCks1kGcD1Hh29ZrGY7wtYish7Adwsn/jlWp20YO8DJMPjJurRpcCd9
        4J9yPWBFCNmGwk7zBI8diMmjsLf30YaIIFDSF77VxLNYSNLw+egy4MK84Mehgs0wF/IkLC+z
        IOw7kDTy4fqsnc+JIqHhRbHTIIZz/SYn3wkHKotQzpAL4KR9DOOaMgC7GwpRTnUIGifmeOwW
        CLkHGjqCOBwBny4+4LMYktvhxIIbi5GNsqK9BuGwEN67K+LUfnDeZMK3YmeWV5zr0LBRv+S8
        rwbAyr4apAx41/4PewKAHkiYdJU8gVGFKJhrgSqZXJWuSAiMS5Ebwcb/GXD0L70GKx8u9QCS
        AFJXIWxwxIgwWYYqU94DIIFI3YXp4RtIGC/LzGKUKReU6cmMqgd4EqhUIryxbSpGRCbI0pgr
        DJPKKLemPMLFIxuccg920Ta72cYnolISRkPHy3dJxLH+zb5+JcqfX9cyp+n1mv3KLMPMTc2P
        7rN1v1qq1c/68mb0LYVUXNHV2Fwt/lAdOW6zFQ96TpoJJrV2MEJxJICM0oXldzXmLgyXttsc
        B6PT/L20rgPnTN75QWPHv/hctupCo3ff6Vw7Q+RJUVWiLGQvolTJ/gLkmpJmOwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4PV2hrf+iDR5tMLe4te4cq0XvuZNM
        FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
        MeP8PiaLtUfuslvMmPySzYHfY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEXp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZbycso654Ip4
        xbxtv9kbGD8IdzFyckgImEjcPfmFuYuRi0NIYCmjxMP3f1kgEjIS8872sUHYwhJ/rnWxQRR9
        YpT4d+c6I0iCTcBU4vbdT2BFIgLKEn8nrmIEKWIWOMgi0bLxDFiRsIC9xJEjc4GKODhYBFQl
        js5JAQnzCnhILL76mRFigZzEzXOdzCA2p4CnxMQJ58FsIaCaRVevsk5g5FvAyLCKUSS1tDg3
        PbfYUK84Mbe4NC9dLzk/dxMjMBq2Hfu5eQfjpY3BhxgFOBiVeHgPrPgXLcSaWFZcmXuIUYKD
        WUmEt9QOKMSbklhZlVqUH19UmpNafIjRFOimicxSosn5wEjNK4k3NDU0t7A0NDc2NzazUBLn
        PW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXAaHxclfVae2D4Yt8vS+eWr+26L/GkbNaaM7ttc9PM
        F74VFv4lkS2hcEXGS68k4NGNDZ+FucRmsmQUlYla8BVO4Pyg58KlEhPO/+Bq+fOD1wKWMzxY
        ynH0V453Ff+vontOQlMd7c6kPDrkfCej8/rx83eCQ+KnzrgY1LrzYbs75wKbvU9S82ofKrEU
        ZyQaajEXFScCAFZUpN2cAgAA
X-CMS-MailID: 20181128153235eucas1p192a346be6aa9ca28a1000238db4c6fc8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181128153235eucas1p192a346be6aa9ca28a1000238db4c6fc8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181128153235eucas1p192a346be6aa9ca28a1000238db4c6fc8
References: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181128153235eucas1p192a346be6aa9ca28a1000238db4c6fc8@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Color format and color range was set based on resolution. Change that,
by splitting range and format. Leave color format setting as it is,
set color range based on drm_display_mode using
drm_default_quant_range helper function.

Tested on Odroid-U3 with Exynos 4412 CPU, kernel next-20181128
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 17 ++++++++++++-----
 drivers/gpu/drm/exynos/regs-mixer.h   |  9 +++++----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index bcc26c10095a..2a25822bd6a1 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -381,14 +381,16 @@ static void mixer_cfg_scan(struct mixer_context *ctx, int width, int height)
 	mixer_reg_writemask(ctx, MXR_CFG, val, MXR_CFG_SCAN_MASK);
 }
 
-static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, unsigned int height)
+static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, struct drm_display_mode *mode)
 {
+	enum hdmi_quantization_range range = drm_default_rgb_quant_range(mode);
 	u32 val;
 
-	if (height < 720) {
-		val = MXR_CFG_RGB601_0_255;
+	if (mode->vdisplay < 720) {
+		val = MXR_CFG_RGB601;
 	} else {
-		val = MXR_CFG_RGB709_16_235;
+		val = MXR_CFG_RGB709;
+
 		/* Configure the BT.709 CSC matrix for full range RGB. */
 		mixer_reg_write(ctx, MXR_CM_COEFF_Y,
 			MXR_CSC_CT( 0.184,  0.614,  0.063) |
@@ -399,6 +401,11 @@ static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, unsigned int height)
 			MXR_CSC_CT( 0.440, -0.399, -0.040));
 	}
 
+	if (range == HDMI_QUANTIZATION_RANGE_FULL)
+		val |= MXR_CFG_QUANT_RANGE_FULL;
+	else
+		val |= MXR_CFG_QUANT_RANGE_LIMITED;
+
 	mixer_reg_writemask(ctx, MXR_CFG, val, MXR_CFG_RGB_FMT_MASK);
 }
 
@@ -455,7 +462,7 @@ static void mixer_commit(struct mixer_context *ctx)
 	struct drm_display_mode *mode = &ctx->crtc->base.state->adjusted_mode;
 
 	mixer_cfg_scan(ctx, mode->hdisplay, mode->vdisplay);
-	mixer_cfg_rgb_fmt(ctx, mode->vdisplay);
+	mixer_cfg_rgb_fmt(ctx, mode);
 	mixer_run(ctx);
 }
 
diff --git a/drivers/gpu/drm/exynos/regs-mixer.h b/drivers/gpu/drm/exynos/regs-mixer.h
index d2b8194a07bf..5ff095b0c1b3 100644
--- a/drivers/gpu/drm/exynos/regs-mixer.h
+++ b/drivers/gpu/drm/exynos/regs-mixer.h
@@ -85,10 +85,11 @@
 /* bits for MXR_CFG */
 #define MXR_CFG_LAYER_UPDATE		(1 << 31)
 #define MXR_CFG_LAYER_UPDATE_COUNT_MASK (3 << 29)
-#define MXR_CFG_RGB601_0_255		(0 << 9)
-#define MXR_CFG_RGB601_16_235		(1 << 9)
-#define MXR_CFG_RGB709_0_255		(2 << 9)
-#define MXR_CFG_RGB709_16_235		(3 << 9)
+#define MXR_CFG_QUANT_RANGE_FULL	(0 << 9)
+#define MXR_CFG_QUANT_RANGE_LIMITED	(1 << 9)
+#define MXR_CFG_RGB601			(0 << 10)
+#define MXR_CFG_RGB709			(1 << 10)
+
 #define MXR_CFG_RGB_FMT_MASK		0x600
 #define MXR_CFG_OUT_YUV444		(0 << 8)
 #define MXR_CFG_OUT_RGB888		(1 << 8)
-- 
2.7.4

