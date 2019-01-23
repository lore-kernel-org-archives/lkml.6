Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE61C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110202184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2A9UpDow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfAWRDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:03:10 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:52977 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfAWRDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=LxNHDb/7n5KgvtEdcBRt6aCBSA4Nvtpr1xd79tz5q/U=;
        b=2A9UpDowZ7B+1f6fSZzUubV8AoP06mKfAQWX8zT2/vnegxqkFOiNEw82GTr95WD79EbSdrNskGjutcg1bK2I0zAGUVA3wb00QUBGqbf6WbusZxPjGuLoc+4jTtd32F4TywrJJBl0li3Qr8TqKiPI+pvEh3vI99ut5G9GlSVQOco=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gmLve-0002q9-4B; Wed, 23 Jan 2019 18:03:06 +0100
Date:   Wed, 23 Jan 2019 18:03:06 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, sd@queasysnail.net, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 02/10] net: macsec: convert to SPDX
Message-ID: <20190123170306.GG5310@lunn.ch>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-3-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123155638.13852-3-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 04:56:30PM +0100, Antoine Tenart wrote:
> This cosmetic patch converts the macsec implementation license header to
> the now recommended format, SPDX.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/macsec.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 64a982563d59..56e354305f76 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * drivers/net/macsec.c - MACsec device
>   *
>   * Copyright (c) 2015 Sabrina Dubroca <sd@queasysnail.net>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>   */
>  
>  #include <linux/types.h>

Hi Antoine

linux$ tail -4 drivers/net/macsec.c
MODULE_ALIAS_GENL_FAMILY("macsec");

MODULE_DESCRIPTION("MACsec IEEE 802.1AE");
MODULE_LICENSE("GPL v2");

The license text and the MODULE_LICENSE() don't agree with each other.
It would be good to fix this as well.

Thanks
	Andrew
