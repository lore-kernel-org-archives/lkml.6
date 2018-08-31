Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E1C2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="muUwCBq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E1C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeIABm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:42:56 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35129 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeIABm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:42:56 -0400
Received: by mail-qt0-f193.google.com with SMTP id j7-v6so16171435qtp.2;
        Fri, 31 Aug 2018 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flIUvzKgAYFDlFX98R4KQ1waPzIR6o3ReWiHYfKtiCE=;
        b=muUwCBq8YjMbeHDt7yY4oVzLYCowyj/gUsYzYrBtnJVknT8Wmm97SzH6H4tnWFz98j
         KHnb52JHf1ElTSnvEwE+HOO+Aro3pX2PKB1Njcy67cfF0i3B90zzBHBTOV2SxADKf+PG
         UMMzIUQ5tSi0zbKpBHqrFQRn8WHl8aTw4/3wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flIUvzKgAYFDlFX98R4KQ1waPzIR6o3ReWiHYfKtiCE=;
        b=C8qN2MKnvfkrnrg7sHWAEr9yuk5tRii3ixkREkvzoSPL2cwrPESch/fIH2Hv7V6tTq
         jsM1zvgPNU26vM8dv7zTOvgw7qcb/UcT2/n7x3o0SLAvBLHXBDMXdoGzGbw+jCDhgk0f
         Xmgd2G1GG1/ImQ4oHbTyPFMQXNemrmpFIav9y5JXgukhPXOpdv/5U/MRdLvy0ngfTB4B
         NpheHZ7xOL+obhNvMppfpGD70h0pxOKkUIaQgcuomW1nOvCTC6b+77LKjOs3Z6q0jcPU
         O5i5Xe4TPh3+ZMy3yC+p9S7vKqsM5CjbkPKX673QiWsMt/YJdUB6nBXbXDScAAiV0RST
         WA1g==
X-Gm-Message-State: APzg51DZ+0ovryWs4IaK/61PEtCuCclBUx7uy9d93184AZq9bNTOaWUR
        lAIt7DZNg3B4LHgc9t+LrYlQB0kyhFCGdAacGoQ=
X-Google-Smtp-Source: ANB0VdaD3S5t3/k/DE8bF4EkOCz91aLzkP7p0h8bGr/v5rHvZnyQtERl/qQ1swLB1htshsvU2jBtoKwrNbFVasBB1CQ=
X-Received: by 2002:a0c:eac3:: with SMTP id y3-v6mr16753036qvp.89.1535751213363;
 Fri, 31 Aug 2018 14:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com> <1535576973-8067-3-git-send-email-eajames@linux.vnet.ibm.com>
In-Reply-To: <1535576973-8067-3-git-send-email-eajames@linux.vnet.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 31 Aug 2018 14:33:22 -0700
Message-ID: <CACPK8Xe+aSgFvysXFJaGdSMjG4CsEL6-iy5d79ou1+VFTV_aQw@mail.gmail.com>
Subject: Re: [PATCH 2/4] clock: aspeed: Setup video engine clocking
To:     eajames <eajames@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>, mchehab@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 at 14:09, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>
> Add the video engine reset bit. Add eclk mux and clock divider table.
>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

I'm travelling this week, so I'll be able to take a closer look next week.

At a glance it looks okay.

Cheers,

Joel

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
> +       "hpll",
> +       "dpll",
> +};
> +
> +static const struct clk_div_table ast2500_eclk_div_table[] = {
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
> +
>  static const struct clk_div_table ast2500_mac_div_table[] = {
>         { 0x0, 4 }, /* Yep, really. Aspeed confirmed this is correct */
>         { 0x1, 4 },
> @@ -192,18 +210,21 @@ static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
>
>  struct aspeed_clk_soc_data {
>         const struct clk_div_table *div_table;
> +       const struct clk_div_table *eclk_div_table;
>         const struct clk_div_table *mac_div_table;
>         struct clk_hw *(*calc_pll)(const char *name, u32 val);
>  };
>
>  static const struct aspeed_clk_soc_data ast2500_data = {
>         .div_table = ast2500_div_table,
> +       .eclk_div_table = ast2500_eclk_div_table,
>         .mac_div_table = ast2500_mac_div_table,
>         .calc_pll = aspeed_ast2500_calc_pll,
>  };
>
>  static const struct aspeed_clk_soc_data ast2400_data = {
>         .div_table = ast2400_div_table,
> +       .eclk_div_table = ast2400_div_table,
>         .mac_div_table = ast2400_div_table,
>         .calc_pll = aspeed_ast2400_calc_pll,
>  };
> @@ -317,6 +338,7 @@ struct aspeed_reset {
>         [ASPEED_RESET_PECI]     = 10,
>         [ASPEED_RESET_I2C]      =  2,
>         [ASPEED_RESET_AHB]      =  1,
> +       [ASPEED_RESET_VIDEO]    =  6,
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
