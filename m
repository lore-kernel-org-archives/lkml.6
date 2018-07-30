Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB900FC6121
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90924205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RWyp2TWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90924205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbeG3TkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:40:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50760 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeG3TkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=MmG/i3BkMsG3UwCgMw4+9fHoO6t66YzU6wuk++jAIY0=;
        b=RWyp2TWZFgFG4L9utbcXaNHGAb/n6hq/F7COfjuWSYaQm4zWpe3Vv/iOAsvjnvw/j2laG4YOsGZ22Ddz3bPIFdN7v+PxIKF4ymJACF4aO9HI7VfEW0GsF/E4pmhpBVp0tnRlnBKluacgt9HiQTvatYCdGy/bnQierxA3nUO8gFg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fkCWa-0002Bj-Nm; Mon, 30 Jul 2018 20:04:04 +0200
Date:   Mon, 30 Jul 2018 20:04:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 6/7] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
Message-ID: <20180730180404.GH2983@lunn.ch>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
 <20180728212224.GF4792@lunn.ch>
 <d19bb673-9088-bbee-ce9f-f2a4d8f404bf@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d19bb673-9088-bbee-ce9f-f2a4d8f404bf@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Arun
> > 
> > There is a devm_mdiobus_alloc() which could make the cleanup on error
> > simple.
> > 
> Should I do this as a separate patch ?

A separate patch is easier to review. And if something breaks, a git
bisect gives you a better idea what actually broke it, if you have
lots of small patches.

     Andrew
