Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EFEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F0D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F0D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeHaSbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:31:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45072 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbeHaSbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:31:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 44FC22072D; Fri, 31 Aug 2018 16:23:21 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1135E20794;
        Fri, 31 Aug 2018 16:23:11 +0200 (CEST)
Date:   Fri, 31 Aug 2018 16:23:10 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        davem@davemloft.net, kishon@ti.com, gregory.clement@bootlin.com,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 02/10] net: mvpp2: phylink support
Message-ID: <20180831142310.GC32574@kwain>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
 <20180831141851.GA19733@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831141851.GA19733@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Aug 31, 2018 at 04:18:51PM +0200, Andrew Lunn wrote:
> > @@ -4691,6 +4685,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
> >  	if (fwnode_property_read_bool(port_fwnode, "marvell,loopback"))
> >  		port->flags |= MVPP2_F_LOOPBACK;
> >  
> > +	if (fwnode_property_present(port_fwnode, "fixed-link"))
> > +		port->flags |= MVPP2_F_FIXED_LINK;
> > +
> 
> There is no need to go look in device tree. When phylink calls
> mac_config() it passes mode == MLO_AN_FIXED, when it is using a fixed
> link.

Sure. This was a proposal to have a workaround when phylink does not
call link_up(), so that we know which mode to pass to the function.

In the meantime Russell explained an assumption about the carrier link
state made by phylink, and a proposal to avoid doing this kind of hack
in the driver. I'll test his solution which will probably means we can
drop this piece of code.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
