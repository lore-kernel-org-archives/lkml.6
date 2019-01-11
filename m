Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A677FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FE62177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CSe3SXHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbfAKOWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:22:09 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40351 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbfAKOTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0RigYZLJue07QZWT7y7EUdLva04itwCInh7YyWYd71c=;
        b=CSe3SXHCrsRC5qnMMAFqJJA2e8kfJ524ZZIrQ8FiwIwQMpAE10KIn574spw9yj6FDG1d8K+LTnmN6oNHdUq6aXhwkyDVb/7XO3MgKweKGEMXEwpSnjKh7AY5thd5oSBHMOuBTiuZjImQWwO1kGok+4uDnjZlXfs5UlahUhYQKgM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ghxem-0001Lw-Mc; Fri, 11 Jan 2019 15:19:32 +0100
Date:   Fri, 11 Jan 2019 15:19:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Camelia Alexandra Groza <camelia.groza@nxp.com>
Cc:     "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "oss@buserror.net" <oss@buserror.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: guard against accessing a NULL features
 bitmap
Message-ID: <20190111141932.GC20924@lunn.ch>
References: <1547207806-30572-1-git-send-email-camelia.groza@nxp.com>
 <20190111133730.GA1895@lunn.ch>
 <VI1PR04MB47994BB92D3E766C6B4E37C9F2850@VI1PR04MB4799.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB47994BB92D3E766C6B4E37C9F2850@VI1PR04MB4799.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Camelia
> > 
> > A NULL features is a driver bug. So i would prefer to solve this
> > differently.
> >
> > Please make phy_driver_register() do a WARN_ON(!new_driver->features)
> > and return -EINVAL.
> 
> I wasn't aware that features are mandatory. I'll make the change.

It was not origionally, but really it should be now.

> Yes, there are five drivers that don't have features configured: BCM8706, BCM8727, CS4340, TN2020 and KSZ8873MLL.

> I'm planning to send patches on net-next for the Cortina and
> Teranetics ones at least, but fixing the generic crash was my
> priority.

O.K, will take the others.

Thanks
	Andrew
