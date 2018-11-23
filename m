Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D65C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA1020866
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA1020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440747AbeKXD4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:56:15 -0500
Received: from foss.arm.com ([217.140.101.70]:49364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbeKXD4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:56:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0C336BA;
        Fri, 23 Nov 2018 09:11:09 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 956CC3F5CF;
        Fri, 23 Nov 2018 09:11:06 -0800 (PST)
Date:   Fri, 23 Nov 2018 17:11:04 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] proc: add /proc/<pid>/arch_state
Message-ID: <20181123171102.GI3505@e103592.cambridge.arm.com>
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
 <1542236407-4323-2-git-send-email-aubrey.li@intel.com>
 <20181119173904.GC2131@hirez.programming.kicks-ass.net>
 <c62acf67-2529-15b1-5325-e0265b0f613d@linux.intel.com>
 <20181121081936.GH2131@hirez.programming.kicks-ass.net>
 <20181121095350.GC2149@hirez.programming.kicks-ass.net>
 <7098dd35-3d7b-57c9-c450-10eee577c199@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7098dd35-3d7b-57c9-c450-10eee577c199@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:40:24AM +0800, Li, Aubrey wrote:
> On 2018/11/21 17:53, Peter Zijlstra wrote:
> > On Wed, Nov 21, 2018 at 09:19:36AM +0100, Peter Zijlstra wrote:
> >> On Wed, Nov 21, 2018 at 09:39:00AM +0800, Li, Aubrey wrote:
> >>>> Also; you were going to shop around with the other architectures to see
> >>>> what they want/need for this interface. I see nothing on that.
> >>>>
> >>> I'm open for your suggestion, :)
> >>
> >> Well, we have linux-arch and the various maintainers are also listed in
> >> MAINTAINERS. Go forth and ask..
> > 
> > Ok, so I googled a wee bit (you could have too).
> > 
> > There's not that many architectures that build big hot chips
> > (powerpc,x86,arm64,s390) (mips, sparc64 and ia64 are pretty dead I
> > think, although the Fujitsu Sparc M10 X+/X SIMD looked like it could be
> > 'fun').
> > 
> > Of those, powerpc altivec doesn't seem to be very wide, but you'd have
> > to ask the power folks. Same for s390 z13.
> > 
> > The Fujitsu/ARM64-SVE stuff looks like it can be big and hot.
> > 
> > And RISC-V has was vector extention, but I don't think anybody is
> > actually building big hot versions of that just yet.
> > 
> Thanks Peter. Add more maintainers here.
> 
> On some x86 architectures, the tasks using simd instruction(AVX512 particularly)
> need to be dealt with specially against the tasks not using simd instruction.
> I proposed an interface to expose such CPU specific information for the user
> space tools to apply different scheduling policies.
> 
> The interface can be refined to be the format as /proc/<pid>/status. Not sure
> if it's useful to any other architectures.
> 
> Welcome any comments.

For SVE:

We currently monitor SVE use by trapping only.  We also made an ABI
decision that a syscall throws away the task's SVE state -- this
falls out naturally from the fact that the SVE state is caller-save
for regular function calls in the AArch64 ABI.

There isn't an explicit means like VZEROUPPER for userspace to
mark the SVE state as non-live without entering the kernel today.

Currently I expose as little detail to userspace as possible regarding
how/when SVE is enabled/disabled or used.


For the /proc interface:

It would be nice to expose some information to userspace about when/
where major hardware functional units are in use, but beyond the
information already supplied by hardware perf events, it's not
obvious what should be exposed.

AFAICT, the exposed flags would be partly an arbitrary artifact of
kernel implementation details: i.e., how often and when the kernel
saves/restores the task's state may affect the pattern of observed
values in non-trivial ways.

For SVE today, a task that does a lot of syscalls may appear to be using
SVE less than a second task that does fewer syscalls but is otherwise
identical -- simply because a syscall is our only way to detect that
SVE is not in use today.


This kind of issue means that userspace may struggle to make good
decisions using this data: instead it's going to rely on some kind of
tuning which may become wrong as soon as the workload, kernel version
or hardware changes.


A /proc/<pid>/file would need to be polled (which doesn't sound great)
and also suffers from all the usual /proc raciness.

Cheers
---Dave
