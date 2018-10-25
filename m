Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247CEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10FB20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j5Hs2mPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10FB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeJYTee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:34:34 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53280 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYTee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:34:34 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so1124430itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SrEHejOApHYwJ0m4n1YjfG9w4qNUXDuf0hH0pKMbhI=;
        b=j5Hs2mPkuEYl7yg9gzXy2SIO/IRp79MOqGcHnxi/PscSp6EE3QkZ5raxZThxXnkdfZ
         yJ7S9GbCt5DuqWWCgUOVjjtX6+RtUVnKBbdF7QuyEPy/BFVXn9+fye9VBDcU7ctW/EyN
         aF4TVZfj+5Dz1ZdM2qLKITFgX4c+WLUm5lUiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SrEHejOApHYwJ0m4n1YjfG9w4qNUXDuf0hH0pKMbhI=;
        b=QyexKH+oCzNCGfY83furKnxZ9KllZtk2jnQdtYVCAwwBfAyEzIojJWU+OChFUAZGQH
         UuMWZLJMD2tlihjvDc6KReLrTATkcg8M2T3DEa1eJcEgzINXy7ZxtZNzeCM+QaMTLNLV
         CyyTeVXAk6t6CGr7ASz3suCt/84qqFIh0xn6QyM4s+UARQRjubBXIoH1Kv5JNwFDfdRP
         eWqW3gKCSTqLYB5i1DSYLnTkYH3AI6WTRuT2eo+GKpyzJBWRZ/yzLsQfbZ93+g/rNM8E
         2jwR/tqmLgKGLDwhvh6W3ImB7odZrorRpVjE6i0viKQ7mCeJWB4gS+kuJGmVfs1T1E6z
         Rjaw==
X-Gm-Message-State: AGRZ1gIsEv9hzL5wLxw2PxAcb8srchMCj6vg1HpJ0FBICFZarfGVVGId
        CKUBNsnztLN0UIrn8A2S/vzPl7//EHYvKA7hQS/6Jg==
X-Google-Smtp-Source: AJdET5frjTBjwurvOX9mhd5JX2L6C+LvCGVzl/1dxlsuou3Gu/yi6KM/B1aMZ2HoZiiGn5xWmECJBWGEUHtd9t/vokA=
X-Received: by 2002:a24:9f82:: with SMTP id c124-v6mr610270ite.32.1540465337870;
 Thu, 25 Oct 2018 04:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-5-jagan@amarulasolutions.com> <20181024180632.zrb3lrqsznspmwbk@flea>
In-Reply-To: <20181024180632.zrb3lrqsznspmwbk@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 25 Oct 2018 16:32:06 +0530
Message-ID: <CAMty3ZDLd=vbYUut6Cwo9VKFR4T1u1p58FLg9vhN79JS1=0rag@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64
 MIPI DSI support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
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

