Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E53ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3950421536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ+qj7A8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3950421536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbeIUFsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:48:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37433 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeIUFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:48:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id n11-v6so1281915wmc.2;
        Thu, 20 Sep 2018 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxdzRiwupch4uAYvazx5GeFQ/Da6DMSdXrfODXODYrQ=;
        b=HJ+qj7A8sslzON4VDmkCB3BppTkLqeb7AGoohDQwYiva2uTX50UFpeoDmTb/jbgblP
         WVgiYuixbhbXJzU8q08ka/gOQA6EVecyJp4xPZI9HfxJMV5d5iHQVESGD3pWehGznPNd
         Kl41uzLuoRcDL6hiNqntOlSkECPCHPTdyBk8mAU1Z4F7l3ceKM73MZj+VTGHn00vXnpt
         E7G6C/e7CPH3Bw57Xev6PKtjVlu1V5AO3HyBnUcRWG7FOuKIdPsfvRVkLeFH5CYKckPy
         NzjHabQJ2hNiU+U1QFR6ygz8jmrAitkDzHCEMj4vLSR2uI3GONuaYOk9oP2OsVXndmOl
         rC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxdzRiwupch4uAYvazx5GeFQ/Da6DMSdXrfODXODYrQ=;
        b=TR1hVPJvYB/QbWJXYMsHIhMYxhzTtBXYCLekNnK1TFFq3ADrmH0t/U+zNBp9IKIHiS
         3dJZvmAu0tVPZnBz2GcAT5/EbeCE9XWIrqVRF3ACrl/MbfYZIyAadhq8rEaT4RHGKJ63
         hupfBYsR50uFamJOfFA2h7PcLMpQ1rYWy9oVDVxlZheYvhMfluCFiws5cejILNDTJgvV
         S7/AmI7jryDqeBraGuJF7BwBqU897ZZk8sXMLh2728yHwtrG9v0PfZLA4+gTolWykYM+
         j8gO3ucn120FBEXdarUrjipAGBDiLef+syHXkyN1k7E4yXMPzNn2HUpF0jO9CrscaLFA
         yU/g==
X-Gm-Message-State: APzg51AiqaEwdV4w6DbmGzvAiP7pMSKl7/y32DT4JUvIp43fy9m7XMQ2
        PFbcVbge0o/TPvEi7qLUo916fVeJ5Z2BzLuofCE=
X-Google-Smtp-Source: ANB0VdbIWVm+Pc+SK88gNKqig5gquOQw6J2DN1sr0xt3oUIeMIVaR8Xp5n8Yf70AbpL4aJNStWS77N2m+68rxneexOE=
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr4518909wmq.36.1537488128689;
 Thu, 20 Sep 2018 17:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com> <1537438000-20313-5-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1537438000-20313-5-git-send-email-abel.vesa@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 20 Sep 2018 17:01:56 -0700
Message-ID: <CAHQ1cqEZ4_xR+Xhbt6Deiqn9dFPx7hfVKfsMXjfGTe6QisVG_A@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] clk: imx: add imx composite clock
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-imx@nxp.com,
        abelvesa@linux.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 3:07 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
