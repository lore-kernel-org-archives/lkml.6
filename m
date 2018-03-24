Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeCXOs6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 10:48:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41057 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeCXOs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 10:48:57 -0400
Date: Sat, 24 Mar 2018 15:48:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
Message-ID: <20180324144850.GB31941@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
 <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
 <20180323212230.GA12808@piout.net>
 <20180323213344.GV24361@lunn.ch>
 <dcac43b7-2eb7-d409-a77c-4f671a8cfc3d@gmail.com>
 <20180323220657.GY24361@lunn.ch>
 <171fb3db-70f4-4818-9390-8164fab5adca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171fb3db-70f4-4818-9390-8164fab5adca@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 03:11:23PM -0700, Florian Fainelli wrote:
> On 03/23/2018 03:06 PM, Andrew Lunn wrote:
> >>> That is the trade off of having a standalone MDIO bus driver.  Maybe
> >>> add a phandle to the internal MDIO bus? The switch driver could then
> >>> follow the phandle, and direct connect the internal PHYs?
> >>
> >> This is more or less what patch 7 does, right?
> > 
> > Patch 7 does it in DT. I'm suggesting it could be done in C. It is
> > hard wired, so there is no need to describe it in DT. Use the phandle
> > to get the mdio bus, mdiobus_get_phy(, port) to get the phydev and
> > then use phy_connect().
> 
> That does not sound like a great idea. And to go back to your example
> about DSA, it is partially true, you will see some switch bindings
> defining the internal PHYs (e.g: qca8k), and most not doing it (b53,
> mv88e6xxx, etc.). In either case, this resolves to the same thing
> though. Being able to parse a phy-handle property is a lot more
> flexible, and if it does matter that the PHY truly is internal, then the
> 'phy-mode' property can help reflect that.

Hi Florian

With DSA, you can always provide a phy-handle. It is only when there
is nothing specified that the fallback case is used to map internal
PHYs to ports.

Putting internal PHYs in DT is fine, but it is a nice simplification
if it is not needed.

   Andrew
