Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C902CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE1C20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtAmxsdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfAPRj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:39:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35302 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfAPRj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:39:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2944938wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkHnhOOsLYZDGsqCGEnCW12gFbGohE4xp9i6QhoRkNQ=;
        b=NtAmxsdF4VzGKlpT0lmtbvYJiLYQMDar/xlqxYhw6D/UuTkJBzDMdyd/hiLxRfJO2Y
         284bfW00aWxNO3W84K1wxGC6FdOVJi3yht8vSyaV9LVwNt1yWJnscmHq3scQVZtP4Yuk
         NwdR8JXXdSFdSAmlvuSToZrQ/1bb8/noYvzuqfdtVX0xUUnPV6bQrcw9L3LKLovGVP+a
         uzrTmr2uyUgJHhZg3HRVoqkKn3znCcQjf4OTkB+imsQXGBrkBA+FnOyjvMOOQYf8jqSX
         D9JFbu4kXY2Fw56nyWXDxhFO9QXWJjEvtIXpBlx30XSDmtk+M8rtFEcrG+bEWE3SSi5R
         hSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkHnhOOsLYZDGsqCGEnCW12gFbGohE4xp9i6QhoRkNQ=;
        b=D4Zrul8ZbGQn0of1p2azVh3ZRoyJWqzFasa2Xets6S0b6yxoJpYfQ6gv0lan/f2NjN
         dK1HBUzbcVuyXBubMPFuRlANAowsLEs3PEwUzBix0q40pgJlBZBhpYXFKFffkPqGSY1W
         cjxaRm18k4FVaIRSp6b5biwBQkShwC4nkQbvO7toCLH5mzQgaX+s+w/kW0uJ2xY0YxNa
         o0dATtdiASyeYXLgRo05EccaB7/I8SwNLtHPnfKIPscFJogUzM4qLCeqB/qTsndjKrUE
         FLlixx/Le6HGeM071IrnQHAdVyDebsy/kT55K4iXoi2hgr0CqaNHFn7X/hUT3f7hCC5f
         D2lw==
X-Gm-Message-State: AJcUukcoL2Z+wFArS5ifgutjGJ+FXtfGd9KHY13YjJk77u0P6MLaQDrw
        ih1bSM6rDx5isHwzqM+L6ffGODnmryRejHbIfZemUA==
X-Google-Smtp-Source: ALg8bN6oK6ZMXC6QP6glapW5Kz8wmrchdwcnXsZIFNdiaWklrjvQy5e6RMf54NWRKDfot/WDFnQ5niSjQUdpmd9n5oE=
X-Received: by 2002:a7b:c951:: with SMTP id i17mr8931903wml.70.1547660365119;
 Wed, 16 Jan 2019 09:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20190110220718.261134-1-surenb@google.com> <20190110220718.261134-6-surenb@google.com>
 <20190114102137.GB14054@worktop.programming.kicks-ass.net>
 <CAJuCfpGUWs0E9oPUjPTNm=WhPJcE_DBjZCtCiaVu5WXabKRW6A@mail.gmail.com> <20190116132446.GF10803@hirez.programming.kicks-ass.net>
In-Reply-To: <20190116132446.GF10803@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 16 Jan 2019 09:39:13 -0800
Message-ID: <CAJuCfpEJW6Uq4GSGEGLKOM4K7ySHUeTGrSUGM1+EJSQ16d8SJg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] psi: introduce psi monitor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
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

On Wed, Jan 16, 2019 at 5:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 14, 2019 at 11:30:12AM -0800, Suren Baghdasaryan wrote:
> > For memory ordering (which Johannes also pointed out) the critical point is:
> >
> > times[cpu] += delta           | if g->polling:
> > smp_wmb()                     |   g->polling = polling = 0
> > cmpxchg(g->polling, 0, 1)     |   smp_rmb()
> >                               |   delta = times[*] (through goto SLOWPATH)
> >
> > So that hotpath writes to times[] then g->polling and slowpath reads
> > g->polling then times[]. cmpxchg() implies a full barrier, so we can
> > drop smp_wmb(). Something like this:
> >
> > times[cpu] += delta           | if g->polling:
> > cmpxchg(g->polling, 0, 1)     |   g->polling = polling = 0
> >                               |   smp_rmb()
> >                               |   delta = times[*] (through goto SLOWPATH)
> >
> > Would that address your concern about ordering?
>
> cmpxchg() implies smp_mb() before and after, so the smp_wmb() on the
> left column is superfluous.

Should I keep it in the comments to make it obvious and add a note
about implicit barriers being the reason we don't call smp_mb() in the
code explicitly?

> The right hand column is actively wrong; because that reads like it
> wants to order a store (g->polling = 0) and a load (d = times[]), and
> therefore requires smp_mb().

Just to clarify, smp_mb() is needed only in the comments or do you
want an explicit smp_mb() in the code as well? As Johannes noted
get_recent_times() which is part of "delta = times[*]" operation
involves read_seqcount section that should act as implicit memory
barrier in the slowpath.

> Also, you probably want to use atomic_t for g->polling, because we
> (sadly) have architectures where regular stores and atomic ops don't
> work 'right'.

Oh, I see. Will do. Thanks!

> --
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
