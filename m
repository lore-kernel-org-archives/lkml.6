Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC9920645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="M146U05d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC9920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403938AbeKVMcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:32:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37974 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403923AbeKVMce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:32:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so5980159qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bMwKQsPkRI/cPJXwXm3wYhKIDjDUhHJjXHdcgorxaAU=;
        b=M146U05dS1W6ab8p8FDpjUuW0Ac4Aorm6XQ++Q5OVr7OJQlUp1lbc0zcFb/qxQkz8d
         BVQbs3X02FtoSSqwxPpvMvqvZwfOu06dNSw4XvBevfL46sewRDBROTt6flHinaxtzP2w
         5MfKDcmm0Ano5yghyFoK3IngdmCS+lE1EwW3b4EcRbaExXn6QpnNFp6AeGF/xMzDdH/o
         BXsKl/xHNFrauOV9QiHUViWgJsrVeYam4PxOTy9PH16IGRuN6fXFuOElkzuy+yWoAMPq
         5W+n8HB1V5b2EXaIovtVxGRaK7N3uv/NTV+MEM4FqI5RTpVUYtWuawfNPG43kDs0H3Vh
         K+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bMwKQsPkRI/cPJXwXm3wYhKIDjDUhHJjXHdcgorxaAU=;
        b=UYnyIQWfxizf1elw10WhO2vErA6c0IIlzI7Y9TNrUtGLhr104L9+2EhkmruIRaewFo
         8BQPvPpctE82O8CSpvVxu7fgXHrwaXi3w6MZngwSwYv6GfhC6XqiTkyDPhgH1vWdAzpJ
         nL4vMElhcXg6veU+ngYKJUcp2S7GIs/DA6e5hzSEJEktL7ioK+Lx/hUsii6v3Hk1FD0G
         J7dIjbGddH/kZwjXGHjq+LzBaggmmnuJapfRn7ji4K8FcnulqjuAA2T52k5+RNv5VjvL
         rZfEYddwF2uEfJ6btfzH3FYGyDSac5/QpbF5/CDUVb2G7X+A3UTzYdH1MqUtWEAJJ8AS
         +lrQ==
X-Gm-Message-State: AGRZ1gKf2Ccbr+b2vzkoRGU2xqHa3x022RaY5EpzNm1Cm0+bmzYMxwQr
        AHLWjsxWrgelkzIfBMtIclVYaQ==
X-Google-Smtp-Source: AJdET5eTZPpxllvlX0XVv9Hpc0qkwc5gdo2s3QZT6jQRlk3pdjFcpjOwZe+qLRee5/pUL+wobqLpHg==
X-Received: by 2002:ac8:231a:: with SMTP id a26mr8604020qta.40.1542851730793;
        Wed, 21 Nov 2018 17:55:30 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q15sm25297721qkl.81.2018.11.21.17.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:55:30 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/9] drm/msm/mdp4: add lcdc-align-lsb flag to control lane alignment
Date:   Wed, 21 Nov 2018 20:52:29 -0500
Message-Id: <20181122015237.14534-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015237.14534-1-jonathan@marek.ca>
References: <20181122015237.14534-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controls which of the 8 lanes are used for 6 bit color.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index e19ab2ab63f7..7d8d11c8150a 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -377,20 +377,26 @@ static void mdp4_lcdc_encoder_enable(struct drm_encoder *encoder)
 	unsigned long pc = mdp4_lcdc_encoder->pixclock;
 	struct mdp4_kms *mdp4_kms = get_kms(encoder);
 	struct drm_panel *panel;
+	uint32_t config;
 	int i, ret;
 
 	if (WARN_ON(mdp4_lcdc_encoder->enabled))
 		return;
 
 	/* TODO: hard-coded for 18bpp: */
-	mdp4_crtc_set_config(encoder->crtc,
-			MDP4_DMA_CONFIG_R_BPC(BPC6) |
-			MDP4_DMA_CONFIG_G_BPC(BPC6) |
-			MDP4_DMA_CONFIG_B_BPC(BPC6) |
-			MDP4_DMA_CONFIG_PACK_ALIGN_MSB |
-			MDP4_DMA_CONFIG_PACK(0x21) |
-			MDP4_DMA_CONFIG_DEFLKR_EN |
-			MDP4_DMA_CONFIG_DITHER_EN);
+	config =
+		MDP4_DMA_CONFIG_R_BPC(BPC6) |
+		MDP4_DMA_CONFIG_G_BPC(BPC6) |
+		MDP4_DMA_CONFIG_B_BPC(BPC6) |
+		MDP4_DMA_CONFIG_PACK(0x21) |
+		MDP4_DMA_CONFIG_DEFLKR_EN |
+		MDP4_DMA_CONFIG_DITHER_EN;
+
+	if (!of_find_property(dev->dev->of_node, "lcdc-align-lsb", NULL))
+		config |= MDP4_DMA_CONFIG_PACK_ALIGN_MSB;
+
+
+	mdp4_crtc_set_config(encoder->crtc, config);
 	mdp4_crtc_set_intf(encoder->crtc, INTF_LCDC_DTV, 0);
 
 	bs_set(mdp4_lcdc_encoder, 1);
-- 
2.17.1

