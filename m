Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B95C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FFA2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qpNQOoxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfA1Syp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:54:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37756 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1Syo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:54:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so8420380pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fx9BHlwzsgKMI4Br65SNZ/6JaAkFgPKOr7GDA8xoIpI=;
        b=qpNQOoxDV96A+ArY9qwlMuTZUKjkhgvngnM+T4VJomiVrOOm0KCIombvJ1OB03ayHv
         eEQgj8OpO5TBrQx5rdo5rdXlJBQOBAIntyN8fUgcEq5B5oEAN+Qxbdu+qJzJ7G3RmZkp
         1EgrQtccWJRtdGUGFi3ZFjRe5TAa2mNIiUb5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fx9BHlwzsgKMI4Br65SNZ/6JaAkFgPKOr7GDA8xoIpI=;
        b=ekmnJ4SuBFp+tPNrW3LMltguPns8Gyk1CvO1fW1u3C8hJKUzupwfGJFkdm56rHIcL/
         V6diln1dG067LDSe69TBez+E0660hisqu+YUIl65T+PsU9DTJOABI7FKuQ8aNWbBWiat
         g/yZaClBMiZdHIxgJOEERiJr2rAEuI/vff0sPqbfYgaMMPeM2zUK5beffhkgCtVOZNNa
         uQXqHmvmVtuisk18MlF4V+RCmIYwSTAD+TtrYRoEfCVl5oPPBm+RrmPeIg60Llwfm7sV
         RdI4HMji7PIpiYbUM0l+HMDHkhkxW3nKOGINFxBmyatqlebJEUPfKcVd+aHces3kJfd6
         UKJQ==
X-Gm-Message-State: AJcUukdA0V+DiJ6yMCNH6IHEFHB0gWznvSO3LyMO9puWlqX7PRI1RytT
        yE5O131tSSCGtFFa5wXDlcgraA==
X-Google-Smtp-Source: ALg8bN6PoTBpfoPVa/C+g1SuGMmZBr8K4IaFAHwNgOwdHIXgMe8ay2x1I9qFVS3fea+TlQNS7B0sIw==
X-Received: by 2002:a63:7044:: with SMTP id a4mr20446546pgn.359.1548701684106;
        Mon, 28 Jan 2019 10:54:44 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id r66sm54088441pfk.157.2019.01.28.10.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 10:54:43 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
Date:   Tue, 29 Jan 2019 00:24:28 +0530
Message-Id: <20190128185428.25129-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190128185428.25129-1-jagan@amarulasolutions.com>
References: <20190128185428.25129-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.

Add panel driver for it.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Tested-by: Bhushan Shah <bshah@kde.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
- add space b/w msleep and comment line
- use multi comment line style
- add sentinel
- collect Sam Ravnborg Reviewed-by
Changes for v5:
- drop drmP.h header
- order include files
- add empty line after kzalloc()
- drop gpio set for reset
- drop backlight put_device from probe()
- drop backlight put_device from remove()
- collect Tested-by from Bhushan Shah
Changes for v4:
- rebase on master
- adjust the hporch values to satisfy the refresh
Changes for v3:
- use simple structure for command init
- update proper comments on power, reset delay sequnce
- fix to use set_display_off in disable function
- move mode type to structure
- drop refres rate value, let drm compute
Changes for v2:
- new patch, derived from another dsi series

 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 271 ++++++++++++++++++
 4 files changed, 287 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e3f785bad68b..5c8591eb5840 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4831,6 +4831,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 S:	Maintained
 F:	drivers/gpu/drm/tve200/
 
+DRM DRIVER FOR FEIYANG FY07024DI26A30-D MIPI-DSI LCD PANELS
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+F:	Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
+
 DRM DRIVER FOR ILITEK ILI9225 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 151ddf720b83..5304db7b7b55 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -47,6 +47,15 @@ config DRM_PANEL_SIMPLE
 	  that it can be automatically turned off when the panel goes into a
 	  low power state.
 
+config DRM_PANEL_FEIYANG_FY07024DI26A30D
+	tristate "Feiyang FY07024DI26A30-D MIPI-DSI LCD panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Feiyang FY07024DI26A30-D MIPI-DSI interface.
+
 config DRM_PANEL_ILITEK_IL9322
 	tristate "Ilitek ILI9322 320x240 QVGA panels"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 54db0921f329..c88dacf9d439 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
 obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20_ICN6211) += panel-bananapi-s070wv20-icn6211.o
 obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
 obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
+obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
 obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
