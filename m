Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506D5C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086FF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086FF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeILVWC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:22:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41138 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILVWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:22:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so2228669edd.8;
        Wed, 12 Sep 2018 09:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V9XlV0z7NBmUUXwuqfwjBRL0dE2cartuJgYivnoX3+E=;
        b=hGiqb/cK2nfcQqeK796DmslulUmpHqQuqNUG1MfwF1wGUKm8MeCjBA/4nQRV6+m+F1
         FM+LKL+HMdrRKjvb7H2gBN0UP3BkZF+lm5CSthpkifv/NJJCu8zgi40Aj8u1fqy0HS+L
         ucZSfTORyT0BrJqNyR/c2pik3MvqSP4xoA+rdL/Gp18tdfprrYIjP2DUTAHCBT2owaZp
         sBDj/Gig7PBrlyCSDtNsh7Mjrsn5jo8WHIRFJJ5LUgKv3E0rrI8tNbuYlg8nRX1LMLpf
         hnBuhxDfZBhJ2rlbv+SIsZQSfRvTTD3C09Dv8O0HtTsv8zZj+vmWvtZIS4ILEeoQGj1F
         Pa9w==
X-Gm-Message-State: APzg51CCbV5oA3FLDvZOgNWkeCWeSjkmQogIwJ4lKpyNUPuYyYrZe/M/
        +UGCZe9uIVz6s6PXtgR7XQs3jE82tlI=
X-Google-Smtp-Source: ANB0VdZKk/V7JyMuXy722EKRrLagprPvUQ+R9l4R61LF14sXMgduV4uLdKkJS502ThbnufGfcVgsGw==
X-Received: by 2002:a50:98a3:: with SMTP id j32-v6mr3633181edb.6.1536769005477;
        Wed, 12 Sep 2018 09:16:45 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id h24-v6sm802119edb.43.2018.09.12.09.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 09:16:44 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id z96-v6so2671209wrb.8;
        Wed, 12 Sep 2018 09:16:43 -0700 (PDT)
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr1933334wrl.26.1536769003578;
 Wed, 12 Sep 2018 09:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <1677668.BePkXd9qNa@jernej-laptop> <CAGb2v66kojjjM4f_tO9NwzkCzD3LMM2eiq+PJ6Bk=1Rra=UnYg@mail.gmail.com>
 <1702684.jtWEXlagAO@jernej-laptop>
