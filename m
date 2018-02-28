Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeB1NOF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:14:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60763 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeB1NOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:14:04 -0500
Date: Wed, 28 Feb 2018 14:14:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] MIPS: mscc: add ocelot dtsi
Message-ID: <20180228131402.GL1479@piout.net>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-6-alexandre.belloni@free-electrons.com>
 <CAOiHx=n5bekhgaA_-teYZzJQCErfb2Vg1X9fTaq073B=kpWnTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=n5bekhgaA_-teYZzJQCErfb2Vg1X9fTaq073B=kpWnTA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2018 at 22:01:37 +0100, Jonas Gorski wrote:
> On 16 January 2018 at 11:12, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Add a device tree include file for the Microsemi Ocelot SoC.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  arch/mips/boot/dts/Makefile         |   1 +
> >  arch/mips/boot/dts/mscc/Makefile    |   4 ++
> >  arch/mips/boot/dts/mscc/ocelot.dtsi | 110 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 115 insertions(+)
> >  create mode 100644 arch/mips/boot/dts/mscc/Makefile
> >  create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
> >
> > diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> > index e2c6f131c8eb..1e79cab8e269 100644
> > --- a/arch/mips/boot/dts/Makefile
> > +++ b/arch/mips/boot/dts/Makefile
> > @@ -4,6 +4,7 @@ subdir-y        += cavium-octeon
> >  subdir-y       += img
> >  subdir-y       += ingenic
> >  subdir-y       += lantiq
> > +subdir-y       += mscc
> >  subdir-y       += mti
> >  subdir-y       += netlogic
> >  subdir-y       += ni
> > diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
> > new file mode 100644
> > index 000000000000..f0a155a74e02
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/mscc/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> > +
> > +# Force kbuild to make empty built-in.o if necessary
> > +obj-                           += dummy.o
> > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > new file mode 100644
> > index 000000000000..b2f936e1fbb9
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > @@ -0,0 +1,110 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/* Copyright (c) 2017 Microsemi Corporation */
> > +
> > +/ {
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +       compatible = "mscc,ocelot";
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               mips-hpt-frequency = <250000000>;
> > +
> > +               cpu@0 {
> > +                       compatible = "mscc,ocelot";
> 
> You are using the same compatible string for the whole chip as well as
> the cpu core of it, this doesn't seem right.
> 
> Also is this really a custom cpu core? Your product brief suggests
> this is a "normal" 24KEc MIPS CPU, at least for ocelot-10 (VSC7514).
> So something like "mips,mips24KEc" might be more appropriate here.
> 

Indeed, that is something I forgot to change before sending.

> 
> Regards
> Jonas

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
