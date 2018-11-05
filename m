Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044D1204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cg5Kv1lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044D1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeKEQMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:12:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53111 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbeKEQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:12:09 -0500
Received: by mail-it1-f195.google.com with SMTP id t190-v6so5512843itb.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 22:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17pJt1nuNRD5uZz6VnucUyaNoPjfFMCqwRN7jufZ8Mc=;
        b=cg5Kv1lv3RLXh3d8qLeRRrZ02UUBGCPPQGrlgl1ttCvqHV3dfRFZDQPblxsAYygJcc
         JV0ZL5Tu2PMQSsOv7WyJOmokCNK3BJd8wpr47Af5UpFcyq/LWR0dTZcsHtFxCCaIe8u2
         EKP/FcTc5CvNeEeG0MDnphcpvO/u4ofEEDvBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17pJt1nuNRD5uZz6VnucUyaNoPjfFMCqwRN7jufZ8Mc=;
        b=g4T0Gtd1+QNXtHMCPOkdhXw7ImrlOVLtbSHrE+9LmXwEdEvrNoVsYoWEGEsIHakGtq
         1Ja2nF3tm59S7yjWPM9xoUF/IpdFSLLJTFKTD5IlJyJAy7rbu8HPoW0Ama929eGqwzMS
         KNOMccya6nT9J1kQgT5uo/DsFVclMpn9XAlgskTi92e5VnbEWQyZrfye0Vh4Kt31xb+6
         R/CdauxcB3Gh+KnB6GHm7arVjmUF5nh0ft5f+VJWVIQ4z/qwXRWdMJEBFUeUgTT1IvWh
         N58XipMJyWbvA1F/6Uw2qcC4RWJDDXHF/LxHkumvVy2pKSSGY8L9s7rK0Alap/o92sF/
         io0w==
X-Gm-Message-State: AGRZ1gJDDN6Q0bZ5CNMn/7xCnGFwipQlrKgthPpeo6c75V+HsWRKqBAZ
        mSEmnLPzOHdfElBBNrgDs67JQmtOnbV9u8s+3QEn6g==
X-Google-Smtp-Source: AJdET5dB06SpkCbf8NoPFeRFxQHlyNuqi5D0zDIGK5yBQJWDo3O9Q6C0IamuHXipGgxuMn0hRExR97xt8T8wnjhv5TA=
X-Received: by 2002:a24:9f82:: with SMTP id c124-v6mr5516471ite.32.1541400838267;
 Sun, 04 Nov 2018 22:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-10-jagan@amarulasolutions.com> <20181104204354.GA12651@ravnborg.org>
