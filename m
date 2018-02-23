Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBWMXB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:23:01 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51714 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeBWMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:22:58 -0500
Date: Fri, 23 Feb 2018 13:22:50 +0100
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
Subject: Re: [PATCH 1/6] arm64: dts: renesas: r8a77965: Add "reg" properties
Message-ID: <20180223122250.GP7203@w540>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519326370-15805-2-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdWGYpeOMJQKcT8=wm1YzQoB+vpK5H99Kg_pJ_HeBUw8Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWGYpeOMJQKcT8=wm1YzQoB+vpK5H99Kg_pJ_HeBUw8Sw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Feb 23, 2018 at 10:19:21AM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Add "reg" properties to place-holder nodes with unit address defined for
> > R-Car M3-N SoC.
> >
> > This silences the following DTC compiler warning:
> > Warning (unit_address_vs_reg): Node /soc/... has a unit name,
> > but no reg property
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> A few minor nits below...
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
>
> > @@ -520,130 +521,163 @@
> >                 };
> >
> >                 avb: ethernet@e6800000 {
> > +                       reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
>
> The first reg part would be sufficient for a placeholder.
> I think even setting the size to zero would work...

Not sure I fully got your point here.

Do you mean I have to remove the second (and third, fourth...)  addresses range block
in all placeholder device nodes with multiple blocks (avb, du, rcar-sound) ?

Do you mean I have to set to 0 the address length in all placeholder nodes?
What's the point if they have to be added back once the device is
enabled?

>
> >                 du: display@feb00000 {
> > +                       reg = <0 0xfeb00000 0 0x70000>,
>
> Unlike M3-W, the M3-N DU has a third channel, so the size is too small.
>

Will fix in v2

> > +                             <0 0xfeb90000 0 0x14>;
> >                         /* placeholder */
>
> > @@ -703,38 +745,47 @@
> >                 };
> >
> >                 usb2_phy1: usb-phy@ee0a0200 {
> > +                       reg = <0 0xee0a0200 0 0x700>;
> >                         /* placeholder */
> >                 };
>
> To be moved up, next to the other usb2 devices?

Will add a patch to move this next to other usb2 device nodes in v2.

I will send v2 as soon as first review comment gets clarified.

Thanks
   j

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
