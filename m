Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE92BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1422087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mosJRJMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfA2RDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:03:31 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59539 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfA2RDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vQDEDpnY+NosLatKVPFvS3iHeR7W2O+OOVyMbYnCJCY=; b=mosJRJMb46TSBIQmbbOIO5+sW7
        kV1MmQx/p9R0W/j0VgNcrnbaXP0IasXrxU2F9B1YmmZOh157ZGlsWFxN1aqL4AtpQ3AYls9ZwOLqg
        3YVLMO5XLkJr9v3rq78jKr9Wnb5KSO1KAzq+vB3igGFaMzvL4Mqcuv/RioOSBravt16c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1goWnG-0002vw-EX; Tue, 29 Jan 2019 18:03:26 +0100
Date:   Tue, 29 Jan 2019 18:03:26 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Camelia Alexandra Groza <camelia.groza@nxp.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 4.19 006/103] net: phy: phy driver features are mandatory
Message-ID: <20190129170326.GE13334@lunn.ch>
References: <20190129113159.567154026@linuxfoundation.org>
 <20190129113159.909710200@linuxfoundation.org>
 <2f2aa129-e9fb-c75a-1b60-1821863986bf@applied-asynchrony.com>
 <VI1PR04MB4799457AC9ECABE4EE8E5021F2970@VI1PR04MB4799.eurprd04.prod.outlook.com>
 <20190129163321.GA21868@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129163321.GA21868@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi
> > 
> > This points to an issue with the Generic 10G PHY driver. The following patch seems to be missing from the 4.19 stable tree and should be merged:
> > f802912 net: phy: genphy_10g_driver: Avoid NULL pointer dereference
> 
> But that patch says it:
> Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
> 
> Which is not in 4.19.y, it showed up in 4.20.
> 
> Ah, wait, I think that there was a patch backported to the 4.19.y queue
> that should not have, specifically:
> 	3e64cf7a435e ("net: phy: phy driver features are mandatory")
> which said it too fixes:
> 	719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")

Hi Greg

None of these patches should be backported to v4.19. All the link mode
and features stuff is v4.20 and later.

Thanks
	Andrew
