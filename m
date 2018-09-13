Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E31C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E1A20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JvYDEY/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E1A20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeIMQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:06:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55884 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=58pngwe/Y8svAz545CEisaXl6sbjbE0b75SZatOv5RQ=; b=JvYDEY/UtSjR6PIRgxMYZ/2to
        JyL4G2C+daw+P0mb9+ShFWt1k24UFN7mHkHuCaK5WVTEQFggiCqjtI04qFrDzwCaD9wtqb4E2tLZQ
        wC5yDPh0GQMGgkdzrDZOXWoB1ur7ZlutL8CXbic5kgsm/Kfny1AOux2lGqgsF/+eLg2rGryoTIZig
        Py+XQFP4o2oCzwnO4O/3MuRBrJZudNhE6OIXceReYgQ1DXqwOLP5hwww2xSFXfsq5nLo93SEv5Npn
        /9UyEB6QBnpqGtb90RBjWu21oiv/dnm9W10xAd+jMkb4m3qtE4wabivaK4Jx/i02wDKi9dxDIGI6n
        A8m/oaE3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0PJd-0001se-7J; Thu, 13 Sep 2018 10:57:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44516202C1A2D; Thu, 13 Sep 2018 12:57:38 +0200 (CEST)
Date:   Thu, 13 Sep 2018 12:57:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180913105738.GW24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
 <20180913123014.0d9321b8@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913123014.0d9321b8@mschwideX1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:30:14PM +0200, Martin Schwidefsky wrote:

> > + * The mmu_gather data structure is used by the mm code to implement the
> > + * correct and efficient ordering of freeing pages and TLB invalidations.
> > + *
> > + * This correct ordering is:
> > + *
> > + *  1) unhook page
> > + *  2) TLB invalidate page
> > + *  3) free page
> > + *
> > + * That is, we must never free a page before we have ensured there are no live
> > + * translations left to it. Otherwise it might be possible to observe (or
> > + * worse, change) the page content after it has been reused.
> > + *
> 
> This first comment already includes the reason why s390 is probably better off
> with its own mmu-gather implementation. It depends on the situation if we have
> 
> 1) unhook the page and do a TLB flush at the same time
> 2) free page
> 
> or
> 
> 1) unhook page
> 2) free page
> 3) final TLB flush of the whole mm

that's the fullmm case, right?

> A variant of the second order we had in the past is to do the mm TLB flush first,
> then the unhooks and frees of the individual pages. The are some tricky corners
> switching between the two variants, see finish_arch_post_lock_switch.
> 
> The point is: we *never* have the order 1) unhook, 2) TLB invalidate, 3) free.
> If there is concurrency due to a multi-threaded application we have to do the
> unhook of the page-table entry and the TLB flush with a single instruction.

You can still get the thing you want if for !fullmm you have a no-op
tlb_flush() implementation, assuming your arch page-table frobbing thing
has the required TLB flush in.

Note that that's not utterly unlike how the PowerPC/Sparc hash things
work, they clear and invalidate entries different from others and don't
use the mmu_gather tlb-flush.


