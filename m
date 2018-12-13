Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07802C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9CC20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MsTv48d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9CC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeLMT0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:26:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36612 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLMT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:26:16 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so5662954itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6BK8gxs7/c5qHB/xAx5sSedZe35YsJEtBrR7XOfXrA=;
        b=MsTv48d68HkIQOrH510MRk6X+FlG4HJzL86fqs1QJcOm/bgtgxdsKEd+XDOmwgITs3
         9Ao51ljJyWbZMg81Kh4GYrQ6eHrPImvswAt1u66vDHgbHtRVZ/rW3MOeNL7B9fJJREFw
         ZQTEikrWpICwMLbP4zMPEeN0wG22ky4KABIBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6BK8gxs7/c5qHB/xAx5sSedZe35YsJEtBrR7XOfXrA=;
        b=pq3PBJH2qtr2XwFrFklbDh3DJzI0iTBvn50S5nSbnJb+W/P3+Jdn2CqLusORVvCZ4A
         vkit83RPf0dyh2+RXjlm7lJXTNkU59d/KB8vgOgAh2by3qE2uCDFYEExUDjUqQzSENOl
         gFOR0gLOToEGHRVifEUneSetMYJqKB9t9jj8y7fMi2b18EMUD4m15WRPNfVWxi/sIAJy
         aA+RReBsc+kZ2UThP6r1tEbzy3z15CxcC1RbgkzMh3IhXcubu/ci/bAVdiX0SSrgeyZA
         iyR7kTeGwSqbhzDRiz2h0qiHobNJVHYiwrQ0VF430lTqACWJh4r/t9LJ7VX54q7uHm0B
         zpqA==
X-Gm-Message-State: AA+aEWaxc1WSPH/a3Kistr97sMYj8FQgHvyd/f8K82o83upsK/PHkYFa
        tRdZohT3nB+Ugo5sw47xxgkMPA62PMHKJPSyZC7wrw==
X-Google-Smtp-Source: AFSGD/XmJxN+jnPyTNVIC4pdN8hDahNyNeQevslQntLro0uSBd4K7rc4GTk0xHBVgROFkprdm3iyQp4zxfi7qNkadSg=
X-Received: by 2002:a02:4d99:: with SMTP id t25mr67236jad.58.1544729174899;
 Thu, 13 Dec 2018 11:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-12-jagan@amarulasolutions.com> <20181213150736.GL154160@art_vandelay>
