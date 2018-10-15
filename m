Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F38DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B1320881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQXwu4hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B1320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeJPCSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:18:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32806 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeJPCSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:18:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so22519031wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOnoWmUePpxemXMheY28Pu/lsa4HfUtce7Syl28Bmps=;
        b=sQXwu4hxZWZRocce+mlkZqEOSQYYSvE5z3ys7FQeFUOtLWPNLMyBaUfLUBHP0YyZS7
         ufUNhOvFfwZp4cxmMQdBB6I4/5moQScXfuwofRoSLhzUb35yZpKJjk13XrsdCAs5VZgM
         M/ZrKcNr//9whe7pWjRXVWvm3nsU1tSGwkv1AFfl+KL/MenpcrI6g0C/Bt4NpkZ1NHaF
         SBhQCpbigDoR2jNQ4hsnERd0cObBgKL2uJuvGNfXC5y7KwQNuK+6Ao4t/RqO81HHnMSo
         iYC62oMHBBIv/Y7omfw92DHhJYonyJYrpvoEEW/qnu79AJE1KKH0J9KL/GvCuoSGoWdJ
         q80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOnoWmUePpxemXMheY28Pu/lsa4HfUtce7Syl28Bmps=;
        b=XbZruaDiJsR8E7kZ9/HuCbfHOnOttWdtNElCSotfI0N3FvtDhyqX1D/vhoRTrY+fGl
         vNWQyqhc2eM6LO+RwKuLwPGIHGQfQLQBiyv+Vf1D5fipzk5qDqJCBWD+u6lt+ch25deS
         9/dSv15Se3huUISrx8PF6tZONEjzZT+ZQAujiL2o6JBtzg4LDYOGlCe6GmNS16uvb2ZM
         067ZCZOxtraHwUzNevUfjmmq94a9zKFMpnF5vnqYJhFeswzr6BVPqOc4lRvhTnGdpitf
         dcwNn1qK2kjKGGIkkHjVPAE5rFgIhCEEb0TUijaH96b/32pG295fnQKw8TdITKIiU7Cr
         GU7g==
X-Gm-Message-State: ABuFfohznSqnW3whGlxD6xDpumXIbOy9p1iyjUvDVOPucCCtJNYl85Ie
        sQuxgZSpaOgi5R73U5EX4IDGuFFEJoIIvZU+4YOTDA==
X-Google-Smtp-Source: ACcGV60gqjN7eZbPq8EONPPXZDoic7UQfVVbWfrIUXfPxaBxL2oqlc4TrU8k6zXq6NFCU+DTTDB/MTW64T3v5UwCjB0=
X-Received: by 2002:a5d:56cb:: with SMTP id m11-v6mr15007157wrw.58.1539628297345;
 Mon, 15 Oct 2018 11:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com> <20181015083448.GN9867@hirez.programming.kicks-ass.net>
 <a7cd88d6-a379-2d3b-7fde-e313328a3381@linux.intel.com>
In-Reply-To: <a7cd88d6-a379-2d3b-7fde-e313328a3381@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 15 Oct 2018 11:31:24 -0700
Message-ID: <CABPqkBQ48dM0bTFr_o3pSpAP8e_aH5gHeqXEdkPS0LY3bxBtLw@mail.gmail.com>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, songliubraving@fb.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, megha.dey@intel.com,
        frederic@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 15, 2018 at 10:29 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Hi,
> On 15.10.2018 11:34, Peter Zijlstra wrote:
> > On Mon, Oct 15, 2018 at 10:26:06AM +0300, Alexey Budankov wrote:
> >> Hi,
> >>
> >> On 10.10.2018 13:45, Peter Zijlstra wrote:
> >>> Hi all,
> >>>
> >>> There have been various issues and limitations with the way perf uses
> >>> (task) contexts to track events. Most notable is the single hardware PMU
> >>> task context, which has resulted in a number of yucky things (both
> >>> proposed and merged).
> >>>
> >>> Notably:
> >>>
> >>>  - HW breakpoint PMU
> >>>  - ARM big.little PMU
> >>>  - Intel Branch Monitoring PMU
> >>>
> >>> Since we now track the events in RB trees, we can 'simply' add a pmu
> >>> order to them and have them grouped that way, reducing to a single
> >>> context. Of course, reality never quite works out that simple, and below
> >>> ends up adding an intermediate data structure to bridge the context ->
> >>> pmu mapping.
> >>>
> >>> Something a little like:
> >>>
> >>>               ,------------------------[1:n]---------------------.
> >>>               V                                                  V
> >>>     perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
> >>>               ^                      ^     |                     |
> >>>               `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
> >>>
> >>> This patch builds (provided you disable CGROUP_PERF), boots and survives
> >>> perf-top without the machine catching fire.
> >>>
> >>> There's still a fair bit of loose ends (look for XXX), but I think this
> >>> is the direction we should be going.
> >>>
> >>> Comments?
> >>>
> >>> Not-Quite-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>> ---
> >>>  arch/powerpc/perf/core-book3s.c |    4
> >>>  arch/x86/events/core.c          |    4
> >>>  arch/x86/events/intel/core.c    |    6
> >>>  arch/x86/events/intel/ds.c      |    6
> >>>  arch/x86/events/intel/lbr.c     |   16
> >>>  arch/x86/events/perf_event.h    |    6
> >>>  include/linux/perf_event.h      |   80 +-
> >>>  include/linux/sched.h           |    2
> >>>  kernel/events/core.c            | 1412 ++++++++++++++++++++--------------------
> >>>  9 files changed, 815 insertions(+), 721 deletions(-)
> >>
> >> Rewrite is impressive however it doesn't result in code base reduction as it is.
> >
> > Yeah.. that seems to be nature of these things ..
> >
> >> Nonetheless there is a clear demand for per pmu events groups tracking and rotation
> >> in single cpu context (HW breakpoints, ARM big.little, Intel LBRs) and there is
> >> a supply thru groups ordering on RB-tree.
> >>
> >> This might be driven into the kernel by some new Perf features that would base on
> >> that RB-tree groups ordering or by refactoring of existing code but in the way it
> >> would result in overall code base reduction thus lowering support cost.
> >
> > If you have a concrete suggestion on how to reduce complexity? I tried,
> > but couldn't find any (without breaking something).
>
> Could some of those PMUs (HW breakpoints, ARM big.little, Intel LBRs)
> or other Perf related code be adjusted now so that overall subsystem
> code base would reduce?
>
I have always had a hard time understanding the role of all these structs in
the generic code. This is still very confusing and very hard to follow.

In my mind, you have per-task and per-cpu perf_events contexts.
And for each you can have multiple PMUs, some hw some sw.
Each PMU has its own list of events maintained in RB tree. There is
never any interactions between PMUs.

Maybe this is how this is done or proposed by your patches, but it
certainly is not
obvious.

Also the Intel LBR is not a PMU on is own. Maybe you are talking about
the BTS in
arch/x86/even/sintel/bts.c.


> >
> > The active lists and pmu_ctx_list could arguably be replaced with
> > (slower) iteratons over the RB tree, but you'll still need the per pmu
> > nr_events/nr_active counts to determine if rotation is required at all.
> >
> > And like you know, performance is quite important here too. I'd love to
> > reduce complexity while maintaining or improve performance, but that
> > rarely if ever happens :/
> >
