Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEQNN5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:13:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54030 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeEQNNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:13:55 -0400
Date: Thu, 17 May 2018 15:13:53 +0200
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
Message-ID: <20180517131353.GN32746@kwain>
References: <20180517082907.14420-1-antoine.tenart@bootlin.com>
 <20180517082907.14420-2-antoine.tenart@bootlin.com>
 <20180517124127.GG8547@lunn.ch>
 <20180517125648.GM32746@kwain>
 <20180517130406.GH8547@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180517130406.GH8547@lunn.ch>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 03:04:06PM +0200, Andrew Lunn wrote:
> 
> I was thinking about how it reads the bit rate from the EEPROM. From
> that it determines what mode the MAC could use, 1000-Base-X,
> 2500-Base-X, etc. Can you still configure this correctly via ethtool,
> if you don't have the bitrate information?

I see. That's a very good question. When testing this, I used SFP cages
which were not wired *at all*. So it worked because the SFP module
injection never was seen by the kernel, which was then not calling
phylink_sfp_module_insert() and thus not calling sfp_parse_support().

But in cases where the module insertion can be detected, as you pointed
out, I'm not so sure it can work then. I'll wait for other answers, but
we may want to fail when probing such modules as you suggested.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
