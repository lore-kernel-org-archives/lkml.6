Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeENIRB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:17:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60961 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbeENIMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:12:09 -0400
Date: Mon, 14 May 2018 10:11:51 +0200
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next] net: phy: sfp: handle cases where neither
 BR,min nor BR,max is given
Message-ID: <20180514081151.GD24660@kwain>
References: <20180504152103.18152-1-antoine.tenart@bootlin.com>
 <20180508123026.GJ16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508123026.GJ16141@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Tue, May 08, 2018 at 01:30:26PM +0100, Russell King - ARM Linux wrote:
> 
> The electronic engineer in me says that using zero isn't really valid
> because there are coupling capacitors in the SFP module that block DC.
> These blocking capacitors are required by the SFP+ specs to have a high
> pass pole of between 20kHz and 100kHz - in other words, frequencies
> below this are attenuated by the coupling capacitors.  The relationship
> between this and the bit rate will be a function of the encoding, so we
> can't come to a definitive figure without some math (and I want to be
> lazy about that!)
> 
> Practically, we're talking about SerDes Ethernet, where the bit rate is
> no lower than 100Mbps [*], which will always have a frequency well above
> this cut-off.  So, I don't have any problem with your approach to
> setting the minimum to zero.  Therefore,
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks for looking into it!
Antoine


-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
