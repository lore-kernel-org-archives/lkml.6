Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13113C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8373218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549480610;
	bh=pZHqUfj+RPmB7wbKaAZj001POtJoQqUTuL6SNXQlQcM=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=hJR9wA+hj0uZRNBJ1Kid/NRPrZsJPXKWJ6DpJiDL7p3C/g+OJA5+uBOOZe5a6pzLG
	 GnauMM2TyVk9BHis059F+4eHYO3FIK9elXEsTWAI5IqVXCB0Ig+BKUS/F6EMzj9haA
	 LPaOKIOyWDSiCBdBN1AjAgjXe/KYBnL+ljoq6LEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfBFTQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfBFTQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:16:48 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB5920B1F;
        Wed,  6 Feb 2019 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549480606;
        bh=pZHqUfj+RPmB7wbKaAZj001POtJoQqUTuL6SNXQlQcM=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=AT4Twd1Hbmw0Ttq3X0NudntTe2b/iayC1OjGtQQ3Y/Fo8yJQUUTuzVhaMkuQX/5QR
         OUuAwVJvQXIAZysWHZaenXroWdzsI1zu1OE7Ek6GYgylzA5N+KjbsKcVqUaic9h2bE
         hDycKEvSpFp4P5IBpn03fVQvYfPtVFuYLryJgy1s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
In-Reply-To: <20190201063540.19636-3-jiaxun.yang@flygoat.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v3 2/3] clk: loongson1: add of support
Message-ID: <154948060595.115909.8140700244360302816@swboyd.mtv.corp.google.com>
References: <20190128152052.3047-1-jiaxun.yang@flygoat.com> <20190201063540.19636-1-jiaxun.yang@flygoat.com> <20190201063540.19636-3-jiaxun.yang@flygoat.com>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 06 Feb 2019 11:16:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiaxun Yang (2019-01-31 22:35:39)
> This patch add of support by split the clk_hw register and
> clkdev register, then handle the of clk_hw via
> of_clk_hw_onecell_get.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Why though? There isn't any motivation here.

> ---
>  drivers/clk/loongson1/clk-loongson1b.c | 197 ++++++++++++++++++++-----
>  drivers/clk/loongson1/clk-loongson1c.c | 164 +++++++++++++++-----
>  drivers/clk/loongson1/clk.c            |  47 +++++-
>  drivers/clk/loongson1/clk.h            |  18 ++-
>  4 files changed, 343 insertions(+), 83 deletions(-)

It just looks like more lines are added.

>=20
> diff --git a/drivers/clk/loongson1/clk-loongson1b.c b/drivers/clk/loongso=
n1/clk-loongson1b.c
> index f36a97e993c0..2148df31db15 100644
> --- a/drivers/clk/loongson1/clk-loongson1b.c
> +++ b/drivers/clk/loongson1/clk-loongson1b.c
> @@ -1,10 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
> - *
> - * This program is free software; you can redistribute  it and/or modify=
 it
> - * under  the terms of  the GNU General  Public License as published by =
the
> - * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> - * option) any later version.

Please make SPDX change in another patch.

> + * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
>   */
> =20
>  #include <linux/clkdev.h>
> @@ -12,11 +9,41 @@
>  #include <linux/io.h>
>  #include <linux/err.h>
> =20
> -#include <loongson1.h>
>  #include "clk.h"
> +#include <dt-bindings/clock/ls1b-clock.h>
> +
> +#define LS1B_CLK_COUNT 9
> =20
> -#define OSC            (33 * 1000000)
>  #define DIV_APB                2
> +/* Clock PLL Divisor Register Bits */
> +#define DIV_DC_EN                      BIT(31)
> +#define DIV_DC_RST                     BIT(30)
> +#define DIV_CPU_EN                     BIT(25)
> +#define DIV_CPU_RST                    BIT(24)
> +#define DIV_DDR_EN                     BIT(19)
> +#define DIV_DDR_RST                    BIT(18)
> +#define RST_DC_EN                      BIT(5)
> +#define RST_DC                         BIT(4)
> +#define RST_DDR_EN                     BIT(3)
> +#define RST_DDR                                BIT(2)
> +#define RST_CPU_EN                     BIT(1)
> +#define RST_CPU                                BIT(0)
> +
> +#define DIV_DC_SHIFT                   26
> +#define DIV_CPU_SHIFT                  20
> +#define DIV_DDR_SHIFT                  14
> +
> +#define DIV_DC_WIDTH                   4
> +#define DIV_CPU_WIDTH                  4
> +#define DIV_DDR_WIDTH                  4
> +
> +#define BYPASS_DC_SHIFT                        12
> +#define BYPASS_DDR_SHIFT               10
> +#define BYPASS_CPU_SHIFT               8
> +
> +#define BYPASS_DC_WIDTH                        1
> +#define BYPASS_DDR_WIDTH               1
> +#define BYPASS_CPU_WIDTH               1
> =20
>  static DEFINE_SPINLOCK(_lock);
> =20
> @@ -25,9 +52,9 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw=
 *hw,
