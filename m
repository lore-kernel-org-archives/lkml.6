Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1095C26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A212085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FBoW1sLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfATTIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 14:08:13 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49464 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfATTIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 14:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=hhnvI/B3sWN5Iqv13mUKLwEjuwVIKUHFWXkKcRCqyIU=;
        b=FBoW1sLRtZPjyBwgXZLFOW7WVEDdrkfQXkt6H7xXDsQTQaL8p+3ilMaxgNjr+tp6XhCJM7rmiJG8Y81e1q0XeB2tfLY2I2avQ2hkDpHeQjFR+kgcp+p8gkBEPdpF+X6IcpHbRXubaZJ7gOLNBhLB4AHyGatUNeYhvhDEaGT5v1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1glIS1-0005Ib-Lr; Sun, 20 Jan 2019 20:08:09 +0100
Date:   Sun, 20 Jan 2019 20:08:09 +0100
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
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190120190809.GB19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-6-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118152352.26417-6-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:23:50PM +0100, Maxime Chevallier wrote:
> As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
> whether or not we should read register (1.21) "2.52/5G PMA Extended
> Abilities", which contains information on the support of 2.5GBASET and
> 5GBASET.
> 
> After testing on several variants of PHYS of this family, it appears
> that bit 14 in (1.11) isn't always set when it should be.
> 
> PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
> but don't have 1.11.14 set. Their register 1.21 is filled with the
> correct values, indicating 2.5G and 5G support.
> 
> PHYs 88X2110 do have their 1.11.14 bit set, as it should.

Hi Maxime

Is there anything about this in any Errata?

We potentially have an issue if Marvell have any PHYs in this family
which don't support 2.5G/5G. Maybe this workaround needs to check the
IDs and only enable it on device we know are broken.

    Andrew
