Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEQNEM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:04:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34515 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeEQNEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:04:10 -0400
Date: Thu, 17 May 2018 15:04:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 1/2] net: phy: sfp: make the i2c-bus property
 really optional
Message-ID: <20180517130406.GH8547@lunn.ch>
References: <20180517082907.14420-1-antoine.tenart@bootlin.com>
 <20180517082907.14420-2-antoine.tenart@bootlin.com>
 <20180517124127.GG8547@lunn.ch>
 <20180517125648.GM32746@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517125648.GM32746@kwain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 02:56:48PM +0200, Antoine Tenart wrote:
> Hi Andrew,
> 
> On Thu, May 17, 2018 at 02:41:28PM +0200, Andrew Lunn wrote:
> > On Thu, May 17, 2018 at 10:29:06AM +0200, Antoine Tenart wrote:
> > > The SFF,SFP documentation is clear about making all the DT properties,
> > > with the exception of the compatible, optional. In practice this is not
> > > the case and without an i2c-bus property provided the SFP code will
> > > throw NULL pointer exceptions.
> > > 
> > > This patch is an attempt to fix this.
> > 
> > How usable is an SFF/SFP module without access to the i2c EEPROM? I
> > guess this comes down to link speed. Can it be manually configured?
> >
> > I'm just wondering if we want to make this mandatory? Fail the probe
> > if it is not listed?
> 
> Yes, the other option would be to fail when probing a cage missing the
> i2c description. I'd say a passive module can work without the i2c
> EEPROM accessible as it does not need to be configured. I don't know
> what would happen with active ones.

Hi Antoine

I was thinking about how it reads the bit rate from the EEPROM. From
that it determines what mode the MAC could use, 1000-Base-X,
2500-Base-X, etc. Can you still configure this correctly via ethtool,
if you don't have the bitrate information?

   Andrew
