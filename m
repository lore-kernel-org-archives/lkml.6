Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeBWMCv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:02:51 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:50947 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:02:49 -0500
Date: Fri, 23 Feb 2018 13:02:44 +0100
From: Simon Horman <horms@verge.net.au>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Arnd Bergmann <arnd@arndb.de>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: renesas: r8a77965: Add #interrupt-cells
 property
Message-ID: <20180223120244.ftzw72a3a6w45pi3@verge.net.au>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519326370-15805-7-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUSS_kFU+Zg40UHvtJ=PteftQW_tvViAr-d4r+jmVNfNQ@mail.gmail.com>
 <20180223100607.GO7203@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223100607.GO7203@w540>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 11:06:07AM +0100, jacopo mondi wrote:
> Hi Geert,
> 
> On Fri, Feb 23, 2018 at 10:27:16AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > > Add "#interrupt-cells" property and "interrupt-controller" label to
> > > "interrupt-controller@e61c0000" device node.
> > >
> > > This silences the following DTC compiler warnings:
> > > Warning (interrupts_property): Missing interrupt-controller or
> > > interrupt-map property in /soc/interrupt-controller@e61c0000
> > > Warning (interrupts_property): Missing #interrupt-cells in
> > > interrupt-parent /soc/interrupt-controller@e61c000
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > > @@ -316,6 +316,8 @@
> > >                 };
> > >
> > >                 intc_ex: interrupt-controller@e61c0000 {
> > > +                       #interrupt-cells = <2>;
> > > +                       interrupt-controller;
> > >                         reg = <0 0xe61c0000 0 0x200>;
> > >                         /* placeholder */
> >
> > (bikeshedding) Should the placeholder be at the top of the node?
> 
> I would like it more too, but in M3-W dtsi:
> 
> 		pciec0: pcie@fe000000 {
> 			reg = <0 0xfe000000 0 0x80000>;
> 			/* placeholder */
> 		};
> 
> So I kept using the same style everywhere here.
> 
> I can change it everywhere in this series to have placeholder at the
> beginning of the node definition if you agree with that!

Either way is fine by me. But if we do change it lets change it everywhere.
