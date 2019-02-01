Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73006C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEC121872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfBAFCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:02:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfBAFCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:02:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A130880D;
        Thu, 31 Jan 2019 21:02:31 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E789E3F557;
        Thu, 31 Jan 2019 21:02:28 -0800 (PST)
Date:   Fri, 1 Feb 2019 05:02:21 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH V3 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190201050220.GA3022@brain-police>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
 <20190131123725.GB31516@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131123725.GB31516@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 01:37:25PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 30, 2019 at 06:23:42AM -0800, kan.liang@linux.intel.com wrote:
> > +enum perf_page_size {
> > +	PERF_PAGE_SIZE_NONE,
> > +	PERF_PAGE_SIZE_4K,
> > +	PERF_PAGE_SIZE_8K,
> > +	PERF_PAGE_SIZE_16K,
> > +	PERF_PAGE_SIZE_64K,
> > +	PERF_PAGE_SIZE_2M,
> > +	PERF_PAGE_SIZE_1G,
> > +	PERF_PAGE_SIZE_512G,
> > +};
> 
> Since you have a u64 to store this in, WTH do you use this limited enum?
> Are you very sure this covers all the possible page sizes for all
> architectures?

FWIW, this covers the basic page sizes on arm64, but it doesn't cover all of
the hugepage sizes.

Will
