Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544E0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544E0206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKSTGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:06:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:52550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbeKSTGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:06:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2291AE4D;
        Mon, 19 Nov 2018 08:43:24 +0000 (UTC)
Date:   Mon, 19 Nov 2018 09:43:22 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
In-Reply-To: <20181119083855.GA129733@gmail.com>
Message-ID: <nycvar.YFH.7.76.1811190941450.21108@cbobk.fhfr.pm>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com> <20181119083855.GA129733@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Ingo Molnar wrote:

> > This was marked for stable, and honestly, nowhere in the discussion
> > did I see any mention of just *how* bad the performance impact of this
> > was.
> 
> Yeah. This was an oversight - we'll fix it!
> 
> > When performance goes down by 50% on some loads, people need to start
> > asking themselves whether it was worth it. It's apparently better to
> > just disable SMT entirely, which is what security-conscious people do
> > anyway.
> > 
> > So why do that STIBP slow-down by default when the people who *really*
> > care already disabled SMT?
> > 
> > I think we should use the same logic as for L1TF: we default to
> > something that doesn't kill performance. Warn once about it, and let
> > the  crazy people say "I'd rather take a 50% performance hit than
> > worry about a theoretical issue".
> 
> Yeah, absolutely.
> 
> We'll also require performance measurements in changelogs enabling any 
> sort of mitigation feature from now on - this requirement was implicit 
> but 53c613fe6349 flew in under the radar, so it's going to be explicit an 
> explicit requirement.

Do you already have an idea whether you'd proceed with Tim's patchset for 
current cycle? If so, great as far as I am concerned. If not, I'll send a 
patch that switches this to opt-in via kernel cmdline (+boot-time warning 
if not mitigated).

Thanks,

-- 
Jiri Kosina
SUSE Labs

