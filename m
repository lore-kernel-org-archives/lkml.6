Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DC1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EA420671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EA420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeGZKyc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:54:32 -0400
Received: from mx.socionext.com ([202.248.49.38]:14570 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbeGZKyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:54:32 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Jul 2018 18:38:29 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 42F461800A9;
        Thu, 26 Jul 2018 18:38:29 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 26 Jul 2018 18:38:29 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 16AEC403AD;
        Thu, 26 Jul 2018 18:38:29 +0900 (JST)
Received: from DESKTOP0FARE34 (unknown [10.213.134.218])
        by yuzu.css.socionext.com (Postfix) with ESMTP id C8E4F120424;
        Thu, 26 Jul 2018 18:38:28 +0900 (JST)
From:   "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To:     "'Andy Shevchenko'" <andy.shevchenko@gmail.com>
Cc:     "Mark Brown" <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        =?utf-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= 
        <yamada.masahiro@socionext.com>,
        "linux-spi" <linux-spi@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Hayashi=2C_Kunihiko/=E6=9E=97_=E9=82=A6=E5=BD=A6?= 
        <hayashi.kunihiko@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com> <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com> <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
In-Reply-To: <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
Subject: RE: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
Date:   Thu, 26 Jul 2018 18:38:25 +0900
Message-ID: <001b01d424c4$66e04230$34a0c690$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUJK+Lb4PtBS+ckEWxak8O5zFtw6SgmfYAgACbT7A=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thank you for your check!


> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> Sent: Thursday, July 26, 2018 5:46 PM
> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
> 
> On Thu, Jul 26, 2018 at 10:09 AM, Keiji Hayashibara <hayashibara.keiji@socionext.com> wrote:
> > Add SPI controller driver implemented in Socionext UniPhier SoCs.
> >
> > UniPhier SoCs have two types SPI controllers; SCSSI supports a single
> > channel, and MCSSI supports multiple channels.
> > This driver supports SCSSI only.
> >
> > This controller has 32bit TX/RX FIFO with depth of eight entry, and
> > supports the SPI master mode only.
> >
> > This commit is implemented in PIO transfer mode, not DMA transfer.
> 
> Few style realted comments.
> 
> > +#include <asm/unaligned.h>
> > +#include <linux/kernel.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spi/spi.h>
> 
> Slightly better to keep them in order and put asm/* at the last.

I see. I will modify this.


> > +#define SSI_TIMEOUT            2000    /* ms */
> 
> SSI_TIMEOUT_MS ?
> 
> > +#define SSI_CTL                        0x0
> 
> Slightly better to keep same width for the addresses, like 0x00 here.
> 
> > +#define SSI_CKS                        0x4
> 
> > +#define SSI_TXWDS              0x8
> 
> > +#define SSI_RXWDS              0xc
> 
> Ditto.

I will modify about above.

> 
> > +static int uniphier_spi_set_baudrate(struct spi_device *spi, unsigned
> > +int speed) {
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> > +       u32 val, ckrat;
> > +
> > +       /*
> > +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
> > +        * round up as we look for equal or less speed
> > +        */
> > +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);
> 
> > +       ckrat = roundup(ckrat, 2);
> 
> ckrat += ckrat & 1;
> 
> ?

It's simple. I will modify.


> > +       /* check if requested speed is too small */
> > +       if (ckrat > SSI_MAX_CLK_DIVIDER)
> 
> > +               return -EINVAL;
> 
> So, does this critical?

If set the value to SSI_MAX_CLK_DIVIDER, the clock frequency will be set high.
I don't change it to high frequency, and it is daringly an error.
On the other hand, when changing to low frequency, I will change it automatically.

> > +
> > +       if (ckrat < SSI_MIN_CLK_DIVIDER)
> > +               ckrat = SSI_MIN_CLK_DIVIDER;
> 
> clamp_val()  / max() ?

I will modify it to use max().

> 
> > +       val = readl(priv->base + SSI_CKS);
> > +       val &= ~SSI_CKS_CKRAT_MASK;
> > +       val |= ckrat & SSI_CKS_CKRAT_MASK;
> > +       writel(val, priv->base + SSI_CKS);
> > +
> > +       return 0;
> > +}
> 
> > +       priv->irq = platform_get_irq(pdev, 0);
> > +       if (priv->irq < 0) {
> > +               dev_err(&pdev->dev, "failed to get IRQ\n");
> 
> > +               ret = -ENXIO;
> 
> What's wrong with
> 
> ret = priv->irq;
> 
> ?

I will modify it.

> > +               goto out_disable_clk;
> > +       }
> 
> > +static const struct of_device_id uniphier_spi_match[] = {
> > +       { .compatible = "socionext,uniphier-scssi", },
> 
> > +       { /* sentinel */ },
> 
> Slightly better without comma.

OK. I will modify this.

-----------------
Best Regards,
Keiji Hayashibara



> > +};
> > +MODULE_DEVICE_TABLE(of, uniphier_spi_match);
> 
> --
> With Best Regards,
> Andy Shevchenko


