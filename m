Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932068AbeEWGpO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:45:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34791 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754114AbeEWGpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:45:02 -0400
X-Google-Smtp-Source: AB8JxZqZRvUY8aNHcHygDm2q9hIVNrTGM1vVUOYb/I/jdcl4LB6saZPR1ryvSY+VzdurIrDsJo7Hh9FHGSk+rRlcyps=
MIME-Version: 1.0
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-3-git-send-email-michel.pollet@bp.renesas.com> <CAMuHMdW-HUBRF4rLdfzixcyMUBg7+4XU+-3zayePoyeQiBZ8ZA@mail.gmail.com>
In-Reply-To: <CAMuHMdW-HUBRF4rLdfzixcyMUBg7+4XU+-3zayePoyeQiBZ8ZA@mail.gmail.com>
From: M P <buserror@gmail.com>
Date: Wed, 23 May 2018 07:44:50 +0100
Message-ID: <CAMMfpEyTORirKiE417AQzCLzxDTKmy83bwivpfJaHQsKUKMc_w@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: Add the rzn1-clocks.h file
To: geert@linux-m68k.org
Cc: michel.pollet@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        horms@verge.net.au, Phil Edworthy <phil.edworthy@renesas.com>,
        buserror+upstream@gmail.com, magnus.damm@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 at 19:44, Geert Uytterhoeven <geert@linux-m68k.org>
wrote:

> Hi Michel,

> On Tue, May 22, 2018 at 12:01 PM, Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > This adds the constants necessary to use the renesas,rzn1-clocks driver.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

> Thanks for your patch!

> > ---
> >  include/dt-bindings/clock/rzn1-clocks.h | 187
++++++++++++++++++++++++++++++++
> >  1 file changed, 187 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/rzn1-clocks.h
> >
> > diff --git a/include/dt-bindings/clock/rzn1-clocks.h
b/include/dt-bindings/clock/rzn1-clocks.h
> > new file mode 100644
> > index 0000000..8a73db2
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/rzn1-clocks.h

> Given this is part of the DT ABI, and there exist multiple different RZ/N1
> SoCs (and there are probably planned more), I wouldn't call this header
> file "rzn1-clocks.h", but e.g. "r9a06g032-clocks.h".

Actually, no, there already are two r906g03X devices that will work
perfectly fine with this driver. We had that discussion before, and you
insist and me removing mentions of the rzn1 everywhere, however, this
applies to *two* devices already, and I'm supposed to upstream support for
them. I can't rename r9g06g032 because it is *inexact* that's why it's
called rzn1. So unless you let me call it r9a06g0xx-clocks.h (which i know
you won't as per multiple previous discussions) this can't be called
r9a06g032 because it won't be fit for my purpose when I try to bring back
the RZ/N1S into the picture. There are minor difference to clocking,

I don't know if Renesas plans to release any more rzn1's in this series,
but my little finger tells me this isn't the case. But regardless of what
we plan, Marketing will screw it up.

Cheers,
Michel


> > @@ -0,0 +1,187 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * RZ/N1 clock IDs
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > + *
> > + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> > + * Derived from zx-reboot.c
> > + */
> > +
> > +#ifndef __DT_BINDINGS_RZN1_CLOCK_H__
> > +#define __DT_BINDINGS_RZN1_CLOCK_H__
> > +
> > +#define RZN1_CLKOUT                    0

> Similar for the RZN1 prefix.

> I'll look at the actual list of clocks later...

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
