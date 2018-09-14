Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A95DECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536C9206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0/DKPm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536C9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeINSQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:16:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RFpv9F2SmIWvJGv2NrwrXdm2+blXCInEbXjfYJPDXFQ=; b=s0/DKPm+o4PHRk67o5PRGF2on
        +88NynYwyhlEZWDbNdZXRgHzEuJqkMYXDjUnTtnT0va1FtohpqdVsUYLqh3oTqxFXmmKj3GE2qqvd
        l0emoiMHMJWxc5Q2B48a0bTUOO9T9wV85YmLZngSreVwbYs0q9c+owminjdiHDUkYeG5mRgBcpkT9
        0ZZoi2jNEsMlfqHpL1wB1P+MUGDmvL2QIUwnQaVoOvnFrhJIbNJaD79T+rZeFFiGdedCG9YeaZA+p
        DlSFh+gtcW7HIDtVfUi1/Otng/hmbooUfjR4t9NESaUCH9/l8tCmEZstr3Cv2qMCGX9TMWeMbOKIv
        CA8oifZZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0njd-0001cP-6z; Fri, 14 Sep 2018 13:02:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D617202C1A09; Fri, 14 Sep 2018 15:02:07 +0200 (CEST)
Date:   Fri, 14 Sep 2018 15:02:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180914130207.GD24106@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
 <20180913123014.0d9321b8@mschwideX1>
 <20180913105738.GW24124@hirez.programming.kicks-ass.net>
 <20180913141827.1776985e@mschwideX1>
 <20180913123937.GX24124@hirez.programming.kicks-ass.net>
 <20180914122824.181d9778@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914122824.181d9778@mschwideX1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 12:28:24PM +0200, Martin Schwidefsky wrote:

> I spent some time to get s390 converted to the common mmu_gather code.
> There is one thing I would like to request, namely the ability to
> disable the page gather part of mmu_gather. For my prototype patch
> see below, it defines the negative HAVE_RCU_NO_GATHER_PAGES Kconfig
> symbol that if defined will remove some parts from common code.
> Ugly but good enough for the prototype to convey the idea.
> For the final solution we better use a positive Kconfig symbol and
> add that to all arch Kconfig files except for s390.

In a private thread ealier Linus raised the point that the batching and
freeing of lots of pages at once is probably better for I$.

> +config HAVE_RCU_NO_GATHER_PAGES
> +	bool

I have a problem with the name more than anything else; this name
suggests it is the RCU table freeing that should not batch, which is not
the case, you want the regular page gather gone, but very much require
the RCU table gather to batch.

So I would like to propose calling it:

config HAVE_MMU_GATHER_NO_GATHER

Or something along those lines.

