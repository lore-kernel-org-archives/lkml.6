Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeBUHVE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 02:21:04 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42051 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbeBUHVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 02:21:03 -0500
X-Google-Smtp-Source: AH8x226KW0PzSCe2jzYTybpjP8rgju/sXAYFDNSsXtfQJ6MeoHItzx/6MUg2Hqx4iQDadZSzS+nVup5YO+I+cIxCnpc=
MIME-Version: 1.0
In-Reply-To: <cover.1518505425.git.greentime@andestech.com>
References: <cover.1518505425.git.greentime@andestech.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 21 Feb 2018 15:20:21 +0800
Message-ID: <CAEbi=3c=RYp+eHHM9NEAvNfeC7byoHH8xznpZ1qrP8v9qDxPHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] clocksource/drivers/atcpit100: Add andestech
 atcpit100 timer
To: Greentime <greentime@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Vincent Chen <deanbo422@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rick Chen <rick@andestech.com>
Cc: Green Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-13 17:13 GMT+08:00 Greentime Hu <green.hu@gmail.com>:
> Hi, all:
>
> ATCPIT100 is often used on the Andes architecture,
> This timer provide 4 PIT channels. Each PIT channel is a
> multi-function timer, can be configured as 32,16,8 bit timers
> or PWM as well.
>
> For system timer it will set channel 1 32-bit timer0 as clock
> source and count downwards until underflow and restart again.
>
> It also set channel 0 32-bit timer0 as clock event and count
> downwards until condition match. It will generate an interrupt
> for handling periodically.
>
> Changes in v7:
>  - Fix atcpit100_clkevt_next_event(), before set reload register,
>    clock source timer shall disable. And re-enable it after the setting.
>    Without this modification, the test case 'clock_nanosleep02' of ltp_20170929
>    will fail.
>
> Changes in v6:
>  - To select TIMER_OF in drivers/clocksource/Kconfig instead of arch/nds32/Kconfig
>  - Refine Kconfig
>  - Update license format to SPDX-License-Identifier
>
>
> Rick Chen (3):
>   clocksource/drivers/atcpit100: Add andestech atcpit100 timer
>   clocksource/drivers/atcpit100: VDSO support
>   dt-bindings: timer: Add andestech atcpit100 timer binding doc
>
>  .../bindings/timer/andestech,atcpit100-timer.txt   |  33 +++
>  drivers/clocksource/Kconfig                        |   9 +
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/timer-atcpit100.c              | 266 +++++++++++++++++++++
>  4 files changed, 309 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
>  create mode 100644 drivers/clocksource/timer-atcpit100.c
>
Hi, Daniel:

Please merge this driver for 4.17 to go along with the nds32
architeture support.
Thank you.
