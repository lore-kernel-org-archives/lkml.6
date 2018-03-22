Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754722AbeCVMtw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:49:52 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42090 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeCVMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:49:48 -0400
X-Google-Smtp-Source: AG47ELtJAg6j9QKJufm2ux2xM7Hq0VV8X4Nx0eKqiNLOsA3/3dbkUur9dQ8TgQ+DcbkJ6fYoZcJmV4qcuU0fDgdI1lk=
MIME-Version: 1.0
In-Reply-To: <1521719091-25157-7-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com> <1521719091-25157-7-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Mar 2018 13:49:47 +0100
X-Google-Sender-Auth: dZOK6ELu2hW-8ZzgAZQ2PuQAgbY
Message-ID: <CAMuHMdWG5gy25MXn2kEP0XO0xWg5Ztou2DrzLXwZWfhYRBTbCg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] DT: arm: Add Renesas RZ/N1 SoC base device tree file
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Thu, Mar 22, 2018 at 12:44 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the Renesas RZ/N1 Family (Part #R9A06G0xx) SoC
> bare bone support.
>
> This currently only handles generic parts (gic, architected timer)
> and a UART.
> For simplicity sake, this also relies on the bootloader to set the
> pinctrl and clocks.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g0xx.dtsi
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base Device Tree Source for the Renesas RZ/N1 SoC Family of devices
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       compatible = "renesas,rzn1";

As per your binding, this should be "renesas,r9a06g032"

> +       soc {

> +               sysctrl: sysctrl@4000c000 {
> +                       compatible = "renesas,rzn1-sysctrl", "syscon",

Missing "renesas,r9a06g032-sysctrl".

> +                                       "simple-mfd";
> +                       reg = <0x4000c000 0x1000>;
> +
> +                       reboot {
> +                               compatible = "renesas,rzn1-reboot";

Missing "renesas,r9a06g032-reboot".

> +                       };
> +               };


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
