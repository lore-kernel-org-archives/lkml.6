Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE70BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1F521924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J8m8LJd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfBORB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:01:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54153 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfBORB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Py2su8RzV13xDHnbmKHfqOETJQ5bPdnq2ClFAX+lQjw=; b=J8m8LJd318Ld2MdywzNqSjSZVT
        ZyDUYI7I4Uv7qtM2rzUyhv2gKrlRoWO5Rh2y6xOhAO36+SUrvrnoVt++L79T9Ki836US/OzKZcy3b
        Wdf5V9gZTgJmydjZP8KG+R9rWzCNl4tEp6q/M7THMtC27JsY66kE5iJdbgp6oeey0Q8M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gugs5-00085s-Gx; Fri, 15 Feb 2019 18:01:53 +0100
Date:   Fri, 15 Feb 2019 18:01:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] net: phy: xgmiitorgmii: Support generic PHY status read
Message-ID: <20190215170153.GR708@lunn.ch>
References: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
 <20190215162344.GQ708@lunn.ch>
 <e8928afbb43cc8fffbb9b9034b2a94907fef596d.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8928afbb43cc8fffbb9b9034b2a94907fef596d.camel@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > How about using phy_read_status()?
> 
> Thanks fo rthe suggestion! Though I don't that would work here since
> our priv->phy_drv != phydev->drv, so it looks like we need to be
> breaking it down in the driver.

Ahm, yes. I forgot how this driver works.

     Andrew
