Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177DD2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F3SGoL5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfBRL2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:28:24 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52680 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRL2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PytXDBpDdpVNIlyP0KHGXj87xngQNc9GC1R8AqZjUiE=; b=F3SGoL5zpnyFk+qn4+Is3+tZR
        7tRn2dJCIMK/0pX/ZCxdZD+Pxq+J7/I1Pdm72S/tDvvDgbXOmXILM2eadnMNRk29f3cU/aD0AWK2Y
        liyzCT68m6poV0FaXOSS2ZpmmM5xPBMyA+Dqcsh3xRdcJzUjEL4kLpsGfi7yOYsxrinGgAXSMKmpW
        hYRbVqGiI8adVNv1grrladWoBpND1CmLOAbFDWkZvWURfaHkVcj8WBZoPoNs5TuZJFp9nCgSQNqYb
        m+ToOyUvjHCUylwvYSwoIf24gectIA+E35BIgBAgyp7ZeggU4Ni5Fpi0zHGQnHAzrA8yKS9+UA0bm
        8ItxAQc4w==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36872)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gvh5u-0006jV-Ru; Mon, 18 Feb 2019 11:28:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gvh5r-00077z-SF; Mon, 18 Feb 2019 11:28:15 +0000
Date:   Mon, 18 Feb 2019 11:28:15 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stefan Chulski <stefanc@marvell.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: Re: [EXT] Re: [PATCH net-next 10/13] net: mvpp2: reset the XPCS
 while reconfiguring the serdes lanes
Message-ID: <20190218112815.ec3pyuvzpphdance@shell.armlinux.org.uk>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
 <20190215153241.6857-11-antoine.tenart@bootlin.com>
 <20190215171224.sjfrid5csseywuks@shell.armlinux.org.uk>
 <20190218102630.GA3784@kwain>
 <20190218104302.bp6ccmpkt26dflyx@shell.armlinux.org.uk>
 <20190218104757.be63b5ft5jpongn3@shell.armlinux.org.uk>
 <20190218105222.GD3784@kwain>
 <DM5PR18MB1067E1DD47E7094E02043A58B0630@DM5PR18MB1067.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR18MB1067E1DD47E7094E02043A58B0630@DM5PR18MB1067.namprd18.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Mon, Feb 18, 2019 at 11:08:34AM +0000, Stefan Chulski wrote:
> HW recommendation upon Serdes reconfiguration are the following:
> 
> 1. Disable port(CTRL0_REG - in XLG/GMAC) 
> 2. Put port in reset (both XLG/GMAC)
> 3. For KR - put in reset MPCS (MAC control clock, RX SD clock, TX SD clock), XPSC is RXAUI/XAUI clock domain
> 4. Power down Serdes lane
> 
> Do reconfiguration of Serdes.
> 
> 5. Enable Serdes lane
> 6. Disable MPCS reset for KR
> 7. Disable port reset (both XLG/GMAC)
> 8. Enable port  (both XLG/GMAC)

For clarity, presumably either the XLG or the GMAC should be released
from reset and enabled at any one time depending on the configured mode,
but never both together?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
