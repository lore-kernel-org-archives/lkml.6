Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE7CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA66217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VSUGJOV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeLRLgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:36:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42046 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLRLgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:36:51 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so12487352ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 03:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwreEKzoORVE1yW1swYmyPH5HDCKPKva5qRcn2bhPkM=;
        b=VSUGJOV7FNJ4syUPL34QOXTKwhOhSMewPzo9D+JZOSt723AP2K8dD5/0WBsXLlQa8+
         Wg4c906+ed6T9pVZW36r995o1IZ36zMju4wKf6V4tIVhM44jac9R6hRfeBdOBWJem+Jf
         zoYC7hDq6CVcO3LQuWTEcmg9oyLeCbH5+AE9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwreEKzoORVE1yW1swYmyPH5HDCKPKva5qRcn2bhPkM=;
        b=Bqqq/G+3mMgXPcKVuElfTypzCWVj+YNXWumaf0HR+UMq5IwDb2WPmMmCXIuWqOzMz6
         Y0Qwz2ymju8AowXfHIIyYumMw48+6vu2Q2UTD1kMmKfD8RUEsoO6AU8CmkdvSNq6JcQu
         B5rj29sNUe/ArCUfuieDAav8MYIbAjvCbWeLpWqKbe5FaPoBQKv3peylwCSvWQAqvFOr
         nwDvNxutM7qp20dtagTLTrmKTgWwjmQQxhQAoekZFgUiQKNzwZ3nguHESMS182ZvF/C5
         nYB4k8ZqJ9Lg2sQi4Tv3hxMnWdqU3JEWxXAx4u/dl9cAQYTMXtqgs3n2mrm58SQgyXWu
         Qv8A==
X-Gm-Message-State: AA+aEWbcG9WLboVjTgQ6QZpJ+BICSEP3pXsf4gjYWgvMOVynSScc7RVS
        WwhnUsPmZJy7QlPp4azAjq0tMGv1CCfRkWMuEzPocg==
X-Google-Smtp-Source: AFSGD/VjLjb2HWnIqkb6VC0kr7dfMfeMUueMxF8iPD5HGaxf2aVpkp2uU2WBgVe3/ktKYIgo80bga1VgX9WBSgnsVdA=
X-Received: by 2002:a5e:c609:: with SMTP id f9mr13204599iok.114.1545133010241;
 Tue, 18 Dec 2018 03:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20181214204101.9681-1-jagan@amarulasolutions.com>
 <20181214204101.9681-2-jagan@amarulasolutions.com> <20181214220231.GT154160@art_vandelay>
In-Reply-To: <20181214220231.GT154160@art_vandelay>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 18 Dec 2018 17:06:38 +0530
Message-ID: <CAMty3ZBJGgwKCZSeWQmRRjnx3i5z_rV0GASdKLfjq+dSTGSkdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Sean Paul <sean@poorly.run>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 3:32 AM Sean Paul <sean@poorly.run> wrote:
>
> On Sat, Dec 15, 2018 at 02:11:01AM +0530, Jagan Teki wrote:
> > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> >
> > Add panel driver for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - use simple structure for command init
> > - update proper comments on power, reset delay sequnce
> > - fix to use set_display_off in disable function
> > - move mode type to structure
> > - drop refres rate value, let drm compute
> >
> >  MAINTAINERS                                   |   6 +
> >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 296 ++++++++++++++++++
> >  4 files changed, 312 insertions(+)
> >  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d2928a4d2847..e643238855ea 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4732,6 +4732,12 @@ T:     git git://anongit.freedesktop.org/drm/drm-misc
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
>
> As I mentioned on IRC, this will be drm-misc maintained with the other panels,
> no need to have a dedicated MAINTAINERS entry. You'll get pulled from
> get_maintainers.pl as a majority commit signer

This I missed it on IRC, sorry will drop.

>
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > index d93b2ba709bc..cb8ca93550cf 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -38,6 +38,15 @@ config DRM_PANEL_SIMPLE
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
> > index 6a9b4cec1891..0fa0ef69e109 100644
> > --- a/drivers/gpu/drm/panel/Makefile
> > +++ b/drivers/gpu/drm/panel/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
> >  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
> >  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> > +obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
> >  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
> >  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
> >  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
> > diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > new file mode 100644
> > index 000000000000..4abccbf62c3c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > @@ -0,0 +1,296 @@
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
> > +#define FEIYANG_INIT_CMD_LEN 2
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
> > +     u8 data[FEIYANG_INIT_CMD_LEN];
> > +};
> > +
> > +static const struct feiyang_init_cmd feiyang_init_cmds[] = {
> > +     { .data = { 0x80, 0x58 } },
> > +     { .data = { 0x81, 0x47 } },
> > +     { .data = { 0x82, 0xD4 } },
> > +     { .data = { 0x83, 0x88 } },
> > +     { .data = { 0x84, 0xA9 } },
> > +     { .data = { 0x85, 0xC3 } },
> > +     { .data = { 0x86, 0x82 } },
> > +};
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
> > +     /* T1 (dvdd start + dvdd rise) 0 < T1 <= 10ms */
> > +     msleep(10);
> > +
> > +     ret = regulator_enable(ctx->avdd);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* T3 (dvdd rise + avdd start + avdd rise) T3 >= 20ms */
> > +     msleep(20);
> > +
> > +     gpiod_set_value(ctx->reset, 1);
> > +     msleep(50);
> > +
> > +     gpiod_set_value(ctx->reset, 0);
> > +     /* T5 + T6 (avdd rise + video & logic signal rise)
> > +      * T5 >= 10ms, 0 < T6 <= 10ms
> > +      */
> > +     msleep(20);
> > +
> > +     gpiod_set_value(ctx->reset, 1);
> > +
> > +     /* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
> > +     msleep(200);
> > +
> > +     for (i = 0; i < ARRAY_SIZE(feiyang_init_cmds); i++) {
> > +             const struct feiyang_init_cmd *cmd =
> > +                                             &feiyang_init_cmds[i];
> > +
> > +             ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
> > +                                             FEIYANG_INIT_CMD_LEN);
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
> > +     /* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
> > +     msleep(200);
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
> > +     return mipi_dsi_dcs_set_display_off(ctx->dsi);
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
> > +     /* T13 (backlight fall + video & logic signal fall) T13 >= 200ms */
> > +     msleep(200);
> > +
> > +     gpiod_set_value(ctx->reset, 0);
> > +
> > +     gpiod_set_value(ctx->reset, 1);
> > +
> > +     gpiod_set_value(ctx->reset, 0);
> > +
> > +     regulator_disable(ctx->avdd);
> > +
> > +     /* T11 (dvdd rise to fall) 0 < T11 <= 10ms  */
> > +     msleep(10);
> > +
> > +     regulator_disable(ctx->dvdd);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct drm_display_mode feiyang_default_mode = {
> > +     .clock = 55000,
> > +
> > +     .hdisplay = 1024,
> > +     .hsync_start = 1024 + 396,
> > +     .hsync_end = 1024 + 396 + 20,
> > +     .htotal = 1024 + 396 + 20 + 100,
> > +
> > +     .vdisplay = 600,
> > +     .vsync_start = 600 + 12,
> > +     .vsync_end = 600 + 12 + 2,
> > +     .vtotal = 600 + 12 + 2 + 21,
>
> These timings are still incorrect, they'll give a 56.2Hz refresh rate. Is that
> really what you want?

I would like to go with same rate as of now since BSP is using the
same, since I don't have any information from chip vendor(even I wrote
it and waiting for response). I will update accordingly once I get the
information from vendor.

Let me know your inputs.
