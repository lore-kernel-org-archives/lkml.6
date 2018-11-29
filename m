Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB13206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vNEdYoKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB13206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeK2Ncx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:32:53 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53697 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeK2Ncx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=IaREirnIWjEsEDdg8DNRbadVs1/HXGD9LzYebql2mcI=;
        b=vNEdYoKFBEFDYGkDjM1TM3N8uyQc7sUYqKw+N/bt4JoFZjsp5qgraI8PystQWQdy5jjGxvavbBU7iFUPP9XiDmIDRyc/5fgKH4FVI9UrZSE1gw5/mbQbOrEiSzsWkc2qRcuyHMrKWlxENpSbnqmMPDxPny+dpV0J0CwU3E1o/VQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gSC4Z-0003dH-0g; Thu, 29 Nov 2018 03:28:59 +0100
Date:   Thu, 29 Nov 2018 03:28:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     f.fainelli@gmail.com, sergei.shtylyov@cogentembedded.com,
        atish.patra@wdc.com, schwab@suse.de, nicolas.ferre@microchip.com,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, hkallweit1@gmail.com
Subject: Re: macb: probe of 10090000.ethernet failed with error -110
Message-ID: <20181129022858.GG5037@lunn.ch>
References: <2e17bba6-d932-37b2-5dca-0963fc50f5e6@gmail.com>
 <mhng-0ddf5852-8900-4131-b3e0-81c5cc7de2eb@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-0ddf5852-8900-4131-b3e0-81c5cc7de2eb@palmer-si-x1c4>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is all fine as long as Linux doesn't go and reset the phy again. Until
> bafbdd527d56 ("phylib: Add device reset GPIO support") was the case.  After
> that commit I believe phylib is resetting the phy while attempting to enter
> unmanaged mode, which is now allowed in this particular chip.
> 
> Since it appears the phy is not usually described by the device tree but is
> instead discovered by probing a MII-based ID register, it seems the best
> place to put this is within the phy driver itself.  I find it's usually best
> to describe things with code, so I hacked up something like

Talking to Florian, i was under the impression that you could not even
discover the device when its reset state what wrong. You could not
read the ID registers.

Your suggested change assumed you can discover the device. Is this
true?

	Thanks
		Andrew
