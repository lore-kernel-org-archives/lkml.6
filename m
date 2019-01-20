Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F364AC26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F6720861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IJEbEVgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfATSvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:51:11 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49451 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfATSvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=F/NoWxBnuEylA+vwK0t2ToezftjRIUcqu5ui+VUsKlg=;
        b=IJEbEVgxitgjMOELet/b0CjherLfgWaGnZh3KLPXRBmVCWkatjU67OW5OuUM3ZvL00gFcNqUFO2Et+ftBG8xsC0Fi7yToDE3BXhTCRhz4ylVOnN9cpEpuaxggF8NJgQxjofl/9Et6d7tnPtYYHv81xfZsOGEo8Chuqqq99dwkmc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1glIBX-0005CI-I6; Sun, 20 Jan 2019 19:51:07 +0100
Date:   Sun, 20 Jan 2019 19:51:07 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/7] net: phy: Extract genphy_c45_read_abilities
 from marvell10g
Message-ID: <20190120185107.GA19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-2-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118152352.26417-2-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:23:46PM +0100, Maxime Chevallier wrote:
> Marvell 10G PHY driver has a generic way of initializing the supported
> link modes by reading the PHY's C45 PMA abilities. This can be made
> generic, since these registers are part of the 802.3 specifications.
> 
> This commit extracts the config_init link_mode initialization code from
> marvell10g and uses it to introduce the genphy_c45_read_abilities
> function.

Hi Maxime

I think the idea is good. I just have a few English language
issues/questions.

Capabilities is more often used than abilities. I just wondered if
abilities is taken from the 802.3 specifications?

Also, i wonder if we should include _pma_ in the name? At some point
we might want to do something similar for other sublayers.

> +/**
> + * genphy_c45_read_abilities - read supported link modes from PMA
> + * @phydev: target phy_device struct
> + *
> + * Read the supported link modes from the PMA Status 2 (1.8) register. If bit
> + * 1.8.9 is set, the list of supported modes is completed with the values in the

completed is not the right word. 'is build using the values in the' ?

> + * PMA Extended Abilities (1.11) register, indicating 1000BASET an 10G related
> + * modes. If bit 1.11.14 is set, then the list is also completed with the modes

list is also extended with the modes

> + * in the 2.5G/5G PMA Extended register (1.21), indicating if 2.5GBASET and
> + * 5GBASET are supported.
> + */


Thanks
	Andrew
