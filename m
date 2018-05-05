Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeEEUxN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 16:53:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50380 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeEEUxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 16:53:11 -0400
Date: Sat, 5 May 2018 22:52:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: mw@semihalf.com, ymarkman@marvell.com, jason@lakedaemon.net,
        Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        gregory.clement@bootlin.com, linux@armlinux.org.uk, kishon@ti.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        stefanc@marvell.com, maxime.chevallier@bootlin.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH net-next v2 03/13] net: phy: sfp: warn the user when no
 tx_disable pin is available
Message-ID: <20180505205242.GA2876@lunn.ch>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-4-antoine.tenart@bootlin.com>
 <ed267042-1a61-7fcc-13ee-3cad2c05c658@gmail.com>
 <20180504171425.GA17233@lunn.ch>
 <44545AF4-64E3-4772-B5BA-43CCF2321025@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44545AF4-64E3-4772-B5BA-43CCF2321025@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 01:38:31PM -0700, Florian Fainelli wrote:
> On May 4, 2018 10:14:25 AM PDT, Andrew Lunn <andrew@lunn.ch> wrote:
> >On Fri, May 04, 2018 at 10:07:53AM -0700, Florian Fainelli wrote:
> >> On 05/04/2018 06:56 AM, Antoine Tenart wrote:
> >> > In case no Tx disable pin is available the SFP modules will always
> >be
> >> > emitting. This could be an issue when using modules using laser as
> >their
> >> > light source as we would have no way to disable it when the fiber
> >is
> >> > removed. This patch adds a warning when registering an SFP cage
> >which do
> >> > not have its tx_disable pin wired or available.
> >> 
> >> Is this something that was done in a possibly earlier revision of a
> >> given board design and which was finally fixed? Nothing wrong with
> >the
> >> patch, but this seems like a pretty serious board design mistake,
> >that
> >> needs to be addressed.
> >
> >Hi Florian
> >
> >Zii Devel B is like this. Only the "Signal Detect" pin is wired to a
> >GPIO.
> 

> Good point, indeed. BTW what do you think about exposing the SFF's
> EEPROM and diagnostics through the standard ethtool operations even
> if we have to keep the description of the SFF as a fixed link in
> Device Tree because of the unfortunate wiring?

I believe in Antoine case, all the control plane is broken. He cannot
read the EEPROM, nor any of the modules pins via GPIOs.

For Zii Devel B, the EEPROM is accessible, and so is the SD pin. What
is missing is transmit disable. So i would expose it as an SFF module.

   Andrew
