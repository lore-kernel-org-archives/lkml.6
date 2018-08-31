Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449F6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D6C20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D6C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeHaRFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:05:36 -0400
Received: from hermes.aosc.io ([199.195.250.187]:35894 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbeHaRFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:05:36 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 9482A42097;
        Fri, 31 Aug 2018 12:58:04 +0000 (UTC)
Message-ID: <f742ef4cd28c4dd3be6b0c64fcb8b8a33635ec8e.camel@aosc.io>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Chen-Yu Tsai <wens@csie.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 31 Aug 2018 20:57:56 +0800
In-Reply-To: <CAGb2v65H_Aog294NYAmcTGARGiOiyCDy=MT9g8ed=Cxr8Bm3Qg@mail.gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
         <20180830190120.722-10-clabbe.montjoie@gmail.com>
         <20180831073500.zubqpvar4yhjqrge@flea> <20180831075631.GB16301@Red>
         <CAGb2v65dWmFxacx16taTdDf0WO4vCJfJLrf=7Vh6RtJEjHdH5A@mail.gmail.com>
         <20180831092934.GC16301@Red>
         <CAGb2v65H_Aog294NYAmcTGARGiOiyCDy=MT9g8ed=Cxr8Bm3Qg@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-08-31五的 19:10 +0800，Chen-Yu Tsai写道：
> On Fri, Aug 31, 2018 at 5:29 PM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> > 
> > On Fri, Aug 31, 2018 at 03:58:34PM +0800, Chen-Yu Tsai wrote:
> > > On Fri, Aug 31, 2018 at 3:56 PM Corentin Labbe
> > > <clabbe.montjoie@gmail.com> wrote:
> > > > 
> > > > On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > > > > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe
> > > > > wrote:
> > > > > > R40 have a sata controller which is the same as A20.
> > > > > > This patch adds a DT node for it.
> > > > > > 
> > > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23
> > > > > > +++++++++++++++++++++++
> > > > > >  1 file changed, 23 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > index 852c2ccc3268..d6b5820da850 100644
> > > > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > @@ -550,6 +550,29 @@
> > > > > >                     #size-cells = <0>;
> > > > > >             };
> > > > > > 
> > > > > > +           ahci: sata@1c18000 {
> > > > > > +                   compatible = "allwinner,sun8i-r40-
> > > > > > ahci";
> > > > > > +                   reg = <0x01c18000 0x1000>;
> > > > > > +                   interrupts = <GIC_SPI 56
> > > > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > > > +                   clocks = <&ccu CLK_BUS_SATA>, <&ccu
> > > > > > CLK_SATA>;
> > > > > > +                   resets = <&ccu RST_BUS_SATA>;
> > > > > > +                   resets-name = "ahci";
> > > > > > +                   #address-cells = <1>;
> > > > > > +                   #size-cells = <0>;
> > > > > > +                   status = "disabled";
> > > > > > +
> > > > > > +                   sata_port: sata-port@0 {
> > > > > > +                           reg = <0>;
> > > > > > +                           phys = <&sata_phy>;
> > > > > > +                   };
> > > > > > +           };
> > > > > > +
> > > > > > +           sata_phy: sata-phy@1c180c0  {
> > > > > > +                   compatible = "allwinner,sun8i-r40-sata-
> > > > > > phy";
> > > > > > +                   reg = <0x1c180c0 0x200>;
> > > > > 
> > > > > Overlapping devices in the DTS is not ok.
> > > > > 
> > > > 
> > > > I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000 
> > > > phy@e900a0)
> > > > But since it is not a good justification, it seems that regmap
> > > > is my only solution ?
> > > 
> > > Since you are effectively splitting one device node into two, you
> > > should
> > > adjust the original (ahci) device nodes register range.
> > > 
> > 
> > I cannot do that if I remove patch 13, iow If I keep phy init code
> > in both place as you requested.
> 
> Then you need to split the phy handling between a10 and r40. A10
> doesn't
> need phy-supply at the moment anyway. And migrating A10 to newer
> binding
> is only causing you problems anyway. Just drop that part, and handle
> the
> R40.

From the hardware perspective, they're the same. The A10/A20 has also
two dedicated VDD pins for SATA, although on boards they're usually
always on.

> 
> ChenYu
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

