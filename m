Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C733C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9A220665
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nvH1QAS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfBWPix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 10:38:53 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36157 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfBWPix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 10:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qK6v7OOPzFELEI0eXzhYvRQ75da0SAacla8L3M21RDI=; b=nvH1QAS2jtYuBckEYoojXH0X/w
        vMB3k6AVWXyqEGTgZLtLyEBFJThvL/CBnDkzvwqVy9yCONwvmE3RuzVXKcFOQf4IHMJ0cMr6tHEUI
        8H8BkDd3yt6+kuv8z4gbsA+L+iTFN9awU/J2FX4lWwplxBcDAFbh6u95/9psM78YhDf8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxZO5-0003op-Oa; Sat, 23 Feb 2019 16:38:49 +0100
Date:   Sat, 23 Feb 2019 16:38:49 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 3/7] net: phy: marvell10g: Use 2500BASEX when
 using 2.5GBASET
Message-ID: <20190223153849.GH10693@lunn.ch>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
 <20190222233744.25735-4-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222233744.25735-4-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 12:37:40AM +0100, Maxime Chevallier wrote:
> The Marvell Alaska family of PHYs supports 2.5GBaseT and 5GBaseT modes,
> as defined in the 802.3bz specification.
> 
> Upon establishing a 2.5GBASET link, the PHY will reconfigure it's MII
> interface to 2500BASEX.
> 
> At 5G, the PHY will reconfigure it's interface to 5GBASE-R, but this
> mode isn't supported by any MAC for now.
> 
> This was tested with :
>  - The 88X3310, which is on the MacchiatoBin
>  - The 88E2010, an Alaska PHY that has no fiber interfaces, and is
>    limited to 5G maximum speed.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
