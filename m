Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF50FECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784292147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAsvmTa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784292147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeGMJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:05:34 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50739 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeGMJFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:05:33 -0400
Received: by mail-it0-f68.google.com with SMTP id w16-v6so10588322ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9bQGNGjZ9snMtQTKSUQq93DqyHGC+ZiXyK/eDhhorU=;
        b=SAsvmTa6Az7uZ2qr568rBw3yq/9gMA8IsJb6d8Q6JYk6zyKbvXEU1Jjc+IAr3O1H2z
         Le7+xL/4ld36U+P85sVasurAdPhUDIb4CyYZBmE/9gBzTDFggSaFRPc1X3YNZE+uvTlG
         IbkI5qyOGivlruw4AL1wfs7xd0oEcLxko/Pw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9bQGNGjZ9snMtQTKSUQq93DqyHGC+ZiXyK/eDhhorU=;
        b=qSf+6guHIGuVBN+nG83Z93VXm1ftz+0QBTBEdVEWxR1Ffl5bubs38tZYUYtFf8ql+b
         5LC/q9MSBGil45DPLclR9MTV6UOOiP81/9us0nYl49FCvQ4k6IYoivBlffvtVDFJgYv7
         0X1EuZS1fRgwuNKPTY7ZFTKN1SUxw2Wto/wndkh0qYkPapXtNuZTw46x/A2DzscF1muX
         UVMlIiUojgRHdr30GgIi+5GdIIG5YS96CZArLHl/GQv+YdOocy0GFO8lqM1Qa8xlvtKn
         jUJ5/QmWyT5w4Hsm2nmxnNiLf+BOXzHtGTfHwm2fvkC9JIf3ypo/ZI9pkMH4OTI4KKHA
         9gRg==
X-Gm-Message-State: AOUpUlG6VIU8DFiShkOECr0MVBCtw3E+UAUb1GJcve+mGPn1n0uKf8rz
        cZeW6jBVUoo1j78xd25zyJcz5/IHtCfW8G616fdCzQ==
X-Google-Smtp-Source: AAOMgpeYaTk9QIVJ/YBlGZOIqJEP7WK+xD55MUsMqtODmXB0jPXUiKz51fy/ictlP/tE2MHvmRNBWb2T3PzF3FbXKss=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr4110066iti.135.1531471912355;
 Fri, 13 Jul 2018 01:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180712214203.114844-1-tmaimon77@gmail.com> <20180712214203.114844-3-tmaimon77@gmail.com>
In-Reply-To: <20180712214203.114844-3-tmaimon77@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 10:51:40 +0200
Message-ID: <CACRpkdYOQMkA6BHtY3-NSXhyhoG7KzDg8SkqL2B6M8GQrvXgMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver
To:     tmaimon77@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, avifishman70@gmail.com,
        yuenn@google.com, brendanhiggins@google.com, venture@google.com,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:42 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

> Add Nuvoton BMC NPCM750/730/715/705 Pinmux and
> GPIO controller driver.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

(...)
> +++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> @@ -0,0 +1,2089 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2016-2018 Nuvoton Technology corporation.
> +// Copyright (c) 2016, Dell Inc
> +
> +#include <linux/device.h>
> +#include <linux/gpio.h>

As this is a driver you should only include <linux/gpio/driver.h>

> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/syscon.h>

If you need syscon then the driver should select or depend
on MFD_SYSCON in Kconfig.

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>

Do you really need this include?

> +/* Structure for register banks */
> +struct NPCM7XX_GPIO {

Can we have this lowercase? Please?

> +       void __iomem            *base;
> +       struct gpio_chip        gc;
> +       int                     irqbase;
> +       int                     irq;
> +       spinlock_t              lock;
> +       void                    *priv;
> +       struct irq_chip         irq_chip;
> +       u32                     pinctrl_id;
> +};

So each GPIO bank has its own gpio chip and register
base, that is NICE! Because then it looks like you can
select GPIO_GENERIC and use the MMIO GPIO helper
library to handle the registers. Let's look into that
option!

> +struct NPCM7xx_pinctrl {
> +       struct pinctrl_dev      *pctldev;
> +       struct device           *dev;
> +       struct NPCM7XX_GPIO     gpio_bank[NPCM7XX_GPIO_BANK_NUM];
> +       struct irq_domain       *domain;

I wonder why the pin controller needs and IRQ domain but
I keep reading the code and I might find out...

> +enum operand {
> +       op_set,
> +       op_getbit,
> +       op_setbit,
> +       op_clrbit,
> +};

This looks complicated. I suspect you can use GPIO_GENERIC
to set/get and clear bits in the register(s).

> +/* Perform locked bit operations on GPIO registers */
> +static int gpio_bitop(struct NPCM7XX_GPIO *bank, int op, unsigned int offset,
> +                     int reg)
> +{
> +       unsigned long flags;
> +       u32 mask, val;
> +
> +       mask = (1L << offset);
> +       spin_lock_irqsave(&bank->lock, flags);
> +       switch (op) {
> +       case op_set:
> +               iowrite32(mask, bank->base + reg);
> +               break;
> +       case op_getbit:
> +               mask &= ioread32(bank->base + reg);
> +               break;
> +       case op_setbit:
> +               val = ioread32(bank->base + reg);
> +               iowrite32(val | mask, bank->base + reg);
> +               break;
> +       case op_clrbit:
> +               val = ioread32(bank->base + reg);
> +               iowrite32(val & (~mask), bank->base + reg);
> +               break;
> +       }
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +       return !!mask;
> +}

This is essentially a reimplementation of drivers/gpio/gpio-mmio.c
(GPIO_GENERIC, also using a spinlock to protect the registers)
so let's use that instead :)

There are drivers already that reuse the spinlock inside the
generic GPIO chip to protect their other registers like for
IRQ registers.

> +static int npcmgpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct NPCM7XX_GPIO *bank = gpiochip_get_data(chip);
> +       u32 oe, ie;
> +
> +       /* Get Input & Output state */
> +       ie = gpio_bitop(bank, op_getbit, offset, NPCM7XX_GP_N_IEM);
> +       oe = gpio_bitop(bank, op_getbit, offset, NPCM7XX_GP_N_OE);
> +       if (ie && !oe)
> +               return GPIOF_DIR_IN;
> +       else if (oe && !ie)
> +               return GPIOF_DIR_OUT;

These are consumer flags and should not be used in drivers.
Use plain 0/1 instead.

Anyways the problem goes away with GPIO_GENERIC.

> +static int npcmgpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +       return pinctrl_gpio_direction_input(offset + chip->base);
> +}

