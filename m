Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbeCPQDu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:03:50 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51578 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933119AbeCPQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:03:46 -0400
Date: Fri, 16 Mar 2018 16:03:22 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, kishon@ti.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 03/10] net: mvpp2: phylink support
Message-ID: <20180316160322.GR9418@n2100.armlinux.org.uk>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-4-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316103351.16616-4-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 11:33:44AM +0100, Antoine Tenart wrote:
> +static void mvpp2_phylink_validate(struct net_device *dev,
> +				   unsigned long *supported,
> +				   struct phylink_link_state *state)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
> +
> +	phylink_set(mask, Autoneg);
> +	phylink_set_port_modes(mask);
> +	phylink_set(mask, Pause);
> +	phylink_set(mask, Asym_Pause);
> +
> +	phylink_set(mask, 10baseT_Half);
> +	phylink_set(mask, 10baseT_Full);
> +	phylink_set(mask, 100baseT_Half);
> +	phylink_set(mask, 100baseT_Full);
> +	phylink_set(mask, 1000baseT_Full);
> +	phylink_set(mask, 1000baseX_Full);

AFAICS, the driver (before these patches) does not support 1000baseX
as it always clears the MVPP2_GMAC_PORT_TYPE_MASK bit, so adding this
mode should be part of the patch adding 1000baseX support.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
