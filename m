Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE90EC65BD1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9963B2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJHQRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:17:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41407 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJHQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:17:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id x31-v6so2171864edd.8;
        Mon, 08 Oct 2018 02:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gguj1MpZ/l5xX7qyDCUSgmY0EJhQt06bbNgw4pYYSrQ=;
        b=LOYPd2NGB/simUMM01bDeYxHmakC4iLGEEvEAoS+4tbT1wy6h3HE15yHQtNg2VION9
         IM2lNqNRmGeTc6eSP27/sQ9DaDDxrG9mC9lsEwkUe5NElcwr4Crae36cw5pEmJjPrB9r
         E0YYec7wgVCiTuVbnFYfasbCDKcaqR7Un05k+1iDpxoOYZfUHy9n1ORgJvwrEupHFg51
         FnSZjaFMe7OsFpQXiyng5eMM151MEDe0p95bdOjhrSLh/cYiB61aWiwMAwFilmDtv5n5
         EKyneny0IF9RB8kzF2O9KKnXqXRS3sVqw44RWkiRvZ1BjcFH3HayyP1pdjnca1rxuZL8
         sE1w==
X-Gm-Message-State: ABuFfoi/b4PXyS2sssiyjexfBJiGwfEb/01RD50O2bbFuBIMbcBFvgBb
        ETFgYNJa0hWxFOvF6xH4ORc2Eezma1s=
X-Google-Smtp-Source: ACcGV615v+DOYWs5rF2b8H9PiLkuJZz2UhpuR5YwmfH9jAzCldN0v1pdv7l5Sh4Te7FO0xYYvmTXig==
X-Received: by 2002:a17:906:b857:: with SMTP id ga23-v6mr22586404ejb.222.1538989620139;
        Mon, 08 Oct 2018 02:07:00 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id z33-v6sm5477553edb.85.2018.10.08.02.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 02:06:58 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id z4-v6so19915986wrb.1;
        Mon, 08 Oct 2018 02:06:58 -0700 (PDT)
X-Received: by 2002:a5d:480b:: with SMTP id l11-v6mr9735968wrq.28.1538989618105;
 Mon, 08 Oct 2018 02:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-26-jernej.skrabec@siol.net> <20181008085112.mejpwvl3dpu7sopy@flea>
In-Reply-To: <20181008085112.mejpwvl3dpu7sopy@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 8 Oct 2018 17:06:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64avzzrGJeg2HU_Ze686C1nmVsNwXJGzsUbQvQTZKuSMw@mail.gmail.com>
Message-ID: <CAGb2v64avzzrGJeg2HU_Ze686C1nmVsNwXJGzsUbQvQTZKuSMw@mail.gmail.com>
Subject: Re: [PATCH v2 25/29] drm: sun4i: add quirks for TCON TOP
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 4:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Oct 07, 2018 at 11:39:01AM +0200, Jernej Skrabec wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> >
> > Some SoCs, such as H6, doesn't have a full-featured TCON TOP.
> >
> > Add quirks support for TCON TOP.
> >
> > Currently the presence of TCON_TV1 and DSI is controlled via the quirks
> > structure.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++------
> >  1 file changed, 34 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > index 37158548b447..ed13233cad88 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > @@ -9,11 +9,17 @@
> >  #include <linux/component.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include <linux/of_device.h>
> >  #include <linux/of_graph.h>
> >  #include <linux/platform_device.h>
> >
> >  #include "sun8i_tcon_top.h"
> >
> > +struct sun8i_tcon_top_quirks {
> > +     bool has_tcon_tv1;
> > +     bool has_dsi;
> > +};
> > +
> >  static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
> >  {
> >       return !!of_match_node(sun8i_tcon_top_of_table, node);
> > @@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> >       struct platform_device *pdev = to_platform_device(dev);
> >       struct clk_hw_onecell_data *clk_data;
> >       struct sun8i_tcon_top *tcon_top;
> > +     const struct sun8i_tcon_top_quirks *quirks;
> >       struct resource *res;
> >       void __iomem *regs;
> >       int ret, i;
> >
> > +     quirks = of_device_get_match_data(&pdev->dev);
> > +
> >       tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> >       if (!tcon_top)
> >               return -ENOMEM;
> > @@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> >                                            &tcon_top->reg_lock,
> >                                            TCON_TOP_TCON_TV0_GATE, 0);
> >
> > -     clk_data->hws[CLK_TCON_TOP_TV1] =
> > -             sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > -                                          &tcon_top->reg_lock,
> > -                                          TCON_TOP_TCON_TV1_GATE, 1);
> > +     if (quirks->has_tcon_tv1) {
> > +             clk_data->hws[CLK_TCON_TOP_TV1] =
> > +                     sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > +                                                  &tcon_top->reg_lock,
> > +                                                  TCON_TOP_TCON_TV1_GATE, 1);
> > +     } else {
> > +             clk_data->hws[CLK_TCON_TOP_TV1] = NULL;
> > +     }
> >
> > -     clk_data->hws[CLK_TCON_TOP_DSI] =
> > -             sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > -                                          &tcon_top->reg_lock,
> > -                                          TCON_TOP_TCON_DSI_GATE, 2);
> > +     if (quirks->has_dsi) {
> > +             clk_data->hws[CLK_TCON_TOP_DSI] =
> > +                     sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > +                                                  &tcon_top->reg_lock,
> > +                                                  TCON_TOP_TCON_DSI_GATE, 2);
> > +     } else {
> > +             clk_data->hws[CLK_TCON_TOP_DSI] = NULL;
>
> clk_data has been kzalloc'd so its content is already NULL.
>
> And you shouldn't have brackets for single line blocks.
>
> with that fixed,

FYI checkpatch.pl complains if you use brackets for the if block
but not for the else block. They should be matching.

ChenYu

> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
