Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA191C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD22087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvnX0Fu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FD22087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeH1Wkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:40:33 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43206 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1Wkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:40:33 -0400
Received: by mail-io0-f194.google.com with SMTP id y10-v6so2336597ioa.10;
        Tue, 28 Aug 2018 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OqSASSNCEufFtxUWbjhk8AYuU0rlGEcmKXGyVnVg7M=;
        b=fvnX0Fu6IsPj2Ze01WXhUfkML2CAFdVdMlxp8XzQ6yuAYDqdLM0NjFI51PLMjFHY+9
         mF7r0to+bCH7zTlgp6Zd4wXAfcUtJh4kiGBVflfyxhOJwcdohT4EzEqeMgpNGKxa6Mvu
         iqBJMegjnfLOSTzTk8CEJZ0ejIW79u0xcQtNBrfP1ByNTLxtc7iqn27NZ3FJvwU98R+a
         uSEWENHt4rdEvG50/si0KiZpd+NfvA50JHiXYZbk3YPRBuFMHDu756QeGRosf8evBmcD
         FQxOc+Lh4XPVUzxXVzzRy5wIyo66OCSI4catFfLegXTCWACvApr0F4+RbpOchuyk+0So
         Uk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OqSASSNCEufFtxUWbjhk8AYuU0rlGEcmKXGyVnVg7M=;
        b=KImtC+NI8j9CSiczN0r5Y7ePotg8n/LyTCC5J3pPPRF24j7O9hwRuDDWzRbpTEQ9xM
         3/dlBqAus5f7uhAGlPuKgdzzfLayeExacEXOcEciNtLsrIV6veQ1rb8d3kgYrCC6xp4s
         UrP18Ibpszkokqyip/FDGZiV5LHBqvjJYDztR/vKRPUbKK0StpfgW/XA57tE6+VlQNX+
         MJyuY3rW5XCHtqYCWMZySmiZeGDAfZpPgNXdDDhEoUgX6bihY8jgOaqh2Tt7meMWvVrL
         7W4Ez76myynXtZyBbCxs5ima8P5lh0ut1yuKHAbU6q4K+BLC5ZGCe536i2MPGW9W+XQd
         LvCg==
X-Gm-Message-State: APzg51Bv35f9vKawhkFt6Ed+STbfCX/wVmNxz16ZfmziZQOYb0hB6ufN
        NkMlmLgKjvrE3xLjdF7okkYFYXSWf2PZY5H1ttg=
X-Google-Smtp-Source: ANB0Vdbb2616XY5gTERF/SBww1WrgYHjoqK7n1KnT/+tZqdBWN2bOKV1o71bM9h7qUW2kbioiApz4ZLxEXqQ9BotzGw=
X-Received: by 2002:a6b:bf04:: with SMTP id p4-v6mr2571809iof.15.1535482055498;
 Tue, 28 Aug 2018 11:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com> <1534945703-4730-4-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1534945703-4730-4-git-send-email-abel.vesa@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 28 Aug 2018 11:47:23 -0700
