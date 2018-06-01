Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeFAIWq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:22:46 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42272 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeFAIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:22:41 -0400
X-Google-Smtp-Source: ADUXVKJwrsBRyW1qxxIDtr7IGAiqC8HSS39TPvbCtiowQ+FFtNTTHUuRZSIHLrzN45KoR4q2jCSqNDK5E9/hxAoV9Qw=
MIME-Version: 1.0
In-Reply-To: <CAMMfpExt6Kogw6T5FVrD94QuuN6BBNCXdW0qfnnWr2bEMfqjpA@mail.gmail.com>
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com>
 <1527154169-32380-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdUb4fWFB9oP41ejO0_FDxmgBPL0GxQnkFv18Zfb5=1-fw@mail.gmail.com> <CAMMfpExt6Kogw6T5FVrD94QuuN6BBNCXdW0qfnnWr2bEMfqjpA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Jun 2018 10:22:39 +0200
X-Google-Sender-Auth: naSpdEh030vu7AarbVhAOmfcNw8
Message-ID: <CAMuHMdWSnYEkJ1YJDrLaE-5jYp6kC+YFLnVEB7CoACrH3Ucu-A@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
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

Hi Michel,

On Thu, May 31, 2018 at 12:16 PM, M P <buserror@gmail.com> wrote:
> On Fri, 25 May 2018 at 10:23, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, May 24, 2018 at 11:28 AM, Michel Pollet
>> <michel.pollet@bp.renesas.com> wrote:
>> > The Renesas R9A06G032 SYSCTRL node description.
>> >
>> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>>
>> Thanks for your patch!
>>
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
>> > @@ -0,0 +1,32 @@
>> > +* Renesas R9A06G032 SYSCTRL
>> > +
>> > +Required Properties:
>> > +
>> > +  - compatible: Must be:
>> > +    - "renesas,r9a06g032-sysctrl"
>> > +  - reg: Base address and length of the SYSCTRL IO block.
>> > +  - #clock-cells: Must be 1
>>
>> No clocks/clock-names for the external clock inputs?
>>
>> "RZ/N1 has 3 clock sources, 1 reference clock inputs for RGMII, and 2
>>  reference clock outputs for RMII/MII."
>>
>> Given the documentation explicitly mentions the module clocks are to be
>> used for power-management, you may want to add #power-domain-cells as well,
>> and let the driver register clock domain. But that can be added later
>> (although it will break backwards compatibility with old DTBs).
>>
>> As PWRCTRL_* registers allow to reset individual modules, #reset-cells is
>> another thing to add later.  It's good to start thinking early about how to
>> reference resets, though.
>> E.g. on other Renesas-SoCs, module resets uses the same numerical
>> references as module clocks.
>
> As you said, could we add all that later, as appropriate? Here I tried
> to trim it
> down to the the bare minimum -- my previous version of the driver had
> separate reset  descriptors, but this one has been all compacted to do just
> what it's supposed to do: clocks.

Yes, it can be added later.
I just wanted to mention it, so you could already think about it, and to avoid a
possible "but we could have nicely integrated reset and clock support if we
did ..." later.

> Or, so you want to add another DT index to refer to other reset indexes etc?
> ie not use the of_clk_src_onecell_get provider? That COULD work and yes, the
> indexes would stay the same, I'd just have to get the reset descriptor from the
> clock object. We haven't had a use for individual resets so far.

Reset indices come from DT, too, but the reset framework doesn't use an
xlate function itself, but just passes the index to the reset driver.
How you obtain the register and bits to reset the device is competlely up
to to the reset driver.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
