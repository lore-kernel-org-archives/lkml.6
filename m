Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D70FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D83220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LY1NRLgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D83220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbeGSSDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:03:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40407 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731442AbeGSSDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=f3LoHwUfZrfCHvkE+cGZJlo2IUPM/VSHvNlceNSuiSQ=;
        b=LY1NRLgI0qb03F/6oH3MexvMA1sZ8c0mtsxvYk0A1suIHIibVOQPGe2Mo2C6Jxw/dVdyi+zMnTkQM/BVs0R1zCmM3XUqan+cYVaFP69zmRX2jvDW9FsDcjBxuumKI4YJo9weY4CXQu8Ta6yopJ417SwuFSLgmop66E5JjVH3R7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fgCaK-00045U-E3; Thu, 19 Jul 2018 19:19:24 +0200
Date:   Thu, 19 Jul 2018 19:19:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: sfp: Do not use "imply HWMON"
Message-ID: <20180719171924.GC12150@lunn.ch>
References: <1532018499-16490-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532018499-16490-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 09:41:39AM -0700, Guenter Roeck wrote:
> "imply HWMON" was supposed to ensure that the SFP phy code can be built
> with HWMON enabled or disabled while at the same time ensuring that
> HWMON is not built as module if SFP is built into the kernel.
> Unfortunately, that does not work as intended. With "allmodconfig", it
> results in several unrelated HWMON drivers to be disabled instead of
> being built as module as expected.
> 
> Let's use the old "depends on HWMON || HWMON=n" instead. This is slightly
> different (it enforces SFP to be built as module if HWMON is built as
> module), but it is better than the alternative of using "IS_REACHABLE()"
> in the driver since that would disable sensor support if HWMON is built
> as module and SFP is built into the kernel.
> 
> Fixes: 1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
