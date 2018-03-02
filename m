Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbeCBWrI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:47:08 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48195 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932482AbeCBWrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:47:06 -0500
X-UUID: 2b02e25cd0fb42d4b0e603b1d9e6d4fa-20180303
Message-ID: <1520030818.8089.190.camel@mtkswgap22>
Subject: Re: [PATCH v1 13/19] arm: dts: mt7623: move node mt6323 leds to
 mt6323.dtsi
From: Sean Wang <sean.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>
Date: Sat, 3 Mar 2018 06:46:58 +0800
In-Reply-To: <20180302154050.lfxojro4woucl6lh@rob-hp-laptop>
References: <cover.1519378871.git.sean.wang@mediatek.com>
         <e8a515a1aeaf06a7162b8b0e390bee615b323303.1519378872.git.sean.wang@mediatek.com>
         <20180302154050.lfxojro4woucl6lh@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-02 at 09:40 -0600, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 06:16:33PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Since those LEDs are parts of PMIC MT6323, it is reasonable to merge
> > those LEDs node definition back into mt6323.dtsi. This way can improve
> > the reusability of those nodes among different boards with the same PMIC.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/mt6323.dtsi                 | 26 ++++++++++++++++++++++++-
> >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 28 ---------------------------
> >  2 files changed, 25 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mt6323.dtsi
> > index 7c783d6..44c5642 100644
> > --- a/arch/arm/boot/dts/mt6323.dtsi
> > +++ b/arch/arm/boot/dts/mt6323.dtsi
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Copyright (c) 2017 MediaTek Inc.
> > + * Copyright (c) 2017-2018 MediaTek Inc.
> >   * Author: John Crispin <john@phrozen.org>
> >   *	   Sean Wang <sean.wang@mediatek.com>
> >   * This program is free software; you can redistribute it and/or modify
> > @@ -237,5 +237,29 @@
> >  				regulator-enable-ramp-delay = <216>;
> >  			};
> >  		};
> > +
> > +		leds {
> > +			compatible = "mediatek,mt6323-led";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			led@0 {
> > +				reg = <0>;
> > +				label = "mt6323:isink:green";
> 
> Changing the label potentially breaks userspace. And the fact that it is 
> a green LED is very much board specific. So I think the old location was 
> correct. You could put the parent node here and leave these child nodes 
> in the board specific dts file.
> 

yes, I really made a mistake on breaking userspace with a label change.

I will keep the parent node here and then leave these child nodes into
board specific dts files. thanks for your idea!

> 
> > +				default-state = "off";
> > +			};
> > +
> > +			led@1 {
> > +				reg = <1>;
> > +				label = "mt6323:isink:red";
> > +				default-state = "off";
> > +			};
> > +
> > +			led@2 {
> > +				reg = <2>;
> > +				label = "mt6323:isink:blue";
> > +				default-state = "off";
> > +			};
> > +		};
> >  	};
> >  };
> > diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > index 75e61c4..767b225 100644
> > --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > @@ -483,34 +483,6 @@
> >  	status = "okay";
> >  };
> >  
> > -&pwrap {
> > -	mt6323 {
> > -		mt6323led: led {
> > -			compatible = "mediatek,mt6323-led";
> > -			#address-cells = <1>;
> > -			#size-cells = <0>;
> > -
> > -			led@0 {
> > -				reg = <0>;
> > -				label = "bpi-r2:isink:green";
> > -				default-state = "off";
> > -			};
> > -
> > -			led@1 {
> > -				reg = <1>;
> > -				label = "bpi-r2:isink:red";
> > -				default-state = "off";
> > -			};
> > -
> > -			led@2 {
> > -				reg = <2>;
> > -				label = "bpi-r2:isink:blue";
> > -				default-state = "off";
> > -			};
> > -		};
> > -	};
> > -};
> > -
> >  &spi0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&spi0_pins_a>;
> > -- 
> > 2.7.4
> > 
