Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8EBC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D6C21479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="NsNngr9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D6C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeKUIGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:06:24 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44294 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKUIGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:06:24 -0500
Received: by mail-ua1-f68.google.com with SMTP id d19so1189521uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KRsRLm2++41GdQ5sZ2GzvmAHid+tTRCcHl3iqSl1Lc=;
        b=NsNngr9bPcsGPY2bsLhFtK6vTzwxj0KFCaFXY18IzMerdOALGJEFpHkagnKKWcCArC
         bzPvqOvrIW7L8mTYUs0D7bGxLNhQ+9jsRDzec2BuXpMaI0/K81HF7b9zTTZpWpkfEQvy
         mbT1Py61xcsXYhH+O3kX38UAl7Q4vszlUSGTSy1A8NhV0y2jONndaWAY9LHzHwIF6VXj
         TQy42gylgs6jSbeJHzSPimTZyzVyDsMwGuz6+AER2pFA/4OzFrt3ERUecinicIkPEPFX
         zgQ+A/KST6l/3WMgFoS3VFD/ekS94yqw0dxkwG2uR3X+U+Mj2HHczaQlYkCsojBVCBFk
         BAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KRsRLm2++41GdQ5sZ2GzvmAHid+tTRCcHl3iqSl1Lc=;
        b=M0aObvZMgasy5iJ6KZTPVqVpvjtIoIYli5aPDi18TdU6xf3MFsZdZmkaQ1u2XbGFhb
         TMs7eKx+3V5ju8UnzGMJgebEKkhu1EUYPE8gpnCtYh66/UoT1U2U1dlSGJNQlT9DaGHD
         0yloxzvk7720Hs3VD4Q3+YQ11YWQQQZ3rjiDV7927FA+WaMnRk+GQpBZZvfjKJN9kFUw
         Zgd+opt1ZNbxzvEXOF8Bpvh6U919nVGfp9c5v5+bx9YLucLg0YkhW/pVlE9BkPzEusGe
         /rwJXg4lj31lqKHB7orDg0yaEuAxvheZWUrQgk0q1itijKaTn7Ik8nWlEoOGIt48VEeW
         8Img==
X-Gm-Message-State: AA+aEWYBT/LTxF5knZF9CQLVhaNNMyZ8OynMAxGv+BWAhdr0E8ln4gpc
        s4I8i+8HgcsNnMlW0HQuqmAOjeuIwX0MBYfYGafqPQ==
X-Google-Smtp-Source: AFSGD/UGm9icJTGOFetW1uTLJ8H3ylUdsYISYTyQ/rjOgAtCFsvX1k48kPkYt8Y93pMaZFyNBDwJk/zf7S06W8MYYOs=
X-Received: by 2002:ab0:3392:: with SMTP id y18mr1718755uap.117.1542749710442;
 Tue, 20 Nov 2018 13:35:10 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com> <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com> <CAP045AoF7-3VBjhaij8JrVLuw+1dUxmLAGthPJm7CsTyY7T9nA@mail.gmail.com>
 <CABPqkBR-rNO=y9HU+-5m0yhejYp=6xQ2impOZy9bBrY=gjFSyg@mail.gmail.com>
In-Reply-To: <CABPqkBR-rNO=y9HU+-5m0yhejYp=6xQ2impOZy9bBrY=gjFSyg@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 20 Nov 2018 13:34:38 -0800
Message-ID: <CAP045ArtZkXHbjxjPJqS76zpthuCN5odwPxpzpVjgjSzMS1f5w@mail.gmail.com>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Stephane Eranian <eranian@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 1:19 PM Stephane Eranian <eranian@google.com> wrote:
>
> On Tue, Nov 20, 2018 at 12:53 PM Kyle Huey <me@kylehuey.com> wrote:
> >
> > On Tue, Nov 20, 2018 at 12:11 PM Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > > > > Given that we're already at rc3, and that this renders rr unusable,
> > > > > > we'd ask that counter freezing be disabled for the 4.20 release.
> > > > >
> > > > > The boot option should be good enough for the release?
> > > >
> > > > I'm not entirely sure what you mean here. We want you to flip the
> > > > default boot option so this feature is off for this release. i.e. rr
> > > > should work by default on 4.20 and people should have to opt into the
> > > > inaccurate behavior if they want faster PMI servicing.
> > >
> > > I don't think it's inaccurate, it's just different
> > > than what you are used to.
> > >
> > > For profiling including the kernel it's actually far more accurate
> > > because the count is stopped much earlier near the sampling
> > > point. Otherwise there is a considerable over count into
> > > the PMI handler.
> > >
> > > In your case you limit the count to ring 3 so it's always cut off
> > > at the transition point into the kernel, while with freezing
> > > it's at the overflow point.
> >
> > I suppose that's fair that it's better for some use cases. The flip
> > side is that it's no longer possible to get exactly accurate counts
> > from user space if you're using the PMI (because any events between
> > the overflow itself and the transition to the PMI handler are
> > permanently lost) which is catastrophically bad for us :)
> >
> Let me make sure I got this right. During recording, you count on
> retired-cond-branch
> and you record the value of the PMU counter at specific locations,
> e.g., syscalls.
> During replay, you program the branch-conditional-retired to overflow
> on interrupt at
> each recorded values. So if you sampled the event at 1,000,000 and
> then at 1,500,000.
> Then you program the event with a period of 1,000,000 first, on
> overflow the counter interrupts
> and you get a signal. Then, you reprogram the event for a new period
> of 500,000.  During recording
> and replay the event is limited to ring 3 (user level). Am I
> understanding this right?

This is largely correct, except that we only program the interrupt for
events that we would not naturally stop at during the course of
execution such as asynchronous signals or context switch points. At
events that we would naturally stop at (i.e. we can stop at syscalls
via ptrace) we simply check that the counters match to find any
discrepancies faster, before they affect an async signal delivery.
Let's say I have the following event sequence:

1. alarm syscall at rbc=1000
2. SIGALARM delivery at rbc=8000
3. exit syscall at rbc=9000

During replay, we begin the program and run to the syscall via a
PTRACE_SYSCALL ptrace. When the replayed process stops, we check that
the value of the rbc counter is 1000 (we also check that all registers
match what we recorded) and then we emulate the effects of the syscall
on the replayed process's registers and memory.

Then we see that the next event is an asynchronous signal, and we
program the rbc counter to interrupt after an additional (8000 - 1000
- SKID_SIZE) events (where SKID_SIZE has been chosen by
experimentation to ensure that the PMU interrupt is not delivered
*after* the point in the program we care about. For Skylake this value
is 100). We then resume the program with a PTRACE_CONT ptrace and wait
for the PMI to stop the replayed tracee. We advance the program to the
exact point that we care about through a combination of breakpoints
and singlestepping, and then deliver the SIGALARM.

Once that is done, we see that the next event is the exit syscall, and
we again do a PTRACE_SYSCALL ptrace to get to it. Once there we check
the rbc counter value and registers match what were recorded, and
perform the syscall.

Our counters are always restricted to ring 3 in both recording and replay.

- Kyle
