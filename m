Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B91BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E7921908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3KSY7zRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBGOJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:09:45 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42468 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfBGOJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UW1DS7PxkZzJbujwgy3uj1+cDFSwJ+CbXVbjWYszkO8=; b=3KSY7zRy20kjGRJiO6yC30ZhAC
        Z4NyPAdkTuUG0aDgz1EH/PEKBigmqJZ7IELFDilxOf6WJq7vlAZ2b6HR4l2116cjiQ5Z647vSSpUk
        /wtKTPvZKB5iuJVvFuMklFzNIKsNgCYn3KYVd9L1pLgS/Yq7xO/WJDHcLZS9R9q4eQVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1grkN1-0006ys-Hm; Thu, 07 Feb 2019 15:09:39 +0100
Date:   Thu, 7 Feb 2019 15:09:39 +0100
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
Subject: Re: [PATCH net-next v2 04/10] net: phy: Automatically fill the
 generic TP, FIBRE and Backplane modes
Message-ID: <20190207140939.GI32483@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207094939.27369-5-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:49:33AM +0100, Maxime Chevallier wrote:
> PHY advertised and supported linkmodes contain both specific modes such
> as 1000BASET Half/Full and generic ones such as TP that represent a
> class of modes.
> 
> Since some modes such as Fibre, TP or Backplane match a wide range of
> specific modes, we can automatically set these bits if one of the
> specific modes it corresponds to is present in the list.
> 
> The 'TP' bit is set whenever there's a BaseT linkmode in
> phydev->supported.
> 
> The 'FIBRE' bit is set for BaseL, BaseS and BaseE linkmodes.
> 
> Finally, the 'Backplane' is set whenever a BaseK mode is supported.

Hi Maxime

Interesting idea.

But what exactly are we supposed to be representing here?  That PHY
can do these modes, or that the port exists on the device? The
marvell10g can do fibre, but do all boards have an SFP/SFF, or do some
only have an RJ-45 for TP? Are there boards without TP and just
SFP/SFF?

Is there documentation in ethtool which gives a clue as to what is
expected?

Thanks
	Andrew
