Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CFEC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2166120869
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Lp6YDGyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2166120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeJ0SgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 14:36:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45027 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeJ0SgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 14:36:05 -0400
Received: by mail-io1-f66.google.com with SMTP id c6-v6so2204205iob.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpexUSayTnX5KkKYuqjH9FNRPWiQFHtkDwZ894g0iZ8=;
        b=Lp6YDGyT+Tki1lR5yS20AC+VwwwYP46Q0ZftJZJPKdmiGlnhMCch/Z6ET8olrrr76a
         RmdmRq4XzMl/WvrWU1ulV/9LL2tPFef021nY91Zl/54wz+hkHN3tcp0HrlgDHAdPXvZX
         gt2Cblz9m8/aPYsnwcVCk7gPl9eGj7y/FB5Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpexUSayTnX5KkKYuqjH9FNRPWiQFHtkDwZ894g0iZ8=;
        b=ga+QZns9fsR3NPzbPsaYruQbE1PzUNSflcjTf0cewfhL/uNansp4amq1XQ0Ry3MSTn
         WSTQ8oEOn8sF1s76U4i6p9oqwV+sKEBVs4J9DkidWDyyz8HtL7W5ywUdg2OSZ34ZT3rL
         f5yGhr+TKzemXp6ELeolX9xpnkEyF7lCISTgDGH/Q65tyCsGl5rS/AMfv3XvLfQt2IxP
         W1wq1OeXAk8iQCGmWlAsrJ/EhEP6qslH1Jd+A4PyO816f5BBWBw38yYoIWIf4QicWMik
         hDNVHB4X81u9RsOcJQi41QNNiF9C82TlDHxUf1KVm+5qPzVnsOw4/VnTuEKy3gcq3BW/
         jiEQ==
X-Gm-Message-State: AGRZ1gIP54+o6tCCLljXnGnmffkwoJ3n7Foeps02WOgsNMDgOHMoQhwH
        JFtmBYqowOqMUGuFoieBR1F77xOgCnO9YfamhIuAkg==
X-Google-Smtp-Source: AJdET5dxdiHy+8/fAHJvSP8BaH+jyKbRI+yYaJzV7Mz8DE2PYOIeRCv5dw82RPphh5wObdWjgywEqmgWiJWlUzx7w0w=
X-Received: by 2002:a6b:5101:: with SMTP id f1-v6mr3862947iob.114.1540634140337;
 Sat, 27 Oct 2018 02:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-21-jagan@amarulasolutions.com> <20181026161324.qbpcpkpwyixi7juk@plaes.org>
In-Reply-To: <20181026161324.qbpcpkpwyixi7juk@plaes.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 27 Oct 2018 15:25:29 +0530
Message-ID: <CAMty3ZDc84ErYB9LR_Y7OJtUOx+AAhTV1RwC7-Jr1Br8yN6hUw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 20/25] drm/panel: Add Techstar TS8550B
 MIPI-DSI LCD panel
To:     plaes@plaes.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 9:43 PM Priit Laes <plaes@plaes.org> wrote:
>
> On Fri, Oct 26, 2018 at 08:13:39PM +0530, Jagan Teki wrote:
> > Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI
> > LCD panel. Add panel driver for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3:
> > - new patch
> > Changes for v2:
> > - none
> >
> >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  .../gpu/drm/panel/panel-techstar-ts8550b.c    | 346 ++++++++++++++++++
> >  3 files changed, 356 insertions(+)
> >  create mode 100644 drivers/gpu/drm/panel/panel-techstar-ts8550b.c
> >
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > index 20b88c275421..d0d4e60f5153 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -195,4 +195,13 @@ config DRM_PANEL_SITRONIX_ST7789V
> >         Say Y here if you want to enable support for the Sitronix
> >         ST7789V controller for 240x320 LCD panels
> >
> > +config DRM_PANEL_TECHSTAR_TS8550B
> > +     tristate "Techstar TS8550B MIPI-DSI panel driver"
> > +     depends on OF
> > +     depends on DRM_MIPI_DSI
> > +     depends on BACKLIGHT_CLASS_DEVICE
> > +     help
> > +       Say Y if you want to enable support for panels based on the
> > +       Techstar TS8550B MIPI-DSI interface.
> > +
> >  endmenu
> > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> > index 04696bb85218..88011f06edb8 100644
> > --- a/drivers/gpu/drm/panel/Makefile
> > +++ b/drivers/gpu/drm/panel/Makefile
> > @@ -20,3 +20,4 @@ obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) += panel-seiko-43wvf1g.o
> >  obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
> >  obj-$(CONFIG_DRM_PANEL_SHARP_LS043T1LE01) += panel-sharp-ls043t1le01.o
> >  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
> > +obj-$(CONFIG_DRM_PANEL_TECHSTAR_TS8550B) += panel-techstar-ts8550b.o
> > diff --git a/drivers/gpu/drm/panel/panel-techstar-ts8550b.c b/drivers/gpu/drm/panel/panel-techstar-ts8550b.c
> > new file mode 100644
> > index 000000000000..8baca71595a7
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-techstar-ts8550b.c
> > @@ -0,0 +1,346 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2019, Amarula Solutions.
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
> > +#include <video/mipi_display.h>
> > +
> > +struct ts8550b {
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
> > +
> > +static inline struct ts8550b *panel_to_ts8550b(struct drm_panel *panel)
> > +{
> > +     return container_of(panel, struct ts8550b, panel);
> > +}
> > +
> > +static inline int ts8550b_dcs_write_seq(struct ts8550b *ctx, const void *seq,
> > +                                     size_t len)
> > +{
> > +     return mipi_dsi_dcs_write_buffer(ctx->dsi, seq, len);
> > +};
> > +
> > +#define ts8550b_dcs_write_seq_static(ctx, seq...)            \
> > +     ({                                                      \
> > +             static const u8 d[] = { seq };                  \
> > +             ts8550b_dcs_write_seq(ctx, d, ARRAY_SIZE(d));   \
> > +     })
> > +
> > +static void ts8550b_init_sequence(struct ts8550b *ctx)
>
> This seems to be pretty "standard" MIPI-based display, utilizing
> bunch of manufacturer-specific commands during init sequence.
>
> Standard MIPI commands fall between 0x00..0xAF and are defined in <video/mipi.h>

Where is this file? we have include/video/mipi_display.h with
0x00..0xA8. Not all commands in sequence is listed in this, may be I
will update DCS commands macros and rest as-it-is. what do you think?
