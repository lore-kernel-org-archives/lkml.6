Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279C4C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D379B2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D379B2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeGZMMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:12:06 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:28455 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbeGZMMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:12:06 -0400
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="scan'208";a="14067181"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Jul 2018 03:55:48 -0700
Received: from [10.145.4.57] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Thu, 26 Jul 2018
 03:55:47 -0700
Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        'Andy Shevchenko' <andy.shevchenko@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= 
        <yamada.masahiro@socionext.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SGF5YXNoaSwgS3VuaWhpa28v5p6XIOmCpuW9pg==?= 
        <hayashi.kunihiko@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
 <001b01d424c4$66e04230$34a0c690$@socionext.com>
From:   Radu Pirea <radu.pirea@microchip.com>
Message-ID: <ab87c6a7-4ead-6492-9e47-42e6ab701d1c@microchip.com>
Date:   Thu, 26 Jul 2018 13:57:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <001b01d424c4$66e04230$34a0c690$@socionext.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/26/2018 12:38 PM, Keiji Hayashibara wrote:
> Hello Andy,
> 
> Thank you for your check!
> 
> 
>> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>> Sent: Thursday, July 26, 2018 5:46 PM
>> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
>> Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
>>
>> On Thu, Jul 26, 2018 at 10:09 AM, Keiji Hayashibara <hayashibara.keiji@socionext.com> wrote:
>>> Add SPI controller driver implemented in Socionext UniPhier SoCs.
>>>
>>> UniPhier SoCs have two types SPI controllers; SCSSI supports a single
>>> channel, and MCSSI supports multiple channels.
>>> This driver supports SCSSI only.
>>>
>>> This controller has 32bit TX/RX FIFO with depth of eight entry, and
>>> supports the SPI master mode only.
>>>
>>> This commit is implemented in PIO transfer mode, not DMA transfer.
>>
>> Few style realted comments.
>>
>>> +#include <asm/unaligned.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/bitfield.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/spi/spi.h>
>>
>> Slightly better to keep them in order and put asm/* at the last.
> 
> I see. I will modify this.
> 
> 
>>> +#define SSI_TIMEOUT            2000    /* ms */
>>
>> SSI_TIMEOUT_MS ?
>>
>>> +#define SSI_CTL                        0x0
>>
>> Slightly better to keep same width for the addresses, like 0x00 here.
>>
>>> +#define SSI_CKS                        0x4
>>
>>> +#define SSI_TXWDS              0x8
>>
>>> +#define SSI_RXWDS              0xc
>>
>> Ditto.
> 
> I will modify about above.
> 
>>
>>> +static int uniphier_spi_set_baudrate(struct spi_device *spi, unsigned
>>> +int speed) {
>>> +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
>>> +       u32 val, ckrat;
>>> +
>>> +       /*
>>> +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
>>> +        * round up as we look for equal or less speed
>>> +        */
>>> +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);
>>
>>> +       ckrat = roundup(ckrat, 2);
>>
>> ckrat += ckrat & 1;
>>
>> ?
> 
> It's simple. I will modify.
> 
> 
>>> +       /* check if requested speed is too small */
>>> +       if (ckrat > SSI_MAX_CLK_DIVIDER)
>>
>>> +               return -EINVAL;
>>
>> So, does this critical?
> 
> If set the value to SSI_MAX_CLK_DIVIDER, the clock frequency will be set high.
> I don't change it to high frequency, and it is daringly an error.
> On the other hand, when changing to low frequency, I will change it automatically.
> 
>>> +
>>> +       if (ckrat < SSI_MIN_CLK_DIVIDER)
>>> +               ckrat = SSI_MIN_CLK_DIVIDER;

In fact you don't need this checks. You already set in probe function this.
master->max_speed_hz = DIV_ROUND_UP(clksrc, SSI_MIN_CLK_DIVIDER);
master->min_speed_hz = DIV_ROUND_UP(clksrc, SSI_MAX_CLK_DIVIDER);

The SPI core will check if transfer speed is higher than controller 
speed and if is, will set the transfer speed to master->max_speed_hz. In 
case of master->min_speed_hz, if transfer speed is lower than 
master->min_speed_hz __spi_validate(drivers/spi/spi.c) will return -EINVAL.

>>
>> clamp_val()  / max() ?
> 
> I will modify it to use max().
> 
>>
>>> +       val = readl(priv->base + SSI_CKS);
>>> +       val &= ~SSI_CKS_CKRAT_MASK;
>>> +       val |= ckrat & SSI_CKS_CKRAT_MASK;
>>> +       writel(val, priv->base + SSI_CKS);
>>> +
>>> +       return 0;
>>> +}
>>
>>> +       priv->irq = platform_get_irq(pdev, 0);
>>> +       if (priv->irq < 0) {
>>> +               dev_err(&pdev->dev, "failed to get IRQ\n");
>>
>>> +               ret = -ENXIO;
>>
>> What's wrong with
>>
>> ret = priv->irq;
>>
>> ?
> 
> I will modify it.
> 
>>> +               goto out_disable_clk;
>>> +       }
>>
>>> +static const struct of_device_id uniphier_spi_match[] = {
>>> +       { .compatible = "socionext,uniphier-scssi", },
>>
>>> +       { /* sentinel */ },
>>
>> Slightly better without comma.
> 
> OK. I will modify this.
> 
> -----------------
> Best Regards,
> Keiji Hayashibara
> 
> 
> 
>>> +};
>>> +MODULE_DEVICE_TABLE(of, uniphier_spi_match);
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
