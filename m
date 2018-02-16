Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757852AbeBPJUX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:20:23 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46950 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757435AbeBPJUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:20:21 -0500
X-Google-Smtp-Source: AH8x2243XdtWSrH7WmEqaB7mHR6Zv35RaUxhYIEnC5iRyC5LXkUJ73EpyfN+c/+tL9DVmSnv/JWOqAuU/A5g/KpH25w=
MIME-Version: 1.0
In-Reply-To: <1518515162-23663-6-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org> <1518515162-23663-6-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2018 10:20:20 +0100
X-Google-Sender-Auth: 4sE__txqEEDP-vZaMVwC6ZolLfE
Message-ID: <CAMuHMdUSXE2k4QwbpRvFChtfFj6_RYxCwst8yvbkA1GxhvacfQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] ARM64: dts: Add R-Car Salvator-x M3-N support
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -0,0 +1,495 @@
> +// SPDX-License-Identifier: GPL-2.
> +/*
> + * Device Tree Source for the r8a77965 SoC
> + *
> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> + *
> + * Based on r8a7796.dtsi
> + * Copyright (C) 2016 Renesas Electronics Corp.
> + */
> +
> +#include <dt-bindings/clock/r8a77965-cpg-mssr.h>

For the initial submission, it's better to use hardcoded numbers than the
R8A77965_CLK_* definitions, as the latter go in through a different tree.
Hence you should replace above include by

    #include <dt-bindings/clock/renesas-cpg-mssr.h>

and replace R8A77965_CLK_* by hardcoded numbers in all r8a77965.dtsi
patches.

> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/r8a77965-sysc.h>

For the initial submission, it's better to use hardcoded numbers than the
R8A77965_PD_* definitions, as the latter go in through a different tree.
Hence you should drop the above include, and replace R8A77965_PD_*
by hardcoded numbers in all r8a77965.dtsi patches.

The hardcoded numbers can be replaced by symbolic definitions later,
when the definitions have hit mainline.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
