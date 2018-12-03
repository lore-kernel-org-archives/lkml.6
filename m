Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE880C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E2720864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="OSXmtHe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E2720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLCVVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:21:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41891 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCVVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:21:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so15596734qto.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 13:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bxnZOVi3Uenah6dbS+lwc/jQi8hk5u9BafXjIbd1zAc=;
        b=OSXmtHe8BV5R+CxDvGU8QC933vBJcgcJy4wNuYeYshBAWMHFnGJEq04xb8tO9PIW+g
         mvfYM9TXm+cPdLuyKtQCOPpV2EBAVBTzN7UBlUh9c+I96gSz7l1giQpBWOsPa1zayZ/V
         joKfdoVb6vSPVOeYll/O3ob5YbnAis5d+Mv69euEDj6AA6rSyQKRv21wi96Fuz/28TNc
         icVcHZgL/X9rDRmMBCpGoEKm9ePnVHvxAoiBih5qcNQtOoDXZY7fZnHZnjZOpKP7U2Y2
         e89YCMk/swEHFVkqrjmmXzca99zMtC0rnEcCwcIZYhmBEzT4Y86jKCuuV+9hs/LDTqQ3
         ZutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bxnZOVi3Uenah6dbS+lwc/jQi8hk5u9BafXjIbd1zAc=;
        b=BUJMolzxS1waezo+VxH4VDRfL9+bNMvl8SpBSUj4s83DDWR8Qp5KzYAfgj9b4gXfFa
         jqbizurgmU7z+LQwgdGy8QoWbJ3a5GJYv/Dr+Vdqm/1E9DRNH7jlJ039zYZYCA3IDG8+
         Of8K574l4L0ngy0115v3vYElKz7ymUkvogLL+m79Q1CyvqY8aGreu8CNk8SZNMIsF0Xf
         Ip8IV8/z26DzV8lZm+iZxfispzo3gqc4Gt9B+R2WnlRt7RU0g/8FToY/zF6oWNLiKi3Y
         iLtOQofx+YYDpluM2C8vV9yTqoYj/Lx8Xvpkw3Iof5uB/BcfjSWBDLyWzst00+SArZ1i
         jLNw==
X-Gm-Message-State: AA+aEWYukGgpEM7BaPepE3ZNJDE3lRJi3kGxbXd82nZ8zj/eGfQE8u6A
        k2wcMu4cnkZ5xxjN57st/Op1hA==
X-Google-Smtp-Source: AFSGD/VbKX+bEZbWwsnYJwwEHgDqVe5acSmApsDB5eSgp8RD/w9AzfDwj2Y4Gfz0FzfZdKtIOzz5UQ==
X-Received: by 2002:a0c:9531:: with SMTP id l46mr17045875qvl.175.1543872068753;
        Mon, 03 Dec 2018 13:21:08 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id l33sm10567353qta.57.2018.12.03.13.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:21:07 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] drm/msm/mdp4: add lcdc-align-lsb flag to control lane alignment
Date:   Mon,  3 Dec 2018 16:18:13 -0500
Message-Id: <20181203211816.5129-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows controlling which of the 8 lanes are used for 6 bit color.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
v3: removed empty line and added documentation

 .../devicetree/bindings/display/msm/mdp4.txt  |  2 ++
 .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 21 ++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/mdp4.txt b/Documentation/devicetree/bindings/display/msm/mdp4.txt
index 3c341a15c..b07eeb38f 100644
--- a/Documentation/devicetree/bindings/display/msm/mdp4.txt
+++ b/Documentation/devicetree/bindings/display/msm/mdp4.txt
@@ -38,6 +38,8 @@ Required properties:
 Optional properties:
 - clock-names: the following clocks are optional:
   * "lut_clk"
+- qcom,lcdc-align-lsb: Boolean value indicating that LSB alignment should be
+  used for LCDC. This is only valid for 18bpp panels.
 
 Example:
 
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index 9e08c2efa..c9e34501a 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -377,20 +377,25 @@ static void mdp4_lcdc_encoder_enable(struct drm_encoder *encoder)
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
+	if (!of_property_read_bool(dev->dev->of_node, "qcom,lcdc-align-lsb"))
+		config |= MDP4_DMA_CONFIG_PACK_ALIGN_MSB;
+
+	mdp4_crtc_set_config(encoder->crtc, config);
 	mdp4_crtc_set_intf(encoder->crtc, INTF_LCDC_DTV, 0);
 
 	bs_set(mdp4_lcdc_encoder, 1);
-- 
2.17.1

