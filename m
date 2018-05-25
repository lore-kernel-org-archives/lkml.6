Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965789AbeEYKbs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:31:48 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40770 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965255AbeEYKbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:31:45 -0400
X-Google-Smtp-Source: ADUXVKI2UDLxvB+cz5LmkEzPQSMDRIkucIDN4/JIas7o9FielvMTj1Zc8Acif5Z0q1PJHWHXTh6e2ISO5jU7GPcZT1w=
MIME-Version: 1.0
In-Reply-To: <1527154169-32380-2-git-send-email-michel.pollet@bp.renesas.com>
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com> <1527154169-32380-2-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 May 2018 12:31:43 +0200
X-Google-Sender-Auth: qbW57B3bA4KJZeX4bdIFHs4eBDM
Message-ID: <CAMuHMdVzN0Cbc9+MJqC4EzVgD3bkDixkf10NA13ko87cMwvpLA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] dt-bindings: Add the r9a06g032-sysctrl.h file
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PAVuXA011244

Hi Michel,

On Thu, May 24, 2018 at 11:28 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the constants necessary to use the renesas,r9a06g032-sysctrl node.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h

You can still call this file r9a06g032-clocks.h, if you want, as it
contains clock definitions only.

> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * R9A06G032 sysctrl IDs
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> + * Derived from zx-reboot.c
> + */
> +
> +#ifndef __DT_BINDINGS_R9A06G032_SYSCTRL_H__
> +#define __DT_BINDINGS_R9A06G032_SYSCTRL_H__
> +
> +#define R9A06G032_CLKOUT                       0
> +#define R9A06G032_CLK_PLL_USB                  1
> +#define R9A06G032_CLK_48                       1 /* AKA CLK_PLL_USB */
> +#define R9A06G032_CLKOUT_D10                   2
> +#define R9A06G032_CLKOUT_D16                   3
> +#define R9A06G032_MSEBIS_CLK                   3 /* AKA CLKOUT_D16 */
> +#define R9A06G032_MSEBIM_CLK                   3 /* AKA CLKOUT_D16 */
> +#define R9A06G032_CLKOUT_D160                  4
> +#define R9A06G032_CLKOUT_D1OR2                 5
> +#define R9A06G032_CLK_DDRPHY_PLLCLK            5 /* AKA CLKOUT_D1OR2 */

[...]

I have 3 comments:

  1. I had expected this list to match (both name- and order-wise) Appendix
     C ("Clock Tree Structure") in the RZ/N1[DSL] User’s Manual: System
     Introduction, Multiplexing, Electrical and Mechanical Information.
     That would make it easier to review.

  2. These definitions seems to be a mix of:
       1. Internal core clocks,
       2. Other core clocks,
       3. Module clocks.

     The internal clocks do not need to be referenced from DT, so I would
     not make them part of the DT bindings.

  3. It looks like the module clocks can be referred to by register offset
     and bit position, which is similar to how this is handled on R-Car
     SoCs.
     Perhaps you can just drop the definitions for these from the header
     file, and refer to them by (combined) register offset and bit position
     instead?
     Or am I missing something?
     I believe this can also be done for the module resets (later).

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
