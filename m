Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F404AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7DD256E7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1nikbPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7DD256E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755142AbeFYJoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:44:32 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43566 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755105AbeFYJo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:44:28 -0400
Received: by mail-ua0-f193.google.com with SMTP id z16-v6so8183716uaz.10;
        Mon, 25 Jun 2018 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tg+HJnzQ4+4Hx2BhSaiiWt+l3FGHGYxR669uEa69CCw=;
        b=u1nikbPIVuteo8d9XcJm2dGpR4LP+EWilQmTFFcc6/Yt/Dipg3GIlIFclm9igPxUbw
         gl1Qt6GJNTCV1NzVob/Y8U1ZmDuvfeQZ1lbVa1/YamPQeVZFJSB9WAqTrEN+yFQNuvrU
         +sfeuA22MBhTtGfPguOv3QGPgfoqR7T1eFPjpjk4WzFKln2LRoPrYK0oXpXh6TyPJg2z
         uO40w7IpQFhEwqCbgjnu5NyU6+Mtt/0I8sMJPFCy5qGPeHj0J/nuqOd97wPusYGl//7+
         5iU7Ni5kzHcRp6EMlR5F/sz8IOsQreJyADanImJxE4A8wfjl7YzY4jpjLafet3qSvjUy
         1XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tg+HJnzQ4+4Hx2BhSaiiWt+l3FGHGYxR669uEa69CCw=;
        b=izsQmvZFHpge59viXa/eYHVlkR0W5R6Woi/2Q+qGAKuFrkwJWAwXH3QWyYtKH6Oz8V
         YMPAFG/ugFq1ydzgDwB03Olz5I96bU7F8TyQKyUw1izgSwVwyTJGrEhPeSKgrJ7utRas
         JjlHmMZN4aIoYu6WKQ40z+uEzNYKaoOxCxlA4pGa+LAVa62J28R6MK54B/PH6LrtME8f
         P+gAh1GmWw39zwWxnTnwF7B7ULPzlcP6lHGvUJ9G9LWTnyj+34f4dOEOV1OzurUMfzrc
         q+dz4MjJMXXuZG4nsLOLTqP9HiOTpMcNJCz6MzzrLfWcfwWRQTnRz3rplwX46l5I+zyi
         gdlQ==
X-Gm-Message-State: APt69E0Y54fDgHCyD8DXN6RuwZNWNMDoyhHHSzB0N8A88ZfQeIcSYdcl
        dVGPni8RcojFGO6P1DpdnQBdtPRxGS2t4z5aU7k=
X-Google-Smtp-Source: ADUXVKJO+J5aij+ynrvljd+HBHqZUn8mKmxKe4ngORQx0Z9/7asTRImI6dw00NC7W2/YIHdps5amiwKFuOyNceAJFT4=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr7795630uad.49.1529919867486;
 Mon, 25 Jun 2018 02:44:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 02:44:26
 -0700 (PDT)
In-Reply-To: <20180623045954.6729-4-manivannan.sadhasivam@linaro.org>
References: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org> <20180623045954.6729-4-manivannan.sadhasivam@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jun 2018 12:44:26 +0300
Message-ID: <CAHp75VdGctz_r7NnnKBGaxVvwooA+nrMpLSUzDbBNWZVXgrWAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pinctrl: actions: Add interrupt support for OWL
 S900 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        jeff.chen@actions-semi.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 7:59 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add interrupt support for Actions Semi OWL S900 SoC.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pinctrl/actions/Kconfig        |   1 +
