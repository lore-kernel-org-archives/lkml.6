Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60083C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C38A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2pDQgPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfANUsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:48:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37409 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfANUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:48:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so1029331wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwW1KirWJa3Otm0mdb+FxZ3AFbnGbcDi8Iugc6Rltwo=;
        b=A2pDQgPMfi8xEcPmWoQZ2vTIY4giMrEqTxyGbkzbS3KIpKn4Rzshn3bvn+6sjPR4v/
         z3eeTNO9KIL13+ffxR2gzEQ6VTGx2Qoefby8azX1xOvMmP1uqyVMPFpL5OBzd/aHEHiG
         gx/yvd/XHBODmMQ73oi3WtAGNEhSTdeQSF0uJWHEHIaqeThB2Vc1CMPdWBarjpe/2Op1
         FnIgnpfClFuK1z7GZIKdpc+2vIwVQrXeSYp4uL6yiI4/MRtFXHeyNuhQHreQFcK57G0f
         z1+JznRXHIrhESLyl/fpth4COZ/LcDv2W0XMR+hBn5T5ug+ZzV329WtQ4EHSmGk27xid
         r6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwW1KirWJa3Otm0mdb+FxZ3AFbnGbcDi8Iugc6Rltwo=;
        b=biISRygNjLsKUwmneZnJwv5TqpOj7LnB8lhI2/7x1HXaBOtluZ7TeQnbI2CtTge1Ky
         bpvPYJIEDl8v5X/PczhBEdc2sZ/dsXtt/S7UZwC037Af8zdn9hxp5graY3MIpRg973ii
         J0PImX6KFIS4FbfsM1jWtt7/wWpyzIlPPsSQtgVf8yIeyjcYCkGBg2nWL8hHc2w1k4F1
         Mu/jJ4BXSYESFRAPs4LzpqweOwgPbbd0/trhIFVq5h6AOAv5Tx06X1a8bPDdUZJ/Qf9o
         uzlmu+jFmhR4HqebCt/68bSSrIn1lYl+hqBjkki1QttXrXnAqyCRNC+Ui+JFufnV6sV1
         zpJw==
X-Gm-Message-State: AJcUukdfi2Jr3VUzSE/0wuiGR6vq4xo+IfCNbQvs8JD3V4gcdY7kff1e
        F6v8vNG1ETrK+RmA7XfdHo+hNGJfYBjkvY+PYeNxBQ==
X-Google-Smtp-Source: ALg8bN7iurn1V/oAb9TPOfzDB1cZrLk7Mb7Ob0iavv3WLprDDiWHghw3bxnNBUClL+Yo6cWdjUkw7edud95FQv0DClc=
X-Received: by 2002:a1c:e910:: with SMTP id q16mr717314wmc.68.1547498879880;
 Mon, 14 Jan 2019 12:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20190110220718.261134-1-surenb@google.com> <20190110220718.261134-6-surenb@google.com>
 <20190114102137.GB14054@worktop.programming.kicks-ass.net>
 <CAJuCfpGUWs0E9oPUjPTNm=WhPJcE_DBjZCtCiaVu5WXabKRW6A@mail.gmail.com> <20190114194222.GA10571@cmpxchg.org>
