Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753379AbeCUUEE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:04:04 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:45434 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbeCUUD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:03:59 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 3/7] drm/panel: add panel CDTech S043WQ26H-CT7 to panel-simple
Date: Wed, 21 Mar 2018 21:03:09 +0100
Message-Id: <1521662593-25468-3-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 .../display/panel/cdtech,s043wq26h-ct7.txt         |  7 ++++++
 drivers/gpu/drm/panel/panel-simple.c               | 28 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt

diff --git a/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt b/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
new file mode 100644
index 0000000..a22af85
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
@@ -0,0 +1,7 @@
+CDTech(H.K.) Electronics Limited 4.3" 480x272 color TFT-LCD panel
+
+Required properties:
+- compatible: should be "cdtech,s043wq26h-ct7"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 714fbdd..5e0c6d9 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -764,6 +764,31 @@ static const struct panel_desc boe_nv101wxmn51 = {
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
@@ -2091,6 +2116,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
 	}, {
+		.compatible = "cdtech,s043wq26h-ct7",
+		.data = &cdtech_s043wq26h_ct7,
+	}, {
 		.compatible = "cdtech,s070wv95-ct16",
 		.data = &cdtech_s070wv95_ct16,
 	}, {
-- 
2.7.4
