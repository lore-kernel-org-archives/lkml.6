Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2526BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC77420870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Zi4WFuQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfALDpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 22:45:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53522 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfALDpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 22:45:00 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so5902253ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 19:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhMsL8ZyihkUVDFc7jsyZArEjDp5+UUza9RLP8RGvMs=;
        b=Zi4WFuQ25635WjJn65+UVazimbrsqmREiDjKjfFdF50LkcyeKdCqBStPp71ha2fBwl
         jqkNX2Tu2WgUtbul/uwjLcTxon8upykErtL0pslpmSUlyeRE+AhR/mCc23utXGgbfkJW
         HRUW5Z2BnR0mfPM6zRxB9v5uxaUHfcxkFpuHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhMsL8ZyihkUVDFc7jsyZArEjDp5+UUza9RLP8RGvMs=;
        b=DpcAwRckucFBS83e8JW/VOjHGgjUtT+roJIvjK+MEs4TBZh5Rg+KiQA2T2ZUZZxapT
         6HeKWRK9DBLJt52TBZ9Zu7jKc+MbT32EXNNJYd/iyKUmL1qVjiuJdqSYc06x/6/0AhUx
         rtVUJiURRnpJYz3MMEA/UfunuM62aVY5xyccxGF6V58xLv4r4cIsAPD9PcQ71PjTJkxS
         pD7vm+N9Kwn5fWvYYDc78sXn+IZlRbu7OYwSDFzxknQTvxR81ykMDKq9OcC3GLXIS1u1
         la6DqVyEmBuJ+fShInobgwLY7JV7V88nFowRbJdgg6r4PlmNRNv3nsiNaXno7Q4kJdyM
         XBvA==
X-Gm-Message-State: AJcUukc6zHJCh3axy8YpZmNWrKszfDyoYMt6x2MNKhAockr4vGG70P6u
        9CbCmJ+wembo8BZ/Ksje8UGxYQG3I42S0MZd8fB9KQ==
X-Google-Smtp-Source: ALg8bN6rjedcBv3tMO4/CklVgZJA9yc0/Qz7Z0/dNFfXQb6g0w+kWOOBOIDiGfVYy0lEkP4K2XY3qfXvkbDW7wwatk4=
X-Received: by 2002:a24:5411:: with SMTP id t17mr2776663ita.32.1547264696578;
 Fri, 11 Jan 2019 19:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com> <20190111211931.GA29735@ravnborg.org>
In-Reply-To: <20190111211931.GA29735@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 12 Jan 2019 09:14:44 +0530
Message-ID: <CAMty3ZArGPf8+M5GVhkzoMDhtYwT3aUS9bNbKt8=gqeb6-b82Q@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 2:49 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Jagan.
>
> Gave this another more detailed read - triggered some additional comments.
> Depite the comments it looks good, and this is all more or
> less cosmetic improvements.

Thanks for the review.