>  {
>         u32 pll, rate;
> =20
> -       pll =3D __raw_readl(LS1X_CLK_PLL_FREQ);
> +       pll =3D __raw_readl(CLK_PLL_FREQ_ADDR);
>         rate =3D 12 + (pll & GENMASK(5, 0));
> -       rate *=3D OSC;
> +       rate *=3D parent_rate;
>         rate >>=3D 1;
> =20
>         return rate;

IS this change related? Maybe think about splitting this out too and
just have a patch that re-does all the registration calls in one patch.

> @@ -120,3 +220,24 @@ void __init ls1x_clk_init(void)
>         clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
>         clk_hw_register_clkdev(hw, "serial8250", NULL);
>  }
> +
> +static void __init ls1b_clk_of_setup(struct device_node *np)
> +{
> +       struct clk_hw_onecell_data *onecell;
> +       int err;
> +       const char *parent =3D of_clk_get_parent_name(np, 0);
> +
> +       clk_base =3D of_iomap(np, 0);
> +
> +       onecell =3D ls1b_clk_init_hw(parent);
> +       if (!onecell)
> +               pr_err("ls1b-clk: unable to register clk_hw");
> +
> +       err =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell=
);
> +       if (err)
> +               pr_err("ls1b-clk: failed to add DT provider: %d\n", err);
> +
> +       pr_info("ls1b-clk: driver registered");

Please no "I'm alive!" messages (plus it's missing a newline at the
end). At the least, make them pr_debug() level.

> +}
> +
> +CLK_OF_DECLARE(clk_ls1b, "loongson,ls1b-clock", ls1b_clk_of_setup);
> diff --git a/drivers/clk/loongson1/clk.c b/drivers/clk/loongson1/clk.c
> index 983ce9f6edbb..b4dc7dd8e0cd 100644
> --- a/drivers/clk/loongson1/clk.c
> +++ b/drivers/clk/loongson1/clk.c
> @@ -1,14 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
> - *
> - * This program is free software; you can redistribute  it and/or modify=
 it
> - * under  the terms of  the GNU General  Public License as published by =
the
> - * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> - * option) any later version.
> + * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
>   */
> =20
> +#include <linux/clkdev.h>
> +
>  #include <linux/clk-provider.h>
>  #include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/mach-loongson32/platform.h>
> +
> +void __iomem *clk_base;
> +
> +#define LS1C_OSC               (24 * 1000000)
> +#define LS1B_OSC               (33 * 1000000)
> +
> +#define LS1X_CLK_BASE  0x1fe78030
> =20
>  #include "clk.h"
> =20
> @@ -43,3 +53,30 @@ struct clk_hw *__init clk_hw_register_pll(struct devic=
e *dev,
> =20
>         return hw;
>  }
> +
> +void __init ls1x_clk_init(void)
> +{
> +       struct clk_hw *hw;
> +       struct clk_hw_onecell_data *onecell;
> +
> +       clk_base =3D (void __iomem *)KSEG1ADDR(LS1X_CLK_BASE);
> +#ifdef CONFIG_LOONGSON1_LS1B
> +       hw =3D clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, LS1B_=
OSC);
> +       clk_hw_register_clkdev(hw, "osc_clk", NULL);
> +       onecell =3D ls1c_clk_init_hw("osc_clk");
> +       if (!onecell)
> +               panic("ls1x-clk: unable to register clk_hw");
> +
> +       ls1c_register_clkdev(onecell);

Should be ls1b_register_clkdev?

> +#elif defined(CONFIG_LOONGSON1_LS1C)
> +       hw =3D clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, LS1C_=
OSC);
> +       clk_hw_register_clkdev(hw, "osc_clk", NULL);
> +       onecell =3D ls1c_clk_init_hw("osc_clk");
> +       if (!onecell)
> +               panic("ls1x-clk: unable to register clk_hw");
> +
> +       ls1c_register_clkdev(onecell);
> +#else
> +       panic("ls1x-clk: not loongson platform");
> +#endif

Can this be implemented with if (IS_ENABLED(CONFIG_LOONGSON1_LS1B))
else-if, etc.? That would make the maybe unused attribute unnecessary and
provide more compile time coverage.

Also, a lot of the code is duplicated twice so that could all be
collapsed together and then the only difference is the fixed rate and
the registration function at the end?=20

Or can this just be implemented in the 1b and 1c files instead of in
some common place here?

> +}
> diff --git a/drivers/clk/loongson1/clk.h b/drivers/clk/loongson1/clk.h
> index 085d74b5d496..be7cc72c0ea3 100644
> --- a/drivers/clk/loongson1/clk.h
> +++ b/drivers/clk/loongson1/clk.h
> @@ -16,4 +13,15 @@ struct clk_hw *clk_hw_register_pll(struct device *dev,
>                                    const struct clk_ops *ops,
>                                    unsigned long flags);
> =20
> +struct clk_hw_onecell_data __init *ls1c_clk_init_hw(const char *osc_name=
);
> +struct clk_hw_onecell_data __init *ls1b_clk_init_hw(const char *osc_name=
);
> +
> +void __maybe_unused __init ls1c_register_clkdev(struct clk_hw_onecell_da=
ta *onecell);
> +void __maybe_unused __init ls1b_register_clkdev(struct clk_hw_onecell_da=
ta *onecell);

I doubt that __maybe_unused and __init are needed here in the header
file. Just on the actual implementation of the function.

