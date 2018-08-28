Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC54DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7962087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7962087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeH1REJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:04:09 -0400
Received: from foss.arm.com ([217.140.101.70]:37696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbeH1REI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:04:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2627180D;
        Tue, 28 Aug 2018 06:12:32 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB0833F721;
        Tue, 28 Aug 2018 06:12:31 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 706B11AE31F5; Tue, 28 Aug 2018 14:12:43 +0100 (BST)
Date:   Tue, 28 Aug 2018 14:12:43 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 09/11] asm-generic/tlb: Track which levels of the
 page tables have been cleared
Message-ID: <20180828131243.GC26727@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-10-git-send-email-will.deacon@arm.com>
 <20180827075341.GY24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827075341.GY24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:53:41AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 24, 2018 at 04:52:44PM +0100, Will Deacon wrote:
> > +static inline unsigned long tlb_get_unmap_granule(struct mmu_gather *tlb)
> > +{
> > +	if (tlb->cleared_ptes)
> > +		return PAGE_SIZE;
> > +	if (tlb->cleared_pmds)
> > +		return PMD_SIZE;
> > +	if (tlb->cleared_puds)
> > +		return PUD_SIZE;
> > +	if (tlb->cleared_p4ds)
> > +		return P4D_SIZE;
> > +
> > +	return PAGE_SIZE;
> > +}
> 
> When doing the x86 patch; I found _SHIFT more useful than _SIZE.

I'll make that change for the next version.

Cheers,

Will
