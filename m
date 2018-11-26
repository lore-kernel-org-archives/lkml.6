Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CEDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A30D20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A30D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeKZT6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:58:31 -0500
Received: from foss.arm.com ([217.140.101.70]:56314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeKZT6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:58:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF3FD351D;
        Mon, 26 Nov 2018 01:05:03 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F4373F5A0;
        Mon, 26 Nov 2018 01:05:02 -0800 (PST)
Date:   Mon, 26 Nov 2018 09:04:48 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/atomics: build atomic headers as required
Message-ID: <20181126090448.5onnooknto67tzoa@salmiak>
References: <20181123153321.8561-1-mark.rutland@arm.com>
 <20181126084621.GL2113@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126084621.GL2113@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:46:21AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 23, 2018 at 03:33:21PM +0000, Mark Rutland wrote:
> > Andrew and Ingo report that the check-atomics.sh script is simply too
> > slow to run for every kernel build, and it's impractical to make it
> > faster without rewriting it in something other than shell.
> > 
> > Rather than committing the generated headers, let's regenerate these
> > as-required for a pristine tree.
> 
> Thing is, I '_never_' have a pristine tree. Now, I would also be in a
> position to know if something with the atomics changed, but that can't help
> other people that never use pristine trees.

Just to be clear, regardless of whether the tree is pristine, the headers will
be rebuilt iff their dependencies have changed. It's just that they
*definitely* have to be built for a pristine tree.

So perhaps I just need to clarify the commit message? Or do you envisage a
problem with that?

I've realised I missed the fallbacks and library script from the dependency
list, so I can also fix that for v2.
 
> Could we perhaps get an explicit 'genatomics' target or something to
> check/force-update this stuff?

If that's preferable, I can have a go.

Thanks,
Mark.
