Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70DFC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB52214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p31Z6sBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB52214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJQIyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:54:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:6808 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeJQIyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539738076; x=1571274076;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qzltMKBFD9GBZjcn5ePHd3WcmyNOpRLo7a7/Sa9inz0=;
  b=p31Z6sBz0gUn/V4e2n7K4xLE8At2QFLwJVQZBtlS16FDnrP9qdO7078v
   hnagTBBK4QxRE/oO6m6FNl2/HusOHnqglS4KmnwXr8sNVGXFdNsvU6OQy
   DwUiMpKEtBd8E6rPdDLhULnGKhErA4aQ8wUkztXtcHH1V8iZPzwU/4/kE
   SGMbtg4oUehtr0qqJMCQw2AJyGi9vdUTq3l9dZ9U/jTUGz+ZsymMRqzOz
   4HPfMHpL2z2ExOIvCZrazFp1UDsH3HGhxT2m2jdK2k4Y9qYPIF9+BS47W
   9PeaCmSpyxAxWIjX6oeR8k/5MyQaXXqJe+BgjsGcCPTWa/1cypPAx5YNG
   w==;
X-IronPort-AV: E=Sophos;i="5.54,389,1534780800"; 
   d="scan'208";a="92111020"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2018 09:01:15 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 16 Oct 2018 17:46:20 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.73.114]) ([10.111.73.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Oct 2018 18:01:15 -0700
From:   Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFC 4/4] gpio: sifive: Add GPIO driver for SiFive SoCs
To:     Linus Walleij <linus.walleij@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-5-git-send-email-atish.patra@wdc.com>
 <CACRpkdaoBwqQ4V5Hm9f_G5_jrdkvjT5anhBK1_HoFTj6=cba-Q@mail.gmail.com>
Message-ID: <d8fe9a17-283c-e2ad-9e01-2754b35699b4@wdc.com>
Date:   Tue, 16 Oct 2018 18:01:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdaoBwqQ4V5Hm9f_G5_jrdkvjT5anhBK1_HoFTj6=cba-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 5:35 AM, Linus Walleij wrote:
> Hi Atish,
> 
> thanks for your patch!
> 
> On Tue, Oct 9, 2018 at 8:51 PM Atish Patra <atish.patra@wdc.com> wrote:
> 
>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>
>> Adds the GPIO driver for SiFive RISC-V SoCs.
>>
>> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>> [Atish: Various fixes and code cleanup]
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> 
> (...)
> 
>> +config GPIO_SIFIVE
>> +       bool "SiFive GPIO support"
>> +       depends on OF_GPIO
>> +       select GPIOLIB_IRQCHIP
> 
> I suggest to add
> select GPIO_GENERIC as per below.
> 
> Maybe select REGMAP_MMIO as well.

ok.

> 
>> +       help
>> +         Say yes here to support the GPIO device on SiFive SoCs.
>> +
> 
>> +#include <linux/of_irq.h>
>> +#include <linux/irqchip/chained_irq.h>
> 
> Do you need these two? I think <linux/gpio/driver.h>
> will bring them in for you.
> 

driver.h only brings chained_irq.h. of_irq.h is still required. Right ?

>> +#include <linux/pinctrl/consumer.h>
> 
> Are you using this?

My bad. Left over from the old code. I will remove it.

> 
>> +struct sifive_gpio {
>> +       raw_spinlock_t          lock;
>> +       void __iomem            *base;
>> +       struct gpio_chip        gc;
>> +       unsigned long           enabled;
> 
> Since max GPIO is 32 why not use an u32 for this?
> 

Sure.

>> +       unsigned int            trigger[MAX_GPIO];
>> +       unsigned int            irq_parent[MAX_GPIO];
>> +       struct sifive_gpio      *self_ptr[MAX_GPIO];
>> +};
>> +
>> +static void sifive_assign_bit(void __iomem *ptr, unsigned int offset, int value)
>> +{
>> +       /*
>> +        * It's frustrating that we are not allowed to use the device atomics
>> +        * which are GUARANTEED to be supported by this device on RISC-V
>> +        */
>> +       u32 bit = BIT(offset), old = ioread32(ptr);
>> +
>> +       if (value)
>> +               iowrite32(old | bit, ptr);
>> +       else
>> +               iowrite32(old & ~bit, ptr);
>> +}
> 
> This looks like a mask and set implementation, you are
> essentially reinventing regmap MMIO and the
> regmap_update_bits() call. Could you look into
> just using regmap MMIO in that case?
> 
> If you need examples, look at gpio-mvebu.c that calls
> devm_regmap_init_mmio() for example.
> 

That's really cool. Sorry, for not checking that earlier.
I am pretty new to this.

>> +static int sifive_direction_input(struct gpio_chip *gc, unsigned int offset)
>> +static int sifive_direction_output(struct gpio_chip *gc, unsigned int offset,
>> +static int sifive_get_direction(struct gpio_chip *gc, unsigned int offset)
>> +static int sifive_get_value(struct gpio_chip *gc, unsigned int offset)
>> +static void sifive_set_value(struct gpio_chip *gc, unsigned int offset,
> 
> These functions look like a typical hardware that can use
> 
> GPIOLIB_GENERIC and bgpio_init() to set up the accessors.
> 
> See gpio-ftgpio010.c for an example.
> 
> As a bonus you will get .get/.set_multiple implemented by
> the generic GPIO.
> 

Great. This will reduce the driver a code by a big factor.
Thanks for the pointer.


>> +static void sifive_irq_enable(struct irq_data *d)
>> +static void sifive_irq_disable(struct irq_data *d)
> (...)
>> +static struct irq_chip sifive_irqchip = {
>> +       .name           = "sifive-gpio",
>> +       .irq_set_type   = sifive_irq_set_type,
>> +       .irq_mask       = sifive_irq_mask,
>> +       .irq_unmask     = sifive_irq_unmask,
>> +       .irq_enable     = sifive_irq_enable,
>> +       .irq_disable    = sifive_irq_disable,
> 
> The handling of .irq_enable and .irq_disable has
> changed upstream. Please align with the new codebase
> as changed by Hans Verkuil:
> 
> commit 461c1a7d4733d1dfd5c47b040cf32a5e7eefbc6c
> "gpiolib: override irq_enable/disable"
> commit 4e9439ddacea06f35acce4d374bf6bd0acf99bc8
> "gpiolib: add flag to indicate if the irq is disabled"
> 
> You will need to rebase your work on the v4.20-rc1 once it is
> out. Right now the changes are on linux-next or my devel
> branch.

Will do.

> 
>> +       ngpio = of_irq_count(node);
>> +       if (ngpio >= MAX_GPIO) {
>> +               dev_err(dev, "Too many GPIO interrupts (max=%d)\n", MAX_GPIO);
>> +               return -ENXIO;
>> +       }
> (...)
>> +       for (gpio = 0; gpio < ngpio; ++gpio) {
>> +               irq = platform_get_irq(pdev, gpio);
>> +               if (irq < 0) {
>> +                       dev_err(dev, "invalid IRQ\n");
>> +                       gpiochip_remove(&chip->gc);
>> +                       return -ENODEV;
>> +               }
> 
> This is an hierarchical IRQ so it should use an hierarchical
> irqdomain.
> 
> I am discussing with Thierry to make more generic irq domains
> for hierarchical IRQ GPIOs, until then you have to look at
> gpio-thunderx.c, gpio-uniphier.c or gpio-xgene-sb.c that all
> use hierarchical IRQs.
> 

Thanks. I will convert them to hierarchical IRQ.

Regards,
Atish
> Yours,
> Linus Walleij
> 