>  drivers/pinctrl/actions/pinctrl-owl.c  | 271 ++++++++++++++++++++++++-
>  drivers/pinctrl/actions/pinctrl-owl.h  |  22 +-
>  drivers/pinctrl/actions/pinctrl-s900.c |  31 +--
>  4 files changed, 307 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pinctrl/actions/Kconfig b/drivers/pinctrl/actions/Kconfig
> index 490927b4ea76..2397cb0f6011 100644
> --- a/drivers/pinctrl/actions/Kconfig
> +++ b/drivers/pinctrl/actions/Kconfig
> @@ -5,6 +5,7 @@ config PINCTRL_OWL
>         select PINCONF
>         select GENERIC_PINCONF
>         select GPIOLIB
> +       select GPIOLIB_IRQCHIP
>         help
>           Say Y here to enable Actions Semi OWL pinctrl driver
>
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> index 76243caa08c6..ce032d71dad5 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.c
> +++ b/drivers/pinctrl/actions/pinctrl-owl.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/io.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -45,6 +46,9 @@ struct owl_pinctrl {
>         struct clk *clk;
>         const struct owl_pinctrl_soc_data *soc;
>         void __iomem *base;
> +       struct irq_chip irq_chip;
> +       unsigned int num_irq;
> +       unsigned int *irq;
>  };
>
>  static void owl_update_bits(void __iomem *base, u32 mask, u32 val)
> @@ -701,10 +705,213 @@ static int owl_gpio_direction_output(struct gpio_chip *chip,
>         return 0;
>  }
>
> +static void irq_set_type(struct owl_pinctrl *pctrl, int gpio, unsigned int type)
> +{
> +       const struct owl_gpio_port *port;
> +       void __iomem *gpio_base;
> +       unsigned long flags;
> +       unsigned int offset, value, irq_type = 0;
> +
> +       switch (type) {
> +       case IRQ_TYPE_EDGE_BOTH:
> +               /*
> +                * Since the hardware doesn't support interrupts on both edges,
> +                * emulate it in the software by setting the single edge
> +                * interrupt and switching to the opposite edge while ACKing
> +                * the interrupt
> +                */
> +               if (owl_gpio_get(&pctrl->chip, gpio))
> +                       irq_type = OWL_GPIO_INT_EDGE_FALLING;
> +               else
> +                       irq_type = OWL_GPIO_INT_EDGE_RISING;
> +               break;
> +
> +       case IRQ_TYPE_EDGE_RISING:
> +               irq_type = OWL_GPIO_INT_EDGE_RISING;
> +               break;
> +
> +       case IRQ_TYPE_EDGE_FALLING:
> +               irq_type = OWL_GPIO_INT_EDGE_FALLING;
> +               break;
> +
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               irq_type = OWL_GPIO_INT_LEVEL_HIGH;
> +               break;
> +
> +       case IRQ_TYPE_LEVEL_LOW:
> +               irq_type = OWL_GPIO_INT_LEVEL_LOW;
> +               break;
> +
> +       default:
> +               break;
> +       }
> +
> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;
> +
> +       gpio_base = pctrl->base + port->offset;
> +
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
> +
> +       offset = (gpio < 16) ? 4 : 0;
> +       value = readl_relaxed(gpio_base + port->intc_type + offset);
> +       value &= ~(OWL_GPIO_INT_MASK << ((gpio % 16) * 2));
> +       value |= irq_type << ((gpio % 16) * 2);
> +       writel_relaxed(value, gpio_base + port->intc_type + offset);
> +
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +}
> +
> +static void owl_gpio_irq_mask(struct irq_data *data)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +       struct owl_pinctrl *pctrl = gpiochip_get_data(gc);
> +       const struct owl_gpio_port *port;
> +       void __iomem *gpio_base;
> +       unsigned long flags;
> +       unsigned int gpio = data->hwirq;
> +       u32 val;
> +
> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;
> +
> +       gpio_base = pctrl->base + port->offset;
> +
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
> +
> +       owl_gpio_update_reg(gpio_base + port->intc_msk, gpio, false);
> +
> +       /* disable port interrupt if no interrupt pending bit is active */
> +       val = readl_relaxed(gpio_base + port->intc_msk);
> +       if (val == 0)
> +               owl_gpio_update_reg(gpio_base + port->intc_ctl,
> +                                       OWL_GPIO_CTLR_ENABLE, false);
> +
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +}
> +
> +static void owl_gpio_irq_unmask(struct irq_data *data)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +       struct owl_pinctrl *pctrl = gpiochip_get_data(gc);
> +       const struct owl_gpio_port *port;
> +       void __iomem *gpio_base;
> +       unsigned long flags;
> +       unsigned int gpio = data->hwirq;
> +       u32 value;
> +
> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;
> +
> +       gpio_base = pctrl->base + port->offset;
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
> +
> +       /* enable port interrupt */
> +       value = readl_relaxed(gpio_base + port->intc_ctl);
> +       value |= BIT(OWL_GPIO_CTLR_ENABLE) | BIT(OWL_GPIO_CTLR_SAMPLE_CLK_24M);
> +       writel_relaxed(value, gpio_base + port->intc_ctl);
> +
> +       /* enable GPIO interrupt */
> +       owl_gpio_update_reg(gpio_base + port->intc_msk, gpio, true);
> +
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +}
> +
> +static void owl_gpio_irq_ack(struct irq_data *data)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +       struct owl_pinctrl *pctrl = gpiochip_get_data(gc);
> +       const struct owl_gpio_port *port;
> +       void __iomem *gpio_base;
> +       unsigned long flags;
> +       unsigned int gpio = data->hwirq;
> +
> +       /*
> +        * Switch the interrupt edge to the opposite edge of the interrupt
> +        * which got triggered for the case of emulating both edges
> +        */
> +       if (irqd_get_trigger_type(data) == IRQ_TYPE_EDGE_BOTH) {
> +               if (owl_gpio_get(gc, gpio))
> +                       irq_set_type(pctrl, gpio, IRQ_TYPE_EDGE_FALLING);
> +               else
> +                       irq_set_type(pctrl, gpio, IRQ_TYPE_EDGE_RISING);
> +       }
> +
> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;
> +
> +       gpio_base = pctrl->base + port->offset;
> +
> +       raw_spin_lock_irqsave(&pctrl->lock, flags);
> +
> +       owl_gpio_update_reg(gpio_base + port->intc_ctl,
> +                               OWL_GPIO_CTLR_PENDING, true);
> +
> +       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +}
> +
> +static int owl_gpio_irq_set_type(struct irq_data *data, unsigned int type)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +       struct owl_pinctrl *pctrl = gpiochip_get_data(gc);
> +
> +       if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
> +               irq_set_handler_locked(data, handle_level_irq);
> +       else
> +               irq_set_handler_locked(data, handle_edge_irq);
> +
> +       irq_set_type(pctrl, data->hwirq, type);
> +
> +       return 0;
> +}
> +
> +static void owl_gpio_irq_handler(struct irq_desc *desc)
> +{
> +       struct owl_pinctrl *pctrl = irq_desc_get_handler_data(desc);
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       struct irq_domain *domain = pctrl->chip.irq.domain;
> +       unsigned int parent = irq_desc_get_irq(desc);
> +       const struct owl_gpio_port *port;
> +       void __iomem *base;
> +       unsigned int pin, irq, offset = 0, i;
> +       unsigned long pending_irq;
> +
> +       chained_irq_enter(chip, desc);
> +
> +       for (i = 0; i < pctrl->soc->nports; i++) {
> +               port = &pctrl->soc->ports[i];
> +               base = pctrl->base + port->offset;
> +
> +               /* skip ports that are not associated with this irq */
> +               if (parent != pctrl->irq[i])
> +                       goto skip;
> +
> +               pending_irq = readl_relaxed(base + port->intc_pd);
> +
> +               for_each_set_bit(pin, &pending_irq, port->pins) {
> +                       irq = irq_find_mapping(domain, offset + pin);
> +                       generic_handle_irq(irq);
> +
> +                       /* clear pending interrupt */
> +                       owl_gpio_update_reg(base + port->intc_pd, pin, true);
> +               }
> +
> +skip:
> +               offset += port->pins;
> +       }
> +
> +       chained_irq_exit(chip, desc);
> +}
> +
>  static int owl_gpio_init(struct owl_pinctrl *pctrl)
>  {
>         struct gpio_chip *chip;
> -       int ret;
> +       struct gpio_irq_chip *gpio_irq;
> +       int ret, i, j, offset;
>
>         chip = &pctrl->chip;
>         chip->base = -1;
> @@ -714,6 +921,35 @@ static int owl_gpio_init(struct owl_pinctrl *pctrl)
>         chip->owner = THIS_MODULE;
>         chip->of_node = pctrl->dev->of_node;
>
> +       pctrl->irq_chip.name = chip->of_node->name;
> +       pctrl->irq_chip.irq_ack = owl_gpio_irq_ack;
> +       pctrl->irq_chip.irq_mask = owl_gpio_irq_mask;
> +       pctrl->irq_chip.irq_unmask = owl_gpio_irq_unmask;
> +       pctrl->irq_chip.irq_set_type = owl_gpio_irq_set_type;
> +
> +       gpio_irq = &chip->irq;
> +       gpio_irq->chip = &pctrl->irq_chip;
> +       gpio_irq->handler = handle_simple_irq;
> +       gpio_irq->default_type = IRQ_TYPE_NONE;
> +       gpio_irq->parent_handler = owl_gpio_irq_handler;
> +       gpio_irq->parent_handler_data = pctrl;
> +       gpio_irq->num_parents = pctrl->num_irq;
> +       gpio_irq->parents = pctrl->irq;
> +
> +       gpio_irq->map = devm_kcalloc(pctrl->dev, chip->ngpio,
> +                               sizeof(*gpio_irq->map), GFP_KERNEL);
> +       if (!gpio_irq->map)
> +               return -ENOMEM;
> +
> +       for (i = 0, offset = 0; i < pctrl->soc->nports; i++) {
> +               const struct owl_gpio_port *port = &pctrl->soc->ports[i];
> +
> +               for (j = 0; j < port->pins; j++)
> +                       gpio_irq->map[offset + j] = gpio_irq->parents[i];
> +
> +               offset += port->pins;
> +       }
> +
>         ret = gpiochip_add_data(&pctrl->chip, pctrl);
>         if (ret) {
>                 dev_err(pctrl->dev, "failed to register gpiochip\n");
> @@ -728,7 +964,7 @@ int owl_pinctrl_probe(struct platform_device *pdev,
>  {
>         struct resource *res;
>         struct owl_pinctrl *pctrl;
> -       int ret;
> +       int ret, i;
>
>         pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
>         if (!pctrl)
> @@ -772,14 +1008,41 @@ int owl_pinctrl_probe(struct platform_device *pdev,
>                                         &owl_pinctrl_desc, pctrl);
>         if (IS_ERR(pctrl->pctrldev)) {
>                 dev_err(&pdev->dev, "could not register Actions OWL pinmux driver\n");
> -               return PTR_ERR(pctrl->pctrldev);
> +               ret = PTR_ERR(pctrl->pctrldev);
> +               goto err_exit;
> +       }
> +
> +       ret = platform_irq_count(pdev);
> +       if (ret < 0)
> +               goto err_exit;
> +
> +       pctrl->num_irq = ret;
> +
> +       pctrl->irq = devm_kcalloc(&pdev->dev, pctrl->num_irq,
> +                                       sizeof(*pctrl->irq), GFP_KERNEL);
> +       if (!pctrl->irq) {
> +               ret = -ENOMEM;
> +               goto err_exit;
> +       }
> +
> +       for (i = 0; i < pctrl->num_irq ; i++) {
> +               pctrl->irq[i] = platform_get_irq(pdev, i);
> +               if (pctrl->irq[i] < 0) {
> +                       ret = pctrl->irq[i];
> +                       goto err_exit;
> +               }
>         }
>
>         ret = owl_gpio_init(pctrl);
>         if (ret)
> -               return ret;
> +               goto err_exit;
>
>         platform_set_drvdata(pdev, pctrl);
>
>         return 0;
> +
> +err_exit:
> +       clk_disable_unprepare(pctrl->clk);
> +
> +       return ret;
>  }
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
> index 74342378937c..a724d1d406d4 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.h
> +++ b/drivers/pinctrl/actions/pinctrl-owl.h
> @@ -29,6 +29,18 @@ enum owl_pinconf_drv {
>         OWL_PINCONF_DRV_12MA,
>  };
>
> +/* GPIO CTRL Bit Definition */
> +#define OWL_GPIO_CTLR_PENDING          0
> +#define OWL_GPIO_CTLR_ENABLE           1
> +#define OWL_GPIO_CTLR_SAMPLE_CLK_24M   2
> +
> +/* GPIO TYPE Bit Definition */
> +#define OWL_GPIO_INT_LEVEL_HIGH                0
> +#define OWL_GPIO_INT_LEVEL_LOW         1
> +#define OWL_GPIO_INT_EDGE_RISING       2
> +#define OWL_GPIO_INT_EDGE_FALLING      3
> +#define OWL_GPIO_INT_MASK              3
> +
>  /**
>   * struct owl_pullctl - Actions pad pull control register
>   * @reg: offset to the pull control register
> @@ -121,6 +133,10 @@ struct owl_pinmux_func {
>   * @outen: offset of the output enable register.
>   * @inen: offset of the input enable register.
>   * @dat: offset of the data register.
> + * @intc_ctl: offset of the interrupt control register.
> + * @intc_pd: offset of the interrupt pending register.
> + * @intc_msk: offset of the interrupt mask register.
> + * @intc_type: offset of the interrupt type register.
>   */
>  struct owl_gpio_port {
>         unsigned int offset;
> @@ -128,6 +144,10 @@ struct owl_gpio_port {
>         unsigned int outen;
>         unsigned int inen;
>         unsigned int dat;
> +       unsigned int intc_ctl;
> +       unsigned int intc_pd;
> +       unsigned int intc_msk;
> +       unsigned int intc_type;
>  };
>
>  /**
> @@ -140,7 +160,7 @@ struct owl_gpio_port {
>   * @ngroups: number of entries in @groups.
>   * @padinfo: array describing the pad info of this SoC.
>   * @ngpios: number of pingroups the driver should expose as GPIOs.
> - * @port: array describing all GPIO ports of this SoC.
> + * @ports: array describing all GPIO ports of this SoC.
>   * @nports: number of GPIO ports in this SoC.
>   */
>  struct owl_pinctrl_soc_data {
> diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
> index 5503c7945764..ea67b14ef93b 100644
> --- a/drivers/pinctrl/actions/pinctrl-s900.c
> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> @@ -1821,22 +1821,27 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
>         [SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
>  };
>
> -#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat)  \
> -       [OWL_GPIO_PORT_##port] = {                              \
> -               .offset = base,                                 \
> -               .pins = count,                                  \
> -               .outen = _outen,                                \
> -               .inen = _inen,                                  \
> -               .dat = _dat,                                    \
> +#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat,          \
> +                       _intc_ctl, _intc_pd, _intc_msk, _intc_type)     \
> +       [OWL_GPIO_PORT_##port] = {                                      \
> +               .offset = base,                                         \
> +               .pins = count,                                          \
> +               .outen = _outen,                                        \
> +               .inen = _inen,                                          \
> +               .dat = _dat,                                            \
> +               .intc_ctl = _intc_ctl,                                  \
> +               .intc_pd = _intc_pd,                                    \
> +               .intc_msk = _intc_msk,                                  \
> +               .intc_type = _intc_type,                                \
>         }
>
>  static const struct owl_gpio_port s900_gpio_ports[] = {
> -       OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8),
> -       OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8),
> -       OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8),
> -       OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8),
> -       OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8),
> -       OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8)
> +       OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240),
> +       OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C),
> +       OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238),
> +       OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234),
> +       OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230),
> +       OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178)
>  };
>
>  static struct owl_pinctrl_soc_data s900_pinctrl_data = {
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
