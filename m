Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67367C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A805216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A805216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeI1KyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 06:54:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38453 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeI1KyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 06:54:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id x8-v6so6977317eds.5;
        Thu, 27 Sep 2018 21:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmNqEhp1gNmQgux+Pdwa8veitys4OPZY99QZ8S0pTI4=;
        b=O9H29Jp7ydOuriA7yuthH/KNa5Db3fsQGVzCOwZaskpPLwlmTAe+PXZ1wZ8C6LU2l9
         xWdSVh/HmYmBdJUcOZFMotRGMrG+xE6wMm4bffaiUtAQn30N5aHW+WxUuXrkLVtUqeTh
         vVEBqiV/cs7H0l7gm3BTa5lj0Ydm2yDvccmEdNp2+yGDsvTCU4X4WKaEpRwWnfnEaiJQ
         ABn8fY4eaZsKThE50Lw1svPUEBlbXc3t3nZXrz7lyoK9c5hywr9epOmeuNBfQK5HQecS
         MH9/riwRT/UnQX6Cbc32uUfXYhREAXk/Vehj/eBjFXvVvuWHDT1i15zsAww+AglIPfug
         fKpw==
X-Gm-Message-State: ABuFfognCaLHdl91+ZUGE41U8XYHp7j9y/ETOlrDYI33sOZK5c5RgIzb
        Tb5knz1wTlEKGOFcEP97hPPF0pwPFy8=
X-Google-Smtp-Source: ACcGV62R2yPscB7I0PKF4n9BhO+RVq4ErY3JafHV5L95fi7Jxy2tjSG33pZng/azdNpYl2jYSZsevg==
X-Received: by 2002:a17:906:c2d0:: with SMTP id ch16-v6mr590051ejb.188.1538109137634;
        Thu, 27 Sep 2018 21:32:17 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id g20-v6sm1530744edm.36.2018.09.27.21.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 21:32:16 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id f10-v6so4855014wrs.0;
        Thu, 27 Sep 2018 21:32:15 -0700 (PDT)
X-Received: by 2002:adf:a646:: with SMTP id k64-v6mr10741582wrc.41.1538109135297;
 Thu, 27 Sep 2018 21:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com> <20180927114850.24565-11-jagan@amarulasolutions.com>
In-Reply-To: <20180927114850.24565-11-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 28 Sep 2018 12:32:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v67+TmDn-MT5-LE1dwRA0vYSJNJBZEA7pi8wi-Cyy-Lp2w@mail.gmail.com>
Message-ID: <CAGb2v67+TmDn-MT5-LE1dwRA0vYSJNJBZEA7pi8wi-Cyy-Lp2w@mail.gmail.com>
Subject: Re: [PATCH 10/12] drm/panel: Add Bananapi S070WV20-CT16 MIPI-DSI
 panel driver
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 7:50 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel which
> can be used to connect via BPI-M64 board, so add a driver for it.
>
> The same panel PCB comes with parallel RBG which is supported via
> panel-simple driver with "bananapi,s070wv20-ct16" compatible.

