Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeEDROl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:14:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49655 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751551AbeEDROj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:14:39 -0400
Date: Fri, 4 May 2018 19:14:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, linux@armlinux.org.uk, gregory.clement@bootlin.com,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 03/13] net: phy: sfp: warn the user when no
 tx_disable pin is available
Message-ID: <20180504171425.GA17233@lunn.ch>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-4-antoine.tenart@bootlin.com>
 <ed267042-1a61-7fcc-13ee-3cad2c05c658@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed267042-1a61-7fcc-13ee-3cad2c05c658@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 10:07:53AM -0700, Florian Fainelli wrote:
> On 05/04/2018 06:56 AM, Antoine Tenart wrote:
> > In case no Tx disable pin is available the SFP modules will always be
> > emitting. This could be an issue when using modules using laser as their
> > light source as we would have no way to disable it when the fiber is
> > removed. This patch adds a warning when registering an SFP cage which do
> > not have its tx_disable pin wired or available.
> 
> Is this something that was done in a possibly earlier revision of a
> given board design and which was finally fixed? Nothing wrong with the
> patch, but this seems like a pretty serious board design mistake, that
> needs to be addressed.

Hi Florian

Zii Devel B is like this. Only the "Signal Detect" pin is wired to a
GPIO.

	Andrew
