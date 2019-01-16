Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7186DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BE820675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nPhfsH5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbfAPWXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:23:34 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45903 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbfAPWXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=NCCrvL2IiMEG1Ja+vgPXwz8tN7y6R94eLBQnfEZBVgY=;
        b=nPhfsH5Mh6fKa2Swf3wVZHPukZQ5lDS1TyVOogkq7jxoH1s3Do88WPGJmRtRnjUTIEAUZxBEJw3VGgQmErHM1GvxPe5zMZ5esoR/1DNkLw0GnOe4AHNq8uATuXLJ1p0h8gsHlKY5x4IY58u95fYpEzq5tNDC7BzRYJc89ne3Wos=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjtar-0002uO-LX; Wed, 16 Jan 2019 23:23:29 +0100
Date:   Wed, 16 Jan 2019 23:23:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add suspend/resume
 callbacks
Message-ID: <20190116222329.GP29244@lunn.ch>
References: <20190116153419.3208-1-miquel.raynal@bootlin.com>
 <20190116155651.GC29244@lunn.ch>
 <e9ac5203-87ba-c14f-8140-5b100808a8a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ac5203-87ba-c14f-8140-5b100808a8a4@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian

> A possible approach could be to call the port_disable, port_enable
> callbacks from dsa_slave_suspend() and dsa_slave_resume(), I might have
> some patches doing that already somewhere.

I expect it is also on Viviens TODO list, since this really could be
in the core.

   Andrew
