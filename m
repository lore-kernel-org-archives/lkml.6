Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91827C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4CE2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OL1Q6rTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4CE2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeKUHuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:50:50 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44938 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeKUHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:50:50 -0500
Received: by mail-vs1-f67.google.com with SMTP id g68so1973133vsd.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKk1mDC16JJ9caAL5YFzkAgYBMKvbRSypLiP/vbYkLA=;
        b=OL1Q6rTgv9msbpcka0MmUdZWBvAOleTNjyDcI8yrfz4VsKC8/swt13rTl6Fqw/UFqv
         ZwmQEq5d5x5sNA3FANcyMT3HOgu+XOM5QPHfBXelCJWaQ0vpb8zueR93Pox5CdN/5VOS
         c4pQM6GC3JV7CuHkfZMqxjvHmyBEwd5OHRwwgR0z03Va0WfFUlq+d8oght41omOMlQUE
         gyUkrWCRHEHgEz2dm5xKgD04IDbeqypJoJ/eqtDBEo50HMpIzgFt1NMKokjMAZx8qeNH
         kLRyRTfon6Kz8ONsmMR005Tg5aG1AOyl0/RdIh1b+Uq9sEI7awZJw4MAxEkPSqM/K5EM
         1QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKk1mDC16JJ9caAL5YFzkAgYBMKvbRSypLiP/vbYkLA=;
        b=CQ1ZZMOPwuyz2BXmUCbCH85dzs4BJojjvbn8i5BT98CrZWyBXjFiKkziE/6jfdW3c/
         DmRFy1LBxQV9XQvp+qBvAhNRB0+xrMAvqR9rHv6hIuwSrBOqp7K00qu4wVDhnW7cCQ5S
         en3i8YsXQK4k7MmqPx1u6T8CFaJjAy2N6XejYz3NAr0XBYu35aCxR2TabpQQwplcQgyB
         7IcbZc5Twf7O2AjFffzvdXGmGY1n8FVNG3xx9fTvPvOGcpT958HuDH2wTSpc255N/8Z5
         Jda35D4wtVe3EiMer05jZUwo4Fwy3bKt6su991Fa0DnjAuEkGj5x3D0veXCseDZYRtPK
         wadw==
X-Gm-Message-State: AGRZ1gLWiEz7rEJ+4ZRDzJUFD6kDX8Z4HlKbHHIKrP4X/LOGJqTR26RU
        KXQ5H3ZWcsYLerynHOpnC/EAAf7SF7zxhYpRKiw/JA==
X-Google-Smtp-Source: AJdET5fy59AvMtpYTJ5CS3LxMIU7O9v+MSLhIJ40v+aPJne9dxooOg0948/eJPrySaIewyeUncQBM8Om9Xg6+ND0g2s=
X-Received: by 2002:a67:2704:: with SMTP id n4mr1616332vsn.208.1542748780168;
 Tue, 20 Nov 2018 13:19:40 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com> <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com> <CAP045AoF7-3VBjhaij8JrVLuw+1dUxmLAGthPJm7CsTyY7T9nA@mail.gmail.com>
In-Reply-To: <CAP045AoF7-3VBjhaij8JrVLuw+1dUxmLAGthPJm7CsTyY7T9nA@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 20 Nov 2018 13:19:28 -0800
Message-ID: <CABPqkBR-rNO=y9HU+-5m0yhejYp=6xQ2impOZy9bBrY=gjFSyg@mail.gmail.com>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Kyle Huey <me@kylehuey.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, robert@ocallahan.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:53 PM Kyle Huey <me@kylehuey.com> wrote:
>
> On Tue, Nov 20, 2018 at 12:11 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > > > Given that we're already at rc3, and that this renders rr unusable,
> > > > > we'd ask that counter freezing be disabled for the 4.20 release.
> > > >
> > > > The boot option should be good enough for the release?
> > >
> > > I'm not entirely sure what you mean here. We want you to flip the
> > > default boot option so this feature is off for this release. i.e. rr
> > > should work by default on 4.20 and people should have to opt into the
> > > inaccurate behavior if they want faster PMI servicing.
> >
> > I don't think it's inaccurate, it's just different
> > than what you are used to.
> >
> > For profiling including the kernel it's actually far more accurate
> > because the count is stopped much earlier near the sampling
> > point. Otherwise there is a considerable over count into
> > the PMI handler.
> >
> > In your case you limit the count to ring 3 so it's always cut off
> > at the transition point into the kernel, while with freezing
> > it's at the overflow point.
>
> I suppose that's fair that it's better for some use cases. The flip
> side is that it's no longer possible to get exactly accurate counts
> from user space if you're using the PMI (because any events between
> the overflow itself and the transition to the PMI handler are
> permanently lost) which is catastrophically bad for us :)
>
Let me make sure I got this right. During recording, you count on
retired-cond-branch
and you record the value of the PMU counter at specific locations,
e.g., syscalls.
During replay, you program the branch-conditional-retired to overflow
on interrupt at
each recorded values. So if you sampled the event at 1,000,000 and
then at 1,500,000.
Then you program the event with a period of 1,000,000 first, on
overflow the counter interrupts
and you get a signal. Then, you reprogram the event for a new period
of 500,000.  During recording
and replay the event is limited to ring 3 (user level). Am I
understanding this right?