In-Reply-To: <20190114194222.GA10571@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 14 Jan 2019 12:47:48 -0800
Message-ID: <CAJuCfpF+eZFxCuB4QtQDOeDFYRg1LBiAKkF6QZxRk-FenkNu7w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] psi: introduce psi monitor
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Mon, Jan 14, 2019 at 11:42 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, Jan 14, 2019 at 11:30:12AM -0800, Suren Baghdasaryan wrote:
> > On Mon, Jan 14, 2019 at 2:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Jan 10, 2019 at 02:07:18PM -0800, Suren Baghdasaryan wrote:
> > > > +/*
> > > > + * psi_update_work represents slowpath accounting part while
> > > > + * psi_group_change represents hotpath part.
> > > > + * There are two potential races between these path:
> > > > + * 1. Changes to group->polling when slowpath checks for new stall, then
> > > > + *    hotpath records new stall and then slowpath resets group->polling
> > > > + *    flag. This leads to the exit from the polling mode while monitored
> > > > + *    states are still changing.
> > > > + * 2. Slowpath overwriting an immediate update scheduled from the hotpath
> > > > + *    with a regular update further in the future and missing the
> > > > + *    immediate update.
> > > > + * Both races are handled with a retry cycle in the slowpath:
> > > > + *
> > > > + *    HOTPATH:                         |    SLOWPATH:
> > > > + *                                     |
> > > > + * A) times[cpu] += delta              | E) delta = times[*]
> > > > + * B) start_poll = (delta[poll_mask] &&|    if delta[poll_mask]:
> > > > + *      cmpxchg(g->polling, 0, 1) == 0)| F)   polling_until = now +
> > > > + *                                     |              grace_period
> > > > + *                                     |    if now > polling_until:
> > > > + *    if start_poll:                   |      if g->polling:
> > > > + * C)   mod_delayed_work(1)            | G)     g->polling = polling = 0
> > > > + *    else if !delayed_work_pending(): | H)     goto SLOWPATH
> > > > + * D)   schedule_delayed_work(PSI_FREQ)|    else:
> > > > + *                                     |      if !g->polling:
> > > > + *                                     | I)     g->polling = polling = 1
> > > > + *                                     | J) if delta && first_pass:
> > > > + *                                     |      next_avg = calculate_averages()
> > > > + *                                     |      if polling:
> > > > + *                                     |        next_poll = poll_triggers()
> > > > + *                                     |    if (delta && first_pass) || polling:
> > > > + *                                     | K)   mod_delayed_work(
> > > > + *                                     |          min(next_avg, next_poll))
> > > > + *                                     |      if !polling:
> > > > + *                                     |        first_pass = false
> > > > + *                                     | L)     goto SLOWPATH
> > > > + *
> > > > + * Race #1 is represented by (EABGD) sequence in which case slowpath
> > > > + * deactivates polling mode because it misses new monitored stall and hotpath
> > > > + * doesn't activate it because at (B) g->polling is not yet reset by slowpath
> > > > + * in (G). This race is handled by the (H) retry, which in the race described
> > > > + * above results in the new sequence of (EABGDHEIK) that reactivates polling
> > > > + * mode.
> > > > + *
> > > > + * Race #2 is represented by polling==false && (JABCK) sequence which
> > > > + * overwrites immediate update scheduled at (C) with a later (next_avg) update
> > > > + * scheduled at (K). This race is handled by the (L) retry which results in the
> > > > + * new sequence of polling==false && (JABCKLEIK) that reactivates polling mode
> > > > + * and reschedules next polling update (next_poll).
> > > > + *
> > > > + * Note that retries can't result in an infinite loop because retry #1 happens
> > > > + * only during polling reactivation and retry #2 happens only on the first
> > > > + * pass. Constant reactivations are impossible because polling will stay active
> > > > + * for at least grace_period. Worst case scenario involves two retries (HEJKLE)
> > > > + */
> > >
> > > I'm having a fairly hard time with this. There's a distinct lack of
> > > memory ordering, and a suspicious mixing of atomic ops (cmpxchg) and
> > > regular loads and stores (without READ_ONCE/WRITE_ONCE even).
> > >
> > > Please clarify.
> >
> > Thanks for the feedback.
> > I do mix atomic and regular loads with g->polling only because the
> > slowpath is the only one that resets it back to 0, so
> > cmpxchg(g->polling, 1, 0) == 1 at (G) would always return 1.
> > Setting g->polling back to 1 at (I) indeed needs an atomic operation
> > but at that point it does not matter whether hotpath or slowpath sets
> > it. In either case we will schedule a polling update.
> > Am I missing anything?
> >
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
>
> delta = times[*] is get_recent_times(), which uses a seqcount and so
> implies the smp_rmb() already as well. So we shouldn't need another
> explicit one. But the comment should point out all the barriers.

Got it, thanks!
How about changing the comment this way:

   HOTPATH:                         |    SLOWPATH:
                                    |
A) times[cpu] += delta              | E) delta = times[*]
   smp_wmb()                        |    if delta[poll_mask]:
B) start_poll = (delta[poll_mask] &&| F)   polling_until = now + grace_period
     cmpxchg(g->polling, 0, 1) == 0)|    if now > polling_until:
   if start_poll:                   |      if g->polling:
C)   mod_delayed_work(1)            | G)     g->polling = polling = 0
   else if !delayed_work_pending(): |        smp_rmb()
D)   schedule_delayed_work(PSI_FREQ)| H)     goto SLOWPATH
                                    |    else:
                                    |      if !g->polling:
                                    | I)     g->polling = polling = 1
                                    | J) if delta && first_pass:
                                    |      next_avg = calculate_averages()
                                    |      if polling:
                                    |        next_poll = poll_triggers()
                                    |    if (delta && first_pass) || polling:
                                    | K)   mod_delayed_work(
                                    |          min(next_avg, next_poll))
                                    |      if !polling:
                                    |        first_pass = false
                                    | L)     goto SLOWPATH

And maybe adding a comment about implied memory barriers in cmpxchg()
and in seqlock.
Would that be enough?
