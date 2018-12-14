Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34245C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1BE2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="BwW9oq0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbeLNWCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:02:34 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41764 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbeLNWCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:02:34 -0500
Received: by mail-yb1-f195.google.com with SMTP id e124so2872922ybb.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VDNMoI7ouqRt5OU94ihsVsDh8DJdXXNSp/aKtw0zGw8=;
        b=BwW9oq0QA9N7ytag15D7UOZTgzVvmHLhsvGz5yNfcspm22sOYa4go/PD3pqmIWGf0M
         Mcg1p5QoX0tfvPaPrUXNE2kJ0OwUv69ZX8TzoTCEkOZKbbm11JIGZqA/dUVdHyPb3Ujo
         m/TUcB3HtQWUzosIY8XGIyjxxDFykgE3LCtDtdD7Ma17O2r6p2PR6Y5ERMDH4gl7ShxJ
         6eQZNw12HRqFidi9O8BRcZoImWFxdxYVkyYwgTS5Obi9AlsK7Ar71Frs9SHTAXtRo98V
         n14pZ/cl2RIYdZo9xBvfKfkIV5F6PscNepQGe6HYrHD6DEXstuizwLV73QZ2dqRJGNgV
         U/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VDNMoI7ouqRt5OU94ihsVsDh8DJdXXNSp/aKtw0zGw8=;
        b=EW6kNlPYrzJyXsv8ioezcZZfWQ5NOfj/bc6nx7usOzLFcerpilRzt8Ab7e32p9pviS
         Jfsw7Cj6M170OhN7o73NvDnjE+bVNZO4joqLPg2rHxRw7B1byH2tFfteRPqk+6daJwQX
         KSt4QOPKYtAblcQNO4iehmDgIFl9sk61Oeoba4GumvbFwiDYZlNx6S+EID+F8YwNpgCP
         aOgkRmE7tsmf+FPpZH4Xo0C/w6kuB1v75Z2N29pfdd1kBzdkx9AOXrL2yqFX0vDnxxu/
         IceYK6v2moEN2GOL0+dYuC/nI/4/bNqgUniWL6BYtTvqC7PRBs5JJPcSmkwEstOk23Aw
         9yoQ==
X-Gm-Message-State: AA+aEWafRMfchL83bNCvDzMburS8Qw39mpfTEtYmxyWPPBeKaZJf992e
        AhdczgpZERFySxhjTvi5TPNS9A==
X-Google-Smtp-Source: AFSGD/WZR4CZv5i6cedytYj56EWYdcbqxyh8bbFbalytQKygW0VpjQWCbelLk97c6vaYiQhLPvuTBg==
X-Received: by 2002:a25:aa10:: with SMTP id s16mr4949914ybi.327.1544824952543;
        Fri, 14 Dec 2018 14:02:32 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id e189sm1849309ywc.101.2018.12.14.14.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 14:02:31 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:02:31 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
Message-ID: <20181214220231.GT154160@art_vandelay>
References: <20181214204101.9681-1-jagan@amarulasolutions.com>
 <20181214204101.9681-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214204101.9681-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 02:11:01AM +0530, Jagan Teki wrote:
> Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> 
> Add panel driver for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - use simple structure for command init
> - update proper comments on power, reset delay sequnce
> - fix to use set_display_off in disable function
> - move mode type to structure
> - drop refres rate value, let drm compute
> 
>  MAINTAINERS                                   |   6 +
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 296 ++++++++++++++++++
>  4 files changed, 312 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d2928a4d2847..e643238855ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4732,6 +4732,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
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

As I mentioned on IRC, this will be drm-misc maintained with the other panels,
no need to have a dedicated MAINTAINERS entry. You'll get pulled from
get_maintainers.pl as a majority commit signer

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index d93b2ba709bc..cb8ca93550cf 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -38,6 +38,15 @@ config DRM_PANEL_SIMPLE
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
> index 6a9b4cec1891..0fa0ef69e109 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
>  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
>  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> +obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
> diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> new file mode 100644
> index 000000000000..4abccbf62c3c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> @@ -0,0 +1,296 @@
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
> +#define FEIYANG_INIT_CMD_LEN	2
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
> +	u8 data[FEIYANG_INIT_CMD_LEN];
> +};
> +
> +static const struct feiyang_init_cmd feiyang_init_cmds[] = {
> +	{ .data = { 0x80, 0x58 } },
> +	{ .data = { 0x81, 0x47 } },
> +	{ .data = { 0x82, 0xD4 } },
> +	{ .data = { 0x83, 0x88 } },
> +	{ .data = { 0x84, 0xA9 } },
> +	{ .data = { 0x85, 0xC3 } },
> +	{ .data = { 0x86, 0x82 } },
> +};
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
> +	/* T1 (dvdd start + dvdd rise) 0 < T1 <= 10ms */
> +	msleep(10);
> +
> +	ret = regulator_enable(ctx->avdd);
> +	if (ret)
> +		return ret;
> +
> +	/* T3 (dvdd rise + avdd start + avdd rise) T3 >= 20ms */
> +	msleep(20);
> +
> +	gpiod_set_value(ctx->reset, 1);
> +	msleep(50);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +	/* T5 + T6 (avdd rise + video & logic signal rise)
> +	 * T5 >= 10ms, 0 < T6 <= 10ms
> +	 */
> +	msleep(20);
> +
> +	gpiod_set_value(ctx->reset, 1);
> +
> +	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
> +	msleep(200);
> +
> +	for (i = 0; i < ARRAY_SIZE(feiyang_init_cmds); i++) {
> +		const struct feiyang_init_cmd *cmd =
> +						&feiyang_init_cmds[i];
> +
> +		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
> +						FEIYANG_INIT_CMD_LEN);
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
> +	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
> +	msleep(200);
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
> +	return mipi_dsi_dcs_set_display_off(ctx->dsi);
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
> +	/* T13 (backlight fall + video & logic signal fall) T13 >= 200ms */
> +	msleep(200);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +
> +	gpiod_set_value(ctx->reset, 1);
> +
> +	gpiod_set_value(ctx->reset, 0);
> +
> +	regulator_disable(ctx->avdd);
> +
> +	/* T11 (dvdd rise to fall) 0 < T11 <= 10ms  */
> +	msleep(10);
> +
> +	regulator_disable(ctx->dvdd);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode feiyang_default_mode = {
> +	.clock = 55000,
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

These timings are still incorrect, they'll give a 56.2Hz refresh rate. Is that
really what you want?

> +
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
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