In-Reply-To: <20181104204354.GA12651@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 5 Nov 2018 12:23:46 +0530
Message-ID: <CAMty3ZDhg2w4_0byeLN6r811tdWUf2v3_LDx2nbDbnOye7fy+w@mail.gmail.com>
Subject: Re: [PATCH 09/10] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     sam@ravnborg.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
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
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 2:14 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Jagan.
>
> Reading through the driver triggered a few comments.
> Read and decide what is usefull.
>
>         Sam
>
> > Add panel driver for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Note: init sequence is referenced from
> > https://github.com/longsleep/linux-pine64/blob/pine64-hacks-1.2/drivers/video/sunxi/disp2/disp/lcd/mb709_mipi.c
>
> This note should perferably be part of the commit message or maybe included
> in the code so it is easie to track back.
>
>
> > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > +/*
> > + * Copyright (C) 2018 Amarula Solutions
> > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > + */
> > +
> > +#include <linux/backlight.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/fb.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_panel.h>
> > +
>
>
>
> > +#include <video/mipi_display.h>
>
> I cannot see this include is used anywhere in this .c file.
> The few MIPI_ constants originates from <drm/drm_mipi_dsi.h>
> and I think the include can be dropped.
>
> > +struct fy07024di26a30d {
> > +     struct drm_panel        panel;
> > +     struct mipi_dsi_device  *dsi;
> > +
> > +     struct backlight_device *backlight;
> > +     struct regulator        *dvdd;
> > +     struct regulator        *avdd;
> > +     struct gpio_desc        *reset;
> > +
> > +     bool                    is_enabled;
> > +     bool                    is_prepared;
> > +};
> Maybe bikeshedding a little here.
> But the use of names like fy07024di26a30d does not help readability.
> Just name it feiyang like for example we see in panel-innolux-p079zca.c
> where this drives is somehow inspired from. (Here the name is innolux).
>
>
>
> > +
> > +static inline struct fy07024di26a30d *panel_to_fy07024di26a30d(struct drm_panel *panel)
> > +{
> > +     return container_of(panel, struct fy07024di26a30d, panel);
> > +}
> > +
> > +struct fy07024di26a30d_init_cmd {
> > +     size_t len;
> > +     const char *data;
> > +};
> > +
> > +#define FY07024DI26A30D(...) { \
> > +     .len = sizeof((char[]){__VA_ARGS__}), \
> > +     .data = (char[]){__VA_ARGS__} }
> > +
> > +static const struct fy07024di26a30d_init_cmd fy07024di26a30d_init_cmds[] = {
> > +     FY07024DI26A30D(0x80, 0x58),
> > +     FY07024DI26A30D(0x81, 0x47),
> > +     FY07024DI26A30D(0x82, 0xD4),
> > +     FY07024DI26A30D(0x83, 0x88),
> > +     FY07024DI26A30D(0x84, 0xA9),
> > +     FY07024DI26A30D(0x85, 0xC3),
> > +     FY07024DI26A30D(0x86, 0x82),
> > +};
> > +
> > +static int fy07024di26a30d_prepare(struct drm_panel *panel)
> > +{
> > +     struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
> > +     struct mipi_dsi_device *dsi = ctx->dsi;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     if (ctx->is_prepared)
> > +             return 0;
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
> > +     for (i = 0; i < ARRAY_SIZE(fy07024di26a30d_init_cmds); i++) {
> > +             const struct fy07024di26a30d_init_cmd *cmd =
> > +                                             &fy07024di26a30d_init_cmds[i];
> > +
> > +             ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     ret = mipi_dsi_dcs_set_display_on(dsi);
> > +     if (ret < 0) {
> > +             dev_err(panel->dev, "failed to set display on: %d\n", ret);
> > +             return ret;
> > +     }
> General comment.
> Consider using DRM_DEV_ERROR(...) to be consistent with
> what is used in many other drm drivers.
>
>
> > +static int fy07024di26a30d_enable(struct drm_panel *panel)
> > +{
> > +     struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
> > +
> > +     if (ctx->is_enabled)
> > +             return 0;
> > +
> > +     msleep(120);
> This msleep() looks unjustified, as no other statement preceed it.
> If prepare() requires a delay then maybe the delay should be there?

I will use mipi_dsi_dcs_set_display_on in enable and this can be
proper place other than prepare, since after prepare enable is the
caller.

>
> > +
> > +static int fy07024di26a30d_unprepare(struct drm_panel *panel)
> > +{
> > +     struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
> > +     int ret;
> > +
> > +     if (!ctx->is_prepared)
> > +             return 0;
> > +
> > +     ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
> > +     if (ret < 0)
> > +             dev_err(panel->dev, "failed to set display off: %d\n", ret);
> > +
> > +     ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> > +     if (ret < 0)
> > +             dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
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
> In prepare() there are dealys around asserting reset and releasing again.
> Consider using a small helper function and be consistent with the
> delays.

Do you think exit calls also need delays?

>
> > +
> > +     ctx->is_prepared = false;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct drm_display_mode fy07024di26a30d_default_mode = {
> > +     .clock = 55000,
> > +     .vrefresh = 60,
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
> > +};
> Consider to assign .flags - if for nothign else then to document
> the default values.
> Many panels have started to do so in panel-simple.c for instance.

I don't see .flags handle is done via bsp driver or with dts, ie
reason I didn't use it.

>
> This is also a proper place to specify the width_mm and height_mm,
> so the physical size is available.
> Assuming this is known.

Correct, I saw these active width, height is mentioned in datasheet.
but the BSP tested dts simply initialized to 0 so I'm not using it.
[2]

>
> > +
> > +static int fy07024di26a30d_get_modes(struct drm_panel *panel)
> > +{
> > +     struct drm_connector *connector = panel->connector;
> > +     struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
> > +     struct drm_display_mode *mode;
> > +
> > +     mode = drm_mode_duplicate(panel->drm, &fy07024di26a30d_default_mode);
> > +     if (!mode) {
> > +             dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> > +                     fy07024di26a30d_default_mode.hdisplay,
> > +                     fy07024di26a30d_default_mode.vdisplay,
> > +                     fy07024di26a30d_default_mode.vrefresh);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     drm_mode_set_name(mode);
> > +
> > +     mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> > +     drm_mode_probed_add(connector, mode);
> > +
> > +     return 1;
> > +}
> > +
> > +static const struct drm_panel_funcs fy07024di26a30d_funcs = {
> > +     .disable = fy07024di26a30d_disable,
> > +     .unprepare = fy07024di26a30d_unprepare,
> > +     .prepare = fy07024di26a30d_prepare,
> > +     .enable = fy07024di26a30d_enable,
> > +     .get_modes = fy07024di26a30d_get_modes,
> > +};
> > +
> > +static int fy07024di26a30d_dsi_probe(struct mipi_dsi_device *dsi)
> > +{
> > +     struct device_node *np;
> > +     struct fy07024di26a30d *ctx;
> > +     int ret;
> > +
> > +     ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
> > +     if (!ctx)
> > +             return -ENOMEM;
> > +     mipi_dsi_set_drvdata(dsi, ctx);
> > +     ctx->dsi = dsi;
> > +
> > +     drm_panel_init(&ctx->panel);
> > +     ctx->panel.dev = &dsi->dev;
> > +     ctx->panel.funcs = &fy07024di26a30d_funcs;
> > +
> > +     ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
> > +     if (IS_ERR(ctx->dvdd)) {
> > +             dev_err(&dsi->dev, "Couldn't get dvdd regulator\n");
> > +             return PTR_ERR(ctx->dvdd);
> > +     }
> > +
> > +     ctx->avdd = devm_regulator_get(&dsi->dev, "avdd");
> > +     if (IS_ERR(ctx->avdd)) {
> > +             dev_err(&dsi->dev, "Couldn't get avdd regulator\n");
> > +             return PTR_ERR(ctx->avdd);
> > +     }
> > +
> > +     ret = regulator_enable(ctx->dvdd);
> > +     if (ret)
> > +             return ret;
> > +
> > +     msleep(100);
> > +
> > +     ret = regulator_enable(ctx->avdd);
> > +     if (ret)
> > +             return ret;
> > +
> > +     msleep(5);
> The regulators are only enabled in the probe function.
> But disabled in the unprepare() function.
>
> Looking at other drivers is seems that the common way is
> to enable these in prepare() and disable these in unprepare().
> Any particular reason the regulators are enabled in probe()?
> Maybe something to do with backlight?
> If so, then please put a comment.
> Also consider if there is somethign missing, as the panel cannot
> be used anymore after an unpreare()

Yes, ie true with many panels resides in mainline. but this panel is
enabling regulators separately wrt reset. not done in inline. But it
still work for me if I enable regulators in prepare, but not sure does
it may any issues.

>
>
> > +
> > +     ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> > +     if (IS_ERR(ctx->reset)) {
> > +             dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
> > +             return PTR_ERR(ctx->reset);
> > +     }
> > +
> > +     np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
> > +     if (np) {
> > +             ctx->backlight = of_find_backlight_by_node(np);
> > +             of_node_put(np);
> > +
> > +             if (!ctx->backlight)
> > +                     return -EPROBE_DEFER;
> > +     }
> > +
> > +     ret = drm_panel_add(&ctx->panel);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST;
> > +     dsi->format = MIPI_DSI_FMT_RGB888;
> > +     dsi->lanes = 4;
> > +
> > +     return mipi_dsi_attach(dsi);
> Several drivers undo the drm_panel_add() if mipi_dsi_attach() fails.
> I dunno if this is correct and when it may fail.

Yes it should be drm_panel_remove for fail case, will take care.

>
>
> > +MODULE_DESCRIPTION("Feiyang FY07024DI26A30-D MIPI-DSI LCD panel");
>
> > +MODULE_LICENSE("GPL v2");
> The SPDX tag mentioned MIT - so the above may not be correct.

Correct, "GPL V2+ MIT" is fine?

[2] https://github.com/armbian/build/blob/master/packages/blobs/sunxi/a64/pine64so.dts#L2182