In-Reply-To: <20181213150736.GL154160@art_vandelay>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 14 Dec 2018 00:56:03 +0530
Message-ID: <CAMty3ZAv1dHCRCShXYbxqMm4wV9WGDpAKPji+3G21eWq34ODaA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Sean Paul <sean@poorly.run>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 8:37 PM Sean Paul <sean@poorly.run> wrote:
>
> On Fri, Nov 16, 2018 at 10:09:15PM +0530, Jagan Teki wrote:
> > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> >
> > Add panel driver for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  MAINTAINERS                                   |   6 +
> >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
> >  4 files changed, 302 insertions(+)
> >  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3dac08d0b3cb..40c8bfc974f4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4620,6 +4620,12 @@ T:     git git://anongit.freedesktop.org/drm/drm-misc
> >  S:   Maintained
> >  F:   drivers/gpu/drm/tve200/
> >
> > +DRM DRIVER FOR FEIYANG FY07024DI26A30-D MIPI-DSI LCD PANELS
> > +M:   Jagan Teki <jagan@amarulasolutions.com>
> > +S:   Maintained
> > +F:   drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > +F:   Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> > +
> >  DRM DRIVER FOR ILITEK ILI9225 PANELS
> >  M:   David Lechner <david@lechnology.com>
> >  S:   Maintained
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > index d0d4e60f5153..bc70896fe43c 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -47,6 +47,15 @@ config DRM_PANEL_SIMPLE
> >         that it can be automatically turned off when the panel goes into a
> >         low power state.
> >
> > +config DRM_PANEL_FEIYANG_FY07024DI26A30D
> > +     tristate "Feiyang FY07024DI26A30-D MIPI-DSI LCD panel"
> > +     depends on OF
> > +     depends on DRM_MIPI_DSI
> > +     depends on BACKLIGHT_CLASS_DEVICE
> > +     help
> > +       Say Y if you want to enable support for panels based on the
> > +       Feiyang FY07024DI26A30-D MIPI-DSI interface.
> > +
> >  config DRM_PANEL_ILITEK_IL9322
> >       tristate "Ilitek ILI9322 320x240 QVGA panels"
> >       depends on OF && SPI
> > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> > index 88011f06edb8..e23c017639c7 100644
> > --- a/drivers/gpu/drm/panel/Makefile
> > +++ b/drivers/gpu/drm/panel/Makefile
> > @@ -3,6 +3,7 @@ obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
> >  obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20_ICN6211) += panel-bananapi-s070wv20-icn6211.o
> >  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
> >  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> > +obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
> >  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
> >  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
> >  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
> > diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > new file mode 100644
> > index 000000000000..a4b46bd8fdbe
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > @@ -0,0 +1,286 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2018 Amarula Solutions
> > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > + */
> > +
> > +#include <linux/backlight.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include <drm/drmP.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_panel.h>
> > +
> > +struct feiyang {
> > +     struct drm_panel        panel;
> > +     struct mipi_dsi_device  *dsi;
> > +
> > +     struct backlight_device *backlight;
> > +     struct regulator        *dvdd;
> > +     struct regulator        *avdd;
> > +     struct gpio_desc        *reset;
> > +};
> > +
> > +static inline struct feiyang *panel_to_feiyang(struct drm_panel *panel)
> > +{
> > +     return container_of(panel, struct feiyang, panel);
> > +}
> > +
> > +struct feiyang_init_cmd {
> > +     size_t len;
> > +     const char *data;
> > +};
> > +
> > +#define FY07024DI26A30D(...) { \
> > +     .len = sizeof((char[]){__VA_ARGS__}), \
> > +     .data = (char[]){__VA_ARGS__} }
> > +
> > +static const struct feiyang_init_cmd feiyang_init_cmds[] = {
> > +     FY07024DI26A30D(0x80, 0x58),
> > +     FY07024DI26A30D(0x81, 0x47),
> > +     FY07024DI26A30D(0x82, 0xD4),
> > +     FY07024DI26A30D(0x83, 0x88),
> > +     FY07024DI26A30D(0x84, 0xA9),
> > +     FY07024DI26A30D(0x85, 0xC3),
> > +     FY07024DI26A30D(0x86, 0x82),
> > +};
>
> These init cmds don't have to be so complicated. You've only got len == 2, so
> just hardcode it in and avoid the macro:
>
> #define FEIYANG_INIT_CMD_LEN    2
>
> struct feiyang_init_cmd {
>         u8 data[FEIYANG_INIT_CMD];
> };
>
> static const struct feiyang_init_cmd feiyang_init_cmds[] = {
>         { .data = { 0x80, 0x58 } },
>         ...
> };
>
> > +
> > +static int feiyang_prepare(struct drm_panel *panel)
> > +{
> > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > +     struct mipi_dsi_device *dsi = ctx->dsi;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     ret = regulator_enable(ctx->dvdd);
> > +     if (ret)
> > +             return ret;
> > +
> > +     msleep(100);
>
> nit: You should do your best to correlate the sleeps with the timing parameters
> from the datasheet with a comment.
>
> ie:
>         /* T1: > 100ms */
>         msleep(100);

Sorry, what does this mean?

>
> > +
> > +     ret = regulator_enable(ctx->avdd);
> > +     if (ret)
> > +             return ret;
> > +
> > +     msleep(20);
> > +
> > +     gpiod_set_value(ctx->reset, 1);
> > +     msleep(50);
> > +
> > +     gpiod_set_value(ctx->reset, 0);
> > +     msleep(20);
> > +
> > +     gpiod_set_value(ctx->reset, 1);
> > +     msleep(200);
> > +
> > +     for (i = 0; i < ARRAY_SIZE(feiyang_init_cmds); i++) {
> > +             const struct feiyang_init_cmd *cmd =
> > +                                             &feiyang_init_cmds[i];
> > +
> > +             ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);
>
>                 ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
>                                                 FEIYANG_INIT_CMD_LEN);
>
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int feiyang_enable(struct drm_panel *panel)
> > +{
> > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > +
> > +     msleep(120);
> > +
> > +     mipi_dsi_dcs_set_display_on(ctx->dsi);
> > +     backlight_enable(ctx->backlight);
> > +
> > +     return 0;
> > +}
> > +
> > +static int feiyang_disable(struct drm_panel *panel)
> > +{
> > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > +
> > +     backlight_disable(ctx->backlight);
> > +     return mipi_dsi_dcs_set_display_on(ctx->dsi);
>
> set_display_on? You probably want set_display_off here :)
>
> > +}
> > +
> > +static int feiyang_unprepare(struct drm_panel *panel)
> > +{
> > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > +     int ret;
> > +
> > +     ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
> > +     if (ret < 0)
> > +             DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
> > +                           ret);
> > +
> > +     ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> > +     if (ret < 0)
> > +             DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
> > +                           ret);
> > +
> > +     msleep(100);
> > +
> > +     regulator_disable(ctx->avdd);
> > +
> > +     regulator_disable(ctx->dvdd);
> > +
> > +     gpiod_set_value(ctx->reset, 0);
> > +
> > +     gpiod_set_value(ctx->reset, 1);
> > +
> > +     gpiod_set_value(ctx->reset, 0);
>
> Presumably this reset line toggle isn't needed since the rails are already
> disabled?

Yes, rails need to reset and turn off. will swap.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct drm_display_mode feiyang_default_mode = {
> > +     .clock = 55000,
> > +     .vrefresh = 60,
>
> This doesn't add up correctly. The pixel clock should be equal to:
>
>         (htotal * vtotal * vrefresh) / 1000
>
> For this reason, we usually don't specify the refresh rate since it can be
> misleading. Your actual refresh rate with the pixel clock you specified is
> actually going to be 56.2Hz instead of the 60 you want.

The actual BSP do work 55MHz[1], I do specify refresh rate unnecessarily.

[1] https://gitlab.com/pine64-android/tools/blob/01b3d9388439106bdd9985cf738c1b876bd617d3/pack/chips/sun50iw1p1/configs/db1000_lcd/sys_config_rgmii.fex#L483
