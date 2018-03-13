Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCMIrB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:47:01 -0400
Received: from h1.radempa.de ([176.9.142.194]:54280 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbeCMIrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:47:00 -0400
From: Harald Geyer <harald@ccbib.org>
To: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        info@olimex.com
Subject: Re: [PATCH 1/5] arm64: dts: allwinner: a64: Add i2c0 pins
In-reply-to: <5b7f1a15-011f-c386-4813-f0fb8a91dfd8@arm.com>
References: <20180312161050.7647-1-harald@ccbib.org> <20180312161050.7647-2-harald@ccbib.org> <5b7f1a15-011f-c386-4813-f0fb8a91dfd8@arm.com>
Comments: In-reply-to =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
   message dated "Tue, 13 Mar 2018 01:35:39 +0000."
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-ID: <1493.1520930811.1@stardust.g4.wien.funkfeuer.at>
Content-Transfer-Encoding: 8BIT
Date: Tue, 13 Mar 2018 09:46:51 +0100
Message-Id: <E1evfa8-0000O7-0e@stardust.g4.wien.funkfeuer.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

André Przywara writes:
> On 12/03/18 16:10, Harald Geyer wrote:
> > Add the proper pin group node to reference in board files.
> > 
> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> 
> That looks correct to me, so:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> But out of curiosity, what is this used for? In patch 5/5 I see it being
> used, but without a clue for what? Shouldn't enabling an I2C node be
> accompanied by some child node, presenting the device on the bus?
> I guess this I2C is not on some kind of "header" on that laptop?

I enabled it because the ANX6345 eDP-bridge is on that bus. There is
no linux (mainline) driver for this chip at the moment, the bootloader
initializes it. However I'm using the i2c-dev driver to read (and maybe)
change some register values from user space.

i2cdetect sees devices at 0x38, 0x39 and 0x3d - all of which might
be the ANX6345. I haven't looked into this in detail.

Since you are asking: Actually the teres has a "header" with usb-otg,
spi, i2c1 and some gpios, but it isn't exposed on the exterior of the
case and nothing is connected to it. So I didn't bother with adding
nodes for this in DT. Curious what olimex are planning to do with that.

Thanks for your review,
Harald

> Cheers,
> Andre.
> 
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index 1b6dc31e7d91..64e452a758fa 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -309,6 +309,11 @@
> >  			interrupt-controller;
> >  			#interrupt-cells = <3>;
> >  
> > +			i2c0_pins: i2c0_pins {
> > +				pins = "PH0", "PH1";
> > +				function = "i2c0";
> > +			};
> > +
> >  			i2c1_pins: i2c1_pins {
> >  				pins = "PH2", "PH3";
> >  				function = "i2c1";
> > 
> 

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via CLAM to xASPBtezLNqj4cUe8MT5nZjthRSEjrRQXN
or via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
