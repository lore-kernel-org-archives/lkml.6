Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeEQJFC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:05:02 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:41127 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeEQJE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:04:58 -0400
Date: Thu, 17 May 2018 11:04:38 +0200
From: Simon Horman <horms@verge.net.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r8a7795: add ccree binding
Message-ID: <20180517090438.pqggltzkcdhzktsp@verge.net.au>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-4-git-send-email-gilad@benyossef.com>
 <CAMuHMdWzeNqsho1V6ezZb81T3_HcRzrtuQpmGXsjtFgt9BtZDQ@mail.gmail.com>
 <20180516074333.i2672u435ymwffk3@verge.net.au>
 <CAOtvUMfFjokOLCg6aHNQESJ_q4Jiok3izrPtae5wR+cND=XL6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMfFjokOLCg6aHNQESJ_q4Jiok3izrPtae5wR+cND=XL6g@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 11:01:57AM +0300, Gilad Ben-Yossef wrote:
> On Wed, May 16, 2018 at 10:43 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, May 15, 2018 at 04:50:44PM +0200, Geert Uytterhoeven wrote:
> >> Hi Gilad,
> >>
> >> On Tue, May 15, 2018 at 2:29 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> >> > Add bindings for CryptoCell instance in the SoC.
> >> >
> >> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> >>
> >> Thanks for your patch!
> >>
> >> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >> > @@ -528,6 +528,14 @@
> >> >                         status = "disabled";
> >> >                 };
> >> >
> >> > +               arm_cc630p: crypto@e6601000 {
> >> > +                       compatible = "arm,cryptocell-630p-ree";
> >> > +                       interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> >> > +                       #interrupt-cells = <2>;
> >>
> >> I believe the #interrupt-cells property is not needed.
> >>
> >> > +                       reg = <0x0 0xe6601000 0 0x1000>;
> >> > +                       clocks = <&cpg CPG_MOD 229>;
> >> > +               };
> >>
> >> The rest looks good, but I cannot verify the register block.
> >>
> >> > +
> >> >                 i2c3: i2c@e66d0000 {
> >> >                         #address-cells = <1>;
> >> >                         #size-cells = <0>;
> >
> > Thanks, I have applied this after dropping the #interrupt-cells property.
> 
> Thanks you!
> 
> Alas, it will not work without the clk patch (the previous one in the
> series) so they need to be
> taken or dropped together.

I think its fine if it does not yet work.
But not if its causes things that previously worked to stop working.
