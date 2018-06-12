Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E5853C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9142920693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yf5CP9p9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9142920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933827AbeFLIiR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:38:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35500 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933242AbeFLIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:38:12 -0400
Received: by mail-it0-f68.google.com with SMTP id a3-v6so14411889itd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EfKGdJGmhIj0sg4BMHfXBmphnOmEg1hlIwHiCNp6i6o=;
        b=Yf5CP9p9I0JoRtkNozJvqG9Q3tKxZ5/pQo8l4EoeTdl6XkD1twPKEQ0l95/i2CSlkc
         L9IE+kf0Ky7PXLWySK9tezmei6irIsURREHqbVw4y0ljtanmZq1oHBCylJvapFRBDY6M
         ZwLby/Bn/TX5Mmb2YNLZ8V4i6OwLJ+3cPlc1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EfKGdJGmhIj0sg4BMHfXBmphnOmEg1hlIwHiCNp6i6o=;
        b=WGSGTpxkLNtsByUAvKrLWwuXDDKiswXBtMnVm6Bk5Mqs+wMsd4ZwCIbBbeE2GK6oBg
         rHicSwX9YJw1JqZBDz/e1EWSoIWoOth1rf83YgIchjRpeboo+ANqJYvR7KJnhTWUXYUv
         Hq88NF30nMB456u1Ve3npZv6wGTGYIM/n2EA+2aQ9hW4bJSS6suQmrAE29GvTHNyZ4xw
         zNtIE/whWmzHN+NcOPBrKRaMBQTaZcKVaxF+tyqkFbCsMIYdVT/HuanXBRC2EgX7sFgY
         iiqFEdYJVf5l6xKrHiDkahAGWJeyz/nhpEVTne9WTqMjiUacoFctI5l/4+clekR/gK21
         6ewA==
X-Gm-Message-State: APt69E1IvycYSR/45WkUHTK3zBhY8EF9rprqQUChZMGL+LsuvS8va5UD
        TFE/Y/KpVWUG5aCPFHZDwAcpF/RYYN4Elb6VALAZ8A==
X-Google-Smtp-Source: ADUXVKLl4g/4afmjBbM/jFHKH77RYg3/4zsVJ0nA3UyrAlbQ2DqSCziiiSwJIhDo+vm76BtR10zCbTygaBer1PjhP7U=
X-Received: by 2002:a24:19ca:: with SMTP id b193-v6mr2247834itb.135.1528792692244;
 Tue, 12 Jun 2018 01:38:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:38:11
 -0700 (PDT)
In-Reply-To: <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
References: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org> <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Jun 2018 10:38:11 +0200
Message-ID: <CACRpkdbRYQ7Wf48Ff-n-OiheW+Dv1yyJQ3NNzGdBx5dvM51YPA@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: actions: Add interrupt support for OWL S900 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 6:54 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add interrupt support for Actions Semi OWL S900 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
(...)

> +++ b/drivers/pinctrl/actions/Kconfig
> @@ -5,6 +5,7 @@ config PINCTRL_OWL
>         select PINCONF
>         select GENERIC_PINCONF
>         select GPIOLIB
> +       select GPIOLIB_IRQCHIP

I don't think you're really using that (certain sign: you're implementing
.to_irq().)

GPIOLIB_IRQCHIP is nice, but can only be used when there is
a 1-1 correspondence betweem GPIO line offsets and
IRQ lines and they are numbered 0..n.

However I think you can use it! Look below for my reference
to the tegra186 and how you can probably cut out the custom
irqdomain with some manouvers.

> +       struct owl_pinctrl *pctrl = irq_data_get_irq_chip_data(data);
> +       const struct owl_gpio_port *port;
(...)
> +       unsigned int gpio = data->hwirq;
> +
> +       port = owl_gpio_get_port(pctrl, &gpio);
> +
> +       gpio_base = pctrl->base + port->offset;

It is all about this calculation really.

> +static int owl_gpio_irq_set_type(struct irq_data *data, unsigned int type)
> +{
> +       struct owl_pinctrl *pctrl = irq_data_get_irq_chip_data(data);
> +       const struct owl_gpio_port *port;
> +       void __iomem *gpio_base;
> +       unsigned long flags;
> +       unsigned int gpio = data->hwirq;
> +       unsigned int offset, value, irq_type = 0;
> +
> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return -ENODEV;
> +
> +       gpio_base = pctrl->base + port->offset;
> +
> +       switch (type) {
> +       case IRQ_TYPE_EDGE_RISING:
> +               irq_type = OWL_GPIO_INT_EDGE_RISING;
> +               break;
> +
> +       case IRQ_TYPE_EDGE_FALLING:
> +               irq_type = OWL_GPIO_INT_EDGE_FALLING;
> +               break;

Very often things such as keys will request trigger on
both edges. This means IRQ_TYPE_EDGE_RISING
and IRQ_TYPE_EDGE_FALLING are both set, which
will cause you problems here, since it is unhandled.

I guess it is fine to set both?

> +       offset = gpio < 16 ? 4 : 0;

I think even the compiler should suggest putting he (gpio < 16)
expression in paranthesis.

> +       value = readl_relaxed(gpio_base + port->intc_type + offset);
> +       value &= ~(OWL_GPIO_INT_MASK << ((gpio % 16) * 2));
> +       value |= irq_type << ((gpio % 16) * 2);
> +       writel_relaxed(value, gpio_base + port->intc_type + offset);
> +
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +
> +       if (type & IRQ_TYPE_EDGE_BOTH)
> +               irq_set_handler_locked(data, handle_edge_irq);
> +       else
> +               irq_set_handler_locked(data, handle_level_irq);

Here you handle both edges, but not in the switch clause.

> +static void owl_gpio_irq_handler(struct irq_desc *desc)

This looks fine.

> +static struct irq_chip owl_gpio_irq_chip = {
> +       .name           = "owlgpio",
> +       .irq_mask       = owl_gpio_irq_mask,
> +       .irq_unmask     = owl_gpio_irq_unmask,
> +       .irq_ack        = owl_gpio_irq_ack,
> +       .irq_set_type   = owl_gpio_irq_set_type,
> +};

If you implement your own irqchip you need to implement
.irq_request_resources and .irq_free_resources locking the GPIO
lines for interrupt, see other drivers that do this or the
gpiolib core code in gpiolib.c.

It would be really neat if you could instead use the
GPIOLIB_IRQCHIP though, but I know it will be a bit tricky
and maybe not possible.

> +       for (i = 0; i < pctrl->soc->nports; i++) {
> +               irq_set_chained_handler_and_data(pctrl->irq[i],
> +                                               owl_gpio_irq_handler,
> +                                               pctrl);
> +       }

If you use GPIOLIB_IRQCHIP with several parent IRQs.
See Thierry's work in drivers/gpio/gpio-tegra186.c for the
only example.

I think that is what you want to do here.

We do want to add helpers in gpiolib to do this in a more
organized and easy-to-use fashion. Patches welcome ;)

Yours,
Linus Walleij
