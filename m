Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA33ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E3120989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjBM60B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E3120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbeIUFkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:40:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43259 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIUFkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:40:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so11048922wre.10;
        Thu, 20 Sep 2018 16:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2a15NyQVkl79RQhPd3PHG6IJ6Lp6SPjRF/fClSpGEoA=;
        b=tjBM60B+pidzyZDFCVswEbCg5b7NYFb976gFALrR6B1ItSY6HHH4IgX7SmPeKybrkO
         Z2p0MhQE4C/KHssaHexs/+oqFy2LVMS5mtjx3E6i70pOZH6r3US9rWAWitv2FKG3diN8
         JGJ6U0MxIeAQiun/VtYR9x4bRpavSBedioFUjntupD5HBe7y0U5bFKbC4FnrPIJQw9NX
         aruWirQwvagxmtzpDdm27EIxLEO3Opwo+bMUr4LWw4mV71lFDpTr4KV2u1BjDbZ+WpRt
         9QAFTbxMYtfzAjf8a6/1XYUimChEruWMwNFJsBOCD9APpICI+LmWvPz3Q+fccZtM3CN9
         3U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2a15NyQVkl79RQhPd3PHG6IJ6Lp6SPjRF/fClSpGEoA=;
        b=XQFWXsyw+n+IKsT+kMoyh2Ie4Hs2uybyVrivCQjsXyJO3ZMOe4NHJrHgrTgXs0JyGI
         tFl8v81wzAx7mvDJF8GBFH8Rb28u1eh0T4/+bCILkFrQKRTS7rBiPFhQ5+GxXeE2pD/5
         qo5nlQS8Sfq1gyklwFHZOpBXq4C2q0MOW29eBgYNTL3hsGbqiVGMYt7KmNFijbK+qTTA
         QcupuZXy4uNpXzAB5tmNoFixRvUXPkHbU8SARmM8gqSTgJLijOXPpOtWlLd0b0ns6XgW
         CQNdeb54t7l/vNuvvzbGaOzZL2S9rv4k0IGtk9iRPSe8EeaOOjYdDNVe4dMjEBJCTlC2
         pbiw==
X-Gm-Message-State: APzg51Bz5FtzqqUGxANI0xYc7hIoAjvnUECXZ8SQjMlBgppVozgVJ9nn
        sYDjFOnGCxAKxrGOaglb+m047ZirYoIzxDI84Ug=
X-Google-Smtp-Source: ANB0VdZ8MSZp80DPNO6UG4xW5LaS0glVBIhdVtKDYiA1sFXok/bLClpjYgOYRoQPm0oCmZr7EShvW4p/+USaDvX3wBU=
X-Received: by 2002:adf:f34c:: with SMTP id e12-v6mr9721581wrp.161.1537487649173;
 Thu, 20 Sep 2018 16:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com> <1537438000-20313-4-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1537438000-20313-4-git-send-email-abel.vesa@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 20 Sep 2018 16:53:57 -0700
Message-ID: <CAHQ1cqHBHB3HywTFvQAxsCEKhSWq5+E3oxTzBx2f3voK3sj4cg@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] clk: imx: add SCCG PLL type
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
> The SCCG is a new PLL type introduced on i.MX8. Add support for this.
> The driver currently misses the PLL lock check, as the preliminary
> documentation mentions lock configurations, but is quiet about where
> to find the actual lock status signal.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile       |   3 +-
>  drivers/clk/imx/clk-sccg-pll.c | 246 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h          |   9 ++
>  3 files changed, 257 insertions(+), 1 deletion(-)
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
> index 0000000..8d87ba5
> --- /dev/null
> +++ b/drivers/clk/imx/clk-sccg-pll.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2018 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
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

Similar to previous patch, I'd suggest using FILED_GET()/GENMAKS for
the above fields

> +#define PLL_LOCK_MASK  BIT(31)
> +#define PLL_PD_MASK    BIT(7)
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
> +static int clk_pll_wait_lock(struct clk_sccg_pll *pll)
> +{
> +       /* max lock time is 70us */
> +       int retry = 7;
> +
> +       /* Wait for PLL to lock */
> +       do {
> +               if (readl_relaxed(pll->base) & PLL_LOCK_MASK)
> +                       break;
> +               udelay(10);
> +               retry--;
> +       } while (retry);
> +

Can readx_poll_timeout_atomic() be used here instead?

Thanks,
Andrey Smirnov