>
>         Sam
>
> > +struct st7701_panel_desc {
> > +     const struct drm_display_mode *mode;
> > +     unsigned int lanes;
> > +     unsigned long flags;
> > +     enum mipi_dsi_pixel_format format;
> > +     const char *const *supply_names;
> > +     unsigned int num_supplies;
> > +     unsigned int panel_sleep_delay;
> > +};
> > +
> > +struct st7701 {
> > +     struct drm_panel panel;
> > +     struct mipi_dsi_device *dsi;
> > +     const struct st7701_panel_desc *desc;
> > +
> > +     struct backlight_device *backlight;
> > +     struct regulator_bulk_data *supplies;
> > +     unsigned int num_supplies;
> I cannot see that num_supplies in this struct are used?

Yes it is used in the code, please check in struct st7701_panel_desc.

>
>
> > +     struct gpio_desc *reset;
> > +     unsigned int sleep_delay;
> > +};
> > +
> > +static inline struct st7701 *panel_to_st7701(struct drm_panel *panel)
> > +{
> > +     return container_of(panel, struct st7701, panel);
> > +}
> > +
> > +static inline int st7701_dsi_write(struct st7701 *st7701, const void *seq,
> > +                                size_t len)
> > +{
> > +     return mipi_dsi_dcs_write_buffer(st7701->dsi, seq, len);
> > +}
> > +
>
>
> > +static int st7701_prepare(struct drm_panel *panel)
> > +{
> > +     struct st7701 *st7701 = panel_to_st7701(panel);
> > +     int ret;
> > +
> > +     gpiod_set_value(st7701->reset, 0);
> > +     msleep(20);
> > +
> > +     ret = regulator_bulk_enable(st7701->desc->num_supplies,
> > +                                 st7701->supplies);
> > +     if (ret < 0)
> > +             return ret;
> > +     msleep(20);
> > +
> > +     gpiod_set_value(st7701->reset, 1);
> > +     msleep(20);
> > +
> > +     gpiod_set_value(st7701->reset, 0);
> > +     msleep(30);
> > +
> > +     gpiod_set_value(st7701->reset, 1);
> > +     msleep(150);
> > +
> > +     st7701_init_sequence(st7701);
> > +
> > +     return 0;
> > +}
> > +
>
> > +static int st7701_unprepare(struct drm_panel *panel)
> > +{
> > +     struct st7701 *st7701 = panel_to_st7701(panel);
> > +
> > +     ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
> > +
> > +     msleep(st7701->sleep_delay);
> > +
> > +     gpiod_set_value(st7701->reset, 0);
> > +
> > +     gpiod_set_value(st7701->reset, 1);
> > +
> > +     gpiod_set_value(st7701->reset, 0);
> No timing constrains here? In prepare there are sleeps intermixed.

Delay while doing unprare is not needed I suppose.

>
> > +
> > +     regulator_bulk_disable(st7701->desc->num_supplies, st7701->supplies);
> > +
> > +     return 0;
> > +}
> > +
> > +static int st7701_get_modes(struct drm_panel *panel)
> > +{
> > +     struct st7701 *st7701 = panel_to_st7701(panel);
> > +     const struct drm_display_mode *desc_mode = st7701->desc->mode;
> > +     struct drm_display_mode *mode;
> > +
> > +     mode = drm_mode_duplicate(panel->drm, desc_mode);
> > +     if (!mode) {
> > +             dev_err(&st7701->dsi->dev, "failed to add mode %ux%ux@%u\n",
> > +                     desc_mode->hdisplay, desc_mode->vdisplay,
> > +                     desc_mode->vrefresh);
> Use something like:
>                 DRM_DEV_ERROR(st7701->dev, "failed to add mode" DRM_MODE_FMT ",
>                               DRM_MODE_ARG(desc_mode));
>
> > +             return -ENOMEM;
> > +     }
> > +
> > +     drm_mode_set_name(mode);
> > +     drm_mode_probed_add(panel->connector, mode);
> > +
> > +     panel->connector->display_info.width_mm = desc_mode->width_mm;
> > +     panel->connector->display_info.height_mm = desc_mode->height_mm;
> > +
> > +     return 1;
> > +}
> > +
>
> > +static const struct st7701_panel_desc ts8550b_desc = {
> > +     .mode = &ts8550b_mode,
> > +     .lanes = 2,
> > +     .flags = MIPI_DSI_MODE_VIDEO,
> > +     .format = MIPI_DSI_FMT_RGB888,
> > +     .supply_names = ts8550b_supply_names,
> > +     .num_supplies = ARRAY_SIZE(ts8550b_supply_names),
> > +     .panel_sleep_delay = 80, /* panel need extra 80ms for sleep out cmd */
> In the only place this is used there is added 120 ms too.
> Looks inconsistent - do we have the same delay twice?

120ms is the one recommended by st7701 controller delay after a sleep
out command, please check it in datasheet [1], page 188. And this 80ms
is specific to TS8550B panel as per BSP code this doesn't have proper
documentation but the BSP code doing this extra 80ms.

>
>
> > +
> > +static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
> > +{
> > +     const struct st7701_panel_desc *desc;
> > +     struct device_node *np;
> > +     struct st7701 *st7701;
> > +     int ret, i;
> > +
> > +     st7701 = devm_kzalloc(&dsi->dev, sizeof(*st7701), GFP_KERNEL);
> > +     if (!st7701)
> > +             return -ENOMEM;
> > +
> > +     desc = of_device_get_match_data(&dsi->dev);
> > +     dsi->mode_flags = desc->flags;
> > +     dsi->format = desc->format;
> > +     dsi->lanes = desc->lanes;
> > +
> > +     st7701->supplies = devm_kcalloc(&dsi->dev, desc->num_supplies,
> > +                                     sizeof(*st7701->supplies),
> > +                                     GFP_KERNEL);
> > +     if (!st7701->supplies)
> > +             return -ENOMEM;
> > +
> > +     for (i = 0; i < desc->num_supplies; i++)
> > +             st7701->supplies[i].supply = desc->supply_names[i];
> > +
> > +     ret = devm_regulator_bulk_get(&dsi->dev, desc->num_supplies,
> > +                                   st7701->supplies);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     st7701->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> > +     if (IS_ERR(st7701->reset)) {
> > +             dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
> > +             return PTR_ERR(st7701->reset);
> > +     }
> > +
> > +     np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
> > +     if (np) {
> > +             st7701->backlight = of_find_backlight_by_node(np);
> > +             of_node_put(np);
> > +
> > +             if (!st7701->backlight)
> > +                     return -EPROBE_DEFER;
> > +     }
> This is a simpler variant of the above:
>         st7701->backlight = devm_of_find_backlight(dsi->dev);
>         if (IS_ERR(st7701->backlight))
>                 return PTR_ERR(st7701->backlight);
>
> Suggested by Noralf in another thread for a similar driver.
>
>
> > +
> > +     drm_panel_init(&st7701->panel);
> > +
> > +     /* We need to wait 120ms after a sleep out command */
> > +     st7701->sleep_delay = 120 + desc->panel_sleep_delay;
> This is the other place where we add 120 to the previous 80 - in total 200 ms.

Please see above comment.

[1] http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf
