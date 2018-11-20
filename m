Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462E8C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F3206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1F3206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeKUBt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:49:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:43698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbeKUBt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:49:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87200AF4D;
        Tue, 20 Nov 2018 15:20:17 +0000 (UTC)
Date:   Tue, 20 Nov 2018 16:20:16 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable@vger.kernel.org
Subject: Re: STIBP by default.. Revert?
In-Reply-To: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1811201616280.21108@cbobk.fhfr.pm>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018, Linus Torvalds wrote:

> This was marked for stable, and honestly, nowhere in the discussion
> did I see any mention of just *how* bad the performance impact of this
> was.
> 
> When performance goes down by 50% on some loads, people need to start
> asking themselves whether it was worth it. It's apparently better to
> just disable SMT entirely, which is what security-conscious people do
> anyway.
> 
> So why do that STIBP slow-down by default when the people who *really*
> care already disabled SMT?
> 
> I think we should use the same logic as for L1TF: we default to
> something that doesn't kill performance. Warn once about it, and let
> the  crazy people say "I'd rather take a 50% performance hit than
> worry about a theoretical issue".

Just to update status quo here -- Thomas is working on polishing Tim's set 
into mergeable state, I've just sent him small addition on top that makes 
IBPB also be controlled via the same toggle.

That should make the whole 'spectre v2 userspace-to-userspace' mitigation 
control consistent and undestandable. And also give us even few more % 
back that are lost due to IBPB as well.

-- 
Jiri Kosina
SUSE Labs

