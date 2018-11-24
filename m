Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C380C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D7F20878
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="HC2nbPYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D7F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeKYGzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:55:55 -0500
Received: from onstation.org ([52.200.56.107]:42442 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbeKYGzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:55:54 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 1726C967;
        Sat, 24 Nov 2018 20:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1543090003;
        bh=Iq04HfGh4N/JRNc39E9WmqDuPrpyfMB5ajyLjC2zP6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HC2nbPYeUyhEgkM81nSJnz3ABfO+nXz9jVQi02c79EWSz4cYDAyVdk5BzaI2fsI+4
         09/pfh93Wx/adS7p/R3rFufmju27+46WCFTd0HUuH/OuTdNEkM/3bGJpOo+gvJslF9
         c3/DQaCCb5/b5cHzyUiTTnU+yHmz6G3wZfd3ArEE=
From:   Brian Masney <masneyb@onstation.org>
To:     thierry.reding@gmail.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH 2/2] drm/panel: simple: add lg,acx467akm-7 panel
Date:   Sat, 24 Nov 2018 15:06:28 -0500
Message-Id: <20181124200628.24393-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181124200628.24393-1-masneyb@onstation.org>
References: <20181124200628.24393-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

Add ACX467AKM-7 4.95" 1080×1920 LCD panel that is found on the LG Nexus
5 (hammerhead) phone.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
[masneyb@onstation.org: checkpatch fixes; rename jdi,1080p-hammerhead
binding to lg,acx467akm-7.]
Signed-off-by: Brian Masney <masneyb@onstation.org>
---
See patch 1 in this series for why I went with the LG model number.

 drivers/gpu/drm/panel/panel-simple.c | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..a772a8cc1eae 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2761,6 +2761,34 @@ static const struct panel_desc_dsi panasonic_vvx10f004b00 = {
 	.lanes = 4,
 };
 
+static const struct drm_display_mode lg_acx467akm_7_mode = {
+	.clock = 150000,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 2,
+	.hsync_end = 1080 + 2 + 2,
+	.htotal = 1080 + 2 + 2 + 2,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 2,
+	.vsync_end = 1920 + 2 + 2,
+	.vtotal = 1920 + 2 + 2 + 2,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc_dsi lg_acx467akm_7 = {
+	.desc = {
+		.modes = &lg_acx467akm_7_mode,
+		.num_modes = 1,
+		.bpc = 8,
+		.size = {
+			.width = 62,
+			.height = 110,
+		},
+	},
+	.flags = 0,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 4,
+};
+
 static const struct of_device_id dsi_of_match[] = {
 	{
 		.compatible = "auo,b080uan01",
@@ -2777,6 +2805,9 @@ static const struct of_device_id dsi_of_match[] = {
 	}, {
 		.compatible = "panasonic,vvx10f004b00",
 		.data = &panasonic_vvx10f004b00
+	}, {
+		.compatible = "lg,acx467akm-7",
+		.data = &lg_acx467akm_7
 	}, {
 		/* sentinel */
 	}
-- 
2.17.2

