Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3539ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C20521536
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEEwvZgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C20521536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbeIUFcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:32:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33230 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUFcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:32:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id r1-v6so2765252wmh.0;
        Thu, 20 Sep 2018 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvBzpqWj6eyWQI7nSTJ4Wgv5Mn119koKVJY4O9nbZjs=;
        b=DEEwvZgb2tqjEPVKuGprphJWEHBc0V+JAqgNlvlPTARNngIjLBVHVKK8OZ25AXiC5D
         G4oBerm9WM0iA/YI8L4W8Bb/iZKm23kkAjjRdDYwo0J+2Coz56BCEKtf0oNKM28BywP1
         9l1cUM+TNICLPHmO3whVknAiwkUJIjpqq4goUvhNdreJteKowLAwsG6M0I8pEFapLf11
         hy9DrT9C586jupnVyI7bmrHygNFHlRB6l8pv5i4IrpvpvZHAoj/npA+YiLLAtg4WKVEy
         TVSfn5Z1u01nBcPTVvqa/ii9/Ae8ahqFmrOMkcPN659uPbwisRzCA3CTcRZk/43MnfQV
         pzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvBzpqWj6eyWQI7nSTJ4Wgv5Mn119koKVJY4O9nbZjs=;
        b=Zs5UalhgV+cK3E5IoILlUjNOQKJ74Q4bT3qcEVsCyh4g+3Mm3As0D8Uloq0lW1Xl9H
         YGGcJxqCqr+NfIMbK0/aEk7N7hMpcxy4mJGzSiTmQS+Yf/9GB37jFwEV3ENlBag27WeC
         KB2/UOfQYW4aj1R868JUi1VvKi45IFpDqeuwAvp/9AokjJ9m9VkJiQnSbvqVXbLqsXDh
         EfDl/0LaXE6s7TDKGDK90CfVKwao788+8ka4YQS5hvhGAmcvUEPoVGYUGwA60Z+Sw8cn
         nk6cPZYwh0eUDcMjJ30S/3xLC8+caPiDHQNCnQKosXs476f5Jy4LjkuSHP6rrQYYQ0lW
         MAQg==
X-Gm-Message-State: APzg51CIvy0VP9TwepAyCvMOTinIRRou7c9Kt/sRxByCSpn3dG8lMf8B
        H90l416G1nIzVS+1XgL7HwIiNWH04X1c7VB88rw=
X-Google-Smtp-Source: ANB0VdYFo8yduUrsiJo8qNI3X7AZuUG4q9URZFV8k1yN5A1r9PSnvfE8Z/usibxkQEUT/nu7qp3wImxiqTjm4UG+Kkk=
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr1521350wmd.77.1537487160722;
 Thu, 20 Sep 2018 16:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com> <1537438000-20313-3-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1537438000-20313-3-git-send-email-abel.vesa@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 20 Sep 2018 16:45:49 -0700