Message-ID: <CAHQ1cqEJe24Zad9BL0FrKmPJjy4RO41n1rDU08Ua_uAq4dB=KA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] clk: imx: add SCCG PLL type
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, abelvesa@linux.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 6:52 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> From: Lucas Stach <l.stach@pengutronix.de>
>
> The SCCG is a new PLL type introduced on i.MX8. Add support for this.
> The driver currently misses the PLL lock check, as the preliminary
> documentation mentions lock configurations, but is quiet about where
> to find the actual lock status signal.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile       |   3 +-
>  drivers/clk/imx/clk-sccg-pll.c | 231 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h          |   9 ++
>  3 files changed, 242 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/imx/clk-sccg-pll.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 4893c1f..b87513c 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -12,7 +12,8 @@ obj-y += \
>         clk-pllv1.o \
>         clk-pllv2.o \
>         clk-pllv3.o \
> -       clk-pfd.o
> +       clk-pfd.o \
> +       clk-sccg-pll.o
>
>  obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
>  obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
> diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
> new file mode 100644
> index 0000000..886ae03
> --- /dev/null
> +++ b/drivers/clk/imx/clk-sccg-pll.c
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2018 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +/* PLL CFGs */
> +#define PLL_CFG0       0x0
> +#define PLL_CFG1       0x4
> +#define PLL_CFG2       0x8
> +
> +#define PLL_DIVF1_SHIFT        13
> +#define PLL_DIVF2_SHIFT        7
> +#define PLL_DIVF_MASK  0x3f
> +
> +#define PLL_DIVR1_SHIFT        25
> +#define PLL_DIVR2_SHIFT        19
> +#define PLL_DIVR1_MASK 0x3
> +#define PLL_DIVR2_MASK 0x3f
> +#define PLL_REF_SHIFT  0
> +#define PLL_REF_MASK   0x3
> +
> +#define PLL_LOCK       31
> +#define PLL_PD         7
> +
> +#define OSC_25M                25000000
> +#define OSC_27M                27000000
> +
> +struct clk_sccg_pll {
> +       struct clk_hw   hw;
> +       void __iomem    *base;
> +};
> +
> +#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
> +
> +static int clk_pll1_is_prepared(struct clk_hw *hw)
> +{
> +       struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       return (val & (1 << PLL_PD)) ? 0 : 1;
> +}
> +
> +static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> +       u32 val, divf;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG2);
> +       divf = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
> +
> +       return parent_rate * 2 * (divf + 1);
> +}
> +
> +static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *prate)
> +{
> +       unsigned long parent_rate = *prate;
> +       u32 div;
> +
> +       div = rate / (parent_rate * 2);
> +
> +       return parent_rate * div * 2;
> +}
> +
> +static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> +       u32 val;
> +       u32 divf;
> +
> +       divf = rate / (parent_rate * 2);
> +
> +       val = readl_relaxed(pll->base + PLL_CFG2);
> +       val &= ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
> +       val |= (divf - 1) << PLL_DIVF1_SHIFT;
> +       writel_relaxed(val, pll->base + PLL_CFG2);
> +
> +       /* FIXME: PLL lock check */
> +
> +       return 0;
> +}
> +
> +static int clk_pll1_prepare(struct clk_hw *hw)
> +{
> +       struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(pll->base);
> +       val &= ~(1 << PLL_PD);
> +       writel_relaxed(val, pll->base);
> +
> +       /* FIXME: PLL lock check */
> +
> +       return 0;
> +}
> +
> +static void clk_pll1_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(pll->base);
> +       val |= (1 << PLL_PD);
> +       writel_relaxed(val, pll->base);
> +}
> +
> +static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> +       u32 val, ref, divr1, divf1, divr2, divf2;
> +       u64 temp64;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       switch ((val >> PLL_REF_SHIFT) & PLL_REF_MASK) {
> +       case 0:
> +               ref = OSC_25M;
> +               break;
> +       case 1:
> +               ref = OSC_27M;
> +               break;
> +       default:
> +               ref = OSC_25M;
> +               break;
> +       }
> +
> +       val = readl_relaxed(pll->base + PLL_CFG2);
> +       divr1 = (val >> PLL_DIVR1_SHIFT) & PLL_DIVR1_MASK;
> +       divr2 = (val >> PLL_DIVR2_SHIFT) & PLL_DIVR2_MASK;
> +       divf1 = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
> +       divf2 = (val >> PLL_DIVF2_SHIFT) & PLL_DIVF_MASK;
> +
> +       temp64 = ref * 2;
> +       temp64 *= (divf1 + 1) * (divf2 + 1);
> +
> +       do_div(temp64, (divr1 + 1) * (divr2 + 1));
> +
> +       return (unsigned long)temp64;
> +}
> +
> +static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *prate)
> +{
> +       u32 div;
> +       unsigned long parent_rate = *prate;
> +
> +       div = rate / (parent_rate);
> +
> +       return parent_rate * div;
> +}
> +
> +static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       u32 val;
> +       u32 divf;
> +       struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> +
> +       divf = rate / (parent_rate);
> +
> +       val = readl_relaxed(pll->base + PLL_CFG2);
> +       val &= ~(PLL_DIVF_MASK << PLL_DIVF2_SHIFT);
> +       val |= (divf - 1) << PLL_DIVF2_SHIFT;
> +       writel_relaxed(val, pll->base + PLL_CFG2);
> +
> +       /* FIXME: PLL lock check */
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops clk_sccg_pll1_ops = {
> +       .is_prepared    = clk_pll1_is_prepared,
> +       .recalc_rate    = clk_pll1_recalc_rate,
> +       .round_rate     = clk_pll1_round_rate,
> +       .set_rate       = clk_pll1_set_rate,
> +};
> +
> +static const struct clk_ops clk_sccg_pll2_ops = {
> +       .prepare        = clk_pll1_prepare,
> +       .unprepare      = clk_pll1_unprepare,
> +       .recalc_rate    = clk_pll2_recalc_rate,
> +       .round_rate     = clk_pll2_round_rate,
> +       .set_rate       = clk_pll2_set_rate,
> +};
> +
> +struct clk *imx_clk_sccg_pll(const char *name,
> +                               const char *parent_name,
> +                               void __iomem *base,
> +                               enum imx_sccg_pll_type pll_type)
> +{
> +       struct clk_sccg_pll *pll;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pll->base = base;
> +       init.name = name;
> +       switch (pll_type) {
> +       case SCCG_PLL1:
> +               init.ops = &clk_sccg_pll1_ops;
> +               break;
> +       case SCCG_PLL2:
> +               init.ops = &clk_sccg_pll2_ops;
> +               break;
> +       }

Please add error checking in the switch above since it's pretty clear
that a wrong kind of argument can be passed as a pll_type without it
being noticeable.

Thanks,
Andrey Smirnov
