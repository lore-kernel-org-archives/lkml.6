Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB81C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BF82081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="yWdcx1Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BF82081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeLDPUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:20:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37604 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:19:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so9806454qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bxnZOVi3Uenah6dbS+lwc/jQi8hk5u9BafXjIbd1zAc=;
        b=yWdcx1Q+qZWhkm8J6pRO7zCnH6lllmHJNY6RxEHba55ATG/ycJFYifRg3BtAqXg9SP
         lenVpI8+22jRW0gTK5oW0xDIY9p8xlSo0NoM1w+b7yW/x5GmzXix705b7dJUhEu+lC9L
         MzpVRxzvUA8MTEvRc7HXmqCIIfUVZrLgdqz7NrMN07cbumli8/12oYfLUeF23hJhEmsh
         dUWMEAlGiD5napR5O7bhlIu0vgXYyrWOepMb2CcsakbMn/9VRxEeoJu/rsvLlRt5ifen
         NVOeFe/12+S4yvYgxRsWB6iHxEU6mA7eEvB1ySsVK5csHj89O3h+y82WCKURUqZrj8pv
         V8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bxnZOVi3Uenah6dbS+lwc/jQi8hk5u9BafXjIbd1zAc=;
        b=tJnaRSed8pCphk21mQp0/q3mnteqA0eCJXh4+un5zT/T7xLZc0yYlLbBpGTI81a4+k
         JW0ZdmG/YDFx83w6vZH2rGaaVXMnEbR6EjYUNgfv5ZkmlTUqZXetGyWZr593GKzIOCU/
         km1cyj6TosmYnpD4+EG20XtWog0TObubWAjaRtOyvyFvgTzIZX+3gwGGHau4lVfeijav
         cWmCvjbMu1d/tJThlC29AvqeIKjvOhqLg3Ag0874yqL17YlcNXvp0SbTOuZw9ZLSQM3a
         T61aR/zUgB2JxU97Pief4u9oWinxL+dYYFrozSAeXG/uomVNQvsJ6wBmVvQhCmG7dGKr
         OTIg==
X-Gm-Message-State: AA+aEWZepI4TIS6M9t8GVlJnwHX7QF6Rs458BZ0E8frPqxYDD+C/kxXN
        wtT8soA6LGrVAz+Fmizn0GGVYQ==
X-Google-Smtp-Source: AFSGD/WxdS6n0zYecre+c752T4IMr5ENKhCcgYNx3aCpG9ys7r8Z5lEdYiK0bpP8lLkWx/kDj3tBXg==
X-Received: by 2002:a37:2e42:: with SMTP id u63mr18972982qkh.249.1543936798013;
        Tue, 04 Dec 2018 07:19:58 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q17sm11053989qtc.19.2018.12.04.07.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:19:57 -0800 (PST)
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
Subject: [PATCH v4 1/5] drm/msm/mdp4: add lcdc-align-lsb flag to control lane alignment
Date:   Tue,  4 Dec 2018 10:16:57 -0500
Message-Id: <20181204151702.8514-1-jonathan@marek.ca>
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

