Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeCJSlE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:41:04 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46048 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbeCJSlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:41:01 -0500
X-Google-Smtp-Source: AG47ELv5kPL/3mEbSGWVQ/L17UOahr+r+fSPXYKllz5ktq+fr/DsQxCW1Nmxj6dU1cf2C+Nt2LQkT2euokGuoiJLhMU=
MIME-Version: 1.0
In-Reply-To: <20180309051345.1011-8-manivannan.sadhasivam@linaro.org>
References: <20180309051345.1011-1-manivannan.sadhasivam@linaro.org> <20180309051345.1011-8-manivannan.sadhasivam@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Mar 2018 20:41:00 +0200
Message-ID: <CAHp75Vdecdw-Qp_cdfCTUcMFQtFosUhgNKehHHJfPTNM9FrrBA@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] gpio: Add gpio driver for Actions OWL S900 SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 7:13 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> controlling the gpio shares the same register range with pinctrl block.
>
> GPIO registers are organized as 6 banks and each bank controls the
> maximum of 32 gpios.

> +static void owl_gpio_set_reg(void __iomem *base, unsigned int pin, int flag)
> +{
> +       u32 val;
> +
> +       val = readl_relaxed(base);
> +
> +       if (flag)
> +               val |= BIT(pin);
> +       else
> +               val &= ~BIT(pin);
> +
> +       writel_relaxed(val, base);
> +}

The name is confusing. It's not exclusively set, it's an update.

> +static void owl_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +       struct owl_gpio *gpio = gpiochip_get_data(chip);
> +       u32 val;
> +
> +       val = readl_relaxed(gpio->base + GPIO_DAT);
> +
> +       if (value)
> +               val |= BIT(offset);
> +       else
> +               val &= ~BIT(offset);
> +
> +       writel_relaxed(val, gpio->base + GPIO_DAT);

Forgot to replace?

> +}

-- 
With Best Regards,
Andy Shevchenko
