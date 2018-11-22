Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B6C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBFF2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="CPB8irCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBFF2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403998AbeKVMdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33975 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403978AbeKVMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so5979123qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iDpxwhz52J7768fW56aWS5n/NR5UxFIVBUXbmrpXRCo=;
        b=CPB8irCD/L/4GU25BfCCWv2hD3ALig10lLDH5MYh8eEtOPdtbJnoDd+UBBrbAX3f0x
         22iTUohGOAzAlpr5vWp6v98aY7cXV2VG1BJosB4A6nOU3Bwr5BAMExpqCf5kKQ4b2gxN
         PIs6FMXCXnJi0zlAv9evxi7iiU9NrI0kGCaLDO1LDhAq/AAEx057ZKpO+uowS/jUkyiH
         osQwpDYXicA+EwxlTc2atpP2/UKfWGV1Y6gefgz5+PXda1Y7HzXcfSLUPJDg6BS7r8ID
         +tgCRo92a6KosqAQ427VSEUaBA/s6we+hguodgv0aP56gcXoSq4JoAndIALSoSQmrhiX
         TJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iDpxwhz52J7768fW56aWS5n/NR5UxFIVBUXbmrpXRCo=;
        b=suCm85t/5XO77HFsQACHCFwOwef+tmIwguFyIZD+S1F8wqBeCjHNNNgRP6BU6rAdmH
         lOuvMV5e3U5IaMZsSm7SEtB8DsH8lftCfV7f8g7Ay4wjQ9pvUietXuUFgtsyi7IjTmVI
         /eSIsmmOh1ubZJAEPOFvukhhqqwTGY/wNEaiy842b14LpXZFROQCKC7Svyqz/uyCnGIi
         hOvseKUejHJJHlV92fSc8w4dOVOYyXIe5RSont87X5SR3HShfMi+p1b7mY9gdWyS32OI
         fNtVOWGpSV1aWAmSm1q0ptC9F9xEzWuRlrILpJGd+XZDKRE1TSPBCULsMa9a2WXcAotD
         Qq1A==
X-Gm-Message-State: AA+aEWYxPoCwItcMsSyTSQJKWP9jBnokLle/tAYaDgQFEUJA4ypVxKGl
        lRC+os4z02WOCpeL6FnWMdjWXA==
X-Google-Smtp-Source: AFSGD/UMeFNofsnMRiV5NPUUyqSVV8LC3RrPRO2CtoaQ5PhqZ/Z2Rbrcb429SFHcowPtODwR7cToyw==
X-Received: by 2002:a0c:e751:: with SMTP id g17mr8493692qvn.160.1542851763685;
        Wed, 21 Nov 2018 17:56:03 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q15sm25297721qkl.81.2018.11.21.17.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:56:03 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 8/9] drm/msm/mdp5: add config for msm8917
Date:   Wed, 21 Nov 2018 20:52:34 -0500
Message-Id: <20181122015237.14534-8-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015237.14534-1-jonathan@marek.ca>
References: <20181122015237.14534-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mdp5_cfg_hw entry for MDP5 version v1.15 found on msm8917.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 86 ++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
index 824067d2d427..05ad159b6261 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
@@ -553,6 +553,91 @@ const struct mdp5_cfg_hw msm8x96_config = {
 	.max_clk = 412500000,
 };
 
+const struct mdp5_cfg_hw msm8917_config = {
+	.name = "msm8917",
+	.mdp = {
+		.count = 1,
+		.caps = MDP_CAP_CDM,
+	},
+	.ctl = {
+		.count = 3,
+		.base = { 0x01000, 0x01200, 0x01400 },
+		.flush_hw_mask = 0xffffffff,
+	},
+	.pipe_vig = {
+		.count = 1,
+		.base = { 0x04000 },
+		.caps = MDP_PIPE_CAP_HFLIP	|
+			MDP_PIPE_CAP_VFLIP	|
+			MDP_PIPE_CAP_SCALE	|
+			MDP_PIPE_CAP_CSC	|
+			MDP_PIPE_CAP_DECIMATION	|
+			MDP_PIPE_CAP_SW_PIX_EXT	|
+			0,
+	},
+	.pipe_rgb = {
+		.count = 2,
+		.base = { 0x14000, 0x16000 },
+		.caps = MDP_PIPE_CAP_HFLIP	|
+			MDP_PIPE_CAP_VFLIP	|
+			MDP_PIPE_CAP_DECIMATION	|
+			MDP_PIPE_CAP_SW_PIX_EXT	|
+			0,
+	},
+	.pipe_dma = {
+		.count = 1,
+		.base = { 0x24000 },
+		.caps = MDP_PIPE_CAP_HFLIP	|
+			MDP_PIPE_CAP_VFLIP	|
+			MDP_PIPE_CAP_SW_PIX_EXT	|
+			0,
+	},
+	.pipe_cursor = {
+		.count = 1,
+		.base = { 0x34000 },
+		.caps = MDP_PIPE_CAP_HFLIP	|
+			MDP_PIPE_CAP_VFLIP	|
+			MDP_PIPE_CAP_SW_PIX_EXT	|
+			MDP_PIPE_CAP_CURSOR	|
+			0,
+	},
+
+	.lm = {
+		.count = 2,
+		.base = { 0x44000, 0x45000 },
+		.instances = {
+				{ .id = 0, .pp = 0, .dspp = 0,
+				  .caps = MDP_LM_CAP_DISPLAY, },
+				{ .id = 1, .pp = -1, .dspp = -1,
+				  .caps = MDP_LM_CAP_WB },
+			     },
+		.nb_stages = 8,
+		.max_width = 2048,
+		.max_height = 0xFFFF,
+	},
+	.dspp = {
+		.count = 1,
+		.base = { 0x54000 },
+
+	},
+	.pp = {
+		.count = 1,
+		.base = { 0x70000 },
+	},
+	.cdm = {
+		.count = 1,
+		.base = { 0x79200 },
+	},
+	.intf = {
+		.base = { 0x6a000, 0x6a800 },
+		.connect = {
+			[0] = INTF_DISABLED,
+			[1] = INTF_DSI,
+		},
+	},
+	.max_clk = 320000000,
+};
+
 static const struct mdp5_cfg_handler cfg_handlers[] = {
 	{ .revision = 0, .config = { .hw = &msm8x74v1_config } },
 	{ .revision = 2, .config = { .hw = &msm8x74v2_config } },
@@ -560,6 +645,7 @@ static const struct mdp5_cfg_handler cfg_handlers[] = {
 	{ .revision = 6, .config = { .hw = &msm8x16_config } },
 	{ .revision = 9, .config = { .hw = &msm8x94_config } },
 	{ .revision = 7, .config = { .hw = &msm8x96_config } },
+	{ .revision = 15, .config = { .hw = &msm8917_config } },
 };
 
 static struct mdp5_cfg_platform *mdp5_get_config(struct platform_device *dev);
-- 
2.17.1

