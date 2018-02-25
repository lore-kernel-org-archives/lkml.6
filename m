Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeBYMTz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 07:19:55 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46033 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeBYMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 07:19:53 -0500
X-Google-Smtp-Source: AG47ELs52bbCl37+AvutDklm8yL2PBJu3cMB3TQqf8kR4QsJVb5iKjFROovwImQctQweTeQX7Ns7tohmL1y4QbzxpKg=
MIME-Version: 1.0
In-Reply-To: <f4a2fefb4c3179e7598dbc8141a661833200b922.1519468782.git.baolin.wang@linaro.org>
References: <334505d3a13a73ad347427b408ed581832434289.1519468782.git.baolin.wang@linaro.org>
 <f4a2fefb4c3179e7598dbc8141a661833200b922.1519468782.git.baolin.wang@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 25 Feb 2018 14:19:51 +0200
Message-ID: <CAHp75VdvLDEmNs-YUFYf+Og18kaU6j6zAxXc1w31X2vw26ACHQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: Add Spreadtrum PMIC EIC driver support
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

On Sat, Feb 24, 2018 at 12:44 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The Spreadtrum PMIC EIC controller contains only one bank of debounce EIC,
> and this bank contains 16 EICs. Each EIC can only be used as input mode,
> as well as supporting the debounce and the capability to trigger interrupts
> when detecting input signals.

> +/*
> + * These registers are modified under the irq bus lock and cached to avoid
> + * unnecessary writes in bus_sync_unlock.
> + */
> +enum { REG_IEV, REG_IE, REG_TRIG, CACHE_NR_REGS };

One item per line.

> +static int sprd_pmic_eic_direction_input(struct gpio_chip *chip,
> +                                        unsigned int offset)
> +{
> +       /* EICs are always input, nothing need to do here. */
> +       return 0;
> +}
> +
> +static void sprd_pmic_eic_set(struct gpio_chip *chip, unsigned int offset,
> +                             int value)
> +{
> +       /* EICs are always input, nothing need to do here. */
> +}

Remove both.

Look at what GPIO core does.

> +       value |= debounce / 1000;

Possible overflow.

> +       for (n = 0; n < chip->ngpio; n++) {
> +               if (!(BIT(n) & val))

for_each_set_bit().

At some point you may need just to go across lib/ in the kernel and
see what we have there.

-- 
With Best Regards,
Andy Shevchenko
