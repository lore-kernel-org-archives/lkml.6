Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeBWP0C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:26:02 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36312 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeBWP0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:26:00 -0500
X-Google-Smtp-Source: AH8x225NRoZ8QPA5GyNDXOLT58KtYimtNtoJLzkXGoZ6sfLA83ULqrn1juzMZjpML4dOOx/I3TPJog==
Date: Fri, 23 Feb 2018 10:25:53 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Revert "gpio: winbond: fix ISA_BUS_API dependency"
Message-ID: <20180223152553.GA20248@sophia>
References: <9a55e8b3-bf34-d8a4-f5a6-01e86374f42f@maciej.szmigiero.name>
 <CAK8P3a3-NTzY3x5xM_d8Bxm-s+SF0L8d60vd-FOHccVxXo_AVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3-NTzY3x5xM_d8Bxm-s+SF0L8d60vd-FOHccVxXo_AVg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 04:19:01PM +0100, Arnd Bergmann wrote:
>On Fri, Feb 23, 2018 at 3:55 PM, Maciej S. Szmigiero
><mail@maciej.szmigiero.name> wrote:
>> This reverts commit 92a8046c9d952a2a7d21dfcd3afadc72a0bc0f72.
>>
>> Now that the patch series changing ISA_BUS_API dependency to selection
>> was merged this reversion will do the same for gpio-winbond driver to
>> make it consistent with other ISA bus gpio drivers.
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>
>I still see a number of other users of 'depends on ISA_BUS_API' in linux-next:
>
>drivers/gpio/Kconfig:   depends on PC104 && ISA_BUS_API
>drivers/gpio/Kconfig:   depends on PC104 && ISA_BUS_API
>drivers/gpio/Kconfig:   depends on PC104 && ISA_BUS_API
>drivers/gpio/Kconfig:   depends on PC104 && ISA_BUS_API
>drivers/gpio/Kconfig:   depends on ISA_BUS_API
>drivers/gpio/Kconfig:   depends on ISA_BUS_API
>drivers/iio/adc/Kconfig:        depends on PC104 && X86 && ISA_BUS_API
>drivers/iio/counter/Kconfig:    depends on PC104 && X86 && ISA_BUS_API
>drivers/iio/dac/Kconfig:        depends on X86 && ISA_BUS_API
>drivers/watchdog/Kconfig:       depends on X86 && ISA_BUS_API
>
>Did you change all of the above? I would really like to avoid mixing
>'select' and 'depends on' here, as that will likely cause other circular
>dependencies in the future.
>
>       Arnd

Those 'depends on' for ISA_BUS_API are resolved in the devel branch of
the linux-gpio tree; this revert patch should be applied there before
being picked up later for linux-next.

William Breathitt Gray
