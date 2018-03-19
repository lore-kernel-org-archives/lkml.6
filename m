Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755560AbeCSN0i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:26:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59419 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753151AbeCSN0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:26:35 -0400
Date: Mon, 19 Mar 2018 14:26:33 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, kishon@ti.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
Message-ID: <20180319132633.GL4519@kwain>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain>
 <20180319125953.GD19795@lunn.ch>
 <20180319131009.GJ4519@kwain>
 <20180319131804.GD2743@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319131804.GD2743@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Mon, Mar 19, 2018 at 01:18:05PM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 19, 2018 at 02:10:09PM +0100, Antoine Tenart wrote:
> > 
> > On 7k/8k you have the following scheme for 10G only interfaces:
> > 
> >    MAC -- Comphy -- PHY -- SFP cage -- ...
> > 
> > Or
> > 
> >    MAC -- Comphy -- SFP cage -- ...
> > 
> > The comphy provides serdes lanes, and can be configured in various
> > modes (SGMII, 2500SGMII, 10GKR...).
> 
> Right - the correct mode is dependent on the SFP module plugged into
> the cage.  Trying to describe this by ignoring the SFP cage isn't
> going to work out well for end-user functionality, though is fine if
> you're just hacking a configuration to test (which would not be
> suitable for mainline kernels!)
> 
> As I've recently replied to Yan, this is a configuration I haven't
> tested yet, and it's entirely possible that phylink may need some
> tweaks for it.
> 
> What you have is a very similar setup to what is on Clearfog with
> its SFP cage, where the SFP cage is connected directly to the
> Armada 388.  That only has to deal with 2500base-X / 1000base-X /
> SGMII and not 10G.
> 
> What I want is to avoid hacks as much as possible here - if there is
> a short-coming with SFP/phylink here, we need to address that
> properly.

OK. So the proper solution would be to properly describe the SFP cages
in the device tree (and check if phylink deals with it nicely).

I'll update the patches in this way.

Thanks for the feedback,
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
