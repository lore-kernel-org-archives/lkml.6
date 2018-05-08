Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754818AbeEHLxN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:53:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51696 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754341AbeEHLxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:53:11 -0400
Date: Tue, 8 May 2018 12:52:47 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, kishon@ti.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 02/13] net: phy: sfp: handle non-wired SFP
 connectors
Message-ID: <20180508115247.GF16141@n2100.armlinux.org.uk>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-3-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504135643.23466-3-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 03:56:32PM +0200, Antoine Tenart wrote:
> SFP connectors can be solder on a board without having any of their pins
> (LOS, i2c...) wired. In such cases the SFP link state cannot be guessed,
> and the overall link status reporting is left to other layers.
> 
> In order to achieve this, a new SFP_DEV status is added, named UNKNOWN.
> This mode is set when it is not possible for the SFP code to get the
> link status and as a result the link status is reported to be always UP
> from the SFP point of view.

This looks weird to me.  SFP_DEV_* states track the netdevice up/down
state and have little to do with whether LOS or MODDEF0 are implemented.

I think it would be better to have a new SFP_MOD_* and to force
sm_mod_state to that in this circumstance.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
