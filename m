Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933636AbeEWPmf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933471AbeEWPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:42:32 -0400
X-Google-Smtp-Source: ADUXVKLl2YiO5G4C7yXp1SZW86Toicu4Ylq3D5hOxvIxs7CEboQo4OMEcQm8WLqxJb33NNzYIi/pPIzfn9RYgbL6CKc=
MIME-Version: 1.0
In-Reply-To: <CAMMfpEwn3+fCZZZ8ADNxjun+jzNSnH+8xPcA8OUS_jPUJ-o6LA@mail.gmail.com>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-4-git-send-email-michel.pollet@bp.renesas.com>
 <20180522160913.GA7755@rob-hp-laptop> <CAMMfpEwn3+fCZZZ8ADNxjun+jzNSnH+8xPcA8OUS_jPUJ-o6LA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 May 2018 10:42:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLqmwfGZcZseO6gB33BA04TLtwZ94VGKOL7TWp30bm44w@mail.gmail.com>
Message-ID: <CAL_JsqLqmwfGZcZseO6gB33BA04TLtwZ94VGKOL7TWp30bm44w@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] dt-bindings: clock: renesas,rzn1-clocks: document
 RZ/N1 clock driver
To: M P <buserror@gmail.com>
Cc: Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 1:52 AM, M P <buserror@gmail.com> wrote:
> Hi Rob,
>
> On Tue, 22 May 2018 at 17:09, Rob Herring <robh@kernel.org> wrote:
>
>> On Tue, May 22, 2018 at 11:01:23AM +0100, Michel Pollet wrote:
>> > The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
>> > to provide the SoC clock infrastructure for Linux.
>> >
>> > This documents the driver bindings.
>> >
>> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>> > ---
>> >  .../bindings/clock/renesas,rzn1-clocks.txt         | 44
> ++++++++++++++++++++++
>> >  1 file changed, 44 insertions(+)
>> >  create mode 100644
> Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
>> >
>> > diff --git
> a/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
>> > new file mode 100644
>> > index 0000000..0c41137
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
>> > @@ -0,0 +1,44 @@
>> > +* Renesas RZ/N1 Clock Driver
>> > +
>> > +This driver provides the clock infrastructure used by all the other
> drivers.
>
>> Bindings document h/w not drivers.
>
>> > +
>> > +One of the 'special' feature of this infrastructure is that Linux
> doesn't
>
>> Bindings are not just for Linux.
>
>> > +necessary 'own' all the clocks on the SoC, some other OS runs on
>> > +the Cortex-M3 core and that OS can access and claim it's own clocks.
>
>> How is this relevant to the binding?
>
> Well you just said it, if the binding is not just for linux, it's probably
> a good idea to mention it somewhere since I can promise you it's *not*
> documented in the hardware manual. Whatever this binding is for, it's
> relevant to point out it is different from the other clock drivers in the
> same directory... ?

That's not an uncommon issue (sometimes it's secure world that owns
the clocks, not even a different processor). I'm just not sure what I
do with this information. It doesn't tell me which clocks are owned by
the M3 or not.

>> > +
>> > +Required Properties:
>> > +
>> > +  - compatible: Must be
>> > +    - "renesas,r9a06g032-clocks" for the RZ/N1D
>> > +    and "renesas,rzn1-clocks" as a fallback.
>
>> Is "clocks" how the chip reference manual refers to this block?
>
> No, the block is called 'sysctrl' and has tons of other stuff in there.
> I've tried multiple times to get a 'sysctrl' driver in the previous
> versions of the patch, in various shape or form, and I can't because I'd be
> supposed to 'document' binding for stuff that has no code, no purpose, no
> testing, and have all wildly different topics. So, after some more
> lengthily discussion with Geert, we've decided to make the 'primary'
> feature of that block (clocks) as a driver, and see from there onward.

If you are referring to Geert's reply on v4, then this is not how I
interpreted it. I understood it as make the clock driver bind to the
sysctrl node and the clock driver can register other functions like
reset. Then later if you need multiple drivers, you can make an MFD
driver that binds to the sysctrl node and creates child devices to
bind sub-drivers (like clocks) to. But the DT doesn't change in the
process wrt clocks.

You don't have to have a driver for everything, but the binding should
be as complete as possible and done in an extendable way. The way you
have done it now is not. I can already see that at some point you will
want to break things and do something like this:

{
  compatible = "renesas,r9a06g032-sysctrl";
  ...
  {
    compatible = "renesas,r9a06g032-clocks";
    ...
  };
};

Which is likely wrong because there's no need to have a child node
like that. The parent node can be the clock provider (and any other
provider). There are cases when child nodes do make sense, but we need
a more complete binding to make that decision. Evolving it one feature
at a time doesn't work.

Rob
