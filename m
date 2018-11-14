Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F3EC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D63E20868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="tq6OKscI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D63E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbeKOIdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:33:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41500 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387528AbeKOIdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:33:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so28787753qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iDpxwhz52J7768fW56aWS5n/NR5UxFIVBUXbmrpXRCo=;
        b=tq6OKscINrxkx2a6Qn/Sx1fSizwV3K4knjNbLkL/CjHYLvQkbici2eRFh2jfngOIGW
         BcMMEHZUklELL7iCdACTXxHzgJ8u3YDhA16CJXy5HHH7pTsHbvQTfyhJp6GvFV+eeA/i
         JvrskShm+sFTPnWmFyNTRcHi5zk6hZ753UE/+/bQx/A2/nyHulTHdbbxKB2snn2QuNSh
         UavKjkbIaRuyCp7Gzbl9ngK9933Ir+xswr/gpLuFikrjHqv7zooiRi7A2/mSsKjsNu/X
         wiJenoBQe4X1HhIOY3ZIVgonE+6oV+0KU9DQzXKbULBj7OK2bikd+C757CiRn1Jt0Pmc
         ow1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iDpxwhz52J7768fW56aWS5n/NR5UxFIVBUXbmrpXRCo=;
        b=aS5X+Hjiu4W486FW0tCwPTzZUBmCIiQtjebjNPgU+AcvHSzm8XjzuoVFuB+kdqY0Mu
         adFCN4LwFb8Q3/aRYbyOpTWRaPmiq+d4HJRd0uLDzjBYXPHSuQZwrEc56iMms7R4PROm
         9gTxGKwbDM9FaeP/yQOPeEn6/3bbptMn9ae9H8up7jyM658SWN7FsCvMGAf8eNO/TTHB
         4cbiGUHAxxrHBy2HchflEBbl/afNDTuREMKBlRNhsCphFa5wQ3lQ71G1TcwZZg+19WSO
         FKDsizVtNcBhuFmQrY6SUHVBEoK+DoDPXcFEDHGmm94AUrR/71dlpcF2LFBXgy7hcdVS
         pCBg==
X-Gm-Message-State: AGRZ1gLaitkjKtFARq300syOTdqhFycrsx5GWOv33O8cQ1Nks4Bzz3xz
        oU91h9O8qXkFTvD1Cvr6hPhNo5M0UAPFEg==
X-Google-Smtp-Source: AJdET5cYiesR/E6cnc8bQ69BrUlD4RuhoRc8yv/zIkPOIhY0wOdYyhiDxyi7qAUXygN0mMZ/twegtA==
X-Received: by 2002:aed:34e6:: with SMTP id x93mr3785103qtd.156.1542234494751;
        Wed, 14 Nov 2018 14:28:14 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 24sm24067595qkp.65.2018.11.14.14.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:28:14 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/9] drm/msm/mdp5: add config for msm8917
Date:   Wed, 14 Nov 2018 17:24:15 -0500
Message-Id: <20181114222418.15960-8-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222418.15960-1-jonathan@marek.ca>
References: <20181114222418.15960-1-jonathan@marek.ca>
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

