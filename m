Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388E6217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2+nYXpvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfBZOGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:06:17 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38999 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfBZOGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=INTdwJZ+JsHtrdKuyZ8XcEtbdIzUNQ4bqAqfcZURm6w=; b=2+nYXpvp8jYOnS5cEk1mm8L3qg
        CAhz55IIcDO6SM1T55DJH5BB+HgtJ4tf+3roGUfIRDupLVsBDWPwdYYmQ7RvXnTQVfWmBi4pmpIdq
        7m3b5r0ENuG8cdElaayxmuVQhBB4XyBR9pfgoJU3BxaXuaW8lfgakwyt4KRSYFKUCLCk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gydN2-0006Zq-5X; Tue, 26 Feb 2019 15:06:08 +0100
Date:   Tue, 26 Feb 2019 15:06:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rajasingh Thavamani <T.Rajasingh@landisgyr.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Micrel KSZ8061: link failure after cable
 connect
Message-ID: <20190226140608.GF3809@lunn.ch>
References: <20190226081506.25887-1-T.Rajasingh@landisgyr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226081506.25887-1-T.Rajasingh@landisgyr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 01:45:06PM +0530, Rajasingh Thavamani wrote:
> With Micrel KSZ8061 PHY, the link may occasionally not come up after
> Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
> sheet 80000688A.pdf descripes the problem and possible workarounds in
> detail, see below.
> The batch implements workaround 1, which permanently fixes the issue.
 
...

> PLAN
> This errata will not be corrected in the future revision.
> 
> Signed-off-by: Rajasingh Thavamani <T.Rajasingh@landisgyr.com>

We have been here before:

https://lkml.org/lkml/2018/11/23/466

At that time, the patch was from Alexander Onnasch, and has his
signed-off-by. Now it only has your SOB. It probably should have
both. My reviewed-by has gone missing. And this is version 3? And in
the comments i also included a Fixed: tag, which should be added.

Please submit a v4 with all these issues fixed.

Thanks
       Andrew
