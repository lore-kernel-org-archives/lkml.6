Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F355D207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nEuVM/8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F355D207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeJZHkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:40:47 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43379 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbeJZHkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=F1otp5Hrpjw4c/HlCZ3ZfoxnWwzsHqzbhJOAqeX2Y0M=;
        b=nEuVM/8t+ixhmCBLunUGNXl1HG0X4CxIdmPJr08KK9yMviujsnxPwRzLbV/hePXwhHyu6a/TPQuInqXVT+81mqVAymZNrQLfiJ/rpVC3wkSqFrBNcZRKE+46kJaXsG7B5ry3ddNnls8AalGg07OniZkQXetbmSLKdpktw2P4vR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gFohf-0005r6-Up; Fri, 26 Oct 2018 01:06:11 +0200
Date:   Fri, 26 Oct 2018 01:06:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Max Uvarov <muvarov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH] dp83867: fix speed 10 in sgmii mode
Message-ID: <20181025230611.GE6276@lunn.ch>
References: <20181025110530.22826-1-muvarov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025110530.22826-1-muvarov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 02:05:30PM +0300, Max Uvarov wrote:

Hi Max

> For support 10Mps sped in SGMII mode DP83867_10M_SGMII_RATE_ADAPT bit

speed.

> of DP83867_10M_SGMII_CFG register has to be cleared by software.
> That does not affect speeds 100 and 1000 so can be done on init.

It would be good to add a Fixes: tag. Has this always been broken?

Thanks
	Andrew
