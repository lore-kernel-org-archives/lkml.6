Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C251CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F90206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8OQnYnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfAIRol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:44:41 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34638 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfAIRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:44:41 -0500
Received: by mail-yw1-f67.google.com with SMTP id g75so3296438ywb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=favChGVhwPSbb8qcnD+cylPo0WpvRGC/2kNhSiLoKK8=;
        b=H8OQnYnDpT/QD8T010mYLe6weU82h+c6bUshO5RhL5vAF554uG6GZy8gWGa/3gfk3A
         nRuMdujfUO9i70TZ6N/RN/xV5IIAKoHUnw660UAZj+DX8C9BKGe6HkFU1WllF3x/wmm+
         swls2lbw927qvQwGYx0s29w7oefWC+1LSRZBy2JJj682ePp/b3mdRbG74WSZNF78WxAG
         6MlXRKuS44x6JrmgflIOiMtVd5XrUiq7sJRyvZx5fFj1GoRdpSP8LU6n6sJFrpBWmQO0
         KK7MYHv6ZAg5OTUACAhCRn76t1JjuTE3xrKeeOMGcHmrWHtejxUi3laCB6hSlFpoNgvL
         4xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=favChGVhwPSbb8qcnD+cylPo0WpvRGC/2kNhSiLoKK8=;
        b=Dp/1LXZj9v1e+/QA5fsY1rzO4n4nwTripDP1+24f4z1zHkAPHxpSjXRJ0h49qzgrhH
         EBaGn52JjynG5ED2t2+z1Lnxmmtm9Ih5OxwWGYTRYLlO7LyISuc9zAljrhWfVUQbknI3
         2PvDwdAPDHTiFNENegURy+CrbNge5ONB9z9lQYQ2rKFs8sUMZWF1yqZVxA8mT3D1FOLC
         MNqpw2JBZSPuq1/bgqeyEyOM2ACbar0bXfICDS7J3Sbst3QAA3WdCtyW5iVJOigSk6++
         nslJ/5g+06jfDXpNKklzTnam3XOSTWWXHWMJwf9jF2bcGgBuztAFvSwByy1dxwN17a3i
         jIWw==
X-Gm-Message-State: AJcUukemHwCtPe1OzToVFWmOepKuPblhZ2HxLJWgor/NG0sPUDg9PDzW
        2c+ubKvEAInus8YkrUvf/G3YKJ9CA4BBUeHUUcJWSw==
X-Google-Smtp-Source: ALg8bN6d/oyAgE1SsVMquCcmplKjV3fcMFFf2qQhTjrnsWOVChTiErE/N9s3RtyErKsK5O76BDVaLqahikxnhHqrQM8=
X-Received: by 2002:a0d:e4c5:: with SMTP id n188mr6537504ywe.349.1547055879675;
 Wed, 09 Jan 2019 09:44:39 -0800 (PST)
MIME-Version: 1.0
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
 <20190109164528.GA13515@cmpxchg.org>
In-Reply-To: <20190109164528.GA13515@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 9 Jan 2019 09:44:28 -0800
Message-ID: <CALvZod6P12gUq-xTZ1V4ZBeFXGE6dGAfA5uiw6iN1w14eP9j2Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] mm: Reduce IO by improving algorithm of memcg
 pagecache pages eviction
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        josef@toxicpanda.com, Jan Kara <jack@suse.cz>,
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

Hi Johannes,

On Wed, Jan 9, 2019 at 8:45 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Jan 09, 2019 at 03:20:18PM +0300, Kirill Tkhai wrote:
> > On nodes without memory overcommit, it's common a situation,
> > when memcg exceeds its limit and pages from pagecache are
> > shrinked on reclaim, while node has a lot of free memory.
> > Further access to the pages requires real device IO, while
> > IO causes time delays, worse powerusage, worse throughput
> > for other users of the device, etc.
> >
> > Cleancache is not a good solution for this problem, since
> > it implies copying of page on every cleancache_put_page()
> > and cleancache_get_page(). Also, it requires introduction
> > of internal per-cleancache_ops data structures to manage
> > cached pages and their inodes relationships, which again
> > introduces overhead.
> >
> > This patchset introduces another solution. It introduces
> > a new scheme for evicting memcg pages:
> >
> >   1)__remove_mapping() uncharges unmapped page memcg
> >     and leaves page in pagecache on memcg reclaim;
> >
> >   2)putback_lru_page() places page into root_mem_cgroup
> >     list, since its memcg is NULL. Page may be evicted
> >     on global reclaim (and this will be easily, as
> >     page is not mapped, so shrinker will shrink it
> >     with 100% probability of success);
> >
> >   3)pagecache_get_page() charges page into memcg of
> >     a task, which takes it first.
> >
> > Below is small test, which shows profit of the patchset.
> >
> > Create memcg with limit 20M (exact value does not matter much):
> >   $ mkdir /sys/fs/cgroup/memory/ct
> >   $ echo 20M > /sys/fs/cgroup/memory/ct/memory.limit_in_bytes
> >   $ echo $$ > /sys/fs/cgroup/memory/ct/tasks
> >
> > Then twice read 1GB file:
> >   $ time cat file_1gb > /dev/null
> >
> > Before (2 iterations):
> >   1)0.01user 0.82system 0:11.16elapsed 7%CPU
> >   2)0.01user 0.91system 0:11.16elapsed 8%CPU
> >
> > After (2 iterations):
> >   1)0.01user 0.57system 0:11.31elapsed 5%CPU
> >   2)0.00user 0.28system 0:00.28elapsed 100%CPU
> >
> > With the patch set applied, we have file pages are cached
> > during the second read, so the result is 39 times faster.
> >
> > This may be useful for slow disks, NFS, nodes without
> > overcommit by memory, in case of two memcg access the same
> > files, etc.
>
> What you're implementing is work conservation: avoid causing IO work,
> unless it's physically necessary, not when the memcg limit says so.
>
> This is a great idea, but we already have that in the form of the
> memory.low setting (or softlimit in cgroup v1).
>
> Say you have a 100M system and two cgroups. Instead of setting the 20M
> limit on group A as you did, you set 80M memory.low on group B. If B
> is not using its share and there is no physical memory pressure, group
> A can consume as much memory as it wants. If B starts and consumes its
> 80M, A will get pushed back to 20M. (And when B grows beyond 80M, they
> compete fairly over the remaining 20M, just like they would if A had
> the 20M limit setting).

There is one difference between the example you give and the proposal.
In your example when B starts and consumes its 80M and pushes back A
to 20M, the direct reclaim can be very expensive and
non-deterministic. While in the proposal, the B's direct reclaim will
be very fast and deterministic (assuming no overcommit on hard limits)
as it will always first reclaim unmapped clean pages which were
charged to A.

thanks,
Shakeel
