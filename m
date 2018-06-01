Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeFAISs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:18:48 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45924 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeFAISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:18:38 -0400
X-Google-Smtp-Source: ADUXVKIpJH0AY7tkj0ohDupQq5RdYBQFb0mP/USgRUUck9OZ1GoPowcFfkgziEzZHdma53IduxWp+SIijA4wFoYS3uM=
MIME-Version: 1.0
In-Reply-To: <CAMMfpEwnB26q+JzEfwby409XkUPWpNZAD8FhRWJfjW=0naY+pg@mail.gmail.com>
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com>
 <1527154169-32380-2-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdVzN0Cbc9+MJqC4EzVgD3bkDixkf10NA13ko87cMwvpLA@mail.gmail.com>
 <CAMMfpEwpiZnZEykzxQJMTwE+cDnOD_qA3nUzyB96DGTWPzSJrw@mail.gmail.com>
 <CAMuHMdXQWSVh37HqrvFWeLNHZ5zNh0=9+hV0_nsQ9mi1HQSCaQ@mail.gmail.com> <CAMMfpEwnB26q+JzEfwby409XkUPWpNZAD8FhRWJfjW=0naY+pg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Jun 2018 10:18:35 +0200
X-Google-Sender-Auth: ca-kOKv5lpTCWV3jvdojiV4ySOw
Message-ID: <CAMuHMdUa4UFOsMb1z9aBdCOW1YmrnLOQ866TCOCfmvEu3H3Dxg@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] dt-bindings: Add the r9a06g032-sysctrl.h file
To: M P <buserror@gmail.com>
Cc: Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w518JO1s017385

Hi Michel,

On Thu, May 31, 2018 at 12:01 PM, M P <buserror@gmail.com> wrote:
> On Thu, 31 May 2018 at 10:32, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, May 31, 2018 at 11:11 AM, M P <buserror@gmail.com> wrote:
>> > On Fri, 25 May 2018 at 11:31, Geert Uytterhoeven <geert@linux-m68k.org>
>> > wrote:
>> >> On Thu, May 24, 2018 at 11:28 AM, Michel Pollet
>> >> <michel.pollet@bp.renesas.com> wrote:
>> >> > This adds the constants necessary to use the renesas,r9a06g032-sysctrl
>> > node.
>>
>> >> > @@ -0,0 +1,187 @@
>> >> > +/* SPDX-License-Identifier: GPL-2.0 */
>> >> > +/*
>> >> > + * R9A06G032 sysctrl IDs
>> >> > + *
>> >> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
>> >> > + *
>> >> > + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
>> >> > + * Derived from zx-reboot.c
>> >> > + */
>> >> > +
>> >> > +#ifndef __DT_BINDINGS_R9A06G032_SYSCTRL_H__
>> >> > +#define __DT_BINDINGS_R9A06G032_SYSCTRL_H__
>> >> > +
>> >> > +#define R9A06G032_CLKOUT                       0
>> >> > +#define R9A06G032_CLK_PLL_USB                  1
>> >> > +#define R9A06G032_CLK_48                       1 /* AKA CLK_PLL_USB */
>> >> > +#define R9A06G032_CLKOUT_D10                   2
>> >> > +#define R9A06G032_CLKOUT_D16                   3
>> >> > +#define R9A06G032_MSEBIS_CLK                   3 /* AKA CLKOUT_D16 */
>> >> > +#define R9A06G032_MSEBIM_CLK                   3 /* AKA CLKOUT_D16 */
>> >> > +#define R9A06G032_CLKOUT_D160                  4
>> >> > +#define R9A06G032_CLKOUT_D1OR2                 5
>> >> > +#define R9A06G032_CLK_DDRPHY_PLLCLK            5 /* AKA CLKOUT_D1OR2 */
>> >
>> >> [...]
>> >
>> >> I have 3 comments:
>> >
>> >>    1. I had expected this list to match (both name- and order-wise)
>> > Appendix
>> >>       C ("Clock Tree Structure") in the RZ/N1[DSL] User’s Manual: System
>> >>       Introduction, Multiplexing, Electrical and Mechanical Information.
>> >>       That would make it easier to review.
>> >
>> > Well, that document was made a *long* time after the internal documentation
>> > we used to generate the clock lists. There are a few things we had to do:
>> >
>> > * Renumber peripherals. We decided a long time ago that u-boot and linux
>> > would stick to zero based peripherals, and not one based numbers. It's next
>> > to impossible to keep mixing number based across software base, so we use
>> > UART0 while the hardware manual mentions UART1 -- It *is* documented
>> > extensively with out SDK, and makes life using linux a lot easier. It's
>> > across all our SDK, u-boot, webapps readmes, howtos etc.
>> >
>> > * Rename some peripherals. Plenty of peripherals names made little sense
>> > and had zero consistency, in fact, many names were different depending on
>> > the place they were used! -- "flashnand"+"nand_flash"+"FNAND" etc,
>> > "QUADSPI"+"QSPI" etc etc so we also re-normalized the names to match linux
>> > conventions.
>> >
>> > * Other internal reasons I can't document here
>> >
>> > Also, the value here are made up anyway -- so I've decided to sort them to
>> > make sure any clock that has a parent is numbered *after* the parent...
>>
>> Well, all of that combines makes it very hard for us to review the list.
>
> I understand -- the previous format was a lot more readable, here I had to
> work to make the table as small as I could, and quite a few bits of readability
> were lost in the process. It's already a huge file.
>
> I'm not sure if that would help, but here is the link to the old table
> format I used
> https://github.com/renesas-rz/rzn1_linux/blob/rzn1-stable/drivers/clk/rzn1/rzn1-clkctrl-tables.h
>
> I had to throw that away to make up the new composite table that now contains
> what was in the device tree file before. However the names are the same.
>
> Perhaps I could change how I encode the register/bit pairs to use 8+8 bits to
> make the hex constants more readable?

