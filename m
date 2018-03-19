Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755444AbeCSMwd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:52:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57984 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754892AbeCSMw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:52:29 -0400
Date: Mon, 19 Mar 2018 13:52:27 +0100
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
Subject: Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
Message-ID: <20180319125227.GI4519@kwain>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319111205.GB2743@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Mon, Mar 19, 2018 at 11:12:05AM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 19, 2018 at 09:52:52AM +0100, Antoine Tenart wrote:
> > 
> > Anyway, the reason to use in-band negotiation was also to avoid using
> > fixed-link. It would work but always report the link is up, which for
> > the user isn't a great experience as we have a way to detect this.
> > 
> > What would you suggest to achieve this in a reasonable way?
> 
> The intention of this test in phylink_of_phy_connect() is to avoid
> failing when there is no requirement for a PHY to be present (such as
> a fixed link, or an 802.3z link.)  However, with 10G PHYs such as the
> 3310, we need the PHY so we can read the speed from it, and so know
> whether to downgrade the MAC to SGMII mode, or having downgraded the
> MAC, upgrade it back to 10G mode when the PHY switches to 10G.
> 
> I'm guessing that you're wanting this for the DB boards, but I don't
> see why.  Do they not have PHYs?

You guessed right, that's exactly my use case. The DB boards (7k and 8k)
have 10G interfaces without PHYs. I could describe them as fixed-link
(it works), but it would be better not to require a PHY in
phylink_of_phy_connect() for such interfaces.

That's why I used in-band AN, which is wrong, but we still probably
need to add a check to allow such setups. I'm all ears for suggestions
as I do not have the full picture of all the supported modes and their
requirements.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
