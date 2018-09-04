Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E1DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0258320843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0258320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeIDN2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:28:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40149 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeIDN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:28:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id j62-v6so2639292edd.7;
        Tue, 04 Sep 2018 02:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKEJDLP9Rl80+AgawcbhlztMYsylwsvsQmVLRseXZvg=;
        b=fqHaPUPXiLm4JheoZk8ijTcoAi6IT2DYLItDKB9rhCwDbyzkYAdraRLIahnuIqkN5Z
         xMqEbFhhtY6ZE2lnYpmg1tAkjq+nIRKNdAACvnw0mYq4rwCo09lhvAKaBhoxZf3K0H4b
         PiRiqF60l3ZMazB4HpY7eJOMum8xo9VD2hUshU+n7PnQ4VlZEJth8oxg7Y/6V+6Bw7tt
         F2UKzw7JXUyeJwX89ob+71qPzyjttdcN2JMkPdkH7zogHvt5a86vRfXqYkZcFxtQwe3S
         8QuOUNk6e+sHR7HRT75Tn7bxYrsG2fp1+c5lQDaO6X2FLmepnI8gBhDycPfefmQ3YD+y
         3/gw==
X-Gm-Message-State: APzg51Bsn3C/LYVv4izImsiH4Glw778n8hjs6baWkKXBKfuhu4kMiQBN
        b1egCnyDQiI/KvU2GbuP5HGglAXPN9E=
X-Google-Smtp-Source: ANB0VdZGKJeoCzy0nX/gHgzxduAzRzPh+2FvW6yzlX3MdBwKdvdn0VToJB6ez8V2MSrr5WgZ4wiIHw==
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr35365519eda.154.1536051876904;
        Tue, 04 Sep 2018 02:04:36 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id w3-v6sm12924277edb.16.2018.09.04.02.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 02:04:35 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id v17-v6so3076063wrr.9;
        Tue, 04 Sep 2018 02:04:34 -0700 (PDT)
X-Received: by 2002:adf:f8ca:: with SMTP id f10-v6mr23006053wrq.237.1536051874375;
 Tue, 04 Sep 2018 02:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-9-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-9-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Sep 2018 17:04:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v66y1iVDknM0uQKbHQFoWn7RveTky8jZO=_2iDqL=bJd-w@mail.gmail.com>
