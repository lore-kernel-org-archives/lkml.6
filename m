Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B44C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E522146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfBTOrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:47:13 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59130 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfBTOrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:47:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17BBB15AB;
        Wed, 20 Feb 2019 06:47:10 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2751B3F5C1;
        Wed, 20 Feb 2019 06:47:08 -0800 (PST)
Date:   Wed, 20 Feb 2019 14:47:05 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com, riel@surriel.com, tony.luck@intel.com
Subject: Re: [PATCH v6 06/18] asm-generic/tlb: Conditionally provide
 tlb_migrate_finish()
Message-ID: <20190220144705.GH7523@fuggles.cambridge.arm.com>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.207580251@infradead.org>
 <20190219124738.GD8501@fuggles.cambridge.arm.com>
 <20190219134147.GZ32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219134147.GZ32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 02:41:47PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 19, 2019 at 12:47:38PM +0000, Will Deacon wrote:
> > Fine for now, but I agree that we should drop the hook altogether. AFAICT,
> > this only exists to help an ia64 optimisation which looks suspicious to
> > me since it uses:
> > 
> >     mm == current->active_mm && atomic_read(&mm->mm_users) == 1
> > 
> > to identify a "single-threaded fork()" and therefore perform only local TLB
> > invalidation. Even if this was the right thing to do, it's not clear to me
> > that tlb_migrate_finish() is called on the right CPU anyway.
> > 
> > So I'd be keen to remove this hook before it spreads, but in the meantime:
> 
> Agreed :-)
> 
> The obvious slash and kill patch ... untested

I'm also unable to test this, unfortunately. Can we get it into next after
the merge window and see if anybody reports issues?

Will
