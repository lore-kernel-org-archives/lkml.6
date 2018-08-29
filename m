Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B26C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172512084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4HQHDrPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172512084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeH2RSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:18:14 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46369 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeH2RSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=18hZpkjHOV+IbrkOrsBkhEpW77H6vfm45VtjKrN9xA0=;
        b=4HQHDrPkU7DZxR1KqYIEFKQS4HtTWBXKzj6WBhqnWz4+b903G0ZqqDHPGsaxzsFDIpJ75KxC4lIDix1IrbZFfGgGR7JytvdUvct83JSSGXF7XxCO9z2wYu5U+RMAWmSr7ULgsJFtN2VbImkT8O2P8Dh+BvAyL2acmrAX9jE8j+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fv0PH-00011Y-GJ; Wed, 29 Aug 2018 15:21:11 +0200
Date:   Wed, 29 Aug 2018 15:21:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Joe Perches <joe@perches.com>
Cc:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        netdev@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ioana.ciornei@nxp.com,
        laurentiu.tudor@nxp.com, madalin.bucur@nxp.com,
        horia.geanta@nxp.com
Subject: Re: [PATCH net-next v2 2/2] dpaa2-eth: Move DPAA2 Ethernet driver
 from staging to drivers/net
Message-ID: <20180829132111.GF1955@lunn.ch>
References: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
 <20180829094240.27242-3-ruxandra.radulescu@nxp.com>
 <7dbd5426426315977a8dc7e1745d3addce3d16b5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dbd5426426315977a8dc7e1745d3addce3d16b5.camel@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:50:02AM -0700, Joe Perches wrote:
> On Wed, 2018-08-29 at 04:42 -0500, Ioana Radulescu wrote:
> > The DPAA2 Ethernet driver supports Freescale/NXP SoCs with DPAA2
> > (DataPath Acceleration Architecture v2). The driver manages
> > network objects discovered on the fsl-mc bus.
> 
> Please use git 'format-patch -M' to make the diff
> smaller and more readable.

Hi Joe

I asked for this.

This is a request to move the driver from staging into the main
tree. We want to review the code in order to see if it has reached
mainline quality.

If the patch just lists a rename, not actually code, i cannot review
it, so i will just NACK it. We need to see the code.

Once the code has been reviewed and has all the needed Acked-by:, then
-M could be used. But this driver is not that far yet.

Thanks

    Andrew