In-Reply-To: <1702684.jtWEXlagAO@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 13 Sep 2018 00:16:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v652fPojGYE1nkAeEzFBcWjebi1zSnPGwm7zjPbE7ojD0Q@mail.gmail.com>
Message-ID: <CAGb2v652fPojGYE1nkAeEzFBcWjebi1zSnPGwm7zjPbE7ojD0Q@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 08/27] clk: sunxi-ng: Add support for H6
 DE3 clocks
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:55 PM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne sreda, 12. september 2018 ob 14:20:08 CEST je Chen-Yu Tsai napisal(a):
> > On Wed, Sep 5, 2018 at 1:46 AM Jernej Škrabec <jernej.skrabec@siol.net>
> wrote:
> > > Dne torek, 04. september 2018 ob 11:04:21 CEST je Chen-Yu Tsai napisal(a):
> > > > On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > wrote:
> > > > > Support for mixer0, mixer1, writeback and rotation units is added.
> > > > >
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > ---
> > > > >
> > > > >  drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 65
> > > > >  ++++++++++++++++++++++++++++
> > > > >  drivers/clk/sunxi-ng/ccu-sun8i-de2.h |  1 +
> > > > >  2 files changed, 66 insertions(+)
> > > > >
> > > > > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > > > > b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c index
> > > > > bae5ee67a797..4535c1c27d27
> > > > > 100644
> > > > > --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > > > > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > > > > @@ -31,6 +31,8 @@ static SUNXI_CCU_GATE(bus_mixer1_clk, "bus-mixer1",
> > > > > "bus-de",>
> > > > >
> > > > >                       0x04, BIT(1), 0);
> > > > >
> > > > >  static SUNXI_CCU_GATE(bus_wb_clk,      "bus-wb",       "bus-de",
> > > > >
> > > > >                       0x04, BIT(2), 0);
> > > > >
> > > > > +static SUNXI_CCU_GATE(bus_rot_clk,     "bus-rot",      "bus-de",
> > > > > +                     0x04, BIT(3), 0);
> > > > >
> > > > >  static SUNXI_CCU_GATE(mixer0_clk,      "mixer0",       "mixer0-div",
> > > > >
> > > > >                       0x00, BIT(0), CLK_SET_RATE_PARENT);
> > > > >
> > > > > @@ -38,6 +40,8 @@ static SUNXI_CCU_GATE(mixer1_clk,     "mixer1",
> > > > > "mixer1-div",>
> > > > >
> > > > >                       0x00, BIT(1), CLK_SET_RATE_PARENT);
> > > > >
> > > > >  static SUNXI_CCU_GATE(wb_clk,          "wb",           "wb-div",
> > > > >
> > > > >                       0x00, BIT(2), CLK_SET_RATE_PARENT);
> > > > >
> > > > > +static SUNXI_CCU_GATE(rot_clk,         "rot",          "rot-div",
> > > > > +                     0x00, BIT(3), CLK_SET_RATE_PARENT);
> > > > >
> > > > >  static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > > @@ -45,6 +49,8 @@ static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div",
> > > > > "de",
> > > > > 0x0c, 4, 4,>
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > >  static SUNXI_CCU_M(wb_div_clk, "wb-div", "de", 0x0c, 8, 4,
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > > +static SUNXI_CCU_M(rot_div_clk, "rot-div", "de", 0x0c, 0x0c, 4,
> > > > > +                  CLK_SET_RATE_PARENT);
> > > > >
> > > > >  static SUNXI_CCU_M(mixer0_div_a83_clk, "mixer0-div", "pll-de", 0x0c,
> > > > >  0,
> > > > >  4,
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > > @@ -53,6 +59,24 @@ static SUNXI_CCU_M(mixer1_div_a83_clk,
> > > > > "mixer1-div",
> > > > > "pll-de", 0x0c, 4, 4,>
> > > > >
> > > > >  static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
> > > > >
> > > > >                    CLK_SET_RATE_PARENT);
> > > > >
> > > > > +static struct ccu_common *sun50i_h6_de3_clks[] = {
> > > > > +       &mixer0_clk.common,
> > > > > +       &mixer1_clk.common,
> > > > > +       &wb_clk.common,
> > > > > +
> > > > > +       &bus_mixer0_clk.common,
> > > > > +       &bus_mixer1_clk.common,
> > > > > +       &bus_wb_clk.common,
> > > > > +
> > > > > +       &mixer0_div_clk.common,
> > > > > +       &mixer1_div_clk.common,
> > > > > +       &wb_div_clk.common,
> > > > > +
> > > > > +       &bus_rot_clk.common,
> > > > > +       &rot_clk.common,
> > > > > +       &rot_div_clk.common,
> > > > > +};
> > > > > +
> > > > >
> > > > >  static struct ccu_common *sun8i_a83t_de2_clks[] = {
> > > > >
> > > > >         &mixer0_clk.common,
> > > > >         &mixer1_clk.common,
> > > > >
> > > > > @@ -92,6 +116,26 @@ static struct ccu_common *sun8i_v3s_de2_clks[] = {
> > > > >
> > > > >         &wb_div_clk.common,
> > > > >
> > > > >  };
> > > > >
> > > > > +static struct clk_hw_onecell_data sun50i_h6_de3_hw_clks = {
> > > > > +       .hws    = {
> > > > > +               [CLK_MIXER0]            = &mixer0_clk.common.hw,
> > > > > +               [CLK_MIXER1]            = &mixer1_clk.common.hw,
> > > > > +               [CLK_WB]                = &wb_clk.common.hw,
> > > > > +               [CLK_ROT]               = &rot_clk.common.hw,
> > > > > +
> > > > > +               [CLK_BUS_MIXER0]        = &bus_mixer0_clk.common.hw,
> > > > > +               [CLK_BUS_MIXER1]        = &bus_mixer1_clk.common.hw,
> > > > > +               [CLK_BUS_WB]            = &bus_wb_clk.common.hw,
> > > > > +               [CLK_BUS_ROT]           = &bus_rot_clk.common.hw,
> > > > > +
> > > > > +               [CLK_MIXER0_DIV]        = &mixer0_div_clk.common.hw,
> > > > > +               [CLK_MIXER1_DIV]        = &mixer1_div_clk.common.hw,
> > > > > +               [CLK_WB_DIV]            = &wb_div_clk.common.hw,
> > > > > +               [CLK_ROT_DIV]           = &rot_div_clk.common.hw,
> > > > > +       },
> > > > > +       .num    = 12,
> > > >
> > > > It's best not to openly code these. It is error prone, like having
> > > > an index beyond .num, which then never gets registered.
> > > >
> > > > Instead, please update CLK_NUMBERS and use that instead.
> > > > sunxi_ccu_probe()
> > > > can handle holes in .hws.
> > >
> > > I'm not sure this will work. All newly introduced indices are at the end,
> > > so other arrays will still have same length (hole at the end). You will
> > > just claim that arrays are larger than they really are, which means bad
> > > things.
> > >
> > > But I take any other suggestion. I really can't think of better solution.
> >
> > Then maybe have macros for both cases instead?
> > CLK_NUMBER_WITH_ROT / CLK_NUMBER_WITHOUT_ROT?
>
> That sounds reasonable. Do you want separate patch which renames original
> macro CLK_NUMBER to CLK_NUMBER_WITHOUT_ROT?

I don't think that's necessary. Just mention the name change in the changelog,
and justifying it by the addition of the ROT clocks.

Thanks
