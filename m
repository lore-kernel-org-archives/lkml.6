Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016D7C26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27E42085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f0/sDciu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfATTKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 14:10:45 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49475 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfATTKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 14:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=sCZd3JDj+IRIBM6px7DZ1fcglyVLb6KVNDu+/y1vdmk=;
        b=f0/sDciudAAjM+x7vN6xgucV36a2FWyLnf1eKJNLGrIpbl78vLwHLRaD9dG1gpcJU9H5/ttZkSkAysAxB0hfaGzBkTe6DGMBjNZpNwSeayVCgyrKoJ5ggsfZFOIte8CPeNqkTdAkO1jXrBkG2ZLcyiGeDFUuz/znFN8vjF8ZMqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1glIUT-0005Ky-Fk; Sun, 20 Jan 2019 20:10:41 +0100
Date:   Sun, 20 Jan 2019 20:10:41 +0100
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
Subject: Re: [PATCH net-next 7/7] net: phy: marvell10g: add support for the
 88x2110 PHY
Message-ID: <20190120191041.GC19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-8-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118152352.26417-8-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Make sure we advertise all the supported modes, and not just the
> +	 * default one specified in the driver's .features.
> +	 */
> +	linkmode_copy(phydev->advertising, phydev->supported);

We need to look a this. This is something the core should be doing.

   Andrew
