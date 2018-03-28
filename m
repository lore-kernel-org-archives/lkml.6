Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeC1WCv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:02:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45753 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeC1WCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:02:50 -0400
Date: Thu, 29 Mar 2018 00:02:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH net-next 2/2] sfp/phylink: move module EEPROM ethtool
 access into netdev core ethtool
Message-ID: <20180328220244.GA23595@lunn.ch>
References: <20180328190339.31433-1-f.fainelli@gmail.com>
 <20180328190339.31433-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328190339.31433-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 12:03:39PM -0700, Florian Fainelli wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Provide a pointer to the SFP bus in struct net_device, so that the
> ethtool module EEPROM methods can access the SFP directly, rather
> than needing every user to provide a hook for it.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 18 ------------------
>  drivers/net/phy/phylink.c             | 28 ----------------------------
>  drivers/net/phy/sfp-bus.c             |  6 ++----
>  include/linux/netdevice.h             |  3 +++
>  include/linux/phylink.h               |  3 ---
>  net/core/ethtool.c                    |  7 +++++++
>  6 files changed, 12 insertions(+), 53 deletions(-)

The diffstats look good, DSA and all other uses of phylink will make a
similar saving in code. The new member in the netdev structure is well
away from members which are commented as being cache line sensitive.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
