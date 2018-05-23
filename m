Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbeEWJMO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:12:14 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35982 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754395AbeEWJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:12:08 -0400
X-Google-Smtp-Source: AB8JxZrxq8po2DPEkKEPc1kawkwP2+d/H0gQA+vSV+UGiipeqCAKQi1qRCRWnvv93rFVlluzc9+dZ5e7cxF3CqtPl2Q=
MIME-Version: 1.0
In-Reply-To: <1526983321-41949-5-git-send-email-michel.pollet@bp.renesas.com>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com> <1526983321-41949-5-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 11:12:07 +0200
X-Google-Sender-Auth: Lp4bFmeXIfu5GWpgfaiu_U7nYPc
Message-ID: <CAMuHMdXETt75rGyYRsNEK0O5CO3A-bG70g=-f23y6PO_uK6rWg@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] ARM: dts: Renesas RZ/N1 SoC base device tree file
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Tue, May 22, 2018 at 12:01 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the Renesas RZ/N1D (Part #R9A06G032) SoC bare
> bone support.
>
> This currently only handles generic parts (gic, architected timer)
> and a UART.
> For simplicity sake, this also relies on the bootloader to set the
> pinctrl and clocks.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base Device Tree Source for the Renesas RZ/N1D (R9A06G032)
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/rzn1-clock.h>
> +
> +/ {
> +       compatible = "renesas,r9a06g032", "renesas,rzn1";

Please drop the "renesas,rzn1".


> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               clocks = <&clock RZN1_DIV_CA7>;

I think the clocks property should be moved to the individual CPU nodes.

> +
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0>;
> +               };
> +
> +               cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <1>;
> +               };
> +       };

The rest looks OK to me (pending acceptance of the clock bindings).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
