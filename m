Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeEQM4w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:56:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53203 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeEQM4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:56:50 -0400
Date: Thu, 17 May 2018 14:56:48 +0200
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 1/2] net: phy: sfp: make the i2c-bus property
 really optional
Message-ID: <20180517125648.GM32746@kwain>
References: <20180517082907.14420-1-antoine.tenart@bootlin.com>
 <20180517082907.14420-2-antoine.tenart@bootlin.com>
 <20180517124127.GG8547@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180517124127.GG8547@lunn.ch>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, May 17, 2018 at 02:41:28PM +0200, Andrew Lunn wrote:
> On Thu, May 17, 2018 at 10:29:06AM +0200, Antoine Tenart wrote:
> > The SFF,SFP documentation is clear about making all the DT properties,
> > with the exception of the compatible, optional. In practice this is not
> > the case and without an i2c-bus property provided the SFP code will
> > throw NULL pointer exceptions.
> > 
> > This patch is an attempt to fix this.
> 
> How usable is an SFF/SFP module without access to the i2c EEPROM? I
> guess this comes down to link speed. Can it be manually configured?
>
> I'm just wondering if we want to make this mandatory? Fail the probe
> if it is not listed?

Yes, the other option would be to fail when probing a cage missing the
i2c description. I'd say a passive module can work without the i2c
EEPROM accessible as it does not need to be configured. I don't know
what would happen with active ones.

So the question is, do we want to enable partially working SFP cages
(ie. probably working with only a subset of SFP modules)?

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
