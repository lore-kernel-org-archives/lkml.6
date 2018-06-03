Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeFCIh5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 04:37:57 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45960 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeFCIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 04:37:55 -0400
X-Google-Smtp-Source: ADUXVKKXP75k/6DaRVRWfFTKeDUGsMermyI8Edur1e8nUC+tH93ptSFzUpf7x4/fkvUhMq8zgcuNm1jL+DQL7kAafLA=
MIME-Version: 1.0
In-Reply-To: <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
References: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org> <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Jun 2018 11:37:53 +0300
Message-ID: <CAHp75Ve8ZCbEqnYK0KqtCHQm-EOUWRSyMzi51P+3_7brtXq6dA@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: actions: Add interrupt support for OWL S900 SoC
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
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>, jeff.chen@actions-semi.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 7:54 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add interrupt support for Actions Semi OWL S900 SoC.

> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;

At which circumstances the above possible?

> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;

Ditto.

> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return;

Ditto.

> +       port = owl_gpio_get_port(pctrl, &gpio);
> +       if (WARN_ON(port == NULL))
> +               return -ENODEV;

Ditto.


> +       for (i = 0; i < chip->ngpio; i++) {
> +               irqno = irq_create_mapping(pctrl->domain, i);
> +               irq_set_chip_and_handler(irqno, &owl_gpio_irq_chip,
> +                                        handle_edge_irq);
> +               irq_set_chip_data(irqno, pctrl);
> +       }

I'm not sure the handle_edge_irq() is a correct handler here. It would
be handle_bad_irq() until IRQ has been requested properly.
No?

> +/* GPIO TYPE Bit Definition */
> +#define OWL_GPIO_INT_LEVEL_HIGH                0
> +#define OWL_GPIO_INT_LEVEL_LOW         1
> +#define OWL_GPIO_INT_EDGE_RISING       2
> +#define OWL_GPIO_INT_EDGE_FALLING      3

> +#define OWL_GPIO_INT_MASK              3

GENMASK?

-- 
With Best Regards,
Andy Shevchenko
