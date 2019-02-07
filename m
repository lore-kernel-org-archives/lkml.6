Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0012BC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE0221721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AeBFBGHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBGXhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:37:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49966 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGXhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ju5+vYpJoZF1xS6C9OLI61WX5FiyHVFYeX6XMvTY2ns=; b=AeBFBGHMda5J9s/ynjOI/Qv9+
        FbNAmhatmnFz1lYq0j6b09eAWld2lZ/tHy6PrJXmngfBf9uTOX7XzYM291YSQCNUFyU8aEWWWGHFb
        3XJrgBaaahv8gl6W1ke1LBN50WR1H3qYPkFxJr1GJIfxQRp2NisqaxNAZBsds+JM9Jt1A=;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36614)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1grtEA-0004dD-Kf; Thu, 07 Feb 2019 23:37:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1grtE4-0006YS-OC; Thu, 07 Feb 2019 23:37:00 +0000
Date:   Thu, 7 Feb 2019 23:37:00 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190207233700.ftw4cyilc2tzzqmb@shell.armlinux.org.uk>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-6-maxime.chevallier@bootlin.com>
 <20190120190809.GB19714@lunn.ch>
 <20190121113531.7a8b5b51@bootlin.com>
 <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
 <20190121132945.6e6dee23@bootlin.com>
 <20190121130030.i5kkjb55gwttobvq@e5254000004ec.dyn.armlinux.org.uk>
 <20190128152621.2aec96c1@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128152621.2aec96c1@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 03:26:21PM +0100, Maxime Chevallier wrote:
> Hello Russell,
> 
> On Mon, 21 Jan 2019 13:00:30 +0000
> Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> 
> >On Mon, Jan 21, 2019 at 01:29:45PM +0100, Maxime Chevallier wrote:
> >> Hello Russell,
> >> 
> >> On Mon, 21 Jan 2019 10:52:06 +0000
> >> Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:  
> >> >It's entirely possible that the 3310 switches to different hardware
> >> >blocks for 2.5G and 5G speeds, and reading _just_ the 1.4 register
> >> >is not sufficient.  
> >> 
> >> I agree with you but in that particular case, I think we are reading
> >> from the correct device. The datasheet itself says that we should be
> >> reading 1.4 and 1.11 as we expect, with 2.5G/5G support being set (these
> >> registers are read-only, and the datasheet's values aren't what we
> >> actually read).  
> >
> >No, you missed what I was saying.
> >
> >The 88x3310 is a hybrid device.  It contains multiple instances of
> >each individual device at different offsets in each MMD address space.
> 
> Ah I see, I indeed thought you refered to the MMDs. 
> 
> [...]
> 
> >The exception seems to be the PMA/PMD MMD which I've only discovered
> >a single instance.
> 
> Yes there only seems to be one. There are some other registers in the
> 1.0xCxxx range, but those who are documented don't help a lot with
> determing wether or not these modes are supported.
> 
> I wonder if these values are correctly reported in newer PHY firmware
> revisions.
> 
> I've checked other PCS instances, but it seems the one at 3.0x0xxx is
> the one used in 2.5/5GBASET.

In the following, I use "subdevice N" to mean instance "N + 1".  So
the instance at address 0 is the main device and the following instance
is subdevice 1.

Looking at the PCS, none of them have the 2.5G/5G bits set in the 3310
which is rather interesting, except the one at 3.0 has the EEE bits
set in 3.21.  You are quite correct that the first instance is used
for 2.5G copper, but PCS subdevice 2 also changes as a result of
switching down to 2.5G (its transmit fault status clears.)

It looks like PhyXS subdevice 3 is used (which is a SGMII/1000base-X
MAC facing PHY), is switched to fixed speed mode.  It doesn't have
what looks like a sensible advertisement either, so my guess is that
this will need the MAC side to be configured _not_ to expect the
in-band control word in this mode.  In other words, it may be SGMII
or 1000base-X upclocked to 2.5G speeds - which it is doesn't matter
because the difference is in the control word which looks like it's
omitted, or if it isn't, doesn't contain useful information.

Note that mvpp2 is slightly buggy in this area, and I have a patch
set that fixes it up - patches can be found in my "mvpp2" branch,
which I'm waiting for my problem reporter to report back after his
testing.  If you use this patch set, as long as you don't use
in-band mode, it should be fine.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
