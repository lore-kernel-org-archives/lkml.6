Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeDQTFM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:05:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59823 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeDQTFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:05:10 -0400
Date: Tue, 17 Apr 2018 20:27:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: vicentiu.galanopulo@nxp.com, robh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, marcel@holtmann.org, devicetree@vger.kernel.org,
        alexandru.marginean@nxp.com, madalin.bucur@nxp.com
Subject: Re: [PATCH net-next 1/3] net: phy: Add binding for vendor specific
 C45 MDIO address space
Message-ID: <20180417182741.GC6688@lunn.ch>
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
 <20180417090233.21548-2-vicentiu.galanopulo@nxp.com>
 <bc00cc86-2293-0fd2-4e98-c516f59f97ce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc00cc86-2293-0fd2-4e98-c516f59f97ce@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 11:18:20AM -0700, Florian Fainelli wrote:
> On 04/17/2018 02:02 AM, Vicentiu Galanopulo wrote:
> > The extra property enables the discovery on the MDIO bus
> > of the PHYs which have a vendor specific address space
> > for accessing the C45 MDIO registers.
> > 
> > Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/phy.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
> > index d2169a5..82692e2 100644
> > --- a/Documentation/devicetree/bindings/net/phy.txt
> > +++ b/Documentation/devicetree/bindings/net/phy.txt
> > @@ -61,6 +61,11 @@ Optional Properties:
> >  - reset-deassert-us: Delay after the reset was deasserted in microseconds.
> >    If this property is missing the delay will be skipped.
> >  
> > +- dev-addr: If set, it indicates the device address of the PHY to be used
> > +  when accessing the C45 PHY registers over MDIO. It is used for vendor specific
> > +  register space addresses that do no conform to standard address for the MDIO
> > +  registers (e.g. MMD30)
> 
> Rob made that comment earlier, and I have to ask again now, why don't we
> have the Clause 45 PHY binding be modified such that you have a reg
> property that has #address-size = 2? This should be entirely backwards
> compatible, but it would allow you to specify that device address in a
> more traditional way.

Hi Florian

I think we might get into trouble when we have both c22 and c45 on the
same bus. Two different reg formats. I would have to try it and see to
be sure.

     Andrew
