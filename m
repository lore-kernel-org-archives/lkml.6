Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0BCC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CA620851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="QZ3p7vsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CA620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeLMPHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:07:40 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45297 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeLMPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:07:39 -0500
Received: by mail-yb1-f195.google.com with SMTP id r11so901297ybp.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 07:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SM57eTi17ZbBz501UB6FxCz2N+F7k/h3+LBNpkRqm2U=;
        b=QZ3p7vsc3gOJ2kGwGorQ9XPsAOzW6VZrEqCO4gvG4gxv4FHt2eX8qtJFodVY3kBr0B
         jK5ADggAMR4DiinzYFuM8jFGrOEsNMP5d0wNEPDnb4NsXzhn/xfKQcKLCZpAjeR4hmas
         9JfLWMcYaXPZVwuM3ftp1BQsoUAAYeR7pF8vjo2UvIvX7RF2ti8rc5mwtELxRsGhzAVN
         dy8UchxRkLGvXmn6WZzp9uLIHrLzesWABi+yEKEF6IXMmblni2/O6Ssx7puape0G7JlJ
         U+hU898qT3/DZ0D9wY1YDArIpz9Hms50LddctDLi4hvdC/nvD+NNs7OR3rJSkyb/WNKH
         qCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SM57eTi17ZbBz501UB6FxCz2N+F7k/h3+LBNpkRqm2U=;
        b=F2nELEOf7J8diEP+KuOHz8mZF3/RjU5hGRZ0LH8UhHmOR55AzLkyde52k4LCH8VFhx
         p9uh+KpbCXFvEmtSSpTr0rw9/fbZhpsRvzVGNEnlk72fOWTjTpqYRxQraf/+Frfru21b
         gPOwwoF5tLr3LW+rikOtS2Z+Uj5ErzeFR/B+U8WB7Hc2kKz8mfRC9tXdeaC1qJVjyCIu
         yDNOOoxH6cvgHSopeNPT8tqZHBn3skfryHnRv0Ixo6ncXjjTN0uFX+19kMccuhgGkaAk
         NKrS+A+YJ0TeQNje9ByHq6gyXm1SbKPicIMgsnoHoINGcemBgMU0IJ1dg4r3Q8J/e+19
         g2+Q==
X-Gm-Message-State: AA+aEWbZYIhltsNITVvfPvGj87qq8IYXCN3r3X6d6/tSRWRinwTKKgkJ
        lQjCJlu5vDbQhVo5W3LAYVmzNw==
X-Google-Smtp-Source: AFSGD/VRTULlafrlKNKn4LNBkZLrl9w6Lqnhyv9sT5QWC0wP7niqSTQCIhy6hLrgsRLt+uWmHKspEw==
X-Received: by 2002:a25:9106:: with SMTP id v6mr5401534ybl.386.1544713657640;
        Thu, 13 Dec 2018 07:07:37 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id b129sm677289ywc.106.2018.12.13.07.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 07:07:36 -0800 (PST)
Date:   Thu, 13 Dec 2018 10:07:36 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D
 MIPI-DSI LCD panel
