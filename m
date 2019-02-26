Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF262173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SGSp8onB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfBZHzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:55:15 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53706 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBZHzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:55:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1Q7t3f3125203;
        Tue, 26 Feb 2019 01:55:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551167703;
        bh=szggMVtFaXxBWCCcAsPkq199J7KfNmEFN/Nf96Xx16Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SGSp8onBnPMwWwhEe9dvcYONFFWl8BJXYer6xQYQxigt1Ec58tGLnthtTbEqY9ud7
         O5hN7FqXbIZuYgA45Ig58naJEqdmtJ6P9HvIAUCdpr0PNcCuY0wbPTfLh9Bs9Etqqv
         yNLB1kSxLdf7+DtvnLAM5uDT4ENooToonkc1KWFs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1Q7t3kg054647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 01:55:03 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 01:55:02 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 01:55:02 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1Q7soqp016249;
        Tue, 26 Feb 2019 01:55:00 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>, <sam@ravnborg.org>
Subject: [PATCH v3 4/4] drm/panel: Add OSD101T2587-53TS driver
Date:   Tue, 26 Feb 2019 09:55:23 +0200
Message-ID: <20190226075523.28997-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226075523.28997-1-peter.ujfalusi@ti.com>
References: <20190226075523.28997-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel is similar to OSD101T2045-53TS (which is handled by panel-simple)
with one big difference: osd101t2587-53ts needs MIPI_DSI_TURN_ON_PERIPHERAL
message to be sent from the host to be operational and thus can not be
handled by panel-simple.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-osd-osd101t2587-53ts.c    | 254 ++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 3e070153ef21..6b6790474c33 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -122,6 +122,15 @@ config DRM_PANEL_ORISETECH_OTM8009A
 	  Say Y here if you want to enable support for Orise Technology
 	  otm8009a 480x800 dsi 2dl panel.
 
+config DRM_PANEL_OSD_OSD101T2587_53TS
+	tristate "OSD OSD101T2587-53TS DSI 1920x1200 video mode panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for One Stop Displays
+	  OSD101T2587-53TS 10.1" 1920x1200 dsi panel.
+
 config DRM_PANEL_PANASONIC_VVX10F034N00
 	tristate "Panasonic VVX10F034N00 1920x1200 video mode panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index e7ab71968bbf..d9d99956db0c 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
 obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
 obj-$(CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO) += panel-olimex-lcd-olinuxino.o
 obj-$(CONFIG_DRM_PANEL_ORISETECH_OTM8009A) += panel-orisetech-otm8009a.o
+obj-$(CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS) += panel-osd-osd101t2587-53ts.o
 obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
 obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) += panel-raspberrypi-touchscreen.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
