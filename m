Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF154C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DE420839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DE420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeILRYo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:24:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35944 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeILRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:24:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so1605353edq.3;
        Wed, 12 Sep 2018 05:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xJMV5CS8CQ+clIdKxJJms7c9G3SDY/Xjh6xYSYgDwFE=;
        b=lh1kKfQuE8Ejpu5MfLaruOUWulAXBWxIGWKHHY8J8a1zPe4oJgPjSNGCMdGoGKHgJ3
         Ka2UdkcCJeI2Kl4swW/lLdScNH+etyZ5MP/a22AP29Fs+Sl+95bDYHVmA5BmNgKxD/Ok
         MePeecEaZO5VbCOBNGNuBhZq9LdJimH8AlERWjIXLK8GpB1aS8P7ez1AbuoBZxoqtfEe
         66+WB7ttM1wK+zA2PJAB8466F1Zrk4P2AcX+ddgguiVd7vehI5HWvuhmDjUeK9Jc/Ht3
         ql0jc/iiWSilcbuZ9Y9bU0fOpmXTE77uztDAiLzS7HdMMHATHoy0KXQ3MS0HdhS2F2qc
         FfQg==
X-Gm-Message-State: APzg51BVZAhiitnNN72WtWENoN9h/n/7Z/uKH3QCVexAKXEu9M9RKkvT
        FM014KGaciZMo/+w0J/ftyaEXIzXtEo=
X-Google-Smtp-Source: ANB0VdaR0k9XfRPWeJv03LPj/0S5e5MfggRD2iD1tHtplWqVbx+C1P2JWOKgIcE4L2kY5y1HRwgQ4w==
X-Received: by 2002:a50:95a8:: with SMTP id w37-v6mr2531872eda.33.1536754825008;
        Wed, 12 Sep 2018 05:20:25 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id f7-v6sm723439edd.6.2018.09.12.05.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 05:20:24 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id k5-v6so1799033wre.10;
        Wed, 12 Sep 2018 05:20:23 -0700 (PDT)
X-Received: by 2002:adf:d245:: with SMTP id o5-v6mr1353566wri.91.1536754823034;
 Wed, 12 Sep 2018 05:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-9-jernej.skrabec@siol.net> <CAGb2v66y1iVDknM0uQKbHQFoWn7RveTky8jZO=_2iDqL=bJd-w@mail.gmail.com>
 <1677668.BePkXd9qNa@jernej-laptop>
In-Reply-To: <1677668.BePkXd9qNa@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 12 Sep 2018 20:20:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v66kojjjM4f_tO9NwzkCzD3LMM2eiq+PJ6Bk=1Rra=UnYg@mail.gmail.com>
Message-ID: <CAGb2v66kojjjM4f_tO9NwzkCzD3LMM2eiq+PJ6Bk=1Rra=UnYg@mail.gmail.com>
Subject: Re: [PATCH 08/27] clk: sunxi-ng: Add support for H6 DE3 clocks
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

