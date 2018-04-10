Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeDJOiW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:38:22 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34127 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbeDJOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:38:19 -0400
X-Google-Smtp-Source: AIpwx4/PyqLZxAQDpOln3RgpmxA5dzNeim5l1zYhFlSnVR3mNqgOFTxZszwwCZS6LjHJFHCx1C0TzeSRQawO89VSNX4=
MIME-Version: 1.0
In-Reply-To: <637f00dd7da98cfeffdc6080914a5f67b433da50.1522868423.git.hns@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com> <637f00dd7da98cfeffdc6080914a5f67b433da50.1522868423.git.hns@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Apr 2018 17:38:17 +0300
Message-ID: <CAHp75VctneZKFrRr5bgq6w1L9JkDzbKW421aDLQU2jf9vZgmFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] [RFC] gpio: pca953x: hack to map LEVEL irqs to
 EDGE irqs (may loose interrupts/hang)
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 10:00 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:

> in driver code. Therefore, the pca953x driver rejects the
> setup of the irq because it can only handle EDGE interrupts
> so far.
>
> This hack translates level interrupts to edge interrupts
> for the pca953x chips. This is enough for initial testing,
> but not a good solution since interrupts may be lost.
>
> If for example the connected chip requests a IRQ_TYPE_LEVEL_LOW
> this may have the reason that there may be multiple different
> interrupt sources in the chip - wired-or together to the
> input of the pca953x. Now if we do edge detecion only,
> the first interrupt will generate an EDGE_FALLING, but a
> second one won't ever if the first interrupt wasn't already
> processed.
>
> IMHO a better solution would be to make the pca953x interrupt
> handler check if the irq input is still in the active
> level and run the device specific handler again.

What I thought about is to enable such exclusively for "L" variants of
the chips and check latched values.

-- 
With Best Regards,
Andy Shevchenko
