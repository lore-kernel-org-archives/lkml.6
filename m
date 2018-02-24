Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeBXB5y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:57:54 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:43572 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeBXB5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:57:52 -0500
X-Google-Smtp-Source: AG47ELu3kcFyh6ctvhuaUnMq7OJ2SD/QGivCL4gxDqCxr0To7LqALuEyKC6xuw8X3okW+il2g+sB3Vowmk4ADzEinq4=
MIME-Version: 1.0
In-Reply-To: <CAHp75VcKiah6sTYq5iJuF-7DyxFtHUx1sne5VpkZwBpQ-1aq8g@mail.gmail.com>
References: <c2db9b3b5c611cadfbe5ea97327be7ee5981fa54.1519360872.git.baolin.wang@linaro.org>
 <2009936f10a349fc6a24796c60e7fea6551b8f0d.1519360872.git.baolin.wang@linaro.org>
 <CAHp75VcKiah6sTYq5iJuF-7DyxFtHUx1sne5VpkZwBpQ-1aq8g@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Sat, 24 Feb 2018 09:57:51 +0800
Message-ID: <CAMz4kuKGtRb1WimZkGOj2yCCj4WHz_kKr3FiCR6Q_RRv7_y8oA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi Andy,

On 23 February 2018 at 21:35, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 23, 2018 at 6:44 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
>> each group contains 16 GPIOs. Each GPIO can set input/output and has
>> the interrupt capability.
>>
>
> Sorry, couple comments below.
>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> +/* We have 16 banks GPIOs and each bank contain 16 GPIOs */
>> +#define SPRD_GPIO_BANK_NR      16
>> +#define SPRD_GPIO_NR           256
>
>> +#define SPRD_GPIO_BANK_SIZE    0x80
>
> 128 ?

Um, I still would like to use 0x80 here to keep consistent with our GPIO Spec.

>
>> +       irq->handler = handle_simple_irq;
>
> Shouldn't be handle_bad_irq() ?

Yes, handle_bad_irq() is better.

>> +static const struct of_device_id sprd_gpio_of_match[] = {
>> +       { .compatible = "sprd,sc9860-gpio", },
>
>> +       { /* end of list */ },
>
> Comma is redundant. Absence of it even better at compile time if at
> some weird case the item goes after a terminator.

Sure. Thanks.

-- 
Baolin.wang
Best Regards
