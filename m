Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B8C676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC9620693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC9620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJHUWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:22:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34853 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeJHUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:22:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id y19-v6so17560309edd.2;
        Mon, 08 Oct 2018 06:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChdR0eyazhaqraK1GSA1+fNLRFSww//guI3zW1QsW0Y=;
        b=USO1aFhSZU2Pw9QK5XOqhEoS+xpeYmST7QGJI1hkVE5AKcuLcMpn+B1F1XZ4AukZ2q
         NJqec5Rf8U9DlJgHbRSTk/uckW3N1x1DZWKNjbCd7dfgz3xSYF+b8jmA4EZNrpPXoEvY
         cfpSFdW0N3MfduVEDtfiQbmu2oOpYOubyjjssmeOwU/tD1/mZfIPnoiDZL28PkpL3ilN
         sWALlVJ3pdB7ElleYcmS4Vb3i9go8cSFnKN9UYGSQVY/LwIrLpeGVc53ABl488UqaIBM
         Q+LuQt2897uLBVgvmdrdoRrxs0H+ahpQxbYGj388T9dqMLOHuNGkISFlGh2/ttoZdDe+
         OVOg==
X-Gm-Message-State: ABuFfoipKt0yUn2jP1NbpozdUvbGzFn25Nw47rO5jeJu3tDYvI3vvPn2
        1mWzwSKEYYQ6gyH87K26cSb5ftXxqMQ=
X-Google-Smtp-Source: ACcGV62ezMKPADkoBTIpT6zoUJGnbj+JKfZ2l6cHCQc3lRsBxHHGMgNBogDqhEWw3UJ1n6VIVUUokw==
X-Received: by 2002:a50:d1d7:: with SMTP id i23-v6mr7472804edg.34.1539004269273;
        Mon, 08 Oct 2018 06:11:09 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id k4-v6sm3030106ejz.67.2018.10.08.06.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 06:11:08 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id y11-v6so5136085wma.3;
        Mon, 08 Oct 2018 06:11:07 -0700 (PDT)
X-Received: by 2002:a1c:e717:: with SMTP id e23-v6mr4555462wmh.145.1539004267255;
 Mon, 08 Oct 2018 06:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-26-jernej.skrabec@siol.net> <20181008085112.mejpwvl3dpu7sopy@flea>
 <CAGb2v64avzzrGJeg2HU_Ze686C1nmVsNwXJGzsUbQvQTZKuSMw@mail.gmail.com>
 <20181008102021.ox34mqbw65euvsb4@flea> <CAGb2v65vG2sCMLOFSVAko+MUBDQa_A+qrMZLFe20QXJhApd1Gw@mail.gmail.com>
 <20181008123313.sxqzulfuktslchhy@flea>
In-Reply-To: <20181008123313.sxqzulfuktslchhy@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 8 Oct 2018 21:10:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v64remLNFdX-FT2xcbcSSkeqmFEjQDEJLPQHiNMctcKTfQ@mail.gmail.com>
Message-ID: <CAGb2v64remLNFdX-FT2xcbcSSkeqmFEjQDEJLPQHiNMctcKTfQ@mail.gmail.com>
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

