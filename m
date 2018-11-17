Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7F0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 06:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFFA2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 06:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lx0kIfKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFFA2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeKQQof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 11:44:35 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38429 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbeKQQof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 11:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=6IdLC6oZvQNL+d4tXlKnZh5ENGWpyAoxcb0P1lNOGxg=;
        b=lx0kIfKFV8M2xOko/dcIRrv0bKv5snZhvNsIcN3iGd7KBiE+m9tw01B9DZek5zlgTMu40+cQJERQoZv8PT394fHVgav+PlkBmWLSRApa7Dlw1cjTQgiu3tpkXFAfEac060X9Lw8EbiFrCULGeVdDKxDUivPOWExPGJH2nRnaYWY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gNu65-0002WP-1U; Sat, 17 Nov 2018 07:28:49 +0100
Date:   Sat, 17 Nov 2018 07:28:49 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Miller <davem@davemloft.net>
Cc:     ms@dev.tdt.de, sergei.shtylyov@cogentembedded.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net: phy: mdio-gpio: Fix working over slow can_sleep
 GPIOs
Message-ID: <20181117062849.GA5004@lunn.ch>
References: <20181114061703.11026-1-ms@dev.tdt.de>
 <20181114115449.28332-1-ms@dev.tdt.de>
 <20181116.202547.692151883173974691.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116.202547.692151883173974691.davem@davemloft.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:25:47PM -0800, David Miller wrote:
> From: Martin Schiller <ms@dev.tdt.de>
> Date: Wed, 14 Nov 2018 12:54:49 +0100
> 
> > This commit re-enables support for slow GPIO pins. It was initially
> > introduced by commit 2d6c9091ab76 ("net: mdio-gpio: support access that
> > may sleep") and got lost by commit 7e5fbd1e0700 ("net: mdio-gpio:
> > Convert to use gpiod functions where possible").
> > 
> > Also add a warning about slow GPIO pins like it is done in i2c-gpio.
> > 
> > Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> 
> Applied, thanks.

Hi David

We were intending that v6 would get merged, and into net. I guess it
is too late now, but could you also add the v4 you merged into
net. You can find the fixes: tag in v6.

   Thanks
	Andrew