As I mentioned before, this PCB uses a ICN6211 MIPI-DSI to RGB bridge.
Please model it as such.

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-bananapi-s070wv20.c   | 336 ++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20.c
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 6020c30a33b3..d25960a63b10 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -17,6 +17,15 @@ config DRM_PANEL_ARM_VERSATILE
>           reference designs. The panel is detected using special registers
>           in the Versatile family syscon registers.
>
> +config DRM_PANEL_BANANAPI_S070WV20
> +       tristate "Bananapi S070WV20-CT16 MIPI-DSI panel driver"
> +       depends on OF
> +       depends on DRM_MIPI_DSI
> +       depends on BACKLIGHT_CLASS_DEVICE
> +       help
> +         Say Y if you want to enable support for panels based on the
> +         Bananapi S070WV20-CT16 MIPI-DSI controller.
> +
>  config DRM_PANEL_LVDS
>         tristate "Generic LVDS panel driver"
>         depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 5ccaaa9d13af..345b6475d3a4 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
> +obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20) += panel-bananapi-s070wv20.o
>  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
>  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
> diff --git a/drivers/gpu/drm/panel/panel-bananapi-s070wv20.c b/drivers/gpu/drm/panel/panel-bananapi-s070wv20.c
> new file mode 100644
> index 000000000000..6c9adbec6dd8
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-bananapi-s070wv20.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2018 Amarula Solutions
> + * Author: Jagan Teki <jagan@amarulasolutions.com>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/fb.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct s070wv20 {
> +       struct drm_panel        panel;
> +       struct mipi_dsi_device  *dsi;
> +
> +       struct backlight_device *backlight;
> +       struct regulator        *dvdd;
> +       struct regulator        *avdd;
> +       struct gpio_desc        *reset;
> +
> +       bool                    is_enabled;
> +       bool                    is_prepared;
> +};
> +
> +static inline struct s070wv20 *panel_to_s070wv20(struct drm_panel *panel)
> +{
> +       return container_of(panel, struct s070wv20, panel);
> +}
> +
> +struct s070wv20_init_cmd {
> +       size_t len;
> +       const char *data;
> +};
> +
> +#define S070WV20_INIT_CMD(...) { \
> +       .len = sizeof((char[]){__VA_ARGS__}), \
> +       .data = (char[]){__VA_ARGS__} }
> +

Using the timings from below, and comparing with

   https://shiminblog.github.io/mipi-to-rgb-lcd/

> +static const struct s070wv20_init_cmd s070wv20_init_cmds[] = {
> +       S070WV20_INIT_CMD(0x7A, 0xC1),

> +       S070WV20_INIT_CMD(0x20, 0x20),

This is likely the lower 8 bits of .hdisplay.

> +       S070WV20_INIT_CMD(0x21, 0xE0),

Lower 8 bits of .vdisplay

> +       S070WV20_INIT_CMD(0x22, 0x13),

Might be ((.hdisplay >> 8) & 0xf | (.vdisplay >> 8) & 0xf) << 4).

> +       S070WV20_INIT_CMD(0x23, 0x28),

HFP, or horizontal front porch. 40 in this case.

> +       S070WV20_INIT_CMD(0x24, 0x30),

HSYNC, or horizontal sync pulse length. 48 in this case.

> +       S070WV20_INIT_CMD(0x25, 0x28),

HBP, or horizontal back porch. 40 in this case.

> +       S070WV20_INIT_CMD(0x26, 0x00),

Unknown. Possibly RGB phase shift?

> +       S070WV20_INIT_CMD(0x27, 0x0D),

VFP, or vertical front porch. 13 in this case.

> +       S070WV20_INIT_CMD(0x28, 0x03),

This might be VSYNC, judging from the grouping. 3 in this case.

> +       S070WV20_INIT_CMD(0x29, 0x1D),

VBP, or vertical back porch. 29 in this case.

> +       S070WV20_INIT_CMD(0x34, 0x80),
> +       S070WV20_INIT_CMD(0x36, 0x28),
> +       S070WV20_INIT_CMD(0xB5, 0xA0),
> +       S070WV20_INIT_CMD(0x5C, 0xFF),
> +       S070WV20_INIT_CMD(0x2A, 0x01),
> +       S070WV20_INIT_CMD(0x56, 0x92),
> +       S070WV20_INIT_CMD(0x6B, 0x71),
> +       S070WV20_INIT_CMD(0x69, 0x2B),
> +       S070WV20_INIT_CMD(0x10, 0x40),
> +       S070WV20_INIT_CMD(0x11, 0x98),

This might be related to number of MIPI lanes. I saw 0x88 for 2-lane devices.

> +       S070WV20_INIT_CMD(0xB6, 0x20),
> +       S070WV20_INIT_CMD(0x51, 0x20),
> +       S070WV20_INIT_CMD(0x09, 0x10),

The last three seem standardized across all ICN6211 drivers I could
find on github.

Other drivers / init sequences I found:

https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15

