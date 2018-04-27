Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757579AbeD0HlC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:41:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50030 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757444AbeD0HlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:41:01 -0400
Date: Fri, 27 Apr 2018 09:40:58 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] MIPS: mscc: Add switch to ocelot
Message-ID: <20180427074058.GW4813@piout.net>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-6-alexandre.belloni@bootlin.com>
 <20180426205113.GD23481@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426205113.GD23481@lunn.ch>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2018 22:51:13+0200, Andrew Lunn wrote:
> > +
> > +		mdio0: mdio@107009c {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			compatible = "mscc,ocelot-miim";
> > +			reg = <0x107009c 0x36>, <0x10700f0 0x8>;
> > +			interrupts = <14>;
> > +			status = "disabled";
> > +
> > +			phy0: ethernet-phy@0 {
> > +				reg = <0>;
> > +			};
> > +			phy1: ethernet-phy@1 {
> > +				reg = <1>;
> > +			};
> > +			phy2: ethernet-phy@2 {
> > +				reg = <2>;
> > +			};
> > +			phy3: ethernet-phy@3 {
> > +				reg = <3>;
> > +			};
> 
> Hi Alexandre
> 
> These are internal PHYs? Is there an option to use external PHYs for
> the ports which have internal PHYs?
> 
> I'm just wondering if they should be linked together by default. Or a
> comment added to the commit message about why they are not linked
> together here.
> 

They are dual media ports so they are not necessarily using the
integrated PHY but can use SerDEs1G lanes.

I'll add that to the commit message.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
