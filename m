Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeBWKGQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:06:16 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42244 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeBWKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:06:14 -0500
Date: Fri, 23 Feb 2018 11:06:07 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: renesas: r8a77965: Add #interrupt-cells
 property
Message-ID: <20180223100607.GO7203@w540>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519326370-15805-7-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUSS_kFU+Zg40UHvtJ=PteftQW_tvViAr-d4r+jmVNfNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUSS_kFU+Zg40UHvtJ=PteftQW_tvViAr-d4r+jmVNfNQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Feb 23, 2018 at 10:27:16AM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Add "#interrupt-cells" property and "interrupt-controller" label to
> > "interrupt-controller@e61c0000" device node.
> >
> > This silences the following DTC compiler warnings:
> > Warning (interrupts_property): Missing interrupt-controller or
> > interrupt-map property in /soc/interrupt-controller@e61c0000
> > Warning (interrupts_property): Missing #interrupt-cells in
> > interrupt-parent /soc/interrupt-controller@e61c000
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > @@ -316,6 +316,8 @@
> >                 };
> >
> >                 intc_ex: interrupt-controller@e61c0000 {
> > +                       #interrupt-cells = <2>;
> > +                       interrupt-controller;
> >                         reg = <0 0xe61c0000 0 0x200>;
> >                         /* placeholder */
>
> (bikeshedding) Should the placeholder be at the top of the node?

I would like it more too, but in M3-W dtsi:

		pciec0: pcie@fe000000 {
			reg = <0 0xfe000000 0 0x80000>;
			/* placeholder */
		};

So I kept using the same style everywhere here.

I can change it everywhere in this series to have placeholder at the
beginning of the node definition if you agree with that!

Thanks
   j

>
> >                 };
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
