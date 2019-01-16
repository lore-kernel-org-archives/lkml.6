Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB6DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD9C20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8HwzKf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfAPV3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:29:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44440 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbfAPV3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:29:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so8618488wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJrfE3jaolNs6YKqdZtpYFmOvcf18H8OhY7pa4kzWEY=;
        b=j8HwzKf4QtGnl55VhWxxU62RJz2zdHqwwXdAJtf4r17Cb5i4Z9PTr3LYowNmAp7bfs
         +ORL7QKVLtsnXsxfog2gfV4zCd8b0Lp/hBynHbSFCWHpsjhb+gUzSAD4s6BHH/fRV6pB
         Y8RKIyku/qvSySJPfI4lQbUHofvTuiB69SAxZnEm2/M1qYVOb6tzofxI8DeoSsxlVo+u
         nZ82jRaDZ+i/eUXJAlQsvkLtbuNxntHHswTgQKdk/B7zvICxLyY6D2dBF/Yx3CINZzCc
         r7EEDIuZ1ahCWCcTqQtXrHreZMO0rz9tVS/ldkSGVBMgfPl+UDSbYYc4Q+A3wO26h8wa
         jfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJrfE3jaolNs6YKqdZtpYFmOvcf18H8OhY7pa4kzWEY=;
        b=kr17ToiJIO19SbIzOJqafrIfesz/n0PYafaBchTIZmpJDl+wEEIadnm8nBxj5cPc3T
         Y4pYzesjr6aUzCyfWt0YaWtC5C4AX93qXTRjDNqqq2+tg5o39ne2u1DPdxz9WYmmVSC7
         pua8iKnSTDh4iEbI6dDjIEkvHIlTOfacH5wgyDDq0QbZEntP2uPWTiS2Ee2XMffFKDhE
         NDm4POoelOV/abdIYxWV9IUfvJWl+JB3yZMBO8U1bBya4a4TBNR1PInuJ68wwSlCloj0
         AiNJYCZuIBy2qjWMGGS9A4ghUi2Bw6WVSIBTESOZRLF480GDBKfPEbETiadBky4iae9y
         sbhQ==
X-Gm-Message-State: AJcUukdmMcUgf7BMotSsq6KNooBJ1Fe53kqI52RfEU3Gpm5WtipgO6fA
        d5M22WZEwVBJ4LiTg2GYAbA3OGa8UIJyK/qJkbrCPg==
X-Google-Smtp-Source: ALg8bN41+hamEJqjA/ErW04qKhyfcdryU7d5AEi8xni3wtZ/EgC/cnBgZaQBeIjpdJCyR0mVUw9KZOn/xGVSOsdGr5g=
X-Received: by 2002:adf:de91:: with SMTP id w17mr9843729wrl.320.1547674175412;
 Wed, 16 Jan 2019 13:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20190110220718.261134-1-surenb@google.com> <20190110220718.261134-6-surenb@google.com>
 <20190114102137.GB14054@worktop.programming.kicks-ass.net>
 <CAJuCfpGUWs0E9oPUjPTNm=WhPJcE_DBjZCtCiaVu5WXabKRW6A@mail.gmail.com>
 <20190116132446.GF10803@hirez.programming.kicks-ass.net> <CAJuCfpEJW6Uq4GSGEGLKOM4K7ySHUeTGrSUGM1+EJSQ16d8SJg@mail.gmail.com>
 <20190116191728.GA1380@cmpxchg.org> <20190116192744.GA1576@cmpxchg.org>
In-Reply-To: <20190116192744.GA1576@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 16 Jan 2019 13:29:24 -0800
Message-ID: <CAJuCfpG1+=XXS=7oTaBw_J9cGvmheTDrr3jv8UxBThwa4K+Dmw@mail.gmail.com>
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

On Wed, Jan 16, 2019 at 11:27 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Jan 16, 2019 at 02:17:28PM -0500, Johannes Weiner wrote:
> > On Wed, Jan 16, 2019 at 09:39:13AM -0800, Suren Baghdasaryan wrote:
> > > On Wed, Jan 16, 2019 at 5:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Mon, Jan 14, 2019 at 11:30:12AM -0800, Suren Baghdasaryan wrote:
> > > > > For memory ordering (which Johannes also pointed out) the critical point is:
> > > > >
> > > > > times[cpu] += delta           | if g->polling:
> > > > > smp_wmb()                     |   g->polling = polling = 0
> > > > > cmpxchg(g->polling, 0, 1)     |   smp_rmb()
> > > > >                               |   delta = times[*] (through goto SLOWPATH)
> > > > >
> > > > > So that hotpath writes to times[] then g->polling and slowpath reads
> > > > > g->polling then times[]. cmpxchg() implies a full barrier, so we can
> > > > > drop smp_wmb(). Something like this:
> > > > >
> > > > > times[cpu] += delta           | if g->polling:
> > > > > cmpxchg(g->polling, 0, 1)     |   g->polling = polling = 0
> > > > >                               |   smp_rmb()
> > > > >                               |   delta = times[*] (through goto SLOWPATH)
> > > > >
> > > > > Would that address your concern about ordering?
> > > >
> > > > cmpxchg() implies smp_mb() before and after, so the smp_wmb() on the
> > > > left column is superfluous.
> > >
> > > Should I keep it in the comments to make it obvious and add a note
> > > about implicit barriers being the reason we don't call smp_mb() in the
> > > code explicitly?
> >
> > I'd keep 'em out if they aren't actually in the code. But I'd switch
> >
> >       delta = times[*]
> >
> > in this comment to to
> >
> >       get_recent_times() // implies smp_mb()
>
> Actually, I might have been mistaken about this. The seqcount locking
> does an smp_rmb() and an smp_wmb(), and that orders reads and writes
> respectively, but doesn't necessarily order reads against writes.
>
> So I think we need an explicit smp_mb() after all.

I see. So, the action items I collected so far:

1. Add a comment in the code next to cmpxchg() indicating implicit smp_mb.
2. Add explicit smp_mb after "g->polling = 0" and before "delta =
times[*]" both in the code and in the comments (in the slowpath).
3. Use atomic_t for g->polling. Add a note in the comments why atomic
operations are not needed in the slowpath.
4. Minimize line-breaks.

Please let me know if I missed anything, otherwise will make these
changes and post ver 3 of the patchset.
Thanks,
Suren.
