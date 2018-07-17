Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6F1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D57F20841
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PE/Y9TQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D57F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeGQQbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:31:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37050 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbeGQQbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mOAgqbLFGnrWIEIIynuEZE0ppaOJYUZkO0eG/7yd4wo=;
        b=PE/Y9TQqa37POP+79e10fmOBwsyYt8218ZFwmATBzW25ESQY8ncmgZJQUiqBzfFWR30bdLf7kPrRYh5BljZfVUDnpvuymams8ywKwOn9ysv2Km1Ii0nzEHW4q6GOsctNJEBiMVYnqGPfNaRoZtSM9B0E/0T2ADMGd1tBpISeq4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ffSME-0005gH-OK; Tue, 17 Jul 2018 17:57:46 +0200
Date:   Tue, 17 Jul 2018 17:57:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Aleksey Makarov <aleksey.makarov@cavium.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Felix Manlunas <felix.manlunas@cavium.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: cavium: add missing PCI dependencies
Message-ID: <20180717155746.GF968@lunn.ch>
References: <20180717134756.3447762-1-arnd@arndb.de>
 <20180717151141.GC16320@lunn.ch>
 <c7d6a57c-e12c-d2e0-d650-4741dbaf3ae8@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d6a57c-e12c-d2e0-d650-4741dbaf3ae8@nokia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 05:38:59PM +0200, Alexander Sverdlin wrote:
> Hello Andrew,
> 
> On 17/07/18 17:11, Andrew Lunn wrote:
> > FYI
> > 
> > There is a 0-day email about mdio-thunder.c also failing. It looks
> > like a missing PCI dependency as well, although i cannot find the
> > patch which removed the existing dependency.
> 
> there were no such patch, some Ethernet driver not depending on PCI
> forcefully selected MDIO_THUNDER. So this is only a side effect of the
> first error.

Ah, O.K. Thanks for the explanation.

       Andrew
