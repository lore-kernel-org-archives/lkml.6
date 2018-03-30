Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeC3Vjr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:39:47 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44302 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeC3Vjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:39:45 -0400
X-Google-Smtp-Source: AIpwx4+Yyg2xYAZy392gPfmZJxejaaBcG/Fbk2j20bRyQUogHEZT3a+BihfSjokgbKyaBvemB2sPnkyNbz4Ie9gTBgM=
MIME-Version: 1.0
In-Reply-To: <281D9C45-537A-4804-A9FA-6816E0FCAD27@goldelico.com>
References: <49f6922ba342cf69bfd2a787d0c2a93b4df2c429.1520664883.git.hns@goldelico.com>
 <CACRpkdYfk7P0+Ysy43HboBe0Z66vO3COXRgUGaZ7Y9sSDh+yxA@mail.gmail.com>
 <EA5887ED-9C02-4FFF-AC29-14F7D4F0B32D@goldelico.com> <281D9C45-537A-4804-A9FA-6816E0FCAD27@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 31 Mar 2018 00:39:44 +0300
Message-ID: <CAHp75VdWYDvZ0tS-MXB+MeEAF+v1ry31ka7oKAn12-Ov=ZPcXw@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: pca953x: add compatibility for pcal6524
 and pcal9555a
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Courbot <gnurou@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>, kernel@pyra-handheld.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 10:29 PM, H. Nikolaus Schaller
<hns@goldelico.com> wrote:

> Another issue I have fixed is that the pcal6524 has 4 registers per
> bank while the pcal9555a has only 2.

So, you mean it's still in non-working case in Linus' tree?
Please, send patches!

> This is encoded in the address
> constants for the new "L"-registers and has to be taken care of in
> pca953x_read_regs_24() and pca953x_write_regs_24().
>
> But I still have another problem:
>
> [    4.808823] pca953x 4-0022: irq 186: unsupported type 8
> [    4.814303] genirq: Setting trigger mode 8 for irq 186 failed (pca953x_irq_set_type+0x0/0xa8)
>
> This comes from https://elixir.bootlin.com/linux/v4.16-rc7/source/sound/soc/codecs/ts3a227e.c#L314
>
> It appears that the pca953x driver/interrupt-controller can't handle
> IRQF_TRIGGER_LOW, but that is hard coded into the ts3a227 driver.
>
> Anyone with knowledge and help about this issue?

This is easy to fix (not read datasheet for better solution though):
emulate it via FALLING (LOW) and RISING (HIGH).


-- 
With Best Regards,
Andy Shevchenko
