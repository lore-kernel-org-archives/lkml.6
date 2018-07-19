Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900BFECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D58E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PHf1MTsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D58E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbeGSNtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:49:09 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56638 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbeGSNtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1QuEvPjlCURjMu7XzfMmTdKXF4pRjHGYWS9HmKfJfW0=; b=PHf1MTsUkvIBGTRJd+0p5X4/C
        QuAnmZ43EgO4rZEatmeaMIzg7vG7b8ahcfErOJ+ex9GkdxQKzp4o1e87AWwUCNgs/OI19KJvuJhpP
        ZsIeXMQB8y4Jc6xXv+VI/uyYCV28mVpX1oNw67kq8XGNmIdirqED6ghMOFF8tlvpHoknQ=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:46850)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fg8U6-0005ig-7J; Thu, 19 Jul 2018 13:56:42 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fg8U0-0002l5-M4; Thu, 19 Jul 2018 13:56:36 +0100
Date:   Thu, 19 Jul 2018 13:56:35 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Camelia Alexandra Groza <camelia.groza@nxp.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: use generic clause 45 autonegotiation done
Message-ID: <20180719125635.GK17271@n2100.armlinux.org.uk>
References: <1531919535-20269-1-git-send-email-camelia.groza@nxp.com>
 <20180718143919.GA10856@lunn.ch>
 <VI1PR04MB4799F126865F4A5C115D1B16F2520@VI1PR04MB4799.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4799F126865F4A5C115D1B16F2520@VI1PR04MB4799.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:47:18PM +0000, Camelia Alexandra Groza wrote:
> > -----Original Message-----
> > From: Andrew Lunn [mailto:andrew@lunn.ch]
> > Sent: Wednesday, July 18, 2018 17:39
> > To: Camelia Alexandra Groza <camelia.groza@nxp.com>
> > Cc: f.fainelli@gmail.com; davem@davemloft.net; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] net: phy: use generic clause 45 autonegotiation done
> > 
> > On Wed, Jul 18, 2018 at 04:12:15PM +0300, Camelia Groza wrote:
> > > Only Clause 22 PHYs can use genphy_aneg_done(). Use
> > > genphy_c45_aneg_done() for PHYs that implement Clause 45 without the
> > > Clause 22 register set.
> > >
> > > This change follows the model of phy_restart_aneg() which
> > > differentiates between the two implementations in a similar way.
> > 
> > Hi Camelia
> > 
> > What about phy_config_aneg()? I would assume any sort of auto-neg action
> > needs to check for c45 without c22, before calling a genphy_ function. Do you
> > think it is possible to write a genphy_c45_config_aneg()? If not, we might
> > want to return -EOPNOTSUPP.
> 
> Hi Andrew,
> 
> Adding Russell to the thread as well, since he wrote the c45 helpers.
> 
> Sure, I'll send a v2 with an additional generic phy_config_aneg(). I'll
> stick to returning -EOPNOTSUPP for c22-less PHYs for now.

Be aware that there are no generic registers for configuring (eg) 1G
speeds in C45 phys - that is vendor specific.

It may be that the expectation in the 802.3 specs is that such PHYs
implement the C22 register set in devad 0, but I've no visibility of
that (and the 10G PHYs that phylib does have, apart from marvell10g,
are particularly poor in the features they implement.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
