Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeBWPTE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:19:04 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39813 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBWPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:19:02 -0500
X-Google-Smtp-Source: AG47ELtXZMtPbzxJIz8IMJgYkS9O1RfAZ9Qon4/Rjsbd+b7RXJ2+A+DylJ1c4ZA9JdyCZgBxfznRaJyrTawl1m7VSMc=
MIME-Version: 1.0
In-Reply-To: <9a55e8b3-bf34-d8a4-f5a6-01e86374f42f@maciej.szmigiero.name>
References: <9a55e8b3-bf34-d8a4-f5a6-01e86374f42f@maciej.szmigiero.name>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Feb 2018 16:19:01 +0100
X-Google-Sender-Auth: NwzZI1VE01skHK3VMH_zNPZKbFs
Message-ID: <CAK8P3a3-NTzY3x5xM_d8Bxm-s+SF0L8d60vd-FOHccVxXo_AVg@mail.gmail.com>
Subject: Re: [PATCH] Revert "gpio: winbond: fix ISA_BUS_API dependency"
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 3:55 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> This reverts commit 92a8046c9d952a2a7d21dfcd3afadc72a0bc0f72.
>
> Now that the patch series changing ISA_BUS_API dependency to selection
> was merged this reversion will do the same for gpio-winbond driver to
> make it consistent with other ISA bus gpio drivers.
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

I still see a number of other users of 'depends on ISA_BUS_API' in linux-next:

drivers/gpio/Kconfig:   depends on PC104 && ISA_BUS_API
drivers/gpio/Kconfig:   depends on PC104 && ISA_BUS_API
drivers/gpio/Kconfig:   depends on PC104 && ISA_BUS_API
drivers/gpio/Kconfig:   depends on PC104 && ISA_BUS_API
drivers/gpio/Kconfig:   depends on ISA_BUS_API
drivers/gpio/Kconfig:   depends on ISA_BUS_API
drivers/iio/adc/Kconfig:        depends on PC104 && X86 && ISA_BUS_API
drivers/iio/counter/Kconfig:    depends on PC104 && X86 && ISA_BUS_API
drivers/iio/dac/Kconfig:        depends on X86 && ISA_BUS_API
drivers/watchdog/Kconfig:       depends on X86 && ISA_BUS_API

Did you change all of the above? I would really like to avoid mixing
'select' and 'depends on' here, as that will likely cause other circular
dependencies in the future.

       Arnd
