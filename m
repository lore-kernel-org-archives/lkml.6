Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id E9/VC/diGVtsZAAAmS7hNA
	; Thu, 07 Jun 2018 16:54:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A1B06608B8; Thu,  7 Jun 2018 16:54:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EuSeYG7i"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 351B060115;
	Thu,  7 Jun 2018 16:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 351B060115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934019AbeFGQyL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:54:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56976 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933743AbeFGQyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=TLlkhZw+XWxGNeMnXy/Gi+jy3pYmYwWbVwRtmgHi6YM=;
        b=EuSeYG7inf7A1ax0C3JzggnZ/6l8vqAqvcWE0sMIXhX3Xz94KrcUHNyMM22QnBetHMT+DmpsrMpEIp3k6UrfWS6y8dcPdHLnoRl9Ra4QOGOIx6A6OUm+hglr92gO4djOt30pwim6VY+Mgak/fg+HkWc/7K+rpAA2xvkkH4zkA1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fQyAi-0001hD-Jg; Thu, 07 Jun 2018 18:54:00 +0200
Date: Thu, 7 Jun 2018 18:54:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Brandon Maier <brandon.maier@rockwellcollins.com>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: phy: Check phy_driver ready before accessing
Message-ID: <20180607165400.GE25513@lunn.ch>
References: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:53:46AM -0500, Brandon Maier wrote:
> Since a phy_device is added to the global mdio_bus list during
> phy_device_register(), but a phy_device's phy_driver doesn't get
> attached until phy_probe(). It's possible of_phy_find_device() in
> xgmiitorgmii will return a valid phy with a NULL phy_driver. Leading to
> a NULL pointer access during the memcpy().

Hi Brandon

FYI: net-next is closed at the moment. Please resubmit these in two
weeks time.

      Andrew