Alternatively, you can use a macro to pack them, cfr. MOD_CLK_PACK()
in renesas-cpg-mssr.

>> >>    2. These definitions seems to be a mix of:
>> >>         1. Internal core clocks,
>> >>         2. Other core clocks,
>> >>         3. Module clocks.
>> >
>> >>       The internal clocks do not need to be referenced from DT, so I would
>> >>       not make them part of the DT bindings.
>> >
>> > Why? I'm told that "Bindings aren't for linux" -- why can't I imagine
>> > 'something' needing them? Why would I decide NOT to include them,
>> > as they are there? I 'factored' a few of them to the same number when
>>
>> Just general safety w.r.t. unchangeable DT definitions: anything that is
>> not listed here cannot be declared wrong later.
>
> Well, I need these #define *somewhere* as I use them in my driver. So what
> do you want me to do?
> + Remove the header, move the constants into the driver?
> + Use hard coded numbers in the DT and remove the header entirely?
> + Duplicate the header, keep the full one with the driver, and only list
> the CA7+UART0 one in the dt-binding and duplicate the ones I need as
> I go along?

None of these. You can just move the #defines that will never be needed
from DT into the driver source file.

Cfr. "Internal Core Clocks" in drivers/clk/renesas/r8a7795-cpg-mssr.c.

>> > applicable.
>>
>> You're 100% sure they're the same?
>
> Yes, the script logic hasn't changed in 2 years, and we've been using that
> hierarchy extensively since.
> Basically the logic is that if a clock doesn't have a gate and isn't a divisor
> of some sort, it's factored with it's parent clock... it used to be
> done with a DT
> alias of the same name.

OK.

>> > This is all done automatically BTW -- a script takes the original clocking
>> > spreadsheet, and converts it into a table, correcting 'human input' as it
>> > goes along.
>>
>> So the internal spreadsheet doesn't match the public documentation neither?
>
> Nope, as usual, people who wrote the documentation went their own way at
> some point, and didn't backport any changes they made.

Well, I guess we'll have to live with that...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
