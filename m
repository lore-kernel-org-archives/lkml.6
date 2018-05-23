Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbeEWISO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:18:14 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44062 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754192AbeEWISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:18:09 -0400
X-Google-Smtp-Source: ADUXVKJPF8PDZzxU3WjSleCIGxkg4qzb3Erk6UWBjkDjXnvGJP55grMtACjWnGfG/8qNlGvbC/MG5mHF66cGyPUmxOE=
MIME-Version: 1.0
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdW-HUBRF4rLdfzixcyMUBg7+4XU+-3zayePoyeQiBZ8ZA@mail.gmail.com>
 <CAMMfpEyTORirKiE417AQzCLzxDTKmy83bwivpfJaHQsKUKMc_w@mail.gmail.com> <CAMuHMdWAU9wZkA+Z0BNAGrLV1WrCO3PgCTo2p=q3Mq9Tm6JBGA@mail.gmail.com>
In-Reply-To: <CAMuHMdWAU9wZkA+Z0BNAGrLV1WrCO3PgCTo2p=q3Mq9Tm6JBGA@mail.gmail.com>
From: M P <buserror@gmail.com>
Date: Wed, 23 May 2018 09:17:57 +0100
Message-ID: <CAMMfpEwKa90XHu_igCxRQLy_CSVHTkN8eD8f7o=wgtttSn=FqA@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: Add the rzn1-clocks.h file
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: michel.pollet@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>, buserror+upstream@gmail.com,
        Magnus Damm <magnus.damm@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, Michael Turquette <mturquette@baylibre.com>,
        sboyd@kernel.org, geert+renesas@glider.be, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Morning Geert,

On Wed, 23 May 2018 at 08:26, Geert Uytterhoeven <geert@linux-m68k.org>
wrote:

> Hi Michel,

> On Wed, May 23, 2018 at 8:44 AM, M P <buserror@gmail.com> wrote:
> > On Tue, 22 May 2018 at 19:44, Geert Uytterhoeven <geert@linux-m68k.org>
> > wrote:
> >> On Tue, May 22, 2018 at 12:01 PM, Michel Pollet
> >> <michel.pollet@bp.renesas.com> wrote:
> >> > This adds the constants necessary to use the renesas,rzn1-clocks
driver.
> >> >
> >> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

> >> > --- /dev/null
> >> > +++ b/include/dt-bindings/clock/rzn1-clocks.h
> >
> >> Given this is part of the DT ABI, and there exist multiple different
RZ/N1
> >> SoCs (and there are probably planned more), I wouldn't call this header
> >> file "rzn1-clocks.h", but e.g. "r9a06g032-clocks.h".
> >
> > Actually, no, there already are two r906g03X devices that will work
> > perfectly fine with this driver. We had that discussion before, and you
> > insist and me removing mentions of the rzn1 everywhere, however, this
> > applies to *two* devices already, and I'm supposed to upstream support
for
> > them. I can't rename r9g06g032 because it is *inexact* that's why it's

> My worry is not that there are two r906g03X devices that will work fine
> with this driver, but that there will be other "rzn1" devices that will
not
> work with these bindings (the header file is part of the bindings).
> Besides, RZ/N1D and RZ/N1S (Which apparently differ in packaging only?
> Oh no, RZ/N1D (the larger package) has less QSPI channels than RZ/N1S
> (the smaller package)), there's also (at least) RZ/N1L.

> > called rzn1. So unless you let me call it r9a06g0xx-clocks.h (which i
know
> > you won't as per multiple previous discussions) this can't be called
> > r9a06g032 because it won't be fit for my purpose when I try to bring
back
> > the RZ/N1S into the picture.

> You can add r9a06g033-clocks.h when adding support for RZ/N1S.

So it is now acceptable to duplicate a huge amount of code, and constants
when in fact there differences are so minor they would require minimal
amount of code to take care of them? That just flies straight against my
30+ years of programming -- We're going to have twice the *identical* code,
twice the header, and completely incompatible device tree files -- I mean,
*right now* our rzn1.dtsi works *as is* on the 1D and 1S, we've got ONE
file to maintain, and you can switch your CPU board from 1D to 1S and your
'board file' can stay the same.

Wasn't it the idea of that stuff in the first place? Isn't it in the
customer/engineer interest to be able to cross grade from one
manufacturer's device *in the same series* to another without having to
duplicate his whole board file?

> > There are minor difference to clocking,

> Aha?

Sure, 1S doesn't' have DDR, 1D doesn't have the second QSPI. That's about
it (I lie, theres a few other bits I'm sure). It's not like it won't even
*work* or anything, the registers are there, the bit positions are there,
all is the same, I'm *sure* that's what the compatible="" thing were
supposed to be used for, isn't it? Heck, I'm pretty sure there's a register
in sysctrl, that tells me that anyway, so I wouldn't even have to have a
special compatible= -- I didn't do it since the driver is already so big.


> > I don't know if Renesas plans to release any more rzn1's in this series,
> > but my little finger tells me this isn't the case. But regardless of
what

> We thought the same thing when the first RZ member (RZ/A1H) showed up.
> Did we know this was not going to be the first SoC of a new RZ family, but
> the first SoC of the first subfamily (RZ/A) of the RZ family... And the
> various subfamilies bear not much similarity.

> > we plan, Marketing will screw it up.

> Correct. And to mitigate that, we have no other choice than to use the
real
> part numbers to differentiate. Once bitten, twice shy.

It's not mitigation from where I stand -- it's a gigantic kludge; To handle
one exception, you throw away the baby with the bathwater. From where I
sit, it's like having to a different screwdriver for the screws on the left
of a panel vs the right of the panel.

Sorry to come out as pretty miffed -- I've just spent weeks polishing up a
driver to make it more or less similar to what they were 10 years ago (whoo
look a platform file with a big table in it!), after throwing away all the
work I had done to make it all device-tree based and make the code as
agnostic as we could -- and now it turns out we need to make it even worse
by throwing away the fact it actually *does* work on two SoC -- and that
just because... because what, again?

What about *making up names* -- The 'family names' can/will change -- the
part numbers are *too limited in scope* -- why not just make up names? does
it matter as long as it's close to reality and are documented? I dunno,
"rzn1_18" or "rzn1_mk1" and so we have a way out when they release a new
one next year? It seems to be working fine for cars "I got a 2018's
<Manufacturer> <series>"...

Cheers,
Michel



> Gr{oetje,eeting}s,

>                          Geert

> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org

> In personal conversations with technical people, I call myself a hacker.
But
> when I'm talking to journalists I just say "programmer" or something like
that.
>                                  -- Linus Torvalds
