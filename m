Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A110EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8E32087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFUBM7+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8E32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJJT5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:57:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39661 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJJT5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:57:30 -0400
Received: by mail-it1-f195.google.com with SMTP id w200-v6so7661951itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LK9+G6KymxKlkyxnkqpHkZFSykVTIPaNiAUqgugUA9Q=;
        b=GFUBM7+fUw2M70npY32WActEysjzu9z/LR6Fe27VNBC769C1UHnZCXXMtEfC5tKOOp
         /eOV+FPRWAJ7gqpL57o2yjEEysIsnkP49siSfeuJuPRWThJE20pVQZbi3r7IrRC3bMfZ
         RGTpZSmCZs3NWNhOHqhwJINCX1Be/WoDoIOZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LK9+G6KymxKlkyxnkqpHkZFSykVTIPaNiAUqgugUA9Q=;
        b=LFPNMEX3WHc/GqJBXRHHQBWKN43Syc1Di8UW3l/91w0fZQCJqha/2gSFeFKPlxRWLj
         6x2kLh13aCQ5RpBkQL+svaTAZqTuIRX5GD4DvG0btxiBbUo/RS8igIMgrSLx12duXGDU
         qC7zTwPHLsjHlfD784JVROhn+B2tZsXsguGTNqrQNA0GqzWgPESAjRl8JXPALpgEHYip
         ZkBGgW3590atE8rRaw6UKOEIlzJwJ8xjjAYkQb23BCP1CzS0fOf1aFrTd03Z0qYOLnSV
         3ggMTH2FbL3AVj4f/8nHVPUIWPOtab2j0N/ou+yrmIv2paab5zGRjxz5uteyuUvPmKtn
         sHaQ==
X-Gm-Message-State: ABuFfoikXCMBGq2ZdTc8uBvujSe9sPfBIxMQRfvRXD+VxMIMop5BvUO1
        KNrUTWIQxH+GnFpLxm1zsfbd7aJPux0cwobD+5uK+A==
X-Google-Smtp-Source: ACcGV61pZB4/wRZzO5PTioNsRJR2UzNnZD7+zC9PHibIDNtS1MeFg+J/Wfl9xwlGbj9WLSHQ0AmgYSGrokyZtRoMqXo=
X-Received: by 2002:a02:7789:: with SMTP id g131-v6mr25519247jac.66.1539174931405;
 Wed, 10 Oct 2018 05:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com> <1539111085-25502-5-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1539111085-25502-5-git-send-email-atish.patra@wdc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 14:35:19 +0200
Message-ID: <CACRpkdaoBwqQ4V5Hm9f_G5_jrdkvjT5anhBK1_HoFTj6=cba-Q@mail.gmail.com>
Subject: Re: [RFC 4/4] gpio: sifive: Add GPIO driver for SiFive SoCs
To:     atish.patra@wdc.com,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

thanks for your patch!

On Tue, Oct 9, 2018 at 8:51 PM Atish Patra <atish.patra@wdc.com> wrote:

> From: "Wesley W. Terpstra" <wesley@sifive.com>
>
> Adds the GPIO driver for SiFive RISC-V SoCs.
>
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Various fixes and code cleanup]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

(...)

> +config GPIO_SIFIVE
> +       bool "SiFive GPIO support"
> +       depends on OF_GPIO
> +       select GPIOLIB_IRQCHIP

I suggest to add
select GPIO_GENERIC as per below.

Maybe select REGMAP_MMIO as well.

> +       help
> +         Say yes here to support the GPIO device on SiFive SoCs.
> +

> +#include <linux/of_irq.h>
> +#include <linux/irqchip/chained_irq.h>

Do you need these two? I think <linux/gpio/driver.h>
will bring them in for you.

> +#include <linux/pinctrl/consumer.h>

Are you using this?

> +struct sifive_gpio {
> +       raw_spinlock_t          lock;
> +       void __iomem            *base;
> +       struct gpio_chip        gc;
> +       unsigned long           enabled;

Since max GPIO is 32 why not use an u32 for this?

> +       unsigned int            trigger[MAX_GPIO];
> +       unsigned int            irq_parent[MAX_GPIO];
> +       struct sifive_gpio      *self_ptr[MAX_GPIO];
> +};
> +
> +static void sifive_assign_bit(void __iomem *ptr, unsigned int offset, int value)
> +{
> +       /*
> +        * It's frustrating that we are not allowed to use the device atomics
> +        * which are GUARANTEED to be supported by this device on RISC-V
> +        */
> +       u32 bit = BIT(offset), old = ioread32(ptr);
> +
> +       if (value)
> +               iowrite32(old | bit, ptr);
> +       else
> +               iowrite32(old & ~bit, ptr);
> +}

This looks like a mask and set implementation, you are
essentially reinventing regmap MMIO and the
regmap_update_bits() call. Could you look into
just using regmap MMIO in that case?

If you need examples, look at gpio-mvebu.c that calls
devm_regmap_init_mmio() for example.

> +static int sifive_direction_input(struct gpio_chip *gc, unsigned int offset)
> +static int sifive_direction_output(struct gpio_chip *gc, unsigned int offset,
> +static int sifive_get_direction(struct gpio_chip *gc, unsigned int offset)
> +static int sifive_get_value(struct gpio_chip *gc, unsigned int offset)
> +static void sifive_set_value(struct gpio_chip *gc, unsigned int offset,

These functions look like a typical hardware that can use

GPIOLIB_GENERIC and bgpio_init() to set up the accessors.

See gpio-ftgpio010.c for an example.

As a bonus you will get .get/.set_multiple implemented by
the generic GPIO.

> +static void sifive_irq_enable(struct irq_data *d)
> +static void sifive_irq_disable(struct irq_data *d)
(...)
> +static struct irq_chip sifive_irqchip = {
> +       .name           = "sifive-gpio",
> +       .irq_set_type   = sifive_irq_set_type,
> +       .irq_mask       = sifive_irq_mask,
> +       .irq_unmask     = sifive_irq_unmask,
> +       .irq_enable     = sifive_irq_enable,
> +       .irq_disable    = sifive_irq_disable,

The handling of .irq_enable and .irq_disable has
changed upstream. Please align with the new codebase
as changed by Hans Verkuil:

commit 461c1a7d4733d1dfd5c47b040cf32a5e7eefbc6c
"gpiolib: override irq_enable/disable"
commit 4e9439ddacea06f35acce4d374bf6bd0acf99bc8
"gpiolib: add flag to indicate if the irq is disabled"

You will need to rebase your work on the v4.20-rc1 once it is
out. Right now the changes are on linux-next or my devel
branch.

> +       ngpio = of_irq_count(node);
> +       if (ngpio >= MAX_GPIO) {
> +               dev_err(dev, "Too many GPIO interrupts (max=%d)\n", MAX_GPIO);
> +               return -ENXIO;
> +       }
(...)
> +       for (gpio = 0; gpio < ngpio; ++gpio) {
> +               irq = platform_get_irq(pdev, gpio);
> +               if (irq < 0) {
> +                       dev_err(dev, "invalid IRQ\n");
> +                       gpiochip_remove(&chip->gc);
> +                       return -ENODEV;
> +               }

This is an hierarchical IRQ so it should use an hierarchical
irqdomain.

I am discussing with Thierry to make more generic irq domains
for hierarchical IRQ GPIOs, until then you have to look at
gpio-thunderx.c, gpio-uniphier.c or gpio-xgene-sb.c that all
use hierarchical IRQs.

Yours,
Linus Walleij
