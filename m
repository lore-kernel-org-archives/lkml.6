Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1617ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6073921479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhhSFo5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6073921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeJRD5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbeJRD5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:57:02 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674F12087A;
        Wed, 17 Oct 2018 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539806385;
        bh=qhKG59RqQU1pgsWB9HfUoqyaME2on0JW8/Lze58Qafw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=BhhSFo5csHF4qWzJPJgxP0jUzjqchW1yqKyofidBenmpBZ3juA1iK3WI1jhEsPY7N
         juMibqLa4rJfJ0LwGap2qnF4wGyBit8GXFiaNQwyZBb2Or4JrP8U4nn+aszSpMEvAS
         6b/t97PUmrslbyDB3XeyL/M4g61rk2yfDCT2IBOw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1537785597-26499-3-git-send-email-abel.vesa@nxp.com>
Cc:     linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-3-git-send-email-abel.vesa@nxp.com>
Message-ID: <153980638471.5275.2935268205764106887@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 2/5] clk: imx: add fractional PLL output clock
Date:   Wed, 17 Oct 2018 12:59:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-09-24 03:39:54)
> From: Lucas Stach <l.stach@pengutronix.de>
> =

> This is a new clock type introduced on i.MX8.

Ok, what's the clock type? Add another sentence please.

> =

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
[..]
> diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pl=
l.c
> new file mode 100644
> index 0000000..030df76
> --- /dev/null
> +++ b/drivers/clk/imx/clk-frac-pll.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 NXP.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>

Is this used for something?

> +#include <linux/slab.h>
> +#include <linux/bitfield.h>
> +
> +#include "clk.h"
[...]
> +
> +static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
> +       u32 val, divff, divfi, divq;
> +       u64 temp64;
> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> +       divq =3D ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
> +       val =3D readl_relaxed(pll->base + PLL_CFG1);
> +       divff =3D FIELD_GET(PLL_FRAC_DIV_MASK, val);
> +       divfi =3D (val & PLL_INT_DIV_MASK);

Nitpick: Drop useless parenthesis please.

> +
> +       temp64 =3D (u64)parent_rate * 8;
> +       temp64 *=3D divff;
> +       do_div(temp64, PLL_FRAC_DENOM);
> +       temp64 /=3D divq;
> +
> +       return parent_rate * 8 * (divfi + 1) / divq + (unsigned long)temp=
64;
> +}
> +
> +static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *prate)
> +{
> +       unsigned long parent_rate =3D *prate;
> +       u32 divff, divfi;
> +       u64 temp64;
> +
> +       parent_rate *=3D 8;

And parent_rate can't overflow if it's a u32? Maybe it could be a u64 so
that we don't need casting later on in this function.

> +       rate *=3D 2;
> +       divfi =3D rate / parent_rate;
> +       temp64 =3D (u64)(rate - divfi * parent_rate);
> +       temp64 *=3D PLL_FRAC_DENOM;
> +       do_div(temp64, parent_rate);
> +       divff =3D temp64;
> +
> +       temp64 =3D (u64)parent_rate;
> +       temp64 *=3D divff;
> +       do_div(temp64, PLL_FRAC_DENOM);
> +
> +       return (parent_rate * divfi + (unsigned long)temp64) / 2;
> +}
> +
> +/*
> + * To simplify the clock calculation, we can keep the 'PLL_OUTPUT_VAL' a=
t zero
> + * (means the PLL output will be divided by 2). So the PLL output can use
> + * the below formula:
> + * pllout =3D parent_rate * 8 / 2 * DIVF_VAL;
> + * where DIVF_VAL =3D 1 + DIVFI + DIVFF / 2^24.
> + */
> +static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
> +       u32 val, divfi, divff;
> +       u64 temp64;
> +       int ret;
> +
> +       parent_rate *=3D 8;
> +       rate *=3D 2;
> +       divfi =3D rate / parent_rate;
> +       temp64 =3D (u64) (rate - divfi * parent_rate);
> +       temp64 *=3D PLL_FRAC_DENOM;
> +       do_div(temp64, parent_rate);
> +       divff =3D temp64;
> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG1);
> +       val &=3D ~(PLL_FRAC_DIV_MASK | PLL_INT_DIV_MASK);
> +       val |=3D ((divff << 7) | (divfi - 1));

Nitpick: Drop the extra parenthesis please.

> +       writel_relaxed(val, pll->base + PLL_CFG1);
> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> +       val &=3D ~0x1f;
> +       writel_relaxed(val, pll->base + PLL_CFG0);
> +
> +       /* Set the NEV_DIV_VAL to reload the DIVFI and DIVFF */
> +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> +       val |=3D PLL_NEWDIV_VAL;
> +       writel_relaxed(val, pll->base + PLL_CFG0);
> +
> +       ret =3D clk_wait_ack(pll);
> +
> +       /* clear the NEV_DIV_VAL */
> +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> +       val &=3D ~PLL_NEWDIV_VAL;
> +       writel_relaxed(val, pll->base + PLL_CFG0);
> +
> +       return ret;
> +}
> +
> +static const struct clk_ops clk_frac_pll_ops =3D {
> +       .prepare        =3D clk_pll_prepare,
> +       .unprepare      =3D clk_pll_unprepare,
> +       .is_prepared    =3D clk_pll_is_prepared,
> +       .recalc_rate    =3D clk_pll_recalc_rate,
> +       .round_rate     =3D clk_pll_round_rate,
> +       .set_rate       =3D clk_pll_set_rate,
> +};
> +
> +struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
> +                            void __iomem *base)
> +{
> +       struct clk_init_data init;
> +       struct clk_frac_pll *pll;
> +       struct clk *clk;
> +
> +       pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pll->base =3D base;
> +       init.name =3D name;
> +       init.ops =3D &clk_frac_pll_ops;
> +       init.flags =3D 0;
> +       init.parent_names =3D &parent_name;
> +       init.num_parents =3D 1;
> +
> +       pll->hw.init =3D &init;
> +
> +       clk =3D clk_register(NULL, &pll->hw);

clk_hw based please.

> +       if (IS_ERR(clk))
> +               kfree(pll);
> +
> +       return clk;
> +}
