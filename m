Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36100C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58282083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBZZ0hlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58282083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeGZKCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:02:02 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:32877 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbeGZKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:02:02 -0400
Received: by mail-ua0-f193.google.com with SMTP id i4-v6so582391uak.0;
        Thu, 26 Jul 2018 01:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kiA3LHrjgsk87XcaU3GUwPkHUqP5OeeG5ipSKUwa1Jw=;
        b=dBZZ0hlfZh8MdfDevrtosbKW1JGX33bQtuxMr0+BM0qu+vBigIJNaWvmDtr8g4CoX7
         yaYWhMM+I+1OgvcrxXBKHELNhiGTwOci4lR9jJlF2eMHb9W/RenaCBjAanIZVZhrD+Zp
         2thLOgGKlkr4VixsWa6hvgAxiaGG4HaNtwxlc8dHlX3LugywVvlV8Y2mrlUT4Px6W+QZ
         maRifLhg+TVBYHHgJQeXDp783JMh2B/ne66JdHQE/nQtnacEOF/51DmhFBy9IIOpfNj6
         sKPCFL0vkzBdMV7sd9s4vFbl3tgsFFNrHknib16OY2s2cI2PNF6dSPWe/TegaNLAnoOS
         9kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kiA3LHrjgsk87XcaU3GUwPkHUqP5OeeG5ipSKUwa1Jw=;
        b=j/MCS0xVw24tktZT7mRgtOmO4JtD7EU9uvVWIHVhpEISvp+8HawGRWqCOCJmhv+7Es
         ZdPDBjrLdDZLWfmh4npCmweTShpgMonRGWzeSYCmwh11MHNGD+oZMJwbRO4p/ephkmRb
         3rJXoFUVic4852fhRXuK7llUdd9Jq9fjSbWNg1qY+nhBYUF8R0XGPVvCDI1ZQu2Qv8C0
         IKsU/8O3SnFl8MnLeSFmIfQBbWeyTQ04d7Y5wHLrhcdIdDykuWnMzIgip6aysbFIRwXb
         yCJIgn1z7SAaIqIJHiDPox7qFnREnA+9/+FjX3Z2W0N0dF+hGYR3cpe6sNhLBXcRyLK+
         sBBQ==
X-Gm-Message-State: AOUpUlHUzpAOhbChQBikTJc3q/tl6qJHgpW6zN5PvXkPbNQ7YqxyykvN
        BFesCoTmogFy3LGk5vQUuG4zc6ZfzuHomPK9Uqc=
X-Google-Smtp-Source: AAOMgpccLVu69sx+04ZfV3pYCbP1iHMlKNHC86JuWIjzslTKtAEaj2oeFVwUTmvBhryixuDzOT8LH6UBhKy7uLsWUro=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr700675ual.28.1532594772676;
 Thu, 26 Jul 2018 01:46:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 01:46:12
 -0700 (PDT)
In-Reply-To: <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Jul 2018 11:46:12 +0300
Message-ID: <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:09 AM, Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:
> Add SPI controller driver implemented in Socionext UniPhier SoCs.
>
> UniPhier SoCs have two types SPI controllers; SCSSI supports a
> single channel, and MCSSI supports multiple channels.
> This driver supports SCSSI only.
>
> This controller has 32bit TX/RX FIFO with depth of eight entry,
> and supports the SPI master mode only.
>
> This commit is implemented in PIO transfer mode, not DMA transfer.

Few style realted comments.

> +#include <asm/unaligned.h>
> +#include <linux/kernel.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>

Slightly better to keep them in order and put asm/* at the last.

> +#define SSI_TIMEOUT            2000    /* ms */

SSI_TIMEOUT_MS ?

> +#define SSI_CTL                        0x0

Slightly better to keep same width for the addresses, like 0x00 here.

> +#define SSI_CKS                        0x4

> +#define SSI_TXWDS              0x8

> +#define SSI_RXWDS              0xc

Ditto.


> +static int uniphier_spi_set_baudrate(struct spi_device *spi, unsigned int speed)
> +{
> +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> +       u32 val, ckrat;
> +
> +       /*
> +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
> +        * round up as we look for equal or less speed
> +        */
> +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);

> +       ckrat = roundup(ckrat, 2);

ckrat += ckrat & 1;

?

> +       /* check if requested speed is too small */
> +       if (ckrat > SSI_MAX_CLK_DIVIDER)

> +               return -EINVAL;

So, does this critical?

> +
> +       if (ckrat < SSI_MIN_CLK_DIVIDER)
> +               ckrat = SSI_MIN_CLK_DIVIDER;

clamp_val()  / max() ?

> +       val = readl(priv->base + SSI_CKS);
> +       val &= ~SSI_CKS_CKRAT_MASK;
> +       val |= ckrat & SSI_CKS_CKRAT_MASK;
> +       writel(val, priv->base + SSI_CKS);
> +
> +       return 0;
> +}

> +       priv->irq = platform_get_irq(pdev, 0);
> +       if (priv->irq < 0) {
> +               dev_err(&pdev->dev, "failed to get IRQ\n");

> +               ret = -ENXIO;

What's wrong with

ret = priv->irq;

?

> +               goto out_disable_clk;
> +       }

> +static const struct of_device_id uniphier_spi_match[] = {
> +       { .compatible = "socionext,uniphier-scssi", },

> +       { /* sentinel */ },

Slightly better without comma.

> +};
> +MODULE_DEVICE_TABLE(of, uniphier_spi_match);

-- 
With Best Regards,
Andy Shevchenko
