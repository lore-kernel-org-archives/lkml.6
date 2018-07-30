Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B689C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3044420892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="Tgw+tqlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3044420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeGaAs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:48:58 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55796 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbeGaAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:48:58 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 061D1B00AB7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:11:41 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1532992300; x=1533856301; bh=ge
        +e7LBLqFcObUAM/KYXviT7vRHQ/XghYID9O2k+6E4=; b=Tgw+tqlB7h3Oy2h2pS
        Mq/tsYSd3C3j2qA7jCYSuRUFBdWw1MkQySt7hR9yxg9nGd2qEbbURf1WV5wj02Pf
        WsjqRymjs/6s/q+jFWh2DcifXInFYeWG+kB5tUgjjfJUoc+LwtVAE4yPTnyEBOXh
        LCcJXA4L6DwqoijlHD+BsWfoY=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CIXmB4Ropxa9 for <linux-kernel@vger.kernel.org>;
        Tue, 31 Jul 2018 01:11:40 +0200 (CEST)
Received: from ubuntu.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id C7C57B00A99;
        Tue, 31 Jul 2018 01:11:36 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 4/5] drm/panel: add panel CDTech S043WQ26H-CT7 to panel-simple
Date:   Tue, 31 Jul 2018 01:11:16 +0200
Message-Id: <20180730231117.5631-5-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for CDTech S043WQ26H-CT7 480x272 4.3" panel to
DRM simple panel driver.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index caa5a01eb8e3..3a6a66c2307d 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -787,6 +787,31 @@ static const struct panel_desc boe_nv101wxmn51 = {
 	},
 };
 
+static const struct drm_display_mode cdtech_s043wq26h_ct7_mode = {
+	.clock = 9000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 5,
+	.hsync_end = 480 + 5 + 5,
+	.htotal = 480 + 5 + 5 + 40,
+	.vdisplay = 272,
+	.vsync_start = 272 + 8,
+	.vsync_end = 272 + 8 + 8,
+	.vtotal = 272 + 8 + 8 + 8,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc cdtech_s043wq26h_ct7 = {
+	.modes = &cdtech_s043wq26h_ct7_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 95,
+		.height = 54,
+	},
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+};
+
 static const struct drm_display_mode cdtech_s070wv95_ct16_mode = {
 	.clock = 35000,
 	.hdisplay = 800,
@@ -2139,6 +2164,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
+	}, {
+		.compatible = "cdtech,s043wq26h-ct7",
+		.data = &cdtech_s043wq26h_ct7,
 	}, {
 		.compatible = "cdtech,s070wv95-ct16",
 		.data = &cdtech_s070wv95_ct16,
-- 
2.17.1