Message-ID: <20181213150736.GL154160@art_vandelay>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-12-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116163916.29621-12-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 10:09:15PM +0530, Jagan Teki wrote:
> Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> 
> Add panel driver for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  MAINTAINERS                                   |   6 +
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
>  4 files changed, 302 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3dac08d0b3cb..40c8bfc974f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4620,6 +4620,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  S:	Maintained
>  F:	drivers/gpu/drm/tve200/
>  
> +DRM DRIVER FOR FEIYANG FY07024DI26A30-D MIPI-DSI LCD PANELS
> +M:	Jagan Teki <jagan@amarulasolutions.com>
> +S:	Maintained
> +F:	drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> +F:	Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> +
>  DRM DRIVER FOR ILITEK ILI9225 PANELS
>  M:	David Lechner <david@lechnology.com>
>  S:	Maintained
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index d0d4e60f5153..bc70896fe43c 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -47,6 +47,15 @@ config DRM_PANEL_SIMPLE
>  	  that it can be automatically turned off when the panel goes into a
>  	  low power state.
>  
> +config DRM_PANEL_FEIYANG_FY07024DI26A30D
> +	tristate "Feiyang FY07024DI26A30-D MIPI-DSI LCD panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y if you want to enable support for panels based on the
> +	  Feiyang FY07024DI26A30-D MIPI-DSI interface.
> +
>  config DRM_PANEL_ILITEK_IL9322
>  	tristate "Ilitek ILI9322 320x240 QVGA panels"
>  	depends on OF && SPI
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 88011f06edb8..e23c017639c7 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
>  obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20_ICN6211) += panel-bananapi-s070wv20-icn6211.o
>  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
>  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> +obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
> diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> new file mode 100644
> index 000000000000..a4b46bd8fdbe
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Amarula Solutions
> + * Author: Jagan Teki <jagan@amarulasolutions.com>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +
> +struct feiyang {
> +	struct drm_panel	panel;
> +	struct mipi_dsi_device	*dsi;
> +
> +	struct backlight_device	*backlight;
> +	struct regulator	*dvdd;
> +	struct regulator	*avdd;
> +	struct gpio_desc	*reset;
> +};
> +
> +static inline struct feiyang *panel_to_feiyang(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct feiyang, panel);
> +}
> +
> +struct feiyang_init_cmd {
> +	size_t len;
> +	const char *data;
> +};
> +
> +#define FY07024DI26A30D(...) { \
> +	.len = sizeof((char[]){__VA_ARGS__}), \
> +	.data = (char[]){__VA_ARGS__} }
> +
> +static const struct feiyang_init_cmd feiyang_init_cmds[] = {
> +	FY07024DI26A30D(0x80, 0x58),
> +	FY07024DI26A30D(0x81, 0x47),
> +	FY07024DI26A30D(0x82, 0xD4),
> +	FY07024DI26A30D(0x83, 0x88),
> +	FY07024DI26A30D(0x84, 0xA9),
> +	FY07024DI26A30D(0x85, 0xC3),
> +	FY07024DI26A30D(0x86, 0x82),
> +};

These init cmds don't have to be so complicated. You've only got len == 2, so
just hardcode it in and avoid the macro:

#define FEIYANG_INIT_CMD_LEN    2

struct feiyang_init_cmd {
        u8 data[FEIYANG_INIT_CMD];
};

static const struct feiyang_init_cmd feiyang_init_cmds[] = {
        { .data = { 0x80, 0x58 } },
        ...
};

> +
> +static int feiyang_prepare(struct drm_panel *panel)
> +{
> +	struct feiyang *ctx = panel_to_feiyang(panel);
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	unsigned int i;
> +	int ret;
> +
> +	ret = regulator_enable(ctx->dvdd);
> +	if (ret)
> +		return ret;
> +
> +	msleep(100);

nit: You should do your best to correlate the sleeps with the timing parameters 
from the datasheet with a comment.

ie:
        /* T1: > 100ms */
        msleep(100);

> +
> +	ret = regulator_enable(ctx->avdd);
> +	if (ret)
> +		return ret;
> +
> +	msleep(20);
> +
> +	gpiod_set_value(ctx->reset, 1);
> +	msleep(50);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +	msleep(20);
> +
> +	gpiod_set_value(ctx->reset, 1);
> +	msleep(200);
> +
> +	for (i = 0; i < ARRAY_SIZE(feiyang_init_cmds); i++) {
> +		const struct feiyang_init_cmd *cmd =
> +						&feiyang_init_cmds[i];
> +
> +		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);

                ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
                                                FEIYANG_INIT_CMD_LEN);

> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int feiyang_enable(struct drm_panel *panel)
> +{
> +	struct feiyang *ctx = panel_to_feiyang(panel);
> +
> +	msleep(120);
> +
> +	mipi_dsi_dcs_set_display_on(ctx->dsi);
> +	backlight_enable(ctx->backlight);
> +
> +	return 0;
> +}
> +
> +static int feiyang_disable(struct drm_panel *panel)
> +{
> +	struct feiyang *ctx = panel_to_feiyang(panel);
> +
> +	backlight_disable(ctx->backlight);
> +	return mipi_dsi_dcs_set_display_on(ctx->dsi);

set_display_on? You probably want set_display_off here :)

> +}
> +
> +static int feiyang_unprepare(struct drm_panel *panel)
> +{
> +	struct feiyang *ctx = panel_to_feiyang(panel);
> +	int ret;
> +
> +	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
> +	if (ret < 0)
> +		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> +			      ret);
> +
> +	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +	if (ret < 0)
> +		DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
> +			      ret);
> +
> +	msleep(100);
> +
> +	regulator_disable(ctx->avdd);
> +
> +	regulator_disable(ctx->dvdd);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +
> +	gpiod_set_value(ctx->reset, 1);
> +
> +	gpiod_set_value(ctx->reset, 0);

