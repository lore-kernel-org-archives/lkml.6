Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C250BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A179217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gtqzQOtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfAYSvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:51:36 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:56008 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfAYSvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KNuk9eoZz5TzsTlNsU4tkALoOUxRrcWP45M+bKYeatE=; b=gtqzQOtv5OOZZBbPmXavhDDLUy
        Ae7kZhD4Q2jnpR2WqiAEaTHttyUHlLCxy4ffeHdhWGpMfX/8bRcQesgr6jdZ4L3PH3XlaHxFyHr+t
        9tshcqfXFgMk5J3LrZnepsknxhld4+HvIfhH69qyDvAfM3/E4KqjO/jGBqT/oy9Zgqcc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gn6Zg-0006cf-1s; Fri, 25 Jan 2019 19:51:32 +0100
Date:   Fri, 25 Jan 2019 19:51:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Carlo Caione <ccaione@baylibre.com>, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: at803x: Use helpers to access MMD PHY registers
Message-ID: <20190125185132.GF22211@lunn.ch>
References: <20190125123510.20511-1-ccaione@baylibre.com>
 <20190125150013.GG12962@lunn.ch>
 <a7f5531b-902b-2849-02a5-a4ec8660e06d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f5531b-902b-2849-02a5-a4ec8660e06d@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 07:11:28PM +0100, Heiner Kallweit wrote:
> On 25.01.2019 16:00, Andrew Lunn wrote:
> > On Fri, Jan 25, 2019 at 12:35:10PM +0000, Carlo Caione wrote:
> >> Libphy provides a standard set of helpers to access the MMD PHY
> >> registers. Use those instead of relying on custom driver-specific
> >> functions.
> > 
> > Hi Carlo
> > 
> > Maybe deja vu, but i thought a similar patch went by recently?
> > 
> Andrew, maybe you mean this one?
> 
> 9b420eff9fcf ("net: phy: micrel: use phy_read_mmd and phy_write_mmd")

Yes, probably that one.

Might be worth grepping of 0xd, 0xe, 0x0d, 0x0e, 13, 14, and see if
there are any more instances in PHY drivers.

      Andrew
