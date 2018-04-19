Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDSJch (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:32:37 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:35720 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752776AbeDSJce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:32:34 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Liu <net147@gmail.com>
Subject: [PATCH 4/6] drm/panel: simple: Add support for Banana Pi 7" S070WV20-CT16 panel
Date: Thu, 19 Apr 2018 17:32:23 +0800
Message-Id: <20180419093225.614-5-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419093225.614-1-wens@csie.org>
References: <20180419093225.614-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel is marketed as Banana Pi 7" LCD display. On the back is
a sticker denoting the model name S070WV20-CT16.

This is a 7" 800x480 panel connected through a 24-bit RGB interface.
However the panel only does 262k colors.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../display/panel/bananapi,s070wv20-ct16.txt  |  7 ++++++
 drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt

diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
new file mode 100644
index 000000000000..2ec35ce36e9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
@@ -0,0 +1,7 @@
+Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
+
+Required properties:
+- compatible: should be "bananapi,s070wv20-ct16"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab404ee7..9bc037f74d6c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -745,6 +745,28 @@ static const struct panel_desc avic_tm070ddh03 = {
 	},
 };
 
+static const struct drm_display_mode bananapi_s070wv20_ct16_mode = {
+	.clock = 30000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 48,
+	.htotal = 800 + 40 + 48 + 40,
+	.vdisplay = 480,
+	.vsync_start = 480 + 13,
+	.vsync_end = 480 + 13 + 3,
+	.vtotal = 480 + 13 + 3 + 29,
+};
+
+static const struct panel_desc bananapi_s070wv20_ct16 = {
+	.modes = &bananapi_s070wv20_ct16_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+};
+
 static const struct drm_display_mode boe_nv101wxmn51_modes[] = {
 	{
 		.clock = 71900,
@@ -2112,6 +2134,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "avic,tm070ddh03",
 		.data = &avic_tm070ddh03,
+	}, {
+		.compatible = "bananapi,s070wv20-ct16",
+		.data = &bananapi_s070wv20_ct16,
 	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
-- 
2.17.0