On Mon, Oct 8, 2018 at 8:33 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Oct 08, 2018 at 06:50:44PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Oct 8, 2018 at 6:20 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Oct 08, 2018 at 05:06:45PM +0800, Chen-Yu Tsai wrote:
> > > > On Mon, Oct 8, 2018 at 4:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Sun, Oct 07, 2018 at 11:39:01AM +0200, Jernej Skrabec wrote:
> > > > > > From: Icenowy Zheng <icenowy@aosc.io>
> > > > > >
> > > > > > Some SoCs, such as H6, doesn't have a full-featured TCON TOP.
> > > > > >
> > > > > > Add quirks support for TCON TOP.
> > > > > >
> > > > > > Currently the presence of TCON_TV1 and DSI is controlled via the quirks
> > > > > > structure.
> > > > > >
> > > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > > ---
> > > > > >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++------
> > > > > >  1 file changed, 34 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > index 37158548b447..ed13233cad88 100644
> > > > > > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > @@ -9,11 +9,17 @@
> > > > > >  #include <linux/component.h>
> > > > > >  #include <linux/device.h>
> > > > > >  #include <linux/module.h>
> > > > > > +#include <linux/of_device.h>
> > > > > >  #include <linux/of_graph.h>
> > > > > >  #include <linux/platform_device.h>
> > > > > >
> > > > > >  #include "sun8i_tcon_top.h"
> > > > > >
> > > > > > +struct sun8i_tcon_top_quirks {
> > > > > > +     bool has_tcon_tv1;
> > > > > > +     bool has_dsi;
> > > > > > +};
> > > > > > +
> > > > > >  static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
> > > > > >  {
> > > > > >       return !!of_match_node(sun8i_tcon_top_of_table, node);
> > > > > > @@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> > > > > >       struct platform_device *pdev = to_platform_device(dev);
> > > > > >       struct clk_hw_onecell_data *clk_data;
> > > > > >       struct sun8i_tcon_top *tcon_top;
> > > > > > +     const struct sun8i_tcon_top_quirks *quirks;
> > > > > >       struct resource *res;
> > > > > >       void __iomem *regs;
> > > > > >       int ret, i;
> > > > > >
> > > > > > +     quirks = of_device_get_match_data(&pdev->dev);
> > > > > > +
> > > > > >       tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> > > > > >       if (!tcon_top)
> > > > > >               return -ENOMEM;
> > > > > > @@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> > > > > >                                            &tcon_top->reg_lock,
> > > > > >                                            TCON_TOP_TCON_TV0_GATE, 0);
> > > > > >
> > > > > > -     clk_data->hws[CLK_TCON_TOP_TV1] =
> > > > > > -             sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > > > > > -                                          &tcon_top->reg_lock,
> > > > > > -                                          TCON_TOP_TCON_TV1_GATE, 1);
> > > > > > +     if (quirks->has_tcon_tv1) {
> > > > > > +             clk_data->hws[CLK_TCON_TOP_TV1] =
> > > > > > +                     sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > > > > > +                                                  &tcon_top->reg_lock,
> > > > > > +                                                  TCON_TOP_TCON_TV1_GATE, 1);
> > > > > > +     } else {
> > > > > > +             clk_data->hws[CLK_TCON_TOP_TV1] = NULL;
> > > > > > +     }
> > > > > >
> > > > > > -     clk_data->hws[CLK_TCON_TOP_DSI] =
> > > > > > -             sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > > > > > -                                          &tcon_top->reg_lock,
> > > > > > -                                          TCON_TOP_TCON_DSI_GATE, 2);
> > > > > > +     if (quirks->has_dsi) {
> > > > > > +             clk_data->hws[CLK_TCON_TOP_DSI] =
> > > > > > +                     sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > > > > > +                                                  &tcon_top->reg_lock,
> > > > > > +                                                  TCON_TOP_TCON_DSI_GATE, 2);
> > > > > > +     } else {
> > > > > > +             clk_data->hws[CLK_TCON_TOP_DSI] = NULL;
> > > > >
> > > > > clk_data has been kzalloc'd so its content is already NULL.
> > > > >
> > > > > And you shouldn't have brackets for single line blocks.
> > > > >
> > > > > with that fixed,
> > > >
> > > > FYI checkpatch.pl complains if you use brackets for the if block
> > > > but not for the else block. They should be matching.
> > >
> > > Checkpatch might not warn on this, but
> > > https://www.kernel.org/doc/Documentation/process/coding-style.rst,
> > > section 3 is pretty clear on whether we should use them or not.
> >
> > Right. What I'm pointing out what checkpatch.pl complains about is
> > shown in the second last example in section 3:
> >
> >     This does not apply if only one branch of a conditional statement
> > is a single
> >     statement; in the latter case use braces in both branches:
> >
> > Which is where I think your comment on "shouldn't have brackets for
> > single line blocks"
> > is pointing in the opposite direction.
>
> I think we have a communication failure :)
>
> The two blocks above are single line blocks, even though the line is
> wrapped. So whether or not there is an else condition or not doesn't
> matter, you shouldn't have braces at all.

Ah... It was a single line split wrapped to two lines...
Sorry for the noise.

ChenYu
