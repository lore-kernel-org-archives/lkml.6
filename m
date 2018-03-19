Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeCSIp1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:45:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49351 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932143AbeCSIpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:45:25 -0400
Date: Mon, 19 Mar 2018 09:45:23 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, gregory.clement@bootlin.com, andrew@lunn.ch,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 03/10] net: mvpp2: phylink support
Message-ID: <20180319084523.GE4519@kwain>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-4-antoine.tenart@bootlin.com>
 <20180316160322.GR9418@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316160322.GR9418@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Fri, Mar 16, 2018 at 04:03:22PM +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 16, 2018 at 11:33:44AM +0100, Antoine Tenart wrote:
> > +static void mvpp2_phylink_validate(struct net_device *dev,
> > +				   unsigned long *supported,
> > +				   struct phylink_link_state *state)
> > +{
> > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
> > +
> > +	phylink_set(mask, Autoneg);
> > +	phylink_set_port_modes(mask);
> > +	phylink_set(mask, Pause);
> > +	phylink_set(mask, Asym_Pause);
> > +
> > +	phylink_set(mask, 10baseT_Half);
> > +	phylink_set(mask, 10baseT_Full);
> > +	phylink_set(mask, 100baseT_Half);
> > +	phylink_set(mask, 100baseT_Full);
> > +	phylink_set(mask, 1000baseT_Full);
> > +	phylink_set(mask, 1000baseX_Full);
> 
> AFAICS, the driver (before these patches) does not support 1000baseX
> as it always clears the MVPP2_GMAC_PORT_TYPE_MASK bit, so adding this
> mode should be part of the patch adding 1000baseX support.

Right, I'll remove 1000baseX_Full from this patch and only add it in the
1000BaseX support patch.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
