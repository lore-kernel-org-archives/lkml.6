Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965242AbeEYJMf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:12:35 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43229 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964909AbeEYJMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:12:32 -0400
X-Google-Smtp-Source: ADUXVKJsbOgL6dzpqTlXTdBnQMvxHCfUgNOe0HIrA5K5eIatspEsRb9jXuTMzEnskqNLFQUxMpd0YouzoQtl6M76FWU=
MIME-Version: 1.0
In-Reply-To: <CAMMfpEwKa90XHu_igCxRQLy_CSVHTkN8eD8f7o=wgtttSn=FqA@mail.gmail.com>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdW-HUBRF4rLdfzixcyMUBg7+4XU+-3zayePoyeQiBZ8ZA@mail.gmail.com>
 <CAMMfpEyTORirKiE417AQzCLzxDTKmy83bwivpfJaHQsKUKMc_w@mail.gmail.com>
 <CAMuHMdWAU9wZkA+Z0BNAGrLV1WrCO3PgCTo2p=q3Mq9Tm6JBGA@mail.gmail.com> <CAMMfpEwKa90XHu_igCxRQLy_CSVHTkN8eD8f7o=wgtttSn=FqA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 May 2018 11:12:30 +0200
X-Google-Sender-Auth: Mik9aF7n1O_ImPWQCnbQwEcZsoM
Message-ID: <CAMuHMdWVde-DfbLVbvZT4rQfsVz1z7AMyQVgbO2DXrQKsEdVcw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: Add the rzn1-clocks.h file
To: M P <buserror@gmail.com>
Cc: Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

On Wed, May 23, 2018 at 10:17 AM, M P <buserror@gmail.com> wrote:
> On Wed, 23 May 2018 at 08:26, Geert Uytterhoeven <geert@linux-m68k.org>
> wrote:
>> On Wed, May 23, 2018 at 8:44 AM, M P <buserror@gmail.com> wrote:
>> > On Tue, 22 May 2018 at 19:44, Geert Uytterhoeven <geert@linux-m68k.org>
>> > wrote:
>> >> On Tue, May 22, 2018 at 12:01 PM, Michel Pollet
>> >> <michel.pollet@bp.renesas.com> wrote:
>> >> > --- /dev/null
>> >> > +++ b/include/dt-bindings/clock/rzn1-clocks.h
>> >
>> >> Given this is part of the DT ABI, and there exist multiple different
> RZ/N1
>> >> SoCs (and there are probably planned more), I wouldn't call this header
>> >> file "rzn1-clocks.h", but e.g. "r9a06g032-clocks.h".
>> >
>> > Actually, no, there already are two r906g03X devices that will work
>> > perfectly fine with this driver. We had that discussion before, and you
>> > insist and me removing mentions of the rzn1 everywhere, however, this
>> > applies to *two* devices already, and I'm supposed to upstream support
> for
>> > them. I can't rename r9g06g032 because it is *inexact* that's why it's
>
>> My worry is not that there are two r906g03X devices that will work fine
>> with this driver, but that there will be other "rzn1" devices that will
> not
>> work with these bindings (the header file is part of the bindings).
>> Besides, RZ/N1D and RZ/N1S (Which apparently differ in packaging only?
>> Oh no, RZ/N1D (the larger package) has less QSPI channels than RZ/N1S
>> (the smaller package)), there's also (at least) RZ/N1L.
>
>> > called rzn1. So unless you let me call it r9a06g0xx-clocks.h (which i
> know
>> > you won't as per multiple previous discussions) this can't be called
>> > r9a06g032 because it won't be fit for my purpose when I try to bring
> back
>> > the RZ/N1S into the picture.
>
>> You can add r9a06g033-clocks.h when adding support for RZ/N1S.
>
> So it is now acceptable to duplicate a huge amount of code, and constants
> when in fact there differences are so minor they would require minimal
> amount of code to take care of them? That just flies straight against my
> 30+ years of programming -- We're going to have twice the *identical* code,
> twice the header, and completely incompatible device tree files -- I mean,
> *right now* our rzn1.dtsi works *as is* on the 1D and 1S, we've got ONE
> file to maintain, and you can switch your CPU board from 1D to 1S and your
> 'board file' can stay the same.
>
> Wasn't it the idea of that stuff in the first place? Isn't it in the
> customer/engineer interest to be able to cross grade from one
> manufacturer's device *in the same series* to another without having to
> duplicate his whole board file?

Yes, all of these are desirable.

Now, given the clock definitions for RZ/N1[DSL] are the same (although some
don't exist on some variants), you could keep on using RZN1_CLK_FOO for the
names of the defines, and store them in a common file, included by the
soc-specific file. But please make clear the common file cannot be included
directly, so the filename does not become part of the DT ABI, and you are
shielded from future marketing silliness (e.g. next quarter's RZ/N1X being
totally different).

E.g.:

include/dt-bindings/clock/r9a06g033-clocks.h:

    #ifndef __DT_BINDINGS_R9A06G033_CLOCK_H__
    #define __DT_BINDINGS_R9A06G033_CLOCK_H__

    #include "rzn1-clocks.h"

    // ... additions and fixups, if needed

   #endif // __DT_BINDINGS_R9A06G033_CLOCK_H__

include/dt-bindings/clock/rzn1-clocks.h:

    #ifndef __DT_BINDINGS_RZN1_CLOCK_H__
    #define __DT_BINDINGS_RZN1_CLOCK_H__

    #ifndef __DT_BINDINGS_R9A06G033_CLOCK_H__
    #error Do not include rzn1-clocks.h directly
    #endif

    #define RZN1_CLK_FOO    0
    #define RZN1_CLK_BAR    1
    ...

    #endif // __DT_BINDINGS_RZN1_CLOCK_H__

As for the driver, I think you should make sure the driver instantiates no
clocks that don't exist on the actual SoC it runs on.

BTW, someone asked why I didn't use the same definitions for R-Car M3-W and
R-Car H3 (there were only a few differences), and didn't use common
definitions for all R-Car Gen3 SoCs.
I doubted a long time that we made the right decision, but then V3M and V3H
appeared in later revisions of the datasheet, and D3 and E3 later,
reconfirming our decision.

Even for compatible values for IP cores within the same family: there are
differences, but usually we only discover them after a while.
In theory all the same IP cores in R-Car Gen3 SoCs are the same (except for
obvious differences like clocks and pinctrl), in practice they are not.
So it may sound silly to have SoC-specific compatible values for the gross
of the IP cores, but it would be worse if we got bitten later by not having
them.

BTW, you're too quick reposting your series. I can't finish my reviews in
time ;-)
Please give people a reasonable amount of time to handle them.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
