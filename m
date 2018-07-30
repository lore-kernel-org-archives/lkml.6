Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA6CC28CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EB820881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="FCbQbVfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EB820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbeGaAs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:48:56 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55718 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbeGaAsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:48:55 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 81FE2B00AB7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:11:38 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1532992298; x=1533856299; bh=22
        Fe5asuBaY0VzF+PC7XSDWjHBonAg8l8ecG9p5cmZ0=; b=FCbQbVfkLxFjSkPlmR
        29QGYvIAfX1bLG6Pz9NwYEf31m5RaKYGP0VOsjZbU539PM9YLcDiX4r/m/4X9GWp
        E2b9ufpaooLW5GMBOdkXyy2njQ9LrrHy6Hh5FHhPXYDmimvybiLXqNCnBJv7AaZA
        32cg97E4e2uiRvHHPOTBy1//s=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NsEFGZLat2vM for <linux-kernel@vger.kernel.org>;
        Tue, 31 Jul 2018 01:11:38 +0200 (CEST)
Received: from ubuntu.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id D080EB00AB6;
        Tue, 31 Jul 2018 01:11:34 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 2/5] drm/panel: add panel CDTech S070WV95-CT16 to panel-simple
Date:   Tue, 31 Jul 2018 01:11:14 +0200
Message-Id: <20180730231117.5631-3-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for CDTech S070WV95-CT16 800x480 7" panel to DRM
simple panel driver.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab404ee7..caa5a01eb8e3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -787,6 +787,30 @@ static const struct panel_desc boe_nv101wxmn51 = {
 	},
 };
 
+static const struct drm_display_mode cdtech_s070wv95_ct16_mode = {
+	.clock = 35000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 40,
+	.htotal = 800 + 40 + 40 + 48,
+	.vdisplay = 480,
+	.vsync_start = 480 + 29,
+	.vsync_end = 480 + 29 + 13,
+	.vtotal = 480 + 29 + 13 + 3,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc cdtech_s070wv95_ct16 = {
+	.modes = &cdtech_s070wv95_ct16_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 154,
+		.height = 85,
+	},
+};
+
 static const struct drm_display_mode chunghwa_claa070wp03xg_mode = {
 	.clock = 66770,
 	.hdisplay = 800,
@@ -2115,6 +2139,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
+	}, {
+		.compatible = "cdtech,s070wv95-ct16",
+		.data = &cdtech_s070wv95_ct16,
 	}, {
 		.compatible = "chunghwa,claa070wp03xg",
 		.data = &chunghwa_claa070wp03xg,
-- 
2.17.1

