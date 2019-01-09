Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E60C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1E8214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="F/wD4vVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfAITU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:20:28 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38782 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfAITUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:20:25 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so3408075ywb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 11:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ilive7NefpVC1VWPNqwFVolhOX0K0LLXWeWrYUDdMbI=;
        b=F/wD4vVGta1uCVZ7S8Lmj0fBLxt6/MV8CsGHLQYKH07YimjV/pz4d33pfiEtKcM9kZ
         bud7UY3X+tXOysjHiBEzoSskwPm8l8l+MQS3ExGdHZqM5WJAxbHUc45OJX2P2JljK9XN
         6IgeiPvhgh3dzJ7oCGPZbzwcIsM7lfWDaXlve8PvfHUnLim61azg3SbazaSiShJgfvoG
         db6NmktiiIgi0QEcZqYtSo8MwcM9B0NqFDoGkdGRaS4xZL41xnQAYCN4Ns5XVwaa/JWL
         HB6hGrQ6bbfPyU4PreCgQDvA2xcH5vz810WfyTIE/AVN/qCsaNJDgDd/Xgdfbv5CzglS
         45+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ilive7NefpVC1VWPNqwFVolhOX0K0LLXWeWrYUDdMbI=;
        b=qA/fqudaG9Ukm6CdEKgAw4oR71RQv2KX+xnVQLOMNI8xvEeWJz+UrWW+I/yjvHZayu
         tpZTbhlTw/kPSQPlgmYPSfPGVcEYVm944vgd2LVaGsafPIx6PMRXjnlxUGIyrWoxEqEE
         Ef3bYfQavZaLVQACR62hWY5mJKY5PHnlEcqNb8kTf5wXxsilskEZe8iWPKjT+V+pbcQ2
         geh49cqjikIDRcijVhZdj+siCHSzPEoLYZjJzJkL8Qw39fIc6pYqipeit6LDjwhZPo3i
         r8CRWZBRJxvXq9lgROlxTzfLyDW10lOsiym3+44rj9dTeO78gemADiMBZ0TWDVIYoGyW
         AcJA==
X-Gm-Message-State: AJcUukfQU1r+sRptulXW6zPcPwnoLwmWZs8bgue6rGePI3H2+OZiwOl0
        8O7ay+B3tLPkhn110QJBjv5LyQ==
X-Google-Smtp-Source: ALg8bN748Gdixbk+nCAiqt1FAkx4JKxNmDSh/h4WYK7NSpg58lobtm7zi/nSUM+60DHM1ZMSlfuuKQ==
X-Received: by 2002:a81:b649:: with SMTP id h9mr7058742ywk.57.1547061624461;
        Wed, 09 Jan 2019 11:20:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:f15b])
        by smtp.gmail.com with ESMTPSA id y187sm24924800ywf.50.2019.01.09.11.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 11:20:23 -0800 (PST)
Date:   Wed, 9 Jan 2019 14:20:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
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
Subject: Re: [PATCH RFC 0/3] mm: Reduce IO by improving algorithm of memcg
 pagecache pages eviction
Message-ID: <20190109192022.GA16027@cmpxchg.org>
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
 <20190109164528.GA13515@cmpxchg.org>
 <CALvZod6P12gUq-xTZ1V4ZBeFXGE6dGAfA5uiw6iN1w14eP9j2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6P12gUq-xTZ1V4ZBeFXGE6dGAfA5uiw6iN1w14eP9j2Q@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 09:44:28AM -0800, Shakeel Butt wrote:
> Hi Johannes,
> 
> On Wed, Jan 9, 2019 at 8:45 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Jan 09, 2019 at 03:20:18PM +0300, Kirill Tkhai wrote:
> > > On nodes without memory overcommit, it's common a situation,
> > > when memcg exceeds its limit and pages from pagecache are
> > > shrinked on reclaim, while node has a lot of free memory.
> > > Further access to the pages requires real device IO, while
> > > IO causes time delays, worse powerusage, worse throughput
> > > for other users of the device, etc.
> > >
> > > Cleancache is not a good solution for this problem, since
> > > it implies copying of page on every cleancache_put_page()
> > > and cleancache_get_page(). Also, it requires introduction
> > > of internal per-cleancache_ops data structures to manage
> > > cached pages and their inodes relationships, which again
> > > introduces overhead.
> > >
> > > This patchset introduces another solution. It introduces
> > > a new scheme for evicting memcg pages:
> > >
> > >   1)__remove_mapping() uncharges unmapped page memcg
> > >     and leaves page in pagecache on memcg reclaim;
> > >
> > >   2)putback_lru_page() places page into root_mem_cgroup
> > >     list, since its memcg is NULL. Page may be evicted
> > >     on global reclaim (and this will be easily, as
> > >     page is not mapped, so shrinker will shrink it
> > >     with 100% probability of success);
> > >
> > >   3)pagecache_get_page() charges page into memcg of
> > >     a task, which takes it first.
> > >
> > > Below is small test, which shows profit of the patchset.
> > >
> > > Create memcg with limit 20M (exact value does not matter much):
> > >   $ mkdir /sys/fs/cgroup/memory/ct
> > >   $ echo 20M > /sys/fs/cgroup/memory/ct/memory.limit_in_bytes
> > >   $ echo $$ > /sys/fs/cgroup/memory/ct/tasks
> > >
> > > Then twice read 1GB file:
> > >   $ time cat file_1gb > /dev/null
> > >
> > > Before (2 iterations):
> > >   1)0.01user 0.82system 0:11.16elapsed 7%CPU
> > >   2)0.01user 0.91system 0:11.16elapsed 8%CPU
> > >
> > > After (2 iterations):
> > >   1)0.01user 0.57system 0:11.31elapsed 5%CPU
> > >   2)0.00user 0.28system 0:00.28elapsed 100%CPU
> > >
> > > With the patch set applied, we have file pages are cached
> > > during the second read, so the result is 39 times faster.
> > >
> > > This may be useful for slow disks, NFS, nodes without
> > > overcommit by memory, in case of two memcg access the same
> > > files, etc.
> >
> > What you're implementing is work conservation: avoid causing IO work,
> > unless it's physically necessary, not when the memcg limit says so.
> >
> > This is a great idea, but we already have that in the form of the
> > memory.low setting (or softlimit in cgroup v1).
> >
> > Say you have a 100M system and two cgroups. Instead of setting the 20M
> > limit on group A as you did, you set 80M memory.low on group B. If B
> > is not using its share and there is no physical memory pressure, group
> > A can consume as much memory as it wants. If B starts and consumes its
> > 80M, A will get pushed back to 20M. (And when B grows beyond 80M, they
> > compete fairly over the remaining 20M, just like they would if A had
> > the 20M limit setting).
> 
> There is one difference between the example you give and the proposal.
> In your example when B starts and consumes its 80M and pushes back A
> to 20M, the direct reclaim can be very expensive and
> non-deterministic. While in the proposal, the B's direct reclaim will
> be very fast and deterministic (assuming no overcommit on hard limits)
> as it will always first reclaim unmapped clean pages which were
> charged to A.

That struck me more as a side-effect of the implementation having to
unmap the pages to be able to change their page->mem_cgroup.

But regardless, we cannot fundamentally change the memory isolation
semantics of the hard limit like these patches propose, so it's a moot
point. A scheme to prepare likely reclaim candidates in advance for a
low-latency workload startup would have to come in a different form.
