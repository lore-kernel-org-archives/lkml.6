Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34A4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E75F247D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lPA4y/An"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E75F247D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbeFZTgp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:36:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43716 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751175AbeFZTgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mFlibdxjbMbDxgt6YIjvFqciEuAlXlaD6+pE5ujpsTw=;
        b=lPA4y/AnvMC8KTGq2nrBd0cXMfkocvUjkSJScdoUGDftkiYFrMQNGisOlrXpGKUbtndKAW78mixt4nvsvmPMeFpLsp5uyO3AkIDPuNOsE6JAyLPrdXepL1DlSJgHIP73GQUwo2pC/L6W8Koz7nb0qjWKKg5JmqT7+3NQSF8ykNY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fXtlU-0004Hr-BA; Tue, 26 Jun 2018 21:36:36 +0200
Date:   Tue, 26 Jun 2018 21:36:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Brandon Maier <brandon.maier@rockwellcollins.com>
Cc:     netdev@vger.kernel.org, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: phy: xgmiitorgmii: Check phy_driver
 ready before accessing
Message-ID: <20180626193636.GC9800@lunn.ch>
References: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:50:48PM -0500, Brandon Maier wrote:
> Since a phy_device is added to the global mdio_bus list during
> phy_device_register(), but a phy_device's phy_driver doesn't get
> attached until phy_probe(). It's possible of_phy_find_device() in
> xgmiitorgmii will return a valid phy with a NULL phy_driver. Leading to
> a NULL pointer access during the memcpy().


> Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
