Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4DFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A242083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o0eizUaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A242083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeHaWDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:03:15 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49073 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHaWDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=/0pAA9oXbMnxjc1bM/1Os81m3y3AI1n3VvhpHkbplUI=;
        b=o0eizUaUGzLmmaDdWxiVlDH3v+ZjxFh4Z9ORZg9lSN7ihZJMWMwvWGhp7XWdJqPUCAvXtgs3hR4utWo3nlDTkLohD5GflKEhheCFvnIKh9hDtK2HnfWf18dzPKl55umoxOhnsSUVDWUKi7ls7qA2IxpYfrZqFQiMO61bZs/iYXQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvncp-0006wF-CL; Fri, 31 Aug 2018 19:54:27 +0200
Date:   Fri, 31 Aug 2018 19:54:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: linux-next: Tree for Aug 31 (nixge.c and phy)
Message-ID: <20180831175427.GC19733@lunn.ch>
References: <20180831130356.6b0fd971@canb.auug.org.au>
 <fe65a78f-51fb-248a-565a-f21594caa957@infradead.org>
 <CAJYdmeMYT_L841XsUOYYepen7WOSp-6zU40QbRy97G5GPzAygg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJYdmeMYT_L841XsUOYYepen7WOSp-6zU40QbRy97G5GPzAygg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -20,7 +20,6 @@ config NI_XGE_MANAGEMENT_ENET
>         tristate "National Instruments XGE management enet support"
>         depends on HAS_IOMEM && HAS_DMA
>         select PHYLIB
> -       select OF_MDIO
>         help
>           Simple LAN device for debug or management purposes. Can
>           support either 10G or 1G PHYs via SFP+ ports.

Hi Moritz

Since you are targeting both DT and non-DT systems, you cannot
unconditionally select OF_MDIO

What might work is

         select OF_MDIO if OF

	 Andrew
