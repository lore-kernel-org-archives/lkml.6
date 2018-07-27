Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996AAC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B68208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbUm7urg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B68208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbeG0O3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:29:48 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46593 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbeG0O3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:29:48 -0400
Received: by mail-vk0-f67.google.com with SMTP id b14-v6so2404201vke.13;
        Fri, 27 Jul 2018 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VAOeTaWahPDyn3xqk869/J06OLHjBONgOekfjZQfzEY=;
        b=JbUm7urgYbL0YD4z4Jr073sInpctIkiqHx4o5yy8N2qMaBax8+P2SpX/DLyFxWmHWj
         qL6XQxExDo2XiC6kNLAvbN5fY8uwK/pp35dItVRJ5saMOqFIrvsg6ttiqDCDH3hj17SW
         uiRtsztTCHsAM/OXZgCwJr4PJ98eD2W/WehZENHG1NjDmj5TwwX7jNU5liBIvIyQgyOE
         eMfMfJVDmQA1F4j6wGR38EPCIEhmtnxIk2RzfxFu8Pz6vpmUt/snv4pX+ADXMMfR0cu3
         l4DVYGRfYJNrWNOEFuyK+Q4w+BPDkTlDzmVTvow1+4huOjDlW5WMXgXXVKB+H2kvO2HI
         Zumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VAOeTaWahPDyn3xqk869/J06OLHjBONgOekfjZQfzEY=;
        b=T0UEeQb4LWN5upayxCXKjTNO8XpCivukUnN1lSJkDqgUBvWsCKS/01hfK5g4MV5KI1
         11ApwyH0L3uxDdi3ITadOanyZGYfIwGfE2MIwdg9Tia9qYWjHGM/DHEtU1DwsoVDQwzj
         71h95a9ACy9ToK/H58g+e1iKx+VVkE/4koKeyovT54qntC4snIjQecDBCmm9tbZ2H9hh
         tZzKtKdDKRTNIeXBxBcWvmf5l7Rxe961T+y2x/ZsL0w+D8E8uKSK+GzofjZGAfL3FB/w
         MjswkjZAAekQpcp/KsURF1SZejiwj8WkCyabp6TQYYjEZncHLrubLekh9mHVRL7ZM1Yj
         uljQ==
X-Gm-Message-State: AOUpUlEWlnGZhQV5K0ILcVMgMkXabklVPo89UbuniyW/jm1q+7BT9kXe
        EzMQf3xvQVLWNOSBoHQjh8JmB7dPeJRX6E5FVBo=
X-Google-Smtp-Source: AAOMgpfToTtndqUmJ8r45TBgSc4ABWGdq6Y8xu9djuYI4RvBredxD8DZ+ItoFQuqbMaEpMXAqUCn7dCiemEhhq/pf6o=
X-Received: by 2002:a1f:920b:: with SMTP id u11-v6mr3881974vkd.58.1532696876039;
 Fri, 27 Jul 2018 06:07:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 06:07:54
 -0700 (PDT)
In-Reply-To: <20180727120535.16504-3-alexandre.belloni@bootlin.com>
References: <20180727120535.16504-1-alexandre.belloni@bootlin.com> <20180727120535.16504-3-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Jul 2018 16:07:54 +0300
Message-ID: <CAHp75Vdk+rqMu6OJOE8Kd-Wib3su+f9tQw6Nqhm9diEvBqaDNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] spi: dw-mmio: add MSCC Ocelot support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 3:05 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Because the SPI controller deasserts the chip select when the TX fifo is
> empty (which may happen in the middle of a transfer), the CS should be
> handled by linux. Unfortunately, some or all of the first four chip
> selects are not muxable as GPIOs, depending on the SoC.
>
> There is a way to bitbang those pins by using the SPI boot controller so
> use it to set the chip selects.
>
> At init time, it is also necessary to give control of the SPI interface to
> the Designware IP.

Thanks for an update! My comments below (most of them just about style).

First of all, can we use 'controller' over the 'master' in the code?

>  .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-

>  Required properties:
> -- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi"
> -- reg : The register base for the controller. For "mscc,<soc>-spi", a second
> -  register set is required (named ICPU_CFG:SPI_MST)
> +- compatible : "snps,dw-apb-ssi"
> +- reg : The register base for the controller.

This hunk is odd.

>  struct dw_spi_mmio {
>         struct dw_spi  dws;
>         struct clk     *clk;
> +       void           *priv;
>  };

> +#define MSCC_SPI_MST_SW_MODE                   0x14
> +#define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE  BIT(13)
> +#define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)      (x << 5)

+ blank line ?

> +struct dw_spi_mscc {
> +       struct regmap       *syscon;

> +       void __iomem        *spi_mst;

A nit: do we need to repeat "spi" here?

> +};

> +       if (!enable)
> +               dw_writel(dws, DW_SPI_SER, BIT(cs));

This sounds like

dw_set_cs(spi, enable);

> +       dwsmscc = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mscc),
> +                              GFP_KERNEL);

sizeof(*dwsmcc)  and one line in the result?

> +       /* Deassert all CS */
> +       writel(0, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);

Hmm... Don't we need to call dw_set_cs() for all of them as well?
If yes, perhaps better to call custom set_cs() in a loop?

-- 
With Best Regards,
Andy Shevchenko
