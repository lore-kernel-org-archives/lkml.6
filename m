Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C70BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE4420844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4YuzPV/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfBEN1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:27:11 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39463 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfBEN1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Zqlnk1X4UGfuwvFpgQxqiW5WczMJ0Ten01zb1oZ51QU=; b=4YuzPV/JC9tKlY+9CIhbac4MjS
        QYzpxOF3XHh7k5Reojah3Ysj8Zaqnab0T7JkchtBUTAM1w/iGbaIaBiO2gaEuH/1IF4aeVW56iMpH
        AUsIiUYuciIkLrh+SDwCLi3E06/l/awLirkqPnw8nJcFqoHh6fI4OrBxkIa7ApJHUrUA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gr0kl-0007hZ-2h; Tue, 05 Feb 2019 14:27:07 +0100
Date:   Tue, 5 Feb 2019 14:27:07 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Prevent suspend to RAM
Message-ID: <20190205132707.GD28397@lunn.ch>
References: <20190205110728.11451-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205110728.11451-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:07:28PM +0100, Miquel Raynal wrote:
> On one hand, the mv88e6xxx driver has a work queue called in loop
> which will attempt register accesses after MDIO bus suspension, that
> entirely freezes the platform during suspend.
> 
> On the other hand, the DSA core is not ready yet to support suspend to
> RAM operation because so far there is no way to recover reliably the
> switch configuration.
> 
> To avoid the kernel to freeze when suspending with a switch driven by
> the mv88e6xxx driver, we choose to prevent the driver suspension and
> in the same way, the whole platform.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
