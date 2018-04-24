Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933445AbeDXN6w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:58:52 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46496 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933396AbeDXNOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:14:46 -0400
X-Google-Smtp-Source: AIpwx4+4xgaf2aBlUbuLexNjZAuO165w6u3zy5cY7ylzn4jdH81bTObIBKA0lWd+YLSB0kxY3X+zVA==
Date: Tue, 24 Apr 2018 08:14:44 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, vicentiu.galanopulo@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, marcel@holtmann.org,
        devicetree@vger.kernel.org, alexandru.marginean@nxp.com,
        madalin.bucur@nxp.com
Subject: Re: [PATCH net-next 1/3] net: phy: Add binding for vendor specific
 C45 MDIO address space
Message-ID: <20180424131444.qqcizi2kkz6t4rtz@rob-hp-laptop>
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
 <20180417090233.21548-2-vicentiu.galanopulo@nxp.com>
 <bc00cc86-2293-0fd2-4e98-c516f59f97ce@gmail.com>
 <20180417182741.GC6688@lunn.ch>
 <3966b12c-5764-d19c-a14d-4618bf039ee5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3966b12c-5764-d19c-a14d-4618bf039ee5@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 11:29:27AM -0700, Florian Fainelli wrote:
> On 04/17/2018 11:27 AM, Andrew Lunn wrote:
> > On Tue, Apr 17, 2018 at 11:18:20AM -0700, Florian Fainelli wrote:
> >> On 04/17/2018 02:02 AM, Vicentiu Galanopulo wrote:
> >>> The extra property enables the discovery on the MDIO bus
> >>> of the PHYs which have a vendor specific address space
> >>> for accessing the C45 MDIO registers.
> >>>
> >>> Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/net/phy.txt | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
> >>> index d2169a5..82692e2 100644
> >>> --- a/Documentation/devicetree/bindings/net/phy.txt
> >>> +++ b/Documentation/devicetree/bindings/net/phy.txt
> >>> @@ -61,6 +61,11 @@ Optional Properties:
> >>>  - reset-deassert-us: Delay after the reset was deasserted in microseconds.
> >>>    If this property is missing the delay will be skipped.
> >>>  
> >>> +- dev-addr: If set, it indicates the device address of the PHY to be used
> >>> +  when accessing the C45 PHY registers over MDIO. It is used for vendor specific
> >>> +  register space addresses that do no conform to standard address for the MDIO
> >>> +  registers (e.g. MMD30)
> >>
> >> Rob made that comment earlier, and I have to ask again now, why don't we
> >> have the Clause 45 PHY binding be modified such that you have a reg
> >> property that has #address-size = 2? This should be entirely backwards
> >> compatible, but it would allow you to specify that device address in a
> >> more traditional way.

#address-size is not a valid property. I think #address-cells is what 
was meant here. However, the statement is still not right either. The 
number of cells is how many cells to encode an address, not how many 
addresses you have.

> > 
> > Hi Florian
> > 
> > I think we might get into trouble when we have both c22 and c45 on the
> > same bus. Two different reg formats. I would have to try it and see to
> > be sure.
>
> Hum indeed, we would no longer be able to mix and match on the same MDIO
> bus, unless we give C22 PHYs a "fake" second cell. Disregard that idea
> then, and let's stick with 'dev-addr'.

The format would be the same (1 cell for an address), you'd just have 1 
address for c22 and 2 addresses for c45 devices which is perfectly fine.

However, as I mentioned on the previous version, I'm okay with dev-addr 
given it seems to be a quirk that isn't always needed.

Rob
