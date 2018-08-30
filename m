Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E06FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B229920835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q3WenpD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B229920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeH3R3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:29:18 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47593 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbeH3R3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ML4fuhsxj2llR4FVPXBnSh4bzZnv8yuxKIMTt10/+C0=;
        b=Q3WenpD+iVIbzcOgSgjstruTC9Mgqja91U/gomUAgMwVjgGqT3/smh7NkfWkSmEbascXdWGgZoxrw7LbGZpsUSKjRlTkqrLrKhfgB/PcuzZE+q/nhqgtTA/72xjPV+j+od2oMZq/6/Qo8gZga4zyFIlF1qWnI0NFcg+whnkYesw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvMyQ-0007ez-MY; Thu, 30 Aug 2018 15:26:58 +0200
Date:   Thu, 30 Aug 2018 15:26:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        olof@lixom.net, LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 00/15] soc: octeontx2: Add RVU admin function driver
Message-ID: <20180830132658.GA27566@lunn.ch>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1xC6XjwDAmocpE5TZO7j6uVGtvBtWLPVcYwKqN6Z+seQ@mail.gmail.com>
 <CA+sq2Cd3R0V5hcaF+ESfkOEBHgBwOB6b8Uwx7K+CeUN6gLFTOg@mail.gmail.com>
 <CA+sq2CfbpQKas7TbQfrcw=Drpb7yO_gqH31iXabjNEQEG4xYrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sq2CfbpQKas7TbQfrcw=Drpb7yO_gqH31iXabjNEQEG4xYrQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > My feeling overall is that we need a review from the network driver
> > > folks more than the arm-soc team etc, and that maybe the driver
> > > as a whole should go into drivers/net/ethernet.
> >
> > This driver doesn't handle any network IO and moreever this driver has to handle
> > configuration requests from crypto driver as well. There will be
> > separate network and
> > crypto drivers which will be upstreamed into drivers/net/ethernet and
> > drivers/crypto.
> > And in future silicons there will be different types of functional
> > blocks which will be
> > added into this resource virtualization unit (RVU). Hence i thought
> > this driver is not a
> > right fit in drivers/net/ethernet.

Hi Sunil

Do you have a git branch for everything? I would like to look at the
actual Ethernet driver, and the full API this driver exports to other
drivers.

I think there real question here is, do you have split between this
driver and the actual device drivers in the right place? For me, link
up/down detection should be in the Ethernet driver, since it is not
shared with the crypto driver.

       Thanks
	Andrew
