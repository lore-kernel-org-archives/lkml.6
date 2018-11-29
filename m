Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54ACC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF2420868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FoRH+oiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF2420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeK3DWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:22:52 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39960 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeK3DWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TGaYwCND+hBhdZa6cfw3iUtDfBeyJbSz1inGLR0Ea4c=; b=FoRH+oiCi6eiv/Mu5LtY+z9xw
        gKdh781uWP1e24hs8Uvw2Fw/jXm/SEy2pQCYLRBahKI4F93TeCMtxoXipjtyi94jVwiIsEd9LZb7i
        fbsPst21cIJvvuuNZJFHGkvXxd7cP6tGaK66QU3qBwTZ9mxICQjxN7cW6mkFLIhdNbWBw=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38399)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gSOzg-0003IW-FU; Thu, 29 Nov 2018 16:16:48 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gSOzd-0002L0-10; Thu, 29 Nov 2018 16:16:45 +0000
Date:   Thu, 29 Nov 2018 16:16:43 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Grzegorz Jaszczyk <jaz@semihalf.com>,
        linux-kernel@vger.kernel.org, Evan Wang <xswang@marvell.com>,
        "Nadav Haklai (Marvell)" <nadavh@marvell.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] phy: add A3700 COMPHY support
Message-ID: <20181129161643.GZ30658@n2100.armlinux.org.uk>
References: <20181122210420.14861-1-miquel.raynal@bootlin.com>
 <20181122210420.14861-3-miquel.raynal@bootlin.com>
 <20181129171245.4f683045@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129171245.4f683045@xps13>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 05:12:45PM +0100, Miquel Raynal wrote:
> Hello,
> 
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 22 Nov 2018
> 22:04:16 +0100:
> > +static struct phy *mvebu_a3700_comphy_xlate(struct device *dev,
> > +					    struct of_phandle_args *args)
> > +{
> > +	struct mvebu_a3700_comphy_lane *lane;
> > +	struct phy *phy;
> > +
> > +	if (WARN_ON(args->args[0] >= MVEBU_A3700_COMPHY_PORTS))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	phy = of_phy_simple_xlate(dev, args);
> > +	if (IS_ERR(phy))
> > +		return phy;
> > +
> > +	lane = phy_get_drvdata(phy);
> > +	if (lane->port >= 0)
> > +		return ERR_PTR(-EBUSY);
> 
> This is not valid. It works only the first time the consumer gets
> a PHY for this lane. If the consumer put the PHY (module is unloaded)
> and then gets the PHY again (module is re-loaded a second time), the
> port is already set to != -1 and this will exit with an error and
> prevent the module to probe.
> 
> > +
> > +	lane->port = args->args[0];
> 
> I will remove the above check and transform it into a valid "port"
> value right here.

Please note that mvebu_comphy_xlate() in
drivers/phy/marvell/phy-mvebu-cp110-comphy.c does exactly the same.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
