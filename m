Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5EFC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6AB208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D038rJL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6AB208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbeHAWLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:11:00 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44768 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeHAWLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AnQvRTHKIZj5HsT/xeNJWWXxGJBb5wQji5HEUtSnPhU=; b=D038rJL1jsni08C+C+rjBSLQH
        NcgMLUjDe0E/SzcPDVsj+Jg1NgmPSfNXO2Z3fA6vBiKLRojgx9AHGf18MCUVBLiR9Pa+MDsJnImXj
        osmsT/+Gw8ZIrjt3WaTcotayTeW9+jtm3l5FSNyl3PAMHM236ij7QBU257aXacqVGsSSI=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:48555)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fkxeQ-0005Pz-KA; Wed, 01 Aug 2018 21:23:18 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fkxeN-0000DC-PJ; Wed, 01 Aug 2018 21:23:15 +0100
Date:   Wed, 1 Aug 2018 21:23:14 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
Message-ID: <20180801202313.GH30658@n2100.armlinux.org.uk>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
 <20180801200712.GD19257@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801200712.GD19257@lunn.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 10:07:12PM +0200, Andrew Lunn wrote:
> You might want to consider adding clk_optional_get() and
> devm_clk_optional_get().

I think there's attempts to add such APIs but I don't think it's
trivial - it seems to require a _lot_ of discussion.

I think part of that is because of the quirky use of error codes.
If you look at clk_get(), it calls __of_clk_get_by_name() which
returns:

 -ENOENT if DT is disabled
 -ENOENT if the device has no DT node
 -EPROBE_DEFER if the lookup in DT succeeds but there's no registered
   clock
 -EINVAL if the device has a DT node but the lookup of the name
   failed (in otherwords, the optional clock was omitted)
 -ENOENT if the clocks = property has not enough clocks for the
    clock-names property
 -ENOMEM if we fail to allocate the clk
 -ENOENT if __clk_get() fails

or any other error code returned via of_clk_provider's ->get() method.

The use of -EINVAL, one of the most common error codes, makes it
difficult to be sure that the clock is not specified in DT.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