On Wed, Oct 24, 2018 at 11:36 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Tue, Oct 23, 2018 at 09:20:24PM +0530, Jagan Teki wrote:
> > The MIPI DSI controller on Allwinner A64 is similar to
> > Allwinner A31 without support of DSI mod clock(CLK_DSI_SCLK)
> >
> > So, alter has_mod_clk bool via driver data for respective
> > SoC's compatible.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - none
> >
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 47 ++++++++++++++++++++------
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  5 +++
> >  2 files changed, 41 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index e3b34a345546..8e9c76febca2 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/component.h>
> >  #include <linux/crc-ccitt.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  #include <linux/reset.h>
> > @@ -981,6 +982,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >       dsi->host.ops = &sun6i_dsi_host_ops;
> >       dsi->host.dev = dev;
> >
> > +     dsi->variant = of_device_get_match_data(dev);
> > +
> >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >       base = devm_ioremap_resource(dev, res);
> >       if (IS_ERR(base)) {
> > @@ -1001,17 +1004,20 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >               return PTR_ERR(dsi->reset);
> >       }
> >
> > -     dsi->mod_clk = devm_clk_get(dev, "mod");
> > -     if (IS_ERR(dsi->mod_clk)) {
> > -             dev_err(dev, "Couldn't get the DSI mod clock\n");
> > -             return PTR_ERR(dsi->mod_clk);
> > +     if (dsi->variant->has_mod_clk) {
> > +             dsi->mod_clk = devm_clk_get(dev, "mod");
> > +             if (IS_ERR(dsi->mod_clk)) {
> > +                     dev_err(dev, "Couldn't get the DSI mod clock\n");
> > +                     return PTR_ERR(dsi->mod_clk);
> > +             }
> >       }
> >
> >       /*
> >        * In order to operate properly, that clock seems to be always
> >        * set to 297MHz.
> >        */
> > -     clk_set_rate_exclusive(dsi->mod_clk, 297000000);
> > +     if (dsi->variant->has_mod_clk)
> > +             clk_set_rate_exclusive(dsi->mod_clk, 297000000);
> >
> >       dphy_node = of_parse_phandle(dev->of_node, "phys", 0);
> >       ret = sun6i_dphy_probe(dsi, dphy_node);
> > @@ -1043,7 +1049,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >       pm_runtime_disable(dev);
> >       sun6i_dphy_remove(dsi);
> >  err_unprotect_clk:
> > -     clk_rate_exclusive_put(dsi->mod_clk);
> > +     if (dsi->variant->has_mod_clk)
> > +             clk_rate_exclusive_put(dsi->mod_clk);
> >       return ret;
> >  }
> >
> > @@ -1056,7 +1063,8 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
> >       mipi_dsi_host_unregister(&dsi->host);
> >       pm_runtime_disable(dev);
> >       sun6i_dphy_remove(dsi);
> > -     clk_rate_exclusive_put(dsi->mod_clk);
> > +     if (dsi->variant->has_mod_clk)
> > +             clk_rate_exclusive_put(dsi->mod_clk);
> >
> >       return 0;
> >  }
> > @@ -1066,7 +1074,8 @@ static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
> >       struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> >
> >       reset_control_deassert(dsi->reset);
> > -     clk_prepare_enable(dsi->mod_clk);
> > +     if (dsi->variant->has_mod_clk)
> > +             clk_prepare_enable(dsi->mod_clk);
> >
> >       /*
> >        * Enable the DSI block.
> > @@ -1094,7 +1103,8 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
> >  {
> >       struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> >
> > -     clk_disable_unprepare(dsi->mod_clk);
> > +     if (dsi->variant->has_mod_clk)
> > +             clk_disable_unprepare(dsi->mod_clk);
> >       reset_control_assert(dsi->reset);
> >
> >       return 0;
> > @@ -1106,9 +1116,24 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
> >                          NULL)
> >  };
> >
> > +static const struct sun6i_dsi_variant sun6i_a31_dsi = {
> > +     .has_mod_clk = true,
> > +};
> > +
> > +static const struct sun6i_dsi_variant sun50i_a64_dsi = {
> > +     .has_mod_clk = false,
>
> This is the default already.

True but we need to assign the .data. how about checking device
compatible? I'm thinking of difference in driver data in future
between SoC's

>
> > +};
> > +
> >  static const struct of_device_id sun6i_dsi_of_table[] = {
> > -     { .compatible = "allwinner,sun6i-a31-mipi-dsi" },
> > -     { }
> > +     {
> > +             .compatible = "allwinner,sun6i-a31-mipi-dsi",
> > +             .data = &sun6i_a31_dsi,
> > +     },
> > +     {
> > +             .compatible = "allwinner,sun50i-a64-mipi-dsi",
> > +             .data = &sun50i_a64_dsi,
> > +     },
> > +     { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > index dbbc5b3ecbda..597b62227019 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > @@ -20,6 +20,10 @@ struct sun6i_dphy {
> >       struct reset_control    *reset;
> >  };
> >
> > +struct sun6i_dsi_variant {
> > +     bool                    has_mod_clk;
> > +};
> > +
>
> This should be part of a separate patch.

How come, because has_mod_clk is using in driver file?
