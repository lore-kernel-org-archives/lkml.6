Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE55DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F682218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PVQnj1JO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395133AbfBOODS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:03:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37296 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395050AbfBOOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:02:59 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FE2ufq004425;
        Fri, 15 Feb 2019 08:02:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550239376;
        bh=Heq/wSBrQJCiPS8kR7vvgEBFhI0/FXdakJo2OBjLoMI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PVQnj1JOu5EpgGSwXMNzXDZ7ITHjjxh+ATgJ1mTKW0w5hHFYFbLJUw04T1a5mc0RZ
         /x+Wx1Q2aYVi4YPnIzgIT3r/AtOQaYenk0kXmVbuyOu7kwzyFo5556ET3/8PILSYPd
         obaGHq0hHeDp4FIIKLnUyQnvgUAgswWXoyDlVCdI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FE2uZh096236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 08:02:56 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 08:02:55 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 08:02:55 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FE2mNl001839;
        Fri, 15 Feb 2019 08:02:53 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>
Subject: [PATCH 2/4] drm/panel: simple: Add support for OSD101T2045-53TS
Date:   Fri, 15 Feb 2019 16:03:13 +0200
Message-ID: <20190215140315.18046-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215140315.18046-1-peter.ujfalusi@ti.com>
References: <20190215140315.18046-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the OSD101T2045-53TS 10.1" 1920x1200 panel from One Stop
Displays to the panel-simple driver

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9e8218f6a3f2..0337583ffa49 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2996,6 +2996,37 @@ static const struct panel_desc_dsi panasonic_vvx10f004b00 = {
 	.lanes = 4,
 };
 
+static const struct drm_display_mode osd101t2045_53ts_mode = {
+	.clock = 154500,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 112,
+	.hsync_end = 1920 + 112 + 16,
+	.htotal = 1920 + 112 + 16 + 32,
+	.vdisplay = 1200,
+	.vsync_start = 1200 + 16,
+	.vsync_end = 1200 + 16 + 2,
+	.vtotal = 1200 + 16 + 2 + 16,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc_dsi osd101t2045_53ts = {
+	.desc = {
+		.modes = &osd101t2045_53ts_mode,
+		.num_modes = 1,
+		.bpc = 8,
+		.size = {
+			.width = 217,
+			.height = 136,
+		},
+	},
+	.flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		 MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		 MIPI_DSI_MODE_EOT_PACKET,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 4,
+};
+
 static const struct of_device_id dsi_of_match[] = {
 	{
 		.compatible = "auo,b080uan01",
@@ -3012,6 +3043,9 @@ static const struct of_device_id dsi_of_match[] = {
 	}, {
 		.compatible = "panasonic,vvx10f004b00",
 		.data = &panasonic_vvx10f004b00
+	}, {
+		.compatible = "osd,osd101t2045-53ts",
+		.data = &osd101t2045_53ts
 	}, {
 		/* sentinel */
 	}
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