> divider, the idea here is to combine all of those into one composite clock,
> but we need to deal with both predivider and divider at the same time and
> therefore we add the imx_clk_composite_divider_ops and register the composite
> clock with those.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-composite.c | 155 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h           |  11 +++
>  3 files changed, 167 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-composite.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index b87513c..4fabb0a 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -3,6 +3,7 @@
>  obj-y += \
>         clk.o \
>         clk-busy.o \
> +       clk-composite.o \
>         clk-cpu.o \
>         clk-fixup-div.o \
>         clk-fixup-mux.o \
> diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c
> new file mode 100644
> index 0000000..40c2aa8
> --- /dev/null
> +++ b/drivers/clk/imx/clk-composite.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 NXP
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +
> +#include "clk.h"
> +
> +#define PCG_PREDIV_SHIFT       16
> +#define PCG_PREDIV_WIDTH       3
> +
> +#define PCG_DIV_SHIFT          0
> +#define PCG_DIV_WIDTH          6
> +
> +#define PCG_PCS_SHIFT          24
> +#define PCG_PCS_MASK           0x7
> +
> +#define PCG_CGC_SHIFT          28
> +
> +static unsigned long imx_clk_composite_divider_recalc_rate(struct clk_hw *hw,
> +                                               unsigned long parent_rate)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       unsigned long prediv_rate;
> +       unsigned int prediv_value;
> +       unsigned int div_value;
> +
> +       prediv_value = clk_readl(divider->reg) >> divider->shift;
> +       prediv_value &= clk_div_mask(divider->width);
> +
> +       prediv_rate = divider_recalc_rate(hw, parent_rate, prediv_value,
> +                                               NULL, divider->flags,
> +                                               divider->width);
> +
> +       div_value = clk_readl(divider->reg) >> PCG_DIV_SHIFT;
> +       div_value &= clk_div_mask(PCG_DIV_WIDTH);
> +
> +       return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
> +                                  divider->flags, PCG_DIV_WIDTH);
> +}
> +
> +static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
> +                                               unsigned long rate,
> +                                               unsigned long *prate)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       unsigned long prediv_rate;
> +
> +       prediv_rate = divider_round_rate(hw, rate, prate, divider->table,
> +                                 divider->width, divider->flags);
> +       return divider_round_rate(hw, rate, &prediv_rate, divider->table,
> +                                 PCG_DIV_WIDTH, divider->flags);
> +}
> +
> +static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
> +                                       unsigned long rate,
> +                                       unsigned long parent_rate)
> +{
> +       struct clk_divider *divider = to_clk_divider(hw);
> +       unsigned long prediv_rate;
> +       unsigned long flags = 0;
> +       int prediv_value;
> +       int div_value;
> +       u32 val;
> +
> +       prediv_value = divider_get_val(rate, parent_rate, NULL,
> +                               PCG_PREDIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
> +       if (prediv_value < 0)
> +               return prediv_value;
> +
> +       prediv_rate = DIV_ROUND_UP_ULL((u64)parent_rate, prediv_value + 1);
> +
> +       div_value = divider_get_val(rate, prediv_rate, NULL,
> +                               PCG_DIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
> +       if (div_value < 0)
> +               return div_value;
> +
> +       spin_lock_irqsave(divider->lock, flags);
> +
> +       val = clk_readl(divider->reg);
> +       val &= ~((clk_div_mask(divider->width) << divider->shift) |
> +                       (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
> +
> +       val |= (u32)prediv_value << divider->shift;
> +       val |= (u32)div_value << PCG_DIV_SHIFT;
> +       clk_writel(val, divider->reg);
> +
> +       spin_unlock_irqrestore(divider->lock, flags);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops imx_clk_composite_divider_ops = {
> +       .recalc_rate = imx_clk_composite_divider_recalc_rate,
> +       .round_rate = imx_clk_composite_divider_round_rate,
> +       .set_rate = imx_clk_composite_divider_set_rate,
> +};
> +
> +struct clk *imx_clk_composite_flags(const char *name,
> +                                       const char **parent_names,
> +                                       int num_parents, void __iomem *reg,
> +                                       unsigned long flags)
> +{
> +       struct clk_hw *mux_hw = NULL, *div_hw = NULL, *gate_hw = NULL;
> +       struct clk_divider *div = NULL;
> +       struct clk_gate *gate = NULL;
> +       struct clk_mux *mux = NULL;
> +       struct clk *clk;
> +
> +       mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +       if (!mux)
> +               return ERR_PTR(-ENOMEM);
> +       mux_hw = &mux->hw;
> +       mux->reg = reg;
> +       mux->shift = PCG_PCS_SHIFT;
> +       mux->mask = PCG_PCS_MASK;
> +
> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div) {
> +               kfree(mux);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +       div_hw = &div->hw;
> +       div->reg = reg;
> +       div->shift = PCG_PREDIV_SHIFT;
> +       div->width = PCG_PREDIV_WIDTH;
> +       div->lock = &imx_ccm_lock;
> +       div->flags = CLK_DIVIDER_ROUND_CLOSEST;
> +
> +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate) {
> +               kfree(mux);
> +               kfree(div);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +       gate_hw = &gate->hw;
> +       gate->reg = reg;
> +       gate->bit_idx = PCG_CGC_SHIFT;
> +
> +       clk = clk_register_composite(NULL, name, parent_names, num_parents,
> +                                       mux_hw, &clk_mux_ops, div_hw,
> +                                       &imx_clk_composite_divider_ops, gate_hw,
> +                                       &clk_gate_ops, flags);
> +       if (IS_ERR(clk)) {
> +               kfree(mux);
> +               kfree(div);
> +               kfree(gate);

Minor suggestion: using goto to free resource in this case might be
more straightforward and require less repeatition.

> +       }
> +
> +       return clk;
> +}
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 12b3fd6..74d8d46 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -232,4 +232,15 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
>                 struct clk *div, struct clk *mux, struct clk *pll,
>                 struct clk *step);
>
> +struct clk *imx_clk_composite_flags(const char *name, const char **parent_names,
> +               int num_parents, void __iomem *reg, unsigned long flags);
> +
> +#define imx_clk_composite(name, parent_names, reg) \
> +       imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
> +                                       CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> +
> +#define imx_clk_composite_critical(name, parent_names, reg) \
> +       imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
> +                               CLK_IS_CRITICAL | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)

Another minor suggestion is to define a intermediary macro and define
both imx_clk_composite_critical() and imx_clk_composite() in terms of
it. Say:

#define __imx_clk_composite(name, parent_names, reg, flags) \
    imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
                                             flags |
CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)

#define imx_clk_composite(name, parent_names, reg)
__imx_clk_composite_flags(name, parent_names, reg, 0)
#define imx_clk_composite_critical(name, parent_names, reg)
__imx_clk_composite_flags(name, parent_names, reg, CLK_IS_CRITICAL)

this way it might be a bit easier to spot that the only difference
between the two is CLK_IS_CRITICAL.

Thanks,
Andrey Smirnov
