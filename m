Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A00C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3832121871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXQfdXZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeLRU3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:29:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50829 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeLRU3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:29:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so3969172wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 12:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqDF5UhWnQFdjY5+ifQ42/eAuC7wfEF19ZVzDTAfbT8=;
        b=ZXQfdXZpJZ1VR/Ywx6+z8PawKuPd29vPvHE5LyZcscdpijjsm5jiaNxfZCJ7p95iob
         i/+Z7fReQZlj9q/6IBlYYYyJcUBsaFFkpOD2EQXFE4bMP3qoQLzLABrS1JdIiPLcPZWj
         diGdpzt3/2wdtx1KnHEE2D/vOeu2HIzQaE4HkI7WRXs92QWqtTY9KjJ9amVCzXmkp3Q8
         7tMAa9g83AhbBHv09A1228AcDPA+JdMiaPN+/YGLkyYn2RvrtqsxakZGPL1ek6MTG71q
         /x3w1F3XBvgIVLYtVPI+xiZIYROS49oVTnqX6a3xMrGsARHQWe+ZvM2jOwaQoUWIufcs
         A+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqDF5UhWnQFdjY5+ifQ42/eAuC7wfEF19ZVzDTAfbT8=;
        b=X4QZOKHHiWdTnMoy27Xow5+EWlNKeWvX+2V5UC2C5wsUyjYbpRuEvV7K8tVVOpenVy
         0oOS0OYJy8FvA6Ex11WuAJCsecBXl1MBfmxOmu64QRp7fGLvbIBND+w2aCBp+p95ovf7
         OenVWUa/11mFrQlgp8BVo1Kb3FbHVQRbXyoYb5n1wIq+N4kEtc715gBHdkckzb/qrhKD
         FTBup8XjahFQQEhsuraOWMYa0QcFQMj3GWhoX3dOwPeNuSXikczBZ9P2akSIndB998It
         FQO+EBe+Wda/INwoVgg/N8NWu7NVEV5Mzb8OE10y/htXpL7mY/U02P0/P4oQJx7oqGhW
         QM1Q==
X-Gm-Message-State: AA+aEWZavwDkN56pQKGnonwyjOIE0nrLDfGPr3WZTRtBhFpNU2JGparZ
        GyZKmah5YLrff/90w866TBQCj7fUvfC+3TMpYjeqqQ==
X-Google-Smtp-Source: AFSGD/XU2AMKRuir4bcKdcBKwmi1CAP5SxKrbGpWgH2ysn59VBnjxoU0B2BvuuxqEozXCA+EZNDsTZu+5mG8jUFDRtU=
X-Received: by 2002:a1c:70b:: with SMTP id 11mr4750314wmh.74.1545164974736;
 Tue, 18 Dec 2018 12:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20181214171508.7791-1-surenb@google.com> <20181214171508.7791-7-surenb@google.com>
 <20181217162223.GD2218@hirez.programming.kicks-ass.net> <CAJuCfpHGsDnE-eAHY1QnX949stA3cvNA=078q1swqVnz95aJfg@mail.gmail.com>
 <20181218104622.GB15430@hirez.programming.kicks-ass.net> <20181218173000.GA4733@cmpxchg.org>
 <CAJuCfpGQKQ9oVKdVeLNQHY2+2XTjLXb6VHDcJKAUCtSxvd68wQ@mail.gmail.com> <CAJWu+oor7SzQVgo7SDKFcJS-BX+Oexj2_x_uWGsC8W=ErNGoNw@mail.gmail.com>
In-Reply-To: <CAJWu+oor7SzQVgo7SDKFcJS-BX+Oexj2_x_uWGsC8W=ErNGoNw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 Dec 2018 12:29:23 -0800
Message-ID: <CAJuCfpEc3jbnd39cV5hx_DQjmBcvu8aBhcgJW5VP0oddOYYctA@mail.gmail.com>
Subject: Re: [PATCH 6/6] psi: introduce psi monitor
To:     Joel Fernandes <joelaf@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:18 AM Joel Fernandes <joelaf@google.com> wrote:
>
> On Tue, Dec 18, 2018 at 9:58 AM 'Suren Baghdasaryan' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > Current design supports only whole percentages and if userspace needs
> > more granularity then it has to use usecs.
> > I agree that usecs cover % usecase and "threshold * win / 100" is
> > simple enough for userspace to calculate. I'm fine with changing to
> > usecs only.
>
> Suren, please avoid top-posting to LKML.

Sorry, did that by accident.

> Also I was going to say the same thing, just usecs only is better.

Thanks for the input.

> thanks,
>
>  - Joel


> > On Tue, Dec 18, 2018 at 9:30 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Tue, Dec 18, 2018 at 11:46:22AM +0100, Peter Zijlstra wrote:
> > > > On Mon, Dec 17, 2018 at 05:21:05PM -0800, Suren Baghdasaryan wrote:
> > > > > On Mon, Dec 17, 2018 at 8:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > > > How well has this thing been fuzzed? Custom string parser, yay!
> > > > >
> > > > > Honestly, not much. Normal cases and some obvious corner cases. Will
> > > > > check if I can use some fuzzer to get more coverage or will write a
> > > > > script.
> > > > > I'm not thrilled about writing a custom parser, so if there is a
> > > > > better way to handle this please advise.
> > > >
> > > > The grammar seems fairly simple, something like:
> > > >
> > > >   some-full = "some" | "full" ;
> > > >   threshold-abs = integer ;
> > > >   threshold-pct = integer, { "%" } ;
> > > >   threshold = threshold-abs | threshold-pct ;
> > > >   window = integer ;
> > > >   trigger = some-full, space, threshold, space, window ;
> > > >
> > > > And that could even be expressed as two scanf formats:
> > > >
> > > >  "%4s %u%% %u" , "%4s %u %u"
> > > >
> > > > which then gets your something like:
> > > >
> > > >   char type[5];
> > > >
> > > >   if (sscanf(input, "%4s %u%% %u", &type, &pct, &window) == 3) {
> > > >       // do pct thing
> > > >   } else if (sscanf(intput, "%4s %u %u", &type, &thres, &window) == 3) {
> > > >       // do abs thing
> > > >   } else return -EFAIL;
> > > >
> > > >   if (!strcmp(type, "some")) {
> > > >       // some
> > > >   } else if (!strcmp(type, "full")) {
> > > >       // full
> > > >   } else return -EFAIL;
> > > >
> > > >   // do more
> > >
> > > We might want to drop the percentage notation.
> > >
> > > While it's somewhat convenient, it's also not unreasonable to ask
> > > userspace to do a simple "threshold * win / 100" themselves, and it
> > > would simplify the interface spec and the parser.
> > >
> > > Sure, psi outputs percentages, but only for fixed window sizes, so
> > > that actually saves us something, whereas this parser here needs to
> > > take a fractional anyway. The output is also in decimal notation,
> > > which is necessary for granularity. And I really don't think we want
> > > to add float parsing on top of this interface spec.
> > >
> > > So neither the convenience nor the symmetry argument are very
> > > compelling IMO. It might be better to just not go there.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kernel-team" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
