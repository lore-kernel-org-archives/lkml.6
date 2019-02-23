Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE22C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994A204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TtVtu93n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfBWPky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 10:40:54 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36181 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfBWPkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 10:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jlZLZsViRFGl/A+TAQDwkrwFi2a68DNaZ30qwnrb0Nk=; b=TtVtu93ndSRC49hMbmyyQtGgBI
        4rNA2T4gkPL5AQNaRgEXZZUcPLovuLu4Z3m0wchjTK1qIEsqxKnhZPG/bEI6bvuGzbiQdGIrRZRyy
        LyAzUakkG+zY9MlW50HS2Vq16G4EwNkJBgqZQh3uv63CXNVsECWB1kAAscP1Ht+PFoOc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxZQ3-0003uF-BT; Sat, 23 Feb 2019 16:40:51 +0100
Date:   Sat, 23 Feb 2019 16:40:51 +0100
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
Subject: Re: [PATCH net-next v2 5/7] net: phy: marvell10g: Force reading of
 2.5/5G
Message-ID: <20190223154051.GJ10693@lunn.ch>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
 <20190222233744.25735-6-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222233744.25735-6-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 12:37:42AM +0100, Maxime Chevallier wrote:
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
> PHYs 88E2110 do have their 1.11.14 bit set, as it should.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