new file mode 100644
index 000000000000..4ecf408d6492
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Amarula Solutions
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
+#include <linux/backlight.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
+
+#define FEIYANG_INIT_CMD_LEN	2
+
+struct feiyang {
+	struct drm_panel	panel;
+	struct mipi_dsi_device	*dsi;
+
+	struct backlight_device	*backlight;
+	struct regulator	*dvdd;
+	struct regulator	*avdd;
+	struct gpio_desc	*reset;
+};
+
+static inline struct feiyang *panel_to_feiyang(struct drm_panel *panel)
+{
+	return container_of(panel, struct feiyang, panel);
+}
+
+struct feiyang_init_cmd {
+	u8 data[FEIYANG_INIT_CMD_LEN];
+};
+
+static const struct feiyang_init_cmd feiyang_init_cmds[] = {
+	{ .data = { 0x80, 0x58 } },
+	{ .data = { 0x81, 0x47 } },
+	{ .data = { 0x82, 0xD4 } },
+	{ .data = { 0x83, 0x88 } },
+	{ .data = { 0x84, 0xA9 } },
+	{ .data = { 0x85, 0xC3 } },
+	{ .data = { 0x86, 0x82 } },
+};
+
+static int feiyang_prepare(struct drm_panel *panel)
+{
+	struct feiyang *ctx = panel_to_feiyang(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	unsigned int i;
+	int ret;
+
+	ret = regulator_enable(ctx->dvdd);
+	if (ret)
+		return ret;
+
+	/* T1 (dvdd start + dvdd rise) 0 < T1 <= 10ms */
+	msleep(10);
+
+	ret = regulator_enable(ctx->avdd);
+	if (ret)
+		return ret;
+
+	/* T3 (dvdd rise + avdd start + avdd rise) T3 >= 20ms */
+	msleep(20);
+
+	gpiod_set_value(ctx->reset, 0);
+
+	/*
+	 * T5 + T6 (avdd rise + video & logic signal rise)
+	 * T5 >= 10ms, 0 < T6 <= 10ms
+	 */
+	msleep(20);
+
+	gpiod_set_value(ctx->reset, 1);
+
+	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
+	msleep(200);
+
+	for (i = 0; i < ARRAY_SIZE(feiyang_init_cmds); i++) {
+		const struct feiyang_init_cmd *cmd =
+						&feiyang_init_cmds[i];
+
+		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
+						FEIYANG_INIT_CMD_LEN);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int feiyang_enable(struct drm_panel *panel)
+{
+	struct feiyang *ctx = panel_to_feiyang(panel);
+
+	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
+	msleep(200);
+
+	mipi_dsi_dcs_set_display_on(ctx->dsi);
+	backlight_enable(ctx->backlight);
+
+	return 0;
+}
+
+static int feiyang_disable(struct drm_panel *panel)
+{
+	struct feiyang *ctx = panel_to_feiyang(panel);
+
+	backlight_disable(ctx->backlight);
+	return mipi_dsi_dcs_set_display_off(ctx->dsi);
+}
+
+static int feiyang_unprepare(struct drm_panel *panel)
+{
+	struct feiyang *ctx = panel_to_feiyang(panel);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
+	if (ret < 0)
+		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
+			      ret);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
+	if (ret < 0)
+		DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
+			      ret);
+
+	/* T13 (backlight fall + video & logic signal fall) T13 >= 200ms */
+	msleep(200);
+
+	gpiod_set_value(ctx->reset, 0);
+
+	regulator_disable(ctx->avdd);
+
+	/* T11 (dvdd rise to fall) 0 < T11 <= 10ms  */
+	msleep(10);
+
+	regulator_disable(ctx->dvdd);
+
+	return 0;
+}
+
+static const struct drm_display_mode feiyang_default_mode = {
+	.clock = 55000,
+
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 310,
+	.hsync_end = 1024 + 310 + 20,
+	.htotal = 1024 + 310 + 20 + 90,
+
+	.vdisplay = 600,
+	.vsync_start = 600 + 12,
+	.vsync_end = 600 + 12 + 2,
+	.vtotal = 600 + 12 + 2 + 21,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int feiyang_get_modes(struct drm_panel *panel)
+{
+	struct drm_connector *connector = panel->connector;
+	struct feiyang *ctx = panel_to_feiyang(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, &feiyang_default_mode);
+	if (!mode) {
+		DRM_DEV_ERROR(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
+			      feiyang_default_mode.hdisplay,
+			      feiyang_default_mode.vdisplay,
+			      feiyang_default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs feiyang_funcs = {
+	.disable = feiyang_disable,
+	.unprepare = feiyang_unprepare,
+	.prepare = feiyang_prepare,
+	.enable = feiyang_enable,
+	.get_modes = feiyang_get_modes,
+};
+
+static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct feiyang *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, ctx);
+	ctx->dsi = dsi;
+
+	drm_panel_init(&ctx->panel);
+	ctx->panel.dev = &dsi->dev;
+	ctx->panel.funcs = &feiyang_funcs;
+
+	ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
+	if (IS_ERR(ctx->dvdd)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get dvdd regulator\n");
+		return PTR_ERR(ctx->dvdd);
+	}
+
+	ctx->avdd = devm_regulator_get(&dsi->dev, "avdd");
+	if (IS_ERR(ctx->avdd)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get avdd regulator\n");
+		return PTR_ERR(ctx->avdd);
+	}
+
+	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get our reset GPIO\n");
+		return PTR_ERR(ctx->reset);
+	}
+
+	ctx->backlight = devm_of_find_backlight(&dsi->dev);
+	if (IS_ERR(ctx->backlight))
+		return PTR_ERR(ctx->backlight);
+
+	ret = drm_panel_add(&ctx->panel);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 4;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int feiyang_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct feiyang *ctx = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&ctx->panel);
+
+	return 0;
+}
+
+static const struct of_device_id feiyang_of_match[] = {
+	{ .compatible = "feiyang,fy07024di26a30d", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, feiyang_of_match);
+
+static struct mipi_dsi_driver feiyang_driver = {
+	.probe = feiyang_dsi_probe,
+	.remove = feiyang_dsi_remove,
+	.driver = {
+		.name = "feiyang-fy07024di26a30d",
+		.of_match_table = feiyang_of_match,
+	},
+};
+module_mipi_dsi_driver(feiyang_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Feiyang FY07024DI26A30-D MIPI-DSI LCD panel");
+MODULE_LICENSE("GPL");
-- 
2.18.0.321.gffc6fa0e3