new file mode 100644
index 000000000000..55974e74aa0a
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+
+struct osd101t2587_panel {
+	struct drm_panel base;
+	struct mipi_dsi_device *dsi;
+
+	struct backlight_device *backlight;
+	struct regulator *supply;
+
+	bool prepared;
+	bool enabled;
+
+	const struct drm_display_mode *default_mode;
+};
+
+static inline struct osd101t2587_panel *ti_osd_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct osd101t2587_panel, base);
+}
+
+static int osd101t2587_panel_disable(struct drm_panel *panel)
+{
+	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
+	int ret;
+
+	if (!osd101t2587->enabled)
+		return 0;
+
+	backlight_disable(osd101t2587->backlight);
+
+	ret = mipi_dsi_shutdown_peripheral(osd101t2587->dsi);
+
+	osd101t2587->enabled = false;
+
+	return ret;
+}
+
+static int osd101t2587_panel_unprepare(struct drm_panel *panel)
+{
+	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
+
+	if (!osd101t2587->prepared)
+		return 0;
+
+	regulator_disable(osd101t2587->supply);
+	osd101t2587->prepared = false;
+
+	return 0;
+}
+
+static int osd101t2587_panel_prepare(struct drm_panel *panel)
+{
+	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
+	int ret;
+
+	if (osd101t2587->prepared)
+		return 0;
+
+	ret = regulator_enable(osd101t2587->supply);
+	if (!ret)
+		osd101t2587->prepared = true;
+
+	return ret;
+}
+
+static int osd101t2587_panel_enable(struct drm_panel *panel)
+{
+	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
+	int ret;
+
+	if (osd101t2587->enabled)
+		return 0;
+
+	ret = mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
+	if (ret)
+		return ret;
+
+	backlight_enable(osd101t2587->backlight);
+
+	osd101t2587->enabled = true;
+
+	return ret;
+}
+
+static const struct drm_display_mode default_mode_osd101t2587 = {
+	.clock = 164400,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 152,
+	.hsync_end = 1920 + 152 + 52,
+	.htotal = 1920 + 152 + 52 + 20,
+	.vdisplay = 1200,
+	.vsync_start = 1200 + 24,
+	.vsync_end = 1200 + 24 + 6,
+	.vtotal = 1200 + 24 + 6 + 48,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static int osd101t2587_panel_get_modes(struct drm_panel *panel)
+{
+	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, osd101t2587->default_mode);
+	if (!mode) {
+		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
+			osd101t2587->default_mode->hdisplay,
+			osd101t2587->default_mode->vdisplay,
+			osd101t2587->default_mode->vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	drm_mode_probed_add(panel->connector, mode);
+
+	panel->connector->display_info.width_mm = 217;
+	panel->connector->display_info.height_mm = 136;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs osd101t2587_panel_funcs = {
+	.disable = osd101t2587_panel_disable,
+	.unprepare = osd101t2587_panel_unprepare,
+	.prepare = osd101t2587_panel_prepare,
+	.enable = osd101t2587_panel_enable,
+	.get_modes = osd101t2587_panel_get_modes,
+};
+
+static const struct of_device_id osd101t2587_of_match[] = {
+	{
+		.compatible = "osd,osd101t2587-53ts",
+		.data = &default_mode_osd101t2587,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, osd101t2587_of_match);
+
+static int osd101t2587_panel_add(struct osd101t2587_panel *osd101t2587)
+{
+	struct device *dev = &osd101t2587->dsi->dev;
+
+	osd101t2587->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(osd101t2587->supply))
+		return PTR_ERR(osd101t2587->supply);
+
+	osd101t2587->backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(osd101t2587->backlight))
+		return PTR_ERR(osd101t2587->backlight);
+
+	drm_panel_init(&osd101t2587->base);
+	osd101t2587->base.funcs = &osd101t2587_panel_funcs;
+	osd101t2587->base.dev = &osd101t2587->dsi->dev;
+
+	return drm_panel_add(&osd101t2587->base);
+}
+
+static int osd101t2587_panel_probe(struct mipi_dsi_device *dsi)
+{
+	struct osd101t2587_panel *osd101t2587;
+	const struct of_device_id *id;
+	int ret;
+
+	id = of_match_node(osd101t2587_of_match, dsi->dev.of_node);
+	if (!id)
+		return -ENODEV;
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
+			  MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+			  MIPI_DSI_MODE_EOT_PACKET;
+
+	osd101t2587 = devm_kzalloc(&dsi->dev, sizeof(*osd101t2587), GFP_KERNEL);
+	if (!osd101t2587)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, osd101t2587);
+
+	osd101t2587->dsi = dsi;
+	osd101t2587->default_mode = id->data;
+
+	ret = osd101t2587_panel_add(osd101t2587);
+	if (ret < 0)
+		return ret;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret)
+		drm_panel_remove(&osd101t2587->base);
+
+	return ret;
+}
+
+static int osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = osd101t2587_panel_disable(&osd101t2587->base);
+	if (ret < 0)
+		dev_warn(&dsi->dev, "failed to disable panel: %d\n", ret);
+
+	osd101t2587_panel_unprepare(&osd101t2587->base);
+
+	drm_panel_remove(&osd101t2587->base);
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+
+	return ret;
+}
+
+static void osd101t2587_panel_shutdown(struct mipi_dsi_device *dsi)
+{
+	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
+
+	osd101t2587_panel_disable(&osd101t2587->base);
+	osd101t2587_panel_unprepare(&osd101t2587->base);
+}
+
+static struct mipi_dsi_driver osd101t2587_panel_driver = {
+	.driver = {
+		.name = "panel-osd-osd101t2587-53ts",
+		.of_match_table = osd101t2587_of_match,
+	},
+	.probe = osd101t2587_panel_probe,
+	.remove = osd101t2587_panel_remove,
+	.shutdown = osd101t2587_panel_shutdown,
+};
+module_mipi_dsi_driver(osd101t2587_panel_driver);
+
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_DESCRIPTION("OSD101T2587-53TS DSI panel");
+MODULE_LICENSE("GPL v2");
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

