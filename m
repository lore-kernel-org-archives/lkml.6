Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F47C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B062080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="E3tlBtSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B062080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbeLNBCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:02:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34012 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeLNBCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:02:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id q8so145751qke.1;
        Thu, 13 Dec 2018 17:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPqCC0+vy1j0qiDeRYjntaHgc93Wn+BCM3UBnz89/08=;
        b=E3tlBtSNY7pmOo7Ttk9d449HB1ofQFxZsce5vsr1/rF4pY/RRbUftlGnCrWYfc5hNW
         tT4qR6HkPfdPbfoXaWBjPiwRzJ0TA1feVd7D3X4e+AF65xtXcCtZY7D8A2Aob7o20bht
         iUmAIbMbWNvzaYijaIj/0WA+LB/Kh6WUBjKzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPqCC0+vy1j0qiDeRYjntaHgc93Wn+BCM3UBnz89/08=;
        b=U9QT5r2EAPQjAJ27i/2MHrpElE3Ln7ozWHt17esf2BTDQFhTmDezWGdLyXU5INL8oJ
         aNlDi06vl9QcCOZDaFpzP3odz3mNtp+ZmsLnXkWZN0YioCqU1rQoUdAJtzvaMaw4ZXJf
         eTQh4YFFYHDPvjyUBUuMmaQl060bhcRpVc/DoCrSZVi4CVbYe4yepE3VMBW02lFtUnoU
         BhtQ9i4R0WrflxZy2v3aXouLkQH/Bdp9KiAZIisyXQNCaFwbQUNdZGmMiCUJJqa/RxCr
         hqV1Odr5VrnXH1JLePm5PjNP+kcG3SibK6hvHm3Sktz44tpf7UlVAMMxxIaS99zp/NyN
         KzEg==
X-Gm-Message-State: AA+aEWagx8Lp/VFxuYC0ZU2LnbbccjZYOzswn/ufGI+mJCE/AjVUiL83
        oE4RgW0iOBgZxrb9SXTKYchK3/nzBVQETzSZOfU=
X-Google-Smtp-Source: AFSGD/WXxv23V6WkJiO5aC/pbouxGh9zlC0JbjhkmgquWky5+rk6VtMHYR3uN/2CoVBjJxkBxrGanGj4Zn9icuHHM+4=
X-Received: by 2002:a37:a391:: with SMTP id m139mr862987qke.11.1544749365974;
 Thu, 13 Dec 2018 17:02:45 -0800 (PST)
MIME-Version: 1.0
References: <1544559161-21468-1-git-send-email-eajames@linux.ibm.com> <1544559161-21468-3-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1544559161-21468-3-git-send-email-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 14 Dec 2018 11:32:33 +1030
Message-ID: <CACPK8XcY_c9NzNv-WyZcz+mZ5c2jixyCzEQAK-+t0QvQ_uJXwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: aspeed: Setup video engine clocking
To:     eajames@linux.ibm.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

On Wed, 12 Dec 2018 at 06:42, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add the video engine reset bit. Add eclk mux and clock divider table.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk-aspeed.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 5961367..f16ce7d 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -87,7 +87,7 @@ struct aspeed_clk_gate {
>  /* TODO: ask Aspeed about the actual parent data */
>  static const struct aspeed_gate_data aspeed_gates[] = {
>         /*                               clk rst   name                 parent  flags */
> -       [ASPEED_CLK_GATE_ECLK] =        {  0, -1, "eclk-gate",          "eclk", 0 }, /* Video Engine */
> +       [ASPEED_CLK_GATE_ECLK] =        {  0,  6, "eclk-gate",          "eclk", 0 }, /* Video Engine */


>         [ASPEED_CLK_GATE_GCLK] =        {  1,  7, "gclk-gate",          NULL,   0 }, /* 2D engine */
>         [ASPEED_CLK_GATE_MCLK] =        {  2, -1, "mclk-gate",          "mpll", CLK_IS_CRITICAL }, /* SDRAM */
>         [ASPEED_CLK_GATE_VCLK] =        {  3,  6, "vclk-gate",          NULL,   0 }, /* Video Capture */
> @@ -113,6 +113,24 @@ struct aspeed_clk_gate {
>         [ASPEED_CLK_GATE_LHCCLK] =      { 28, -1, "lhclk-gate",         "lhclk", 0 }, /* LPC master/LPC+ */
>  };
>
> +static const char * const eclk_parent_names[] = {
> +       "mpll",

Is the mpll really an input to the eclk?

> +       "hpll",
> +       "dpll",

We don't have a dpll in the driver that I can see.

> +};
> +
> +static const struct clk_div_table ast2500_eclk_div_table[] = {

Is the clocking setup different on the ast2400?

> +       { 0x0, 2 },
> +       { 0x1, 2 },
> +       { 0x2, 3 },
> +       { 0x3, 4 },
> +       { 0x4, 5 },
> +       { 0x5, 6 },
> +       { 0x6, 7 },
> +       { 0x7, 8 },
> +       { 0 }
> +};

> @@ -317,6 +338,7 @@ struct aspeed_reset {
>         [ASPEED_RESET_PECI]     = 10,
>         [ASPEED_RESET_I2C]      =  2,
>         [ASPEED_RESET_AHB]      =  1,
> +       [ASPEED_RESET_VIDEO]    =  6,

You've added the reset line to the ASPEED_CLK_GATE_ECLK clock so you
do not need to separately expose the reset controller. Instead
enabling the clock will deassert the rest line for you.

This means you should drop the change from the header too, and it
affects the bindings document for the video engine.

>
>         /*
>          * SCUD4 resets start at an offset to separate them from
> @@ -522,6 +544,22 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_clk_data->hws[ASPEED_CLK_24M] = hw;
>
> +       hw = clk_hw_register_mux(dev, "eclk-mux", eclk_parent_names,
> +                                ARRAY_SIZE(eclk_parent_names), 0,
> +                                scu_base + ASPEED_CLK_SELECTION, 2, 0x3, 0,
> +                                &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_clk_data->hws[ASPEED_CLK_ECLK_MUX] = hw;
> +
> +       hw = clk_hw_register_divider_table(dev, "eclk", "eclk-mux", 0,
> +                                          scu_base + ASPEED_CLK_SELECTION, 28,
> +                                          3, 0, soc_data->eclk_div_table,
> +                                          &aspeed_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
> +
>         /*
>          * TODO: There are a number of clocks that not included in this driver
>          * as more information is required:
> @@ -531,7 +569,6 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>          *   RGMII
>          *   RMII
>          *   UART[1..5] clock source mux
> -        *   Video Engine (ECLK) mux and clock divider
>          */
>
>         for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
> --
> 1.8.3.1
>