https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
matches timings for
https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20

https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169

I also reached out to Bananapi to see if they have more information on
this chip.

ChenYu

> +};
> +
> +static int s070wv20_prepare(struct drm_panel *panel)
> +{
> +       struct s070wv20 *ctx = panel_to_s070wv20(panel);
> +       struct mipi_dsi_device *dsi = ctx->dsi;
> +       unsigned int i;
> +       int ret;
> +
> +       if (ctx->is_prepared)
> +               return 0;
> +
> +       msleep(50);
> +
> +       gpiod_set_value(ctx->reset, 1);
> +       msleep(50);
> +
> +       gpiod_set_value(ctx->reset, 0);
> +       msleep(50);
> +
> +       gpiod_set_value(ctx->reset, 1);
> +       msleep(20);
> +
> +       ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +       if (ret < 0) {
> +               dev_err(panel->dev, "failed to exit sleep mode: %d\n", ret);
> +               return ret;
> +       }
> +
> +       msleep(120);
> +
> +       for (i = 0; i < ARRAY_SIZE(s070wv20_init_cmds); i++) {
> +               const struct s070wv20_init_cmd *cmd = &s070wv20_init_cmds[i];
> +
> +               ret = mipi_dsi_generic_write(dsi, cmd->data, cmd->len);
> +               if (ret < 0)
> +                       return ret;
> +
> +               msleep(10);
> +       }
> +
> +       ret = mipi_dsi_dcs_set_display_on(dsi);
> +       if (ret < 0) {
> +               dev_err(panel->dev, "failed to set display on: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ctx->is_prepared = true;
> +
> +       return 0;
> +}
> +
> +static int s070wv20_enable(struct drm_panel *panel)
> +{
> +       struct s070wv20 *ctx = panel_to_s070wv20(panel);
> +
> +       if (ctx->is_enabled)
> +               return 0;
> +
> +       msleep(120);
> +
> +       backlight_enable(ctx->backlight);
> +       ctx->is_enabled = true;
> +
> +       return 0;
> +}
> +
> +static int s070wv20_disable(struct drm_panel *panel)
> +{
> +       struct s070wv20 *ctx = panel_to_s070wv20(panel);
> +
> +       if (!ctx->is_enabled)
> +               return 0;
> +
> +       backlight_disable(ctx->backlight);
> +       ctx->is_enabled = false;
> +
> +       return 0;
> +}
> +
> +static int s070wv20_unprepare(struct drm_panel *panel)
> +{
> +       struct s070wv20 *ctx = panel_to_s070wv20(panel);
> +       int ret;
> +
> +       if (!ctx->is_prepared)
> +               return 0;
> +
> +       ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
> +       if (ret < 0)
> +               dev_err(panel->dev, "failed to set display off: %d\n", ret);
> +
> +       ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +       if (ret < 0)
> +               dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
> +
> +       msleep(100);
> +
> +       regulator_disable(ctx->avdd);
> +
> +       regulator_disable(ctx->dvdd);
> +
> +       gpiod_set_value(ctx->reset, 0);
> +
> +       gpiod_set_value(ctx->reset, 1);
> +
> +       gpiod_set_value(ctx->reset, 0);
> +
> +       ctx->is_prepared = false;
> +
> +       return 0;
> +}
> +
> +static const struct drm_display_mode s070wv20_default_mode = {
> +       .clock = 30000,
> +       .vrefresh = 60,
> +
> +       .hdisplay = 800,
> +       .hsync_start = 800 + 40,
> +       .hsync_end = 800 + 40 + 48,
> +       .htotal = 800 + 40 + 48 + 40,
> +
> +       .vdisplay = 480,
> +       .vsync_start = 480 + 13,
> +       .vsync_end = 480 + 13 + 3,
> +       .vtotal = 480 + 13 + 3 + 29,
> +};
> +
> +static int s070wv20_get_modes(struct drm_panel *panel)
> +{
> +       struct drm_connector *connector = panel->connector;
> +       struct s070wv20 *ctx = panel_to_s070wv20(panel);
> +       struct drm_display_mode *mode;
> +
> +       mode = drm_mode_duplicate(panel->drm, &s070wv20_default_mode);
> +       if (!mode) {
> +               dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> +                       s070wv20_default_mode.hdisplay,
> +                       s070wv20_default_mode.vdisplay,
> +                       s070wv20_default_mode.vrefresh);
> +               return -ENOMEM;
> +       }
> +
> +       drm_mode_set_name(mode);
> +
> +       mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +       drm_mode_probed_add(connector, mode);
> +
> +       panel->connector->display_info.width_mm = 86;
> +       panel->connector->display_info.height_mm = 154;
> +
> +       return 1;
> +}
> +
> +static const struct drm_panel_funcs s070wv20_funcs = {
> +       .disable = s070wv20_disable,
> +       .unprepare = s070wv20_unprepare,
> +       .prepare = s070wv20_prepare,
> +       .enable = s070wv20_enable,
> +       .get_modes = s070wv20_get_modes,
> +};
> +
> +static int s070wv20_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +       struct device_node *np;
> +       struct s070wv20 *ctx;
> +       int ret;
> +
> +       ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +       mipi_dsi_set_drvdata(dsi, ctx);
> +       ctx->dsi = dsi;
> +
> +       drm_panel_init(&ctx->panel);
> +       ctx->panel.dev = &dsi->dev;
> +       ctx->panel.funcs = &s070wv20_funcs;
> +
> +       ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
> +       if (IS_ERR(ctx->dvdd)) {
> +               dev_err(&dsi->dev, "Couldn't get dvdd regulator\n");
> +               return PTR_ERR(ctx->dvdd);
> +       }
> +
> +       ctx->avdd = devm_regulator_get(&dsi->dev, "avdd");
> +       if (IS_ERR(ctx->avdd)) {
> +               dev_err(&dsi->dev, "Couldn't get avdd regulator\n");
> +               return PTR_ERR(ctx->avdd);
> +       }
> +
> +       ret = regulator_enable(ctx->dvdd);
> +       if (ret)
> +               return ret;
> +
> +       msleep(5);
> +
> +       ret = regulator_enable(ctx->avdd);
> +       if (ret)
> +               return ret;
> +
> +       msleep(5);
> +
> +       ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> +       if (IS_ERR(ctx->reset)) {
> +               dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
> +               return PTR_ERR(ctx->reset);
> +       }
> +
> +       np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
> +       if (np) {
> +               ctx->backlight = of_find_backlight_by_node(np);
> +               of_node_put(np);
> +
> +               if (!ctx->backlight)
> +                       return -EPROBE_DEFER;
> +       }
> +
> +       ret = drm_panel_add(&ctx->panel);
> +       if (ret < 0)
> +               return ret;
> +
> +       dsi->mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> +       dsi->format = MIPI_DSI_FMT_RGB888;
> +       dsi->lanes = 4;
> +
> +       return mipi_dsi_attach(dsi);
> +}
> +
> +static int s070wv20_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +       struct s070wv20 *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +       mipi_dsi_detach(dsi);
> +       drm_panel_remove(&ctx->panel);
> +
> +       if (ctx->backlight)
> +               put_device(&ctx->backlight->dev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id s070wv20_of_match[] = {
> +       { .compatible = "bananapi,s070wv20-ct16-dsi", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, s070wv20_of_match);
> +
> +static struct mipi_dsi_driver s070wv20_driver = {
> +       .probe = s070wv20_dsi_probe,
> +       .remove = s070wv20_dsi_remove,
> +       .driver = {
> +               .name = "bananapi-s070wv20-ct16-dsi",
> +               .of_match_table = s070wv20_of_match,
> +       },
> +};
> +module_mipi_dsi_driver(s070wv20_driver);
> +
> +MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
> +MODULE_DESCRIPTION("Bananapi S070WV20-CT16 MIPI-DSI");
> +MODULE_LICENSE("GPL v2");
> --
> 2.18.0.321.gffc6fa0e3
>
