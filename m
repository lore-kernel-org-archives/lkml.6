Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8D5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC3820874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYhj3bBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfAJTUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:20:14 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34369 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfAJTUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:20:12 -0500
Received: by mail-yw1-f65.google.com with SMTP id g75so4852941ywb.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/RiC2GtO9byIkMsVaaUkbqYI1Ft50zQDgpxIfbE+0k=;
        b=UYhj3bBg4xOKRWFncUKG0IUL+OsRuRiGBFWxKr2FmdmReLaXYbPoGGxXvJI7Nd6m6+
         iFowsmlv67/XLIhtEd+nmUZ8PgfxplsSiA9lRuqbmth4nD/dwvaS++HJNmFd/m6udM6w
         1SFQK1ES7jEHEmS0d0AfcWAVtvi0kssrjcZOvIc0BvtGgfoHswx0ERE38VlxpfhVhhOK
         CljDPVOY4sThGdJRyaKqzZJG4rKCIbGG69a9KoTcGpJJveIVpGPRkfE1jdOKp+NSpD+l
         Tway70LpLM1hbRJYNs3mAH09DfUpYRJiF9UpH8Lk1X4lRBXV8+yhBI+jN5uYFBH50Qhz
         JFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/RiC2GtO9byIkMsVaaUkbqYI1Ft50zQDgpxIfbE+0k=;
        b=aZhtA78+TTE5dPF4jYrCW7Wo1hinj2dWEkd3muzp/BdCD+5Rpac7cUJf7SRjSeqVTp
         MRGINNeBKirGxp/WGMxFnWXzMF2hI/S8jpk3ujwRGImbg3OjF3AnvlzR+n7/Gg9UNElH
         iZU/W2SzMcYfwrRC6yT2EKmpF1Wi3UIiXUbR12RltnxuCMnoI7WKyVkOEA876GQVxo/J
         Lkj58gfCv0KpSEMQRft/2PQdn4tH2TF6L+OIu+BCjbZi1qKqUKt0YTlF0HuiHvvYITaZ
         u2/OBnkC6rP/9ziWKWm7vr7UOixfgP4fe0SP7sirplkmvbwGA79pRIhlUeKUvdJezJKm
         HHJQ==
X-Gm-Message-State: AJcUukcTQPvjUIgz7zn4VwNh7B6ku8DACVPiCSUGxLy5W8vjKWrL9ZMM
        Cxx2jBlR17Jh5WCRRJaIVmcFnyUpY4ZeddKzDqP0UQ==
X-Google-Smtp-Source: ALg8bN7ggYVATESbolrfvITxljTH6xr5lhCa7qXwk/qZoJi1EJrrGQmndLhHVq7Nmwg15scow1ojxwkTQoLTucoiNX4=
X-Received: by 2002:a81:30d6:: with SMTP id w205mr11368287yww.27.1547148009842;
 Thu, 10 Jan 2019 11:20:09 -0800 (PST)
MIME-Version: 1.0
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
 <CALvZod63z5_m-izxFh4XQvjcALqffkZ5G91-KsyOuAC4wvN3Wg@mail.gmail.com> <a1dbe366-43bd-e3ee-6133-f6179b2f2278@virtuozzo.com>
In-Reply-To: <a1dbe366-43bd-e3ee-6133-f6179b2f2278@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 10 Jan 2019 11:19:58 -0800
Message-ID: <CALvZod62A+EpGF6UVGjBhuDfwPd2b7c0M9mR86jP-3GGGT1T6g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] mm: Reduce IO by improving algorithm of memcg
 pagecache pages eviction
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 1:46 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> Hi, Shakeel,
>
> On 09.01.2019 20:37, Shakeel Butt wrote:
> > Hi Kirill,
> >
> > On Wed, Jan 9, 2019 at 4:20 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On nodes without memory overcommit, it's common a situation,
> >> when memcg exceeds its limit and pages from pagecache are
> >> shrinked on reclaim, while node has a lot of free memory.
> >> Further access to the pages requires real device IO, while
> >> IO causes time delays, worse powerusage, worse throughput
> >> for other users of the device, etc.
> >>
> >> Cleancache is not a good solution for this problem, since
> >> it implies copying of page on every cleancache_put_page()
> >> and cleancache_get_page(). Also, it requires introduction
> >> of internal per-cleancache_ops data structures to manage
> >> cached pages and their inodes relationships, which again
> >> introduces overhead.
> >>
> >> This patchset introduces another solution. It introduces
> >> a new scheme for evicting memcg pages:
> >>
> >>   1)__remove_mapping() uncharges unmapped page memcg
> >>     and leaves page in pagecache on memcg reclaim;
> >>
> >>   2)putback_lru_page() places page into root_mem_cgroup
> >>     list, since its memcg is NULL. Page may be evicted
> >>     on global reclaim (and this will be easily, as
> >>     page is not mapped, so shrinker will shrink it
> >>     with 100% probability of success);
> >>
> >>   3)pagecache_get_page() charges page into memcg of
> >>     a task, which takes it first.
> >>
> >
> > From what I understand from the proposal, on memcg reclaim, the file
> > pages are uncharged but kept in the memory and if they are accessed
> > again (either through mmap or syscall), they will be charged again but
> > to the requesting memcg. Also it is assumed that the global reclaim of
> > such uncharged file pages is very fast and deterministic. Is that
> > right?
>
> Yes, this was my assumption. But Michal, Josef and Johannes pointed a diving
> into reclaim in general is not fast. So, maybe we need some more creativity
> here to minimize the effect of this diving..
>

I kind of disagree that this patchset is breaking the API semantics as
the charged memory of a memcg will never go over max/limit_in_bytes.
However the concern I have is the performance isolation. The
performance of a pagecache heavy job with a private mount can be
impacted by other jobs running on the system. This might be fine for
some customers but not for Google. One use-case I can tell is the
auto-tuner which adjusts the limits of the jobs based on their
performance and history. So, to make the auto-tuning deterministic we
have to disable the proposed optimization for the jobs with
auto-tuning enabled. Beside that there are internal non-auto-tuned
customers who prefer deterministic performance.

Also I am a bit skeptical that the allocation from the pool of such
(clean unmapped uncharged) file pages can be made as efficient as
fastpath of page allocator. Even if these pages are stored in a
separate list instead of root's LRU, on allocation, the pages need to
be unlinked from their mapping and has to be cleared.

BTW does this optimization have any impact on workingset mechanism?

thanks,
Shakeel