Message-ID: <CAHQ1cqHkp5-XyLAPTWPota6cxM79oaToZEQpa+tewH4CVt9XSA@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] clk: imx: add fractional PLL output clock
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
> From: Lucas Stach <l.stach@pengutronix.de>
>
> This is a new clock type introduced on i.MX8.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile       |   1 +
>  drivers/clk/imx/clk-frac-pll.c | 230 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h          |   3 +
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-frac-pll.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 8c3baa7..4893c1f 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -6,6 +6,7 @@ obj-y += \
>         clk-cpu.o \
>         clk-fixup-div.o \
>         clk-fixup-mux.o \
> +       clk-frac-pll.o \
>         clk-gate-exclusive.o \
>         clk-gate2.o \
>         clk-pllv1.o \
> diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
> new file mode 100644
> index 0000000..c80c6ed
> --- /dev/null
> +++ b/drivers/clk/imx/clk-frac-pll.c
> @@ -0,0 +1,230 @@
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
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +#define PLL_CFG0               0x0
> +#define PLL_CFG1               0x4
> +
> +#define PLL_LOCK_STATUS                BIT(31)
> +#define PLL_PD                 19
> +#define PLL_PD_MASK            BIT(PLL_PD)
> +#define PLL_BYPASS             14
> +#define PLL_BYPASS_MASK                BIT(PLL_BYPASS)
> +#define PLL_NEWDIV_VAL         BIT(12)
> +#define PLL_NEWDIV_ACK         BIT(11)
> +#define PLL_FRAC_DIV_MASK      0xffffff
> +#define PLL_INT_DIV_MASK       0x7f
> +#define PLL_OUTPUT_DIV_MASK    0x1f
> +#define PLL_FRAC_DENOM         0x1000000
> +
> +struct clk_frac_pll {
> +       struct clk_hw   hw;
> +       void __iomem    *base;
> +};
> +
> +#define to_clk_frac_pll(_hw) container_of(_hw, struct clk_frac_pll, hw)
> +
> +static int clk_wait_lock(struct clk_frac_pll *pll)
> +{
> +       unsigned long timeout = jiffies + msecs_to_jiffies(10);
> +       u32 val;
> +
> +       /* Wait for PLL to lock */
> +       do {
> +               if (readl_relaxed(pll->base) & PLL_LOCK_STATUS)
> +                       break;
> +               if (time_after(jiffies, timeout))
> +                       break;
> +       } while (1);
> +
> +       return readl_poll_timeout(pll->base, val,
> +                                       val & PLL_LOCK_STATUS, 0, 1000);

Is this code intentional? It seems to me those two are almost
identical wait loops, so it's a bit confusing to see without at least
a comment why it is done that way. If it is intentional, can the first
loop be replaced with readx_poll_timeout(readl_relaxed, ...) ?

> +}
> +
> +static int clk_wait_ack(struct clk_frac_pll *pll)
> +{
> +       unsigned long timeout = jiffies + msecs_to_jiffies(50);
> +       u32 val;
> +
> +       /* return directly if the pll is in powerdown or in bypass */
> +       if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
> +               return 0;
> +
> +       /* Wait for the pll's divfi and divff to be reloaded */
> +       do {
> +               if (readl_relaxed(pll->base) & PLL_NEWDIV_ACK)
> +                       break;
> +               if (time_after(jiffies, timeout))
> +                       break;
> +       } while (1);
> +
> +       return readl_poll_timeout(pll->base, val,
> +                                       val & PLL_NEWDIV_ACK, 0, 1000);
> +}

Ditto.

> +
> +static int clk_pll_prepare(struct clk_hw *hw)
> +{
> +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       val &= ~PLL_PD_MASK;
> +       writel_relaxed(val, pll->base + PLL_CFG0);
> +
> +       return clk_wait_lock(pll);
> +}
> +
> +static void clk_pll_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       val |= PLL_PD_MASK;
> +       writel_relaxed(val, pll->base + PLL_CFG0);
> +}
> +
> +static int clk_pll_is_prepared(struct clk_hw *hw)
> +{
> +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> +       u32 val;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       return (val & PLL_PD_MASK) ? 0 : 1;
> +}
> +
> +static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_frac_pll *pll = to_clk_frac_pll(hw);
> +       u32 val, divff, divfi, divq;
> +       u64 temp64;
> +
> +       val = readl_relaxed(pll->base + PLL_CFG0);
> +       divq = ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
> +       val = readl_relaxed(pll->base + PLL_CFG1);
> +       divff = (val >> 7) & PLL_FRAC_DIV_MASK;

Just as a suggestion you can do:

#define PLL_FRAC_DIV GENMASK(30, 7)

divff = FIELD_GET(PLL_FRAC_DIV, val)

it's a bit nicer (IMHO, of course) because it allows you to avoid
having to encode shit and mask separately and mask definition can be
easily verified against the datasheet.

Thanks,
Andrey Smirnov
