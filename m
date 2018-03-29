Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeC2OOW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:14:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42024 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeC2OOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:14:20 -0400
Date: Thu, 29 Mar 2018 16:14:08 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 3/8] net: mscc: Add MDIO driver
Message-ID: <20180329141408.GC12066@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-4-alexandre.belloni@bootlin.com>
 <9547b11d-147d-5029-0abe-8bf0f705c959@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9547b11d-147d-5029-0abe-8bf0f705c959@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2018 at 14:51:19 -0700, Florian Fainelli wrote:
> > +	writel(MSCC_MIIM_CMD_VLD | (mii_id << MSCC_MIIM_CMD_PHYAD_SHIFT) |
> > +	       (regnum << MSCC_MIIM_CMD_REGAD_SHIFT) | MSCC_MIIM_CMD_OPR_READ,
> > +	       miim->regs + MSCC_MIIM_REG_CMD);
> > +
> > +	ret = mscc_miim_wait_ready(bus);
> > +	if (ret)
> > +		goto out;
> 
> Your example had an interrupt specified, can't you use that instead of
> polling?
> 

the interrupt doesn't handle that. It is used to detect when a PHY
register has changed once the MIIM controller is configured to poll the
phys. At some point, this could be used to replace the PHY interrupts
but it doesn't correspond to the linux model so I didn't investigate too
much.

>  > +	for (i = 0; i < PHY_MAX_ADDR; i++) {
> > +		if (mscc_miim_read(bus, i, MII_PHYSID1) < 0)
> > +			bus->phy_mask |= BIT(i);
> > +	}
> 
> What is this used for? You have an OF MDIO bus which would create a
> phy_device for each node specified, is this a similar workaround to what
> drivers/net/phy/mdio-bcm-unimac.c has to do? If so, please document it
> as such.
> 

I replied to Andrew who had the same question.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
