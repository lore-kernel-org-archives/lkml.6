Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5EFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1FC218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfAXPFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:05:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40691 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXPFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:05:50 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2076B207B2; Thu, 24 Jan 2019 16:05:48 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id C6DB12074E;
        Thu, 24 Jan 2019 16:05:47 +0100 (CET)
Date:   Thu, 24 Jan 2019 16:05:48 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Igor Russkikh <Igor.Russkikh@aquantia.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sd@queasysnail.net" <sd@queasysnail.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        "allan.nielsen@microchip.com" <allan.nielsen@microchip.com>
Subject: Re: [PATCH net-next 06/10] net: introduce a net_device_ops macsec
 helper
Message-ID: <20190124150548.GG3662@kwain>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-7-antoine.tenart@bootlin.com>
 <f9b58195-9345-ab13-87b2-2c261aa89b58@aquantia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9b58195-9345-ab13-87b2-2c261aa89b58@aquantia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Thu, Jan 24, 2019 at 02:58:45PM +0000, Igor Russkikh wrote:
> 
> Its great to see macsec hw offload infrastructure happening!
> 
> > @@ -1441,6 +1445,10 @@ struct net_device_ops {
> >  						u32 flags);
> >  	int			(*ndo_xsk_async_xmit)(struct net_device *dev,
> >  						      u32 queue_id);
> > +#ifdef CONFIG_MACSEC
> > +	int			(*ndo_macsec)(struct net_device *dev,
> > +					      struct netdev_macsec *macsec);
> > +#endif
> >  };
> 
> Most of ndo's are named by action verbs. This ndo is abit misleading, reader
> may have difficulties understanding what
> 
> +	if (phydev->drv->macsec)
> +		ret = phydev->drv->macsec(phydev, macsec);
> 
> is actually doing.
> 
> May be it'd be better renaming to at least ndo_do_macsec(), or ndo_setup_macsec()
> ?
> 
> Similar comment is for
> 
> +struct netdev_macsec {
> 
> It reads like a macsec device context, but it is a macsec configuration command.

OK, I'll rename the functions so that they contain a verb.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
