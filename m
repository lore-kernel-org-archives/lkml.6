Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301EAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF871222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M6Oyvino"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbfBLVNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:13:25 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49032 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfBLVNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=P6bPAQSDN9aNwTg20je9DY8n6icorEV+5+8z6SGXS+Y=; b=M6OyvinoenjyMKrQ+2Svs3i8hr
        q9QwX8xL1rECYfF7hI4FoM8qg4o5ZzvzbVa5RnI25TXL80Oj9OIFFn6GLIKc8rHRPoARyfnDNLpCF
        nQfk82hABwZJ6YRRRutlmd8BnLuyGaR8bUqLB8HEk0M1TnPLFVAvxmpDbh3cNEPmDVWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gtfMn-0007kp-Tz; Tue, 12 Feb 2019 22:13:21 +0100
Date:   Tue, 12 Feb 2019 22:13:21 +0100
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
Subject: Re: [PATCH net-next 4/4] net: phy: Add generic support for 2.5GBaseT
 and 5GBaseT
Message-ID: <20190212211321.GC27170@lunn.ch>
References: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
 <20190211142529.22885-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211142529.22885-5-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:25:29PM +0100, Maxime Chevallier wrote:
> The 802.3bz specification, based on previous by the NBASET alliance,
> defines the 2.5GBaseT and 5GBaseT link modes for ethernet traffic on
> cat5e, cat6 and cat7 cables.
> 
> These mode integrate with the already defined C45 MDIO PMA/PMD registers
> set that added 10G support, by defining some previously reserved bits,
> and adding a new register (2.5G/5G Extended abilities).
> 
> This commit adds the required definitions in include/uapi/linux/mdio.h
> to support these modes, and detect when a link-partner advertises them.
> 
> It also adds support for these mode in the generic C45 PHY
> infrastructure.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