On Wed, Sep 5, 2018 at 1:46 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne torek, 04. september 2018 ob 11:04:21 CEST je Chen-Yu Tsai napisal(a):
> > On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
> > > Support for mixer0, mixer1, writeback and rotation units is added.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > >
> > >  drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 65 ++++++++++++++++++++++++++++
> > >  drivers/clk/sunxi-ng/ccu-sun8i-de2.h |  1 +
> > >  2 files changed, 66 insertions(+)
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > > b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c index bae5ee67a797..4535c1c27d27
> > > 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > > @@ -31,6 +31,8 @@ static SUNXI_CCU_GATE(bus_mixer1_clk, "bus-mixer1",
> > > "bus-de",>
> > >                       0x04, BIT(1), 0);
> > >
> > >  static SUNXI_CCU_GATE(bus_wb_clk,      "bus-wb",       "bus-de",
> > >
> > >                       0x04, BIT(2), 0);
> > >
> > > +static SUNXI_CCU_GATE(bus_rot_clk,     "bus-rot",      "bus-de",
> > > +                     0x04, BIT(3), 0);
> > >
> > >  static SUNXI_CCU_GATE(mixer0_clk,      "mixer0",       "mixer0-div",
> > >
> > >                       0x00, BIT(0), CLK_SET_RATE_PARENT);
> > >
> > > @@ -38,6 +40,8 @@ static SUNXI_CCU_GATE(mixer1_clk,     "mixer1",
> > > "mixer1-div",>
> > >                       0x00, BIT(1), CLK_SET_RATE_PARENT);
> > >
> > >  static SUNXI_CCU_GATE(wb_clk,          "wb",           "wb-div",
> > >
> > >                       0x00, BIT(2), CLK_SET_RATE_PARENT);
> > >
> > > +static SUNXI_CCU_GATE(rot_clk,         "rot",          "rot-div",
> > > +                     0x00, BIT(3), CLK_SET_RATE_PARENT);
> > >
> > >  static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
> > >
> > >                    CLK_SET_RATE_PARENT);
> > >
> > > @@ -45,6 +49,8 @@ static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div", "de",
> > > 0x0c, 4, 4,>
> > >                    CLK_SET_RATE_PARENT);
> > >
> > >  static SUNXI_CCU_M(wb_div_clk, "wb-div", "de", 0x0c, 8, 4,
> > >
> > >                    CLK_SET_RATE_PARENT);
> > >
> > > +static SUNXI_CCU_M(rot_div_clk, "rot-div", "de", 0x0c, 0x0c, 4,
> > > +                  CLK_SET_RATE_PARENT);
> > >
> > >  static SUNXI_CCU_M(mixer0_div_a83_clk, "mixer0-div", "pll-de", 0x0c, 0,
> > >  4,
> > >
> > >                    CLK_SET_RATE_PARENT);
> > >
> > > @@ -53,6 +59,24 @@ static SUNXI_CCU_M(mixer1_div_a83_clk, "mixer1-div",
> > > "pll-de", 0x0c, 4, 4,>
> > >  static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
> > >
> > >                    CLK_SET_RATE_PARENT);
> > >
> > > +static struct ccu_common *sun50i_h6_de3_clks[] = {
> > > +       &mixer0_clk.common,
> > > +       &mixer1_clk.common,
> > > +       &wb_clk.common,
> > > +
> > > +       &bus_mixer0_clk.common,
> > > +       &bus_mixer1_clk.common,
> > > +       &bus_wb_clk.common,
> > > +
> > > +       &mixer0_div_clk.common,
> > > +       &mixer1_div_clk.common,
> > > +       &wb_div_clk.common,
> > > +
> > > +       &bus_rot_clk.common,
> > > +       &rot_clk.common,
> > > +       &rot_div_clk.common,
> > > +};
> > > +
> > >
> > >  static struct ccu_common *sun8i_a83t_de2_clks[] = {
> > >
> > >         &mixer0_clk.common,
> > >         &mixer1_clk.common,
> > >
> > > @@ -92,6 +116,26 @@ static struct ccu_common *sun8i_v3s_de2_clks[] = {
> > >
> > >         &wb_div_clk.common,
> > >
> > >  };
> > >
> > > +static struct clk_hw_onecell_data sun50i_h6_de3_hw_clks = {
> > > +       .hws    = {
> > > +               [CLK_MIXER0]            = &mixer0_clk.common.hw,
> > > +               [CLK_MIXER1]            = &mixer1_clk.common.hw,
> > > +               [CLK_WB]                = &wb_clk.common.hw,
> > > +               [CLK_ROT]               = &rot_clk.common.hw,
> > > +
> > > +               [CLK_BUS_MIXER0]        = &bus_mixer0_clk.common.hw,
> > > +               [CLK_BUS_MIXER1]        = &bus_mixer1_clk.common.hw,
> > > +               [CLK_BUS_WB]            = &bus_wb_clk.common.hw,
> > > +               [CLK_BUS_ROT]           = &bus_rot_clk.common.hw,
> > > +
> > > +               [CLK_MIXER0_DIV]        = &mixer0_div_clk.common.hw,
> > > +               [CLK_MIXER1_DIV]        = &mixer1_div_clk.common.hw,
> > > +               [CLK_WB_DIV]            = &wb_div_clk.common.hw,
> > > +               [CLK_ROT_DIV]           = &rot_div_clk.common.hw,
> > > +       },
> > > +       .num    = 12,
> >
> > It's best not to openly code these. It is error prone, like having
> > an index beyond .num, which then never gets registered.
> >
> > Instead, please update CLK_NUMBERS and use that instead. sunxi_ccu_probe()
> > can handle holes in .hws.
>
> I'm not sure this will work. All newly introduced indices are at the end, so
> other arrays will still have same length (hole at the end). You will just
> claim that arrays are larger than they really are, which means bad things.
>
> But I take any other suggestion. I really can't think of better solution.

Then maybe have macros for both cases instead?
CLK_NUMBER_WITH_ROT / CLK_NUMBER_WITHOUT_ROT?

ChenYu

> Best regards,
> Jernej
>
> >
> > On the other hand, it can't handle holes in the ccu_reset_map. Hope we
> > never have to deal with such an instance.
> >
> > ChenYu
> >
> > > +};
> > > +
> > >
> > >  static struct clk_hw_onecell_data sun8i_a83t_de2_hw_clks = {
> > >
> > >         .hws    = {
> > >
> > >                 [CLK_MIXER0]            = &mixer0_clk.common.hw,
> > >
> > > @@ -156,6 +200,13 @@ static struct ccu_reset_map sun50i_a64_de2_resets[] =
> > > {>
> > >         [RST_WB]        = { 0x08, BIT(2) },
> > >
> > >  };
> > >
> > > +static struct ccu_reset_map sun50i_h6_de3_resets[] = {
> > > +       [RST_MIXER0]    = { 0x08, BIT(0) },
> > > +       [RST_MIXER1]    = { 0x08, BIT(1) },
> > > +       [RST_WB]        = { 0x08, BIT(2) },
> > > +       [RST_ROT]       = { 0x08, BIT(3) },
> > > +};
> > > +
> > >
> > >  static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
> > >
> > >         .ccu_clks       = sun8i_a83t_de2_clks,
> > >         .num_ccu_clks   = ARRAY_SIZE(sun8i_a83t_de2_clks),
> > >
> > > @@ -186,6 +237,16 @@ static const struct sunxi_ccu_desc
> > > sun50i_a64_de2_clk_desc = {>
> > >         .num_resets     = ARRAY_SIZE(sun50i_a64_de2_resets),
> > >
> > >  };
> > >
> > > +static const struct sunxi_ccu_desc sun50i_h6_de3_clk_desc = {
> > > +       .ccu_clks       = sun50i_h6_de3_clks,
> > > +       .num_ccu_clks   = ARRAY_SIZE(sun50i_h6_de3_clks),
> > > +
> > > +       .hw_clks        = &sun50i_h6_de3_hw_clks,
> > > +
> > > +       .resets         = sun50i_h6_de3_resets,
> > > +       .num_resets     = ARRAY_SIZE(sun50i_h6_de3_resets),
> > > +};
> > > +
> > >
> > >  static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc = {
> > >
> > >         .ccu_clks       = sun8i_v3s_de2_clks,
> > >         .num_ccu_clks   = ARRAY_SIZE(sun8i_v3s_de2_clks),
> > >
> > > @@ -296,6 +357,10 @@ static const struct of_device_id sunxi_de2_clk_ids[]
> > > = {>
> > >                 .compatible = "allwinner,sun50i-h5-de2-clk",
> > >                 .data = &sun50i_a64_de2_clk_desc,
> > >
> > >         },
> > >
> > > +       {
> > > +               .compatible = "allwinner,sun50i-h6-de3-clk",
> > > +               .data = &sun50i_h6_de3_clk_desc,
> > > +       },
> > >
> > >         { }
> > >
> > >  };
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.h
> > > b/drivers/clk/sunxi-ng/ccu-sun8i-de2.h index 530c006e0ae9..27bd88539f42
> > > 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.h
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.h
> > > @@ -22,6 +22,7 @@
> > >
> > >  #define CLK_MIXER0_DIV 3
> > >  #define CLK_MIXER1_DIV 4
> > >  #define CLK_WB_DIV     5
> > >
> > > +#define CLK_ROT_DIV    11
> > >
> > >  #define CLK_NUMBER     (CLK_WB + 1)
> > >
> > > --
> > > 2.18.0
>
>
>
>
