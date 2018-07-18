Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEDFECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E6A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="YUDJIxse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E6A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeGRQQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:16:13 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44716 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbeGRQQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:16:12 -0400
Received: by mail-ua0-f194.google.com with SMTP id k25-v6so3194429uao.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GLOsjN8uNrpfP+QBEl9HZf+rMY9k/d825pLbIvoBw9g=;
        b=YUDJIxse7kGOHryqt7PsBHeGGr+iKtjenk2Ifl7Fe+2kY4YLQMiT/tJnnxbsdn903v
         qA1+0y6H40Kq7Rtrhig5tz7lpu/2ZfJL/ojzdItPAnZtpstJSG+lkH4hm1flMDtmqqYY
         JoaeXfhgIk6pvd6OOr1/9SIHx6OkK/cj3JmzX76q0OEs94sA3wNWjjkHMgCLDjpN2Pgo
         wVxqD0n7R5YsPJs7TpgHaXBMnuWTlEst3Y4IcHP/mfqp6vQX2kt0OHwnmpzVzrlOIVM9
         oB5t5VYTy2dxOSXlW3Cw1ktMKlQsLHFYzjvijcyll1Y4ITwv6P60qldoL6ltCvYzQmCB
         Ub2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GLOsjN8uNrpfP+QBEl9HZf+rMY9k/d825pLbIvoBw9g=;
        b=YVKk1ntV78Hnr8mohbr9+dL5zwxvOX6XZzBlYgf4z8rqPhIwkuqU0ZeFas9mcb/Y94
         TMbbOukJY3VqJbF6edKFtdiJDZuYBDsLQfKyJDLh8Z8Kc8a9z706RrgBYN1BUm9x+Z+W
         O3quj+W28mihLwkhp7jAAlukqujQxtuJJU0WPzDnx+R97wfG7xyQ4vwEUzIiOwJjO4bQ
         z6A4YkXaHFSZLdUbBd4v1s+bAhA3wgiYPdwl1OqooLE0EutLRVG2KFM+/fPYgvZ/Wh2F
         6uD/nM3XxZ86U9vTvMvDtYDBrizPk8jhXvHeD9qSYa/qMxE8UAGAcK33apklVjnp3bcq
         aNDw==
X-Gm-Message-State: AOUpUlH98G7tEJmQxcp861ZXkCwirbf52S1Gh5iHn5dT3oYoQ8LQiHoo
        dudYMqhrE7MaBIH1EopqrwIcyy+mVgkjpoUKoy9lKA==
X-Google-Smtp-Source: AAOMgpeqEKCDXjMLyvzaJzXBcEdhUaBpe31UHbMg22IlhCTRAJ9BohoxaDF5ScNf0+Zuj9mbxpqPLdWKly+HlDJBVdU=
X-Received: by 2002:a9f:3861:: with SMTP id q30-v6mr4165956uad.170.1531928263933;
 Wed, 18 Jul 2018 08:37:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:37:43 -0700 (PDT)
In-Reply-To: <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Wed, 18 Jul 2018 17:37:43 +0200
Message-ID: <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 17:26, Shakeel Butt <shakeelb@google.com> wrote:
> On Wed, Jul 18, 2018 at 7:29 AM Bruce Merry <bmerry@ska.ac.za> wrote:
> It seems like you are using cgroup-v1. How many nodes are there in
> your memcg tree and also how many cpus does the system have?

From my original email: "there are 106 memory.stat files in
/sys/fs/cgroup/memory." - is that what you mean by the number of
nodes?

The affected systems all have 8 CPU cores (hyperthreading is disabled).

> Please note that memcg_stat_show or reading memory.stat in cgroup-v1
> is not optimized as cgroup-v2. The function memcg_stat_show() in 4.13
> does ~17 tree walks and then for ~12 of those tree walks, it goes
> through all cpus for each node in the memcg tree. In 4.16,
> a983b5ebee57 ("mm: memcontrol: fix excessive complexity in memory.stat
> reporting") optimizes aways the cpu traversal at the expense of some
> accuracy. Next optimization would be to do just one memcg tree
> traversal similar to cgroup-v2's memory_stat_show().

On most machines it is still fast (1-2ms), and there is no difference
in the number of CPUs and only very small differences in the number of
live memory cgroups, so presumably something else is going on.

> The memcg tree does include all zombie memcgs and these zombies does
> contribute to the memcg_stat_show cost.

That sounds promising. Is there any way to tell how many zombies there
are, and is there any way to deliberately create zombies? If I can
produce zombies that might give me a reliable way to reproduce the
problem, which could then sensibly be tested against newer kernel
versions.

Thanks
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
