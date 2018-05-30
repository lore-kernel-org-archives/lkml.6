Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968669AbeE3InX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:43:23 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39250 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937267AbeE3Imu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:42:50 -0400
X-Google-Smtp-Source: ADUXVKLllrEt2SxyoGr5aU6Dk7n7/2zXIKcwxT81ja0PNhqvDTUUMKfMhq5LqddIhheItN+dmATj8kXKg40RXoWmOWw=
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB20546AE06422C9AD896F8F60D26C0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1527157834-7747-1-git-send-email-michel.pollet@bp.renesas.com>
 <1527157834-7747-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdWv2ZRbX=k5+H_WfAeoQ4QsyQLU9iQ9TJ9OQ0fmwg0GOQ@mail.gmail.com> <OSBPR01MB20546AE06422C9AD896F8F60D26C0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 May 2018 10:42:48 +0200
X-Google-Sender-Auth: FMQbo9awfIJQhAmFFhs-Q5vIlWk
Message-ID: <CAMuHMdUZ-sVE3z5nW30m3O5g4gB=TcQATDQ-Q5mdDsYX7c4ttQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Juri Lelli <juri.lelli@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@endlessm.com>, Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Wed, May 30, 2018 at 10:19 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> On 25 May 2018 10:49, Geert wrote:
>> On Thu, May 24, 2018 at 12:30 PM, Michel Pollet
>> <michel.pollet@bp.renesas.com> wrote:
>> > The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>> > it requires a special enable method to get it started.
>> >
>> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>>
>> Thanks for your patch!
>>
>> >  arch/arm/mach-shmobile/smp-r9a06g032.c | 85
>> > ++++++++++++++++++++++++++++++++++
>>
>> I think you can safely call this driver smp-rzn1d.c, or smp-rzn1.c.
>> Source files are not covered by the stable DT ABI, and can be reordered later
>> at will.
>>
>> I expect you will just add more CPU_METHOD_OF_DECLARE() lines later
>> (perhaps with a little bit of extra code to handle deviations).
>
> Now I am completely confused -- you had me remove the mention of rzn1
> from everywhere it mattered to handle 'family' cases, and now you are
> telling me that in *this* case where there is not a single chance of that file
> covering another part and there's a clear cut case for it to be part specific
> .... I should call it rzn1?!?

Sorry for confusing you.
There's a difference between stable DT ABI and (non-existing) kernel stable ABI.
A driver that handles multiple SoCs can be named after the SoC family.

I agree this one is a bit special, as only RZ/N1D has the dual Cortex A7
(RZ/N1S has a single A7, RZ/N1L has no A7), so for now[*] there's no need
to use it on anything but r9a06g032 aka RZ/N1D.

> I'd like consistency -- I *thought* I had a consistent naming scheme before,
> now I've moved to your part specific one (under duress), I'd rather stick to
> something that is consistent and keep everything as r9a06g032 now.

OK for me. Driver names can be changed any time.

[*] Until e.g. a quad A7 arrives :-)
    Perhaps this can also be used to enable the A7s on both RZ/N1D and
    RZ/N1S when running Linux on the Cortex M3?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
