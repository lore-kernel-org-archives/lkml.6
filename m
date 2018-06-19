Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FC3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D5920652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sEUIEeBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D5920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966617AbeFSPPj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:15:39 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36563 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966451AbeFSPPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=KoEUxF1DFKBxcBrdCD2CER6UxaQD5/LK63bCe/Qxyj4=;
        b=sEUIEeBJ9S1qpMq68MpO+HAr87itCnhhaPlN/blIAZS+RFg13grkUa9ySiP99AYc3Yjb5rBX7cN1SIY+P8PxDhTnI/Pk/D84eJ4wtVCXmdlv7N6CJNiIhpcrL4k9/bXA+7o/ARSPX7TAzzkZjeBMwUG7ejTemRZePU+gzIRo90I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fVILe-00077q-QS; Tue, 19 Jun 2018 17:15:10 +0200
Date:   Tue, 19 Jun 2018 17:15:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Don Bollinger <don@thebollingers.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, brandon_chuang@edge-core.com,
        wally_wang@accton.com, roy_lee@edge-core.com,
        rick_burchett@edge-core.com, quentin.chang@quantatw.com,
        steven.noble@bigswitch.com, jeffrey.townsend@bigswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180619151510.GB26796@lunn.ch>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
 <20180612181109.GD12251@lunn.ch>
 <20180615022652.t6oqpnwwvdmbooab@thebollingers.org>
 <20180615075417.GA28730@lunn.ch>
 <20180618194127.uaeqlo3dy35qs3ip@thebollingers.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618194127.uaeqlo3dy35qs3ip@thebollingers.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you are using Linux as a boot loader, i doubt you will find any
> > network kernel developers who are willing to consider this driver. The
> 
> It isn't a boot loader.  It is the kernel that is running on the switch
> when it is doing its switch thing.  The kernel hosts the drivers and the
> switch SDK and all the apps that configure and manage the networking.

That is exactly using it as a boot loader. Linux network stack itself
has nothing to do with the switches. It just loads an application
which controls the switch from user space.

> This is real code, that fits a real need, and would like the
> benefits of being maintained as part of the mainline kernel.

Have you ever attended one of the netdev conferences?

https://www.netdevconf.org/2.1/submit-proposal.html

Netdev 2.1 is a community-driven conference geared towards Linux
netheads. Linux kernel networking and user space utilization of the
interfaces to the Linux kernel networking subsystem are the focus. If
you are using Linux as a boot system for proprietary networking, then
this conference _may not be for you_.

That gives you an idea of what the kernel community feels about this
sort of thing. Why should we help maintain code which brings no
benefit to the netdev community?

If you make use of the existing SFP code, extend it so it both
benefits the netdev kernel community and your own, then we might
consider merging your code. But optoe as it is brings no benefit to
the netdev community, so is unlikely to get merged.

    Andrew