It's a bit tricksy to get this to work with GPIO_GENERIC.

After calling bgpio_init() you need to overwrite the assigned
.direction_input handler with this and then direct back to the
one assigned by GPIO_GENERIC.

Something like this:

1. Add two indirection pointers to the npcm7xx_gpio state container:

struct npcm7xx_gpio {
     (...)
      int (*direction_input)(struct gpio_chip *chip, unsigned offset);
      int (*direction_output)(struct gpio_chip *chip, unsigned offset,
int value);
     (...)
};

2. Save the pointers

struct npcm7xx_gpio *npcm;

bgpio_init( ... register setup ...)
npcm->direction_input = npcm->gc.direction_input;
npcm->direction_output = npcm->gc.direction_output;
npcm->gc.direction_input = npcmgpio_direction_input;
npcm->gc.direction_output = npcmgpio_direction_output;

3. Modify the functions like that:

static int npcmgpio_direction_input(struct gpio_chip *chip, unsigned int offset)
{
    struct npcm7xx_gpio *npcm = gpiochip_get_data(chip);
    int ret;

    ret = pinctrl_gpio_direction_input(offset + chip->base);
    if (ret)
        return ret;
    return npcm->direction_input(chip);
}

I'm sure you get the idea... if you think we can modify gpio-mmio
to be more helpful with this, suggestions are welcome!

> +/* Set GPIO to Output with initial value */
> +static int npcmgpio_direction_output(struct gpio_chip *chip,
> +                                    unsigned int offset, int value)
> +{
> +       struct NPCM7XX_GPIO *bank = gpiochip_get_data(chip);
> +
> +       dev_dbg(chip->parent, "gpio_direction_output: offset%d = %x\n", offset,
> +               value);
> +
> +       /* Check if we're enabled as an interrupt.. */
> +       if (gpio_bitop(bank, op_getbit, offset, NPCM7XX_GP_N_EVEN) &&
> +           gpio_bitop(bank, op_getbit, offset, NPCM7XX_GP_N_IEM)) {
> +               dev_dbg(chip->parent,
> +                       "gpio_direction_output: IRQ enabled on offset%d\n",
> +                       offset);
> +               return -EINVAL;
> +       }

This should not be necessary as you are using GPIOLIB_IRQCHIP,
which locks the GPIO for interrupt and disallows this to happen.

> +static int npcmgpio_gpio_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +       dev_dbg(chip->parent, "gpio_request: offset%d\n", offset);
> +       return pinctrl_gpio_request(offset + chip->base);
> +}
> +
> +static void npcmgpio_gpio_free(struct gpio_chip *chip, unsigned int offset)
> +{
> +       dev_dbg(chip->parent, "gpio_free: offset%d\n", offset);
> +       pinctrl_gpio_free(offset + chip->base);
> +}

This needs the same pattern as the direction functions above, then
you can use GPIO_GENERIC (mmio).

> +static unsigned int npcmgpio_irq_startup(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +       unsigned int gpio = d->hwirq;
> +
> +       /* active-high, input, clear interrupt, enable interrupt */
> +       dev_dbg(d->chip->parent_device, "startup: %u.%u\n", gpio, d->irq);
> +       npcmgpio_direction_output(gc, gpio, 1);
> +       npcmgpio_direction_input(gc, gpio);

Interesting dance. So it is required to set the line to
1 and then switch to input?

> +static struct irq_chip npcmgpio_irqchip = {
> +       .name = "NPCM7XX-GPIO-IRQ",
> +       .irq_ack = npcmgpio_irq_ack,
> +       .irq_unmask = npcmgpio_irq_unmask,
> +       .irq_mask = npcmgpio_irq_mask,
> +       .irq_set_type = npcmgpio_set_irq_type,
> +       .irq_startup = npcmgpio_irq_startup,
> +};

This code is looking good BTW.

The patch in my inbox just ends in the middle of everything, I wonder
why :( suspect the new gmail interface I'm using.

Anyways: the pointers above should keep you busy for the next
iteration of the patch, the pin control part seems pretty straight-forward.

Yours,
Linus Walleij
