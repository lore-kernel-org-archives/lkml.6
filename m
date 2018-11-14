Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B9BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2FF20866
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="wYq++P+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2FF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbeKOIco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:32:44 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36431 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388803AbeKOIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:44 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so28800729qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bMwKQsPkRI/cPJXwXm3wYhKIDjDUhHJjXHdcgorxaAU=;
        b=wYq++P+rujYBelKPFYYC++T7Z6ch3IIEFz2abpJ5VUGwrQRVEL9/5ZHVcwOFhb5C6I
         VDMBj4w0r6wrfROFagWSWVqGpatx/MYynJDJCh6YHW0aQqheF7xWKbl89iVWQllRb2gz
         6H3110zPKYJj9hRqRQQW4CtotlgMNSDW/80hvyLeSOmtxvihYHMn0f6rAKaU4CVou5nc
         fWKr1K2fnDEHElvAF1OsgHQ7FsDW7RSPEQLz1nVieE+2KgPIOdpWoTdlkBXwK8ttHp5i
         67uMUFa8yVF2pCzGjGTryZpBtaItUB4ljmgArcQ2YGf/VvG5oaRog57gLyVYFrjJN2Ms
         TurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bMwKQsPkRI/cPJXwXm3wYhKIDjDUhHJjXHdcgorxaAU=;
        b=ZnosSX+H0W0tOQ5X0O2batcTpQuRcKZ0c8WedCS2Zl03mu9my0D53MTYwaUohAvtMT
         WydwL3ZhrnatITiVC9XDSGedx2jzy/HI9iLAlzscneroz69NZknNZ0b6bawL472S74fc
         y4JFYhb+OjAMwRzc+J4eZo+9ewzKyaN+W5Mh5ZirCC4KU3Z3G1mcMaKmHRuOcHSP63lY
         W/qTbRSR0VzzxaHsYkj5lRCmTNiK1F+3bgSKuR1Uvhb60lsmvgVptSF29qVUAYNbZQQC
         uWW0JyQuP0UvX5SO1qkZQRuqz8gbzyER0Jd/GXwIxPbZ5pl/5GDv6h0puiorypvHj0TS
         YMRw==
X-Gm-Message-State: AGRZ1gJw4DTOxfNkYRkjFWUrNtAVbR4zApw593DY6vhZMxSWF5x6Z7DW
        B+saJY7JSivBQ8JVjt4KkLctmQ==
X-Google-Smtp-Source: AJdET5d5yihjjUfneVTMijFa7FNO3l571/RFRF51vW5ETLfr+D1ibIltQyG1eXHB+Y9wfekbdMG2og==
X-Received: by 2002:ac8:3518:: with SMTP id y24mr3600014qtb.241.1542234458110;
        Wed, 14 Nov 2018 14:27:38 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 24sm24067595qkp.65.2018.11.14.14.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:27:37 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/9] drm/msm/mdp4: add lcdc-align-lsb flag to control lane alignment
Date:   Wed, 14 Nov 2018 17:24:10 -0500
Message-Id: <20181114222418.15960-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222418.15960-1-jonathan@marek.ca>
References: <20181114222418.15960-1-jonathan@marek.ca>
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

