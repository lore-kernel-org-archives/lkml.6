Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD036C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEF32064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEF32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJXV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:27:16 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:56309 "EHLO
        2.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeJXV1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:27:15 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Oct 2018 17:27:13 EDT
Received: from player759.ha.ovh.net (unknown [10.109.143.18])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id AB8D2DF591
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 14:42:25 +0200 (CEST)
Received: from localhost.localdomain (22.220.201.77.rev.sfr.net [77.201.220.22])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player759.ha.ovh.net (Postfix) with ESMTPSA id 1DA1E6400DE;
        Wed, 24 Oct 2018 14:42:11 +0200 (CEST)
From:   =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [RESEND PATCH 1/2] drm/panel: Add support for Armadeus ST0700 Adapt
Date:   Wed, 24 Oct 2018 14:54:56 +0200
Message-Id: <20181024125457.25204-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7543810852919334021
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrgeejgdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Armadeus ST0700 Adapt. It comes with a
Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT and an adapter board so
that it can be connected on the TFT header of Armadeus Dev boards.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 .../display/panel/armadeus,st0700-adapt.txt        |  9 +++++++
 drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt

diff --git a/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
new file mode 100644
index 000000000000..a30d63db3c8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
@@ -0,0 +1,9 @@
+Armadeus ST0700 Adapt. A Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT with
+an adapter board.
+
+Required properties:
+- compatible: "armadeus,st0700-adapt"
+- power-supply: see panel-common.txt
+
+Optional properties:
+- backlight: see panel-common.txt
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..e96df00a1c00 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -436,6 +436,32 @@ static const struct panel_desc ampire_am800480r3tmqwa1h = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct display_timing santek_st0700i5y_rbslw_f_timing = {
+	.pixelclock = { 26400000, 33300000, 46800000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 16, 210, 354 },
+	.hback_porch = { 45, 36, 6 },
+	.hsync_len = { 1, 10, 40 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 7, 22, 147 },
+	.vback_porch = { 22, 13, 3 },
+	.vsync_len = { 1, 10, 20 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE
+};
+
+static const struct panel_desc armadeus_st0700_adapt = {
+	.timings = &santek_st0700i5y_rbslw_f_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+};
+
 static const struct drm_display_mode auo_b101aw03_mode = {
 	.clock = 51450,
 	.hdisplay = 1024,
@@ -2330,6 +2356,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "ampire,am800480r3tmqwa1h",
 		.data = &ampire_am800480r3tmqwa1h,
+	}, {
+		.compatible = "armadeus,st0700-adapt",
+		.data = &armadeus_st0700_adapt,
 	}, {
 		.compatible = "auo,b101aw03",
 		.data = &auo_b101aw03,
-- 
2.16.4