Message-ID: <CAGb2v66y1iVDknM0uQKbHQFoWn7RveTky8jZO=_2iDqL=bJd-w@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Support for mixer0, mixer1, writeback and rotation units is added.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 65 ++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.h |  1 +
>  2 files changed, 66 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> index bae5ee67a797..4535c1c27d27 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> @@ -31,6 +31,8 @@ static SUNXI_CCU_GATE(bus_mixer1_clk, "bus-mixer1",   "bus-de",
>                       0x04, BIT(1), 0);
>  static SUNXI_CCU_GATE(bus_wb_clk,      "bus-wb",       "bus-de",
>                       0x04, BIT(2), 0);
> +static SUNXI_CCU_GATE(bus_rot_clk,     "bus-rot",      "bus-de",
> +                     0x04, BIT(3), 0);
>
>  static SUNXI_CCU_GATE(mixer0_clk,      "mixer0",       "mixer0-div",
>                       0x00, BIT(0), CLK_SET_RATE_PARENT);
> @@ -38,6 +40,8 @@ static SUNXI_CCU_GATE(mixer1_clk,     "mixer1",       "mixer1-div",
>                       0x00, BIT(1), CLK_SET_RATE_PARENT);
>  static SUNXI_CCU_GATE(wb_clk,          "wb",           "wb-div",
>                       0x00, BIT(2), CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_GATE(rot_clk,         "rot",          "rot-div",
> +                     0x00, BIT(3), CLK_SET_RATE_PARENT);
>
>  static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
>                    CLK_SET_RATE_PARENT);
> @@ -45,6 +49,8 @@ static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div", "de", 0x0c, 4, 4,
>                    CLK_SET_RATE_PARENT);
>  static SUNXI_CCU_M(wb_div_clk, "wb-div", "de", 0x0c, 8, 4,
>                    CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_M(rot_div_clk, "rot-div", "de", 0x0c, 0x0c, 4,
> +                  CLK_SET_RATE_PARENT);
>
>  static SUNXI_CCU_M(mixer0_div_a83_clk, "mixer0-div", "pll-de", 0x0c, 0, 4,
>                    CLK_SET_RATE_PARENT);
> @@ -53,6 +59,24 @@ static SUNXI_CCU_M(mixer1_div_a83_clk, "mixer1-div", "pll-de", 0x0c, 4, 4,
>  static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
>                    CLK_SET_RATE_PARENT);
>
> +static struct ccu_common *sun50i_h6_de3_clks[] = {
> +       &mixer0_clk.common,
> +       &mixer1_clk.common,
> +       &wb_clk.common,
> +
> +       &bus_mixer0_clk.common,
> +       &bus_mixer1_clk.common,
> +       &bus_wb_clk.common,
> +
> +       &mixer0_div_clk.common,
> +       &mixer1_div_clk.common,
> +       &wb_div_clk.common,
> +
> +       &bus_rot_clk.common,
> +       &rot_clk.common,
> +       &rot_div_clk.common,
> +};
> +
>  static struct ccu_common *sun8i_a83t_de2_clks[] = {
>         &mixer0_clk.common,
>         &mixer1_clk.common,
> @@ -92,6 +116,26 @@ static struct ccu_common *sun8i_v3s_de2_clks[] = {
>         &wb_div_clk.common,
>  };
>
> +static struct clk_hw_onecell_data sun50i_h6_de3_hw_clks = {
> +       .hws    = {
> +               [CLK_MIXER0]            = &mixer0_clk.common.hw,
> +               [CLK_MIXER1]            = &mixer1_clk.common.hw,
> +               [CLK_WB]                = &wb_clk.common.hw,
> +               [CLK_ROT]               = &rot_clk.common.hw,
> +
> +               [CLK_BUS_MIXER0]        = &bus_mixer0_clk.common.hw,
> +               [CLK_BUS_MIXER1]        = &bus_mixer1_clk.common.hw,
> +               [CLK_BUS_WB]            = &bus_wb_clk.common.hw,
> +               [CLK_BUS_ROT]           = &bus_rot_clk.common.hw,
> +
> +               [CLK_MIXER0_DIV]        = &mixer0_div_clk.common.hw,
> +               [CLK_MIXER1_DIV]        = &mixer1_div_clk.common.hw,
> +               [CLK_WB_DIV]            = &wb_div_clk.common.hw,
> +               [CLK_ROT_DIV]           = &rot_div_clk.common.hw,
> +       },
> +       .num    = 12,

It's best not to openly code these. It is error prone, like having
an index beyond .num, which then never gets registered.

Instead, please update CLK_NUMBERS and use that instead. sunxi_ccu_probe()
can handle holes in .hws.

On the other hand, it can't handle holes in the ccu_reset_map. Hope we
never have to deal with such an instance.

ChenYu

> +};
> +
>  static struct clk_hw_onecell_data sun8i_a83t_de2_hw_clks = {
>         .hws    = {
>                 [CLK_MIXER0]            = &mixer0_clk.common.hw,
> @@ -156,6 +200,13 @@ static struct ccu_reset_map sun50i_a64_de2_resets[] = {
>         [RST_WB]        = { 0x08, BIT(2) },
>  };
>
> +static struct ccu_reset_map sun50i_h6_de3_resets[] = {
> +       [RST_MIXER0]    = { 0x08, BIT(0) },
> +       [RST_MIXER1]    = { 0x08, BIT(1) },
> +       [RST_WB]        = { 0x08, BIT(2) },
> +       [RST_ROT]       = { 0x08, BIT(3) },
> +};
> +
>  static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
>         .ccu_clks       = sun8i_a83t_de2_clks,
>         .num_ccu_clks   = ARRAY_SIZE(sun8i_a83t_de2_clks),
> @@ -186,6 +237,16 @@ static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc = {
>         .num_resets     = ARRAY_SIZE(sun50i_a64_de2_resets),
>  };
>
> +static const struct sunxi_ccu_desc sun50i_h6_de3_clk_desc = {
> +       .ccu_clks       = sun50i_h6_de3_clks,
> +       .num_ccu_clks   = ARRAY_SIZE(sun50i_h6_de3_clks),
> +
> +       .hw_clks        = &sun50i_h6_de3_hw_clks,
> +
> +       .resets         = sun50i_h6_de3_resets,
> +       .num_resets     = ARRAY_SIZE(sun50i_h6_de3_resets),
> +};
> +
>  static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc = {
>         .ccu_clks       = sun8i_v3s_de2_clks,
>         .num_ccu_clks   = ARRAY_SIZE(sun8i_v3s_de2_clks),
> @@ -296,6 +357,10 @@ static const struct of_device_id sunxi_de2_clk_ids[] = {
>                 .compatible = "allwinner,sun50i-h5-de2-clk",
>                 .data = &sun50i_a64_de2_clk_desc,
>         },
> +       {
> +               .compatible = "allwinner,sun50i-h6-de3-clk",
> +               .data = &sun50i_h6_de3_clk_desc,
> +       },
>         { }
>  };
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.h b/drivers/clk/sunxi-ng/ccu-sun8i-de2.h
> index 530c006e0ae9..27bd88539f42 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.h
> @@ -22,6 +22,7 @@
>  #define CLK_MIXER0_DIV 3
>  #define CLK_MIXER1_DIV 4
>  #define CLK_WB_DIV     5
> +#define CLK_ROT_DIV    11
>
>  #define CLK_NUMBER     (CLK_WB + 1)
>
> --
> 2.18.0
>
