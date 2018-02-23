Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeBWNfF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:35:05 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36038 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeBWNfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:35:03 -0500
X-Google-Smtp-Source: AG47ELvfJBn/4KYPA2QXcNs//0VDohhEcn0/slw6od1oHqbAvEVHtpr5y4a5BzicqKrYvvbxPis2A7HvBDISxjdZT3c=
MIME-Version: 1.0
In-Reply-To: <2009936f10a349fc6a24796c60e7fea6551b8f0d.1519360872.git.baolin.wang@linaro.org>
References: <c2db9b3b5c611cadfbe5ea97327be7ee5981fa54.1519360872.git.baolin.wang@linaro.org>
 <2009936f10a349fc6a24796c60e7fea6551b8f0d.1519360872.git.baolin.wang@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 15:35:01 +0200
Message-ID: <CAHp75VcKiah6sTYq5iJuF-7DyxFtHUx1sne5VpkZwBpQ-1aq8g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 6:44 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
> each group contains 16 GPIOs. Each GPIO can set input/output and has
> the interrupt capability.
>

Sorry, couple comments below.

> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +/* We have 16 banks GPIOs and each bank contain 16 GPIOs */
> +#define SPRD_GPIO_BANK_NR      16
> +#define SPRD_GPIO_NR           256

> +#define SPRD_GPIO_BANK_SIZE    0x80

128 ?

> +       irq->handler = handle_simple_irq;

Shouldn't be handle_bad_irq() ?


> +static const struct of_device_id sprd_gpio_of_match[] = {
> +       { .compatible = "sprd,sc9860-gpio", },

> +       { /* end of list */ },

Comma is redundant. Absence of it even better at compile time if at
some weird case the item goes after a terminator.

> +};

-- 
With Best Regards,
Andy Shevchenko
