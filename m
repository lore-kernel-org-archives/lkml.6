Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeEWJUq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:20:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55259 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932128AbeEWJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:20:32 -0400
X-Google-Smtp-Source: AB8JxZrLaRLfow/yRLA8BlfLSOG7W21ZuLSsxnbBf+Pj5QYk11oMCD0BlbsZ6qYIlV52XvcEdW5gWTn8KAci0LLbw9k=
MIME-Version: 1.0
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-5-git-send-email-michel.pollet@bp.renesas.com> <CAMuHMdXETt75rGyYRsNEK0O5CO3A-bG70g=-f23y6PO_uK6rWg@mail.gmail.com>
In-Reply-To: <CAMuHMdXETt75rGyYRsNEK0O5CO3A-bG70g=-f23y6PO_uK6rWg@mail.gmail.com>
From: M P <buserror@gmail.com>
Date: Wed, 23 May 2018 10:20:20 +0100
Message-ID: <CAMMfpEw=6POaZBU9HduKBb8Wk2mH0oAXhCdQo7c+hQWgxka3vA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] ARM: dts: Renesas RZ/N1 SoC base device tree file
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

Hi Geert,

On Wed, 23 May 2018 at 10:12, Geert Uytterhoeven <geert@linux-m68k.org>
wrote:

> Hi Michel,

> On Tue, May 22, 2018 at 12:01 PM, Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > This adds the Renesas RZ/N1D (Part #R9A06G032) SoC bare
> > bone support.
> >
> > This currently only handles generic parts (gic, architected timer)
> > and a UART.
> > For simplicity sake, this also relies on the bootloader to set the
> > pinctrl and clocks.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

> Thanks for your patch!


> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               clocks = <&clock RZN1_DIV_CA7>;

> I think the clocks property should be moved to the individual CPU nodes.


Ah, I had a look around, and I found some instances that are in the cpu
sub-node, and others that are not -- it seems that having it in the cpu
sub-node would implies it's core specific... here if that clock is changed
both cores would change speed...
Either way, it's not used by the kernel in any way at the moment -- I had
hoped cpufreq or something would claim it, but it's not the case.

Thanks,
Michel
