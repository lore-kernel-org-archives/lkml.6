Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE2AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1FA214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MsHMmbCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1FA214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbeISRKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:10:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbeISRKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VVw9pgPBgBl+mavNz0SBOIeEnR9NPXLuyN2WLtCgZAo=; b=MsHMmbCa72kDecCvQEkUZGr48
        lPOMCIN4Y1vXwMjNhRDt2QXDCwwB4MvN3Cd7pbfPzELJZ0jggGyqdbmNmzYbK4xpNQUFbEYO1w6Ns
        QyX9ABPnmRKAsHR1KLzFB83QyEf5mG4zovWn62Ch6xFb2hdtgge23ERznFKqFx6Bf35857H4Sw7w1
        yTjApBS/eaaORR+yCNtvrlGFocmiVjk/wv57hecqI8JfQaCaGpbGDGW+HB+EfIyx/en7li+Ud83Cv
        Ies8e77NpavCppYQVU4eIC6L8jKG/GswQnN2UZEWseQjPca9uJfBlCxRsIN0o/TFcZoKM/JPVDCeQ
        O1RvFi2kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2ajD-0001rD-8v; Wed, 19 Sep 2018 11:33:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 097962024E43D; Wed, 19 Sep 2018 13:33:06 +0200 (CEST)
Date:   Wed, 19 Sep 2018 13:33:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180919113305.GC24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
 <20180914164857.GG6236@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914164857.GG6236@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 05:48:57PM +0100, Will Deacon wrote:

> > + *  - tlb_change_page_size()
> 
> This doesn't seem to exist in my tree.
> [since realised you rename to it in the next patch]
> 

> > + * Additionally there are a few opt-in features:
> > + *
> > + *  HAVE_MMU_GATHER_PAGE_SIZE
> > + *
> > + *  This ensures we call tlb_flush() every time tlb_change_page_size() actually
> > + *  changes the size and provides mmu_gather::page_size to tlb_flush().
> 
> Ah, you add this later in the series. I think Nick reckoned we could get rid
> of this (the page_size field) eventually...

Right; let me fix that ordering..
