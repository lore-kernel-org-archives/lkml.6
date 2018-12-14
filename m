Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2C7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04450206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbeLNQJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:09:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34158 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeLNQJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:09:46 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0F9ED208E3; Fri, 14 Dec 2018 17:09:44 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id D42BD20726;
        Fri, 14 Dec 2018 17:09:43 +0100 (CET)
Date:   Fri, 14 Dec 2018 17:09:44 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH net v2] net: mvpp2: 10G modes aren't supported on all
 ports
Message-ID: <20181214160944.GE20364@kwain>
References: <20181214093451.26314-1-antoine.tenart@bootlin.com>
 <20181214160249.GD26090@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214160249.GD26090@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Fri, Dec 14, 2018 at 04:02:50PM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 14, 2018 at 10:34:51AM +0100, Antoine Tenart wrote:
> > The mvpp2_phylink_validate() function sets all modes that are
> > supported by a given PPv2 port. A recent change made all ports to
> > advertise they support 10G modes in certain cases. This is not true,
> > as only the port #0 can do so. This patch fixes it.
> > 
> > Fixes: 01b3fd5ac97c ("net: mvpp2: fix detection of 10G SFP modules")
> > Cc: Baruch Siach <baruch@tkos.co.il>
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> 
> Looking at net-next, I think there's more to be fixed here:
> 
>         case PHY_INTERFACE_MODE_RGMII:
>         case PHY_INTERFACE_MODE_RGMII_ID:
>         case PHY_INTERFACE_MODE_RGMII_RXID:
>         case PHY_INTERFACE_MODE_RGMII_TXID:
>         case PHY_INTERFACE_MODE_SGMII:
> ...
> 		phylink_set(mask, 10000baseT_Full);
> 
> Is that really true?

Good catch. Will you send a fix or do you want me to do it?

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
