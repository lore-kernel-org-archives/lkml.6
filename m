Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F671C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D2620859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="gtN74UDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfAIQpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:45:32 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43145 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfAIQpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:45:31 -0500
Received: by mail-yb1-f196.google.com with SMTP id t16so3230100ybk.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qFf8yCo9D/PFlaja0chJd/rcqL3FRMZX/0Opf/4J2Lw=;
        b=gtN74UDFfojJ7B/2MGsm3ij+p1PQ9Fx79gDg+7CVM/D0tIc6dTw66Ko7vQUxuG0U7i
         OCwb2I+NAUAv7WMqhpXZ2anHTMjmLWZ6uKc1QWqD1kGCFLf4Bp4GkvzEiGJlmesCCW4C
         LiPjprJA00X719SFFP2D5WOQGRCBx20wmUQqsoB+BtJmZpNtYaUifUudVkNHStzKnHQs
         FxJPYlivjfp6q9s/H7CzOXy/5JGyv1EHr5weIFz08/TbUAuJKcYZHIjQo2S/DHKXH/Wf
         3ufdFdgwOzIrc9a8KjMCkS3bjqHNHi+yLZ6CTcWIDxKutaiJRNhZ5yQUXvhBdKAnBhnP
         FPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFf8yCo9D/PFlaja0chJd/rcqL3FRMZX/0Opf/4J2Lw=;
        b=GI9aronHJ3E0m6i6F0VqcU7ArKAeJPdF/nyT8bBpHNyclK+q3qeOc9wT8Yj0/0bFW/
         hedgBj4J8GwX+eCDRHZVFUSyR5WZS5Beuwy+tKp4hdd954uKh6QTMRYMc4yCkC26qSJI
         YqDfF3pXsR8A+o1tjDzUE9m8xiF1kWmNWY1fagx+vkCUpCSVo5riKh7hZfNVEFff79/L
         l4zlOxER++HbOhh2WaQQc7Ncg///USunYoVHs1S7uJzPRIb6GWIhRHVAgFxuXaZ/uhpB
         U9GLZH3+dJLe0DyF64fxcwEnzXBpKoqi8NvWjmj02s0o5iqQLKuj/q4KQhhG72B7cmds
         DTyQ==
X-Gm-Message-State: AJcUukd7DDHkcCbrolgsclft2aWkl0j3PLLb4quT96brl0tiSrix085h
        nIgPxnwWTi2gpV7EKTCe3HacJA==
X-Google-Smtp-Source: ALg8bN5mlw7OjqF9ujWGwTpp1rdbh36a7wSSf27Agt4DYL+wQATILiMTlgIFVHFtxXv6K26BH9lTLA==
X-Received: by 2002:a25:238d:: with SMTP id j135mr6361139ybj.137.1547052330378;
        Wed, 09 Jan 2019 08:45:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:f15b])
        by smtp.gmail.com with ESMTPSA id u4sm33459221ywu.92.2019.01.09.08.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 08:45:29 -0800 (PST)
Date:   Wed, 9 Jan 2019 11:45:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, josef@toxicpanda.com, jack@suse.cz,
        hughd@google.com, darrick.wong@oracle.com, mhocko@suse.com,
        aryabinin@virtuozzo.com, guro@fb.com, mgorman@techsingularity.net,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] mm: Reduce IO by improving algorithm of memcg
 pagecache pages eviction
Message-ID: <20190109164528.GA13515@cmpxchg.org>
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 03:20:18PM +0300, Kirill Tkhai wrote:
> On nodes without memory overcommit, it's common a situation,
> when memcg exceeds its limit and pages from pagecache are
> shrinked on reclaim, while node has a lot of free memory.
> Further access to the pages requires real device IO, while
> IO causes time delays, worse powerusage, worse throughput
> for other users of the device, etc.
> 
> Cleancache is not a good solution for this problem, since
> it implies copying of page on every cleancache_put_page()
> and cleancache_get_page(). Also, it requires introduction
> of internal per-cleancache_ops data structures to manage
> cached pages and their inodes relationships, which again
> introduces overhead.
> 
> This patchset introduces another solution. It introduces
> a new scheme for evicting memcg pages:
> 
>   1)__remove_mapping() uncharges unmapped page memcg
>     and leaves page in pagecache on memcg reclaim;
> 
>   2)putback_lru_page() places page into root_mem_cgroup
>     list, since its memcg is NULL. Page may be evicted
>     on global reclaim (and this will be easily, as
>     page is not mapped, so shrinker will shrink it
>     with 100% probability of success);
> 
>   3)pagecache_get_page() charges page into memcg of
>     a task, which takes it first.
> 
> Below is small test, which shows profit of the patchset.
> 
> Create memcg with limit 20M (exact value does not matter much):
>   $ mkdir /sys/fs/cgroup/memory/ct
>   $ echo 20M > /sys/fs/cgroup/memory/ct/memory.limit_in_bytes
>   $ echo $$ > /sys/fs/cgroup/memory/ct/tasks
> 
> Then twice read 1GB file:
>   $ time cat file_1gb > /dev/null
> 
> Before (2 iterations):
>   1)0.01user 0.82system 0:11.16elapsed 7%CPU
>   2)0.01user 0.91system 0:11.16elapsed 8%CPU
> 
> After (2 iterations):
>   1)0.01user 0.57system 0:11.31elapsed 5%CPU
>   2)0.00user 0.28system 0:00.28elapsed 100%CPU
> 
> With the patch set applied, we have file pages are cached
> during the second read, so the result is 39 times faster.
> 
> This may be useful for slow disks, NFS, nodes without
> overcommit by memory, in case of two memcg access the same
> files, etc.

What you're implementing is work conservation: avoid causing IO work,
unless it's physically necessary, not when the memcg limit says so.

This is a great idea, but we already have that in the form of the
memory.low setting (or softlimit in cgroup v1).

Say you have a 100M system and two cgroups. Instead of setting the 20M
limit on group A as you did, you set 80M memory.low on group B. If B
is not using its share and there is no physical memory pressure, group
A can consume as much memory as it wants. If B starts and consumes its
80M, A will get pushed back to 20M. (And when B grows beyond 80M, they
compete fairly over the remaining 20M, just like they would if A had
the 20M limit setting).

At FB we use protection like this for most group allocations. ISTR
Google does too with a modified softlimit implementation in v1.

We do use hard limits for failsafes. I.e. "I don't care if we're not
using all available memory for this one workload, it's already 2x its
expected size, something is wrong with it anyway" -> apply reclaim
pressure and kill if necessary. So we actually do NOT want the work
conservation aspect in this case, because we don't want a likely buggy
workload to compete over memory with well-behaved jobs.