Presumably this reset line toggle isn't needed since the rails are already
disabled?

> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode feiyang_default_mode = {
> +	.clock = 55000,
> +	.vrefresh = 60,

This doesn't add up correctly. The pixel clock should be equal to:

        (htotal * vtotal * vrefresh) / 1000

For this reason, we usually don't specify the refresh rate since it can be
misleading. Your actual refresh rate with the pixel clock you specified is
actually going to be 56.2Hz instead of the 60 you want.

If you can only generate a 55MHz pixel clock, consider reducing your blanking
periods so the calculation above matches.

> +
> +	.hdisplay = 1024,
> +	.hsync_start = 1024 + 396,
> +	.hsync_end = 1024 + 396 + 20,
> +	.htotal = 1024 + 396 + 20 + 100,
> +
> +	.vdisplay = 600,
> +	.vsync_start = 600 + 12,
> +	.vsync_end = 600 + 12 + 2,
> +	.vtotal = 600 + 12 + 2 + 21,
> +};
> +
> +static int feiyang_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_connector *connector = panel->connector;
> +	struct feiyang *ctx = panel_to_feiyang(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, &feiyang_default_mode);
> +	if (!mode) {
> +		DRM_DEV_ERROR(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> +			      feiyang_default_mode.hdisplay,
> +			      feiyang_default_mode.vdisplay,
> +			      feiyang_default_mode.vrefresh);
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;

Just set these above.

> +	drm_mode_probed_add(connector, mode);
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs feiyang_funcs = {
> +	.disable = feiyang_disable,
> +	.unprepare = feiyang_unprepare,
> +	.prepare = feiyang_prepare,
> +	.enable = feiyang_enable,
> +	.get_modes = feiyang_get_modes,
> +};
> +
> +static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device_node *np;
> +	struct feiyang *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +	ctx->dsi = dsi;
> +
> +	drm_panel_init(&ctx->panel);
> +	ctx->panel.dev = &dsi->dev;
> +	ctx->panel.funcs = &feiyang_funcs;
> +
> +	ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
> +	if (IS_ERR(ctx->dvdd)) {
> +		DRM_DEV_ERROR(&dsi->dev, "Couldn't get dvdd regulator\n");
> +		return PTR_ERR(ctx->dvdd);
> +	}
> +
> +	ctx->avdd = devm_regulator_get(&dsi->dev, "avdd");
> +	if (IS_ERR(ctx->avdd)) {
> +		DRM_DEV_ERROR(&dsi->dev, "Couldn't get avdd regulator\n");
> +		return PTR_ERR(ctx->avdd);
> +	}
> +
> +	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset)) {
> +		DRM_DEV_ERROR(&dsi->dev, "Couldn't get our reset GPIO\n");
> +		return PTR_ERR(ctx->reset);
> +	}
> +
> +	np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
> +	if (np) {
> +		ctx->backlight = of_find_backlight_by_node(np);
> +		of_node_put(np);
> +
> +		if (!ctx->backlight)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	ret = drm_panel_add(&ctx->panel);
> +	if (ret < 0)
> +		goto put_backlight;
> +
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->lanes = 4;
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0)
> +		goto panel_remove;
> +
> +	return ret;
> +
> +panel_remove:
> +	drm_panel_remove(&ctx->panel);
> +put_backlight:
> +	if (ctx->backlight)
> +		put_device(&ctx->backlight->dev);
> +
> +	return ret;
> +}
> +
> +static int feiyang_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct feiyang *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&ctx->panel);
> +
> +	if (ctx->backlight)
> +		put_device(&ctx->backlight->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id feiyang_of_match[] = {
> +	{ .compatible = "feiyang,fy07024di26a30d", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, feiyang_of_match);
> +
> +static struct mipi_dsi_driver feiyang_driver = {
> +	.probe = feiyang_dsi_probe,
> +	.remove = feiyang_dsi_remove,
> +	.driver = {
> +		.name = "feiyang-fy07024di26a30d",
> +		.of_match_table = feiyang_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(feiyang_driver);
> +
> +MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
> +MODULE_DESCRIPTION("Feiyang FY07024DI26A30-D MIPI-DSI LCD panel");
> +MODULE_LICENSE("GPL");
> -- 
> 2.18.0.321.gffc6fa0e3
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
