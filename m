Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F52C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF092147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cuVlkzRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBGOPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:15:43 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42478 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBGOPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i8wpvOeWaWs47XPtdzw6kdYnPH8LLtVL8HntV08+VZA=; b=cuVlkzRyzb1PgRMsfyLuC+xaSH
        lWEBYOnqC1e16FDYGRULhhu0dTDcLWfJ0uwrsXTAQ7DHE/VETwLZw3WnUwfuKcmcciKrsvZ+HywX0
        kYmgP06pJ05UOigIJ4AzwMU+raERdiHBX/SU6ZIhKWBMWQqE6KmZXO0TS7J+FLO9Po5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1grkSp-000728-4R; Thu, 07 Feb 2019 15:15:39 +0100
Date:   Thu, 7 Feb 2019 15:15:39 +0100
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
Subject: Re: [PATCH net-next v2 07/10] net: phy: marvell10g: Add support for
 2.5GBASET
Message-ID: <20190207141539.GJ32483@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-8-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207094939.27369-8-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  		if (phydev->speed == SPEED_10000)
>  			phydev->interface = PHY_INTERFACE_MODE_10GKR;
> +		else if (phydev->speed == SPEED_2500)
> +			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
>  		else if (phydev->speed >= SPEED_10 &&
> -			 phydev->speed < SPEED_10000)
> +			 phydev->speed < SPEED_2500)
>  			phydev->interface = PHY_INTERFACE_MODE_SGMII;
>  	}

Maybe swap to a switch statement?

>  static struct phy_driver mv3310_drivers[] = {
>  	{
> -		.phy_id		= 0x002b09aa,
> +		.phy_id		= MARVELL_PHY_ID_88X3310,

What does the datasheet say about the lower nibble? Often it is a
silicon revision field, so you don't match on it. But 0xa is a rather
odd revision.

Thanks
	Andrew
