Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E663BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EC420850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0y/IaifF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EC420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeGQPoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:44:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36892 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbeGQPoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=+vCQn6XqGramsLCovf049hKFwBp1oMGYGSv8/OAdBxY=;
        b=0y/IaifFhey6fFUNjNq4MCAcIdJP4YBc2q/VMr9MH8mpthKEqmxthqYeF5Ahxebu3XWNZwyuutaeo8KcgygD71Ds433z1Ire89E866T/m7y3QGpaArEop+5ezr21WMGZmsTFpizepLXJTj4yUQXRFQX/NTkPBORMXOMD/VA+r5g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ffRdd-0004sH-MF; Tue, 17 Jul 2018 17:11:41 +0200
Date:   Tue, 17 Jul 2018 17:11:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aleksey Makarov <aleksey.makarov@cavium.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Felix Manlunas <felix.manlunas@cavium.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: cavium: add missing PCI dependencies
Message-ID: <20180717151141.GC16320@lunn.ch>
References: <20180717134756.3447762-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717134756.3447762-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:46:34PM +0200, Arnd Bergmann wrote:
> While some of the cavium drivers don't require PCI support, most
> others do, as shown by these build failures:

Hi Arnd

FYI

There is a 0-day email about mdio-thunder.c also failing. It looks
like a missing PCI dependency as well, although i cannot find the
patch which removed the existing dependency.

       Andrew
