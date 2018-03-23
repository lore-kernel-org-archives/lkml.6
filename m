Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeCWVdz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:33:55 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40668 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752300AbeCWVdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:33:53 -0400
Date: Fri, 23 Mar 2018 22:33:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
Message-ID: <20180323213344.GV24361@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
 <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
 <20180323212230.GA12808@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323212230.GA12808@piout.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:22:30PM +0100, Alexandre Belloni wrote:
> On 23/03/2018 at 14:17:48 -0700, Florian Fainelli wrote:
> > On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> > > +
> > > +			phy0: ethernet-phy@0 {
> > > +				reg = <0>;
> > > +			};
> > > +			phy1: ethernet-phy@1 {
> > > +				reg = <1>;
> > > +			};
> > > +			phy2: ethernet-phy@2 {
> > > +				reg = <2>;
> > > +			};
> > > +			phy3: ethernet-phy@3 {
> > > +				reg = <3>;
> > > +			};
> > 
> > These PHYs should be defined at the board DTS level.
> 
> Those are internal PHYs, present on the SoC, I doubt anyone will have
> anything different while using the same SoC.

With DSA, there is no need to list internal PHYs.

That is the trade off of having a standalone MDIO bus driver.  Maybe
add a phandle to the internal MDIO bus? The switch driver could then
follow the phandle, and direct connect the internal PHYs?

       Andrew
