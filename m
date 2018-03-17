Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeCQSvR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:51:17 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40434 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbeCQSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:51:09 -0400
X-Google-Smtp-Source: AG47ELtcefdPe+tKfob1UM4sCf0u2R5RIXkdpAACJ3pUd6izH2uzfRrkEUPkOjE110hUglUHbrScnvD0qX6Wa9Mj5xA=
MIME-Version: 1.0
In-Reply-To: <14a09900bf4642495ebe4072b9eb02769dbc4c5e.1521301345.git.vilhelm.gray@gmail.com>
References: <cover.1521301345.git.vilhelm.gray@gmail.com> <14a09900bf4642495ebe4072b9eb02769dbc4c5e.1521301345.git.vilhelm.gray@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 17 Mar 2018 20:51:07 +0200
Message-ID: <CAHp75Vci2sMWPC2Sij5WzNtSi_2b3f1PC5qn3-hiSf8xrCpcBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] iio: stx104: Implement get_multiple callback
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 5:49 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> The Apex Embedded Systems STX104 series of devices provides 4 TTL
> compatible lines of inputs accessed via a single 4-bit port. Since four
> input lines are acquired on a single port input read, the STX104 GPIO
> driver may improve multiple input reads by utilizing a get_multiple
> callback. This patch implements the stx104_gpio_get_multiple function
> which serves as the respective get_multiple callback.

> +static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
> +       unsigned long *bits)
> +{
> +       struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
> +

> +       *bits = inb(stx104gpio->base);

I think on LE and BE if will give you different results.

> +
> +       return 0;
> +}



-- 
With Best Regards,
Andy Shevchenko
