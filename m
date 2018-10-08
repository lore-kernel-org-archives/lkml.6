Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3603C65C22
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698552087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698552087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJHSCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:02:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43441 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeJHSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:02:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so10509566eds.10;
        Mon, 08 Oct 2018 03:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sp1Rt77FbE0VElAV0LDzuDpOt6j+idfasg4Y/aRM7S0=;
        b=CMDq7R/SvgWQ3N2gIn/2vi9otq9O983CdvYDvz7CK6NpR0r2upZOPIDoKQMsXRW2fB
         uG2ghjP647tlfOcEIUQJX1Vp40Ww2yjpluoCLjv9BHfBS0cg6X+Nviulya0LjOSQ8NIy
         KHrYKL9KcfddvySdHmHBM7SoPRnPAPhYeQYEHtWG4eiozvhcDm65vn6qEUe8Hh4O4Krj
         I8FB6euZXqVNMkLinPnXO/qsfr64pD5/wsQgb335wp1eXODZFzKiCUazjQKHylfSDVWq
         uHk9A2hQEiARkkmRmb0QrXY8zqiLg5qWiDj5zmO+1g0gKWzI1TReeOLOqalHPFhQHSA7
         6Yiw==
X-Gm-Message-State: ABuFfoixVsQ1OIwB+IY4ZEgFu7VWFd0v4TfUaEaQm+PWKc90khqBOiWW
        hW6t52CP+Gd8Zyh4FEz2iCdf0xE0yH0=
X-Google-Smtp-Source: ACcGV63bRL2rl1VcFcrguZQeRMbJaeOAiRxsRCaoPeExsG5A0MKmIxzJjOW+f0bePgtNE1grUsfU6Q==
X-Received: by 2002:a17:906:70c3:: with SMTP id g3-v6mr22367610ejk.194.1538995857175;
        Mon, 08 Oct 2018 03:50:57 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id e38-v6sm5597250eda.67.2018.10.08.03.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 03:50:56 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 189-v6so7666881wmw.2;
        Mon, 08 Oct 2018 03:50:56 -0700 (PDT)
X-Received: by 2002:a1c:e717:: with SMTP id e23-v6mr4168295wmh.145.1538995856186;
 Mon, 08 Oct 2018 03:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-26-jernej.skrabec@siol.net> <20181008085112.mejpwvl3dpu7sopy@flea>
 <CAGb2v64avzzrGJeg2HU_Ze686C1nmVsNwXJGzsUbQvQTZKuSMw@mail.gmail.com> <20181008102021.ox34mqbw65euvsb4@flea>
In-Reply-To: <20181008102021.ox34mqbw65euvsb4@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 8 Oct 2018 18:50:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v65vG2sCMLOFSVAko+MUBDQa_A+qrMZLFe20QXJhApd1Gw@mail.gmail.com>
Message-ID: <CAGb2v65vG2sCMLOFSVAko+MUBDQa_A+qrMZLFe20QXJhApd1Gw@mail.gmail.com>
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

On Mon, Oct 8, 2018 at 6:20 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Oct 08, 2018 at 05:06:45PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Oct 8, 2018 at 4:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sun, Oct 07, 2018 at 11:39:01AM +0200, Jernej Skrabec wrote:
> > > > From: Icenowy Zheng <icenowy@aosc.io>
> > > >
> > > > Some SoCs, such as H6, doesn't have a full-featured TCON TOP.
> > > >
> > > > Add quirks support for TCON TOP.
> > > >
> > > > Currently the presence of TCON_TV1 and DSI is controlled via the quirks
> > > > structure.
> > > >
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++------
> > > >  1 file changed, 34 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > index 37158548b447..ed13233cad88 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > @@ -9,11 +9,17 @@
> > > >  #include <linux/component.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/of_device.h>
> > > >  #include <linux/of_graph.h>
> > > >  #include <linux/platform_device.h>
> > > >
> > > >  #include "sun8i_tcon_top.h"
> > > >
> > > > +struct sun8i_tcon_top_quirks {
> > > > +     bool has_tcon_tv1;
> > > > +     bool has_dsi;
> > > > +};
> > > > +
> > > >  static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
> > > >  {
> > > >       return !!of_match_node(sun8i_tcon_top_of_table, node);
> > > > @@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> > > >       struct platform_device *pdev = to_platform_device(dev);
> > > >       struct clk_hw_onecell_data *clk_data;
> > > >       struct sun8i_tcon_top *tcon_top;
> > > > +     const struct sun8i_tcon_top_quirks *quirks;
> > > >       struct resource *res;
> > > >       void __iomem *regs;
> > > >       int ret, i;
> > > >
> > > > +     quirks = of_device_get_match_data(&pdev->dev);
> > > > +
> > > >       tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> > > >       if (!tcon_top)
> > > >               return -ENOMEM;
> > > > @@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> > > >                                            &tcon_top->reg_lock,
> > > >                                            TCON_TOP_TCON_TV0_GATE, 0);
> > > >
> > > > -     clk_data->hws[CLK_TCON_TOP_TV1] =
> > > > -             sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > > > -                                          &tcon_top->reg_lock,
> > > > -                                          TCON_TOP_TCON_TV1_GATE, 1);
> > > > +     if (quirks->has_tcon_tv1) {
> > > > +             clk_data->hws[CLK_TCON_TOP_TV1] =
> > > > +                     sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > > > +                                                  &tcon_top->reg_lock,
> > > > +                                                  TCON_TOP_TCON_TV1_GATE, 1);
> > > > +     } else {
> > > > +             clk_data->hws[CLK_TCON_TOP_TV1] = NULL;
> > > > +     }
> > > >
> > > > -     clk_data->hws[CLK_TCON_TOP_DSI] =
> > > > -             sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > > > -                                          &tcon_top->reg_lock,
> > > > -                                          TCON_TOP_TCON_DSI_GATE, 2);
> > > > +     if (quirks->has_dsi) {
> > > > +             clk_data->hws[CLK_TCON_TOP_DSI] =
> > > > +                     sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > > > +                                                  &tcon_top->reg_lock,
> > > > +                                                  TCON_TOP_TCON_DSI_GATE, 2);
> > > > +     } else {
> > > > +             clk_data->hws[CLK_TCON_TOP_DSI] = NULL;
> > >
> > > clk_data has been kzalloc'd so its content is already NULL.
> > >
> > > And you shouldn't have brackets for single line blocks.
> > >
> > > with that fixed,
> >
> > FYI checkpatch.pl complains if you use brackets for the if block
> > but not for the else block. They should be matching.
>
> Checkpatch might not warn on this, but
> https://www.kernel.org/doc/Documentation/process/coding-style.rst,
> section 3 is pretty clear on whether we should use them or not.

Right. What I'm pointing out what checkpatch.pl complains about is
shown in the second last example in section 3:

    This does not apply if only one branch of a conditional statement
is a single
    statement; in the latter case use braces in both branches:

Which is where I think your comment on "shouldn't have brackets for
single line blocks"
is pointing in the opposite direction.

ChenYu
