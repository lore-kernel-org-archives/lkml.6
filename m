Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeEWH07 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:26:59 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44938 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbeEWH0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:26:31 -0400
X-Google-Smtp-Source: AB8JxZrUZ+QEjBmGZyBTOpNrvmQ3SIm9+I6MjJ+s1e9+Lq5gnGoxt7h1e5LIhQrrVE8uAd2PMRSeqpKwTgON7QKgkKM=
MIME-Version: 1.0
In-Reply-To: <CAMMfpEyTORirKiE417AQzCLzxDTKmy83bwivpfJaHQsKUKMc_w@mail.gmail.com>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdW-HUBRF4rLdfzixcyMUBg7+4XU+-3zayePoyeQiBZ8ZA@mail.gmail.com> <CAMMfpEyTORirKiE417AQzCLzxDTKmy83bwivpfJaHQsKUKMc_w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 09:26:30 +0200
X-Google-Sender-Auth: SlBPPR4TA7gSeEAsGUxaLR3wkBo
Message-ID: <CAMuHMdWAU9wZkA+Z0BNAGrLV1WrCO3PgCTo2p=q3Mq9Tm6JBGA@mail.gmail.com>
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

On Wed, May 23, 2018 at 8:44 AM, M P <buserror@gmail.com> wrote:
> On Tue, 22 May 2018 at 19:44, Geert Uytterhoeven <geert@linux-m68k.org>
> wrote:
>> On Tue, May 22, 2018 at 12:01 PM, Michel Pollet
>> <michel.pollet@bp.renesas.com> wrote:
>> > This adds the constants necessary to use the renesas,rzn1-clocks driver.
>> >
>> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

>> > --- /dev/null
>> > +++ b/include/dt-bindings/clock/rzn1-clocks.h
>
>> Given this is part of the DT ABI, and there exist multiple different RZ/N1
>> SoCs (and there are probably planned more), I wouldn't call this header
>> file "rzn1-clocks.h", but e.g. "r9a06g032-clocks.h".
>
> Actually, no, there already are two r906g03X devices that will work
> perfectly fine with this driver. We had that discussion before, and you
> insist and me removing mentions of the rzn1 everywhere, however, this
> applies to *two* devices already, and I'm supposed to upstream support for
> them. I can't rename r9g06g032 because it is *inexact* that's why it's

My worry is not that there are two r906g03X devices that will work fine
with this driver, but that there will be other "rzn1" devices that will not
work with these bindings (the header file is part of the bindings).
Besides, RZ/N1D and RZ/N1S (Which apparently differ in packaging only?
Oh no, RZ/N1D (the larger package) has less QSPI channels than RZ/N1S
(the smaller package)), there's also (at least) RZ/N1L.

> called rzn1. So unless you let me call it r9a06g0xx-clocks.h (which i know
> you won't as per multiple previous discussions) this can't be called
> r9a06g032 because it won't be fit for my purpose when I try to bring back
> the RZ/N1S into the picture.

You can add r9a06g033-clocks.h when adding support for RZ/N1S.

> There are minor difference to clocking,

Aha?

> I don't know if Renesas plans to release any more rzn1's in this series,
> but my little finger tells me this isn't the case. But regardless of what

We thought the same thing when the first RZ member (RZ/A1H) showed up.
Did we know this was not going to be the first SoC of a new RZ family, but
the first SoC of the first subfamily (RZ/A) of the RZ family... And the
various subfamilies bear not much similarity.

> we plan, Marketing will screw it up.

Correct. And to mitigate that, we have no other choice than to use the real
part numbers to differentiate. Once bitten, twice shy.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
