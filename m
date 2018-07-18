Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF684ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B743205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlGoW6iS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B743205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbeGRQ1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:27:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45288 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730862AbeGRQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:27:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so5159218wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxpyeO8/BSUIFgP/KCcixj+ymfGj0DJsdHu/MWej2fY=;
        b=tlGoW6iSlZqdToBvGCCrH7fLfpJUj/7dr6Sdpb/mXPLwHYh5h6bCV0VlbQUB2HoWFB
         ixF8j6BVDjza0Jrx/R04d2CDzfygNsj37K6GUcN4fYLChowcQ+1bF00PdjXiAWQaJyMp
         qFdSE7SAuAoCwchfNjdVdfTh9PrLdx9MQEK9gRcb/f5ZShUc2MisEVGGiCTwNKXwwy4/
         ZkEKHE19ZhVKVS2IqjY3/G2pr0bmmZ8VnLA3tnt6DykeeG1QX/j6yoje3I3ytBhkqLhy
         TIgtiQ5XoSN1Z9k3C7sHFQDukMeSPfYTqXn8d09otr8Q5KUIffu3RKvgQtlywipehq7S
         KoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxpyeO8/BSUIFgP/KCcixj+ymfGj0DJsdHu/MWej2fY=;
        b=CDku0uKUFdueJ+akAvrga8aRVP4QApCbogEFtWOfef2yjVLYwXE69Zg0e+FEEilsen
         DBNkrzeAZoRaxw6hj5xNhLAU98cTeFjUUpSULiAkcp9KJJkDjaz8zqdKmIVv7losbS15
         eNRTdJKvKMDTG03nhMdU0KZ2irvamS59PrH8BBoY3vSdYPkzYNMXNY1cQoIMb2EdI1Vx
         RkMY1wTCdom8ezZ25WVRii/h11sP/D6HCYgI7cuOIuc5QZVPI4GbKO6hiaaCUh7yLT+j
         MWVes/0bdZVPa5v7YBOmvWGIjAzeuNtJnzowY0aOOvLdG7MvPaKzN3PvoUp7JD+sYCxq
         7Biw==
X-Gm-Message-State: AOUpUlFaoxMUhxgbOZsNJVnJXu4Pw7AvNvDh3N8y8yFt5AxFjFN/UwD1
        CrmRoc2yab8EZWvTMvJmE8CESR05Al6p+n+8muKqDQ==
X-Google-Smtp-Source: AAOMgpfK+uHQZgJZZt/utoDDTFWtquLgMljrS/qCpBpYh8Zz6+WDm+ZU/Hdz6xok/7Zi0/aN/e1YswdfvE0u/iIl0vQ=
X-Received: by 2002:adf:b112:: with SMTP id l18-v6mr5127093wra.101.1531928961077;
 Wed, 18 Jul 2018 08:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com> <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
In-Reply-To: <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Jul 2018 08:49:09 -0700
Message-ID: <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     bmerry@ska.ac.za
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

On Wed, Jul 18, 2018 at 8:37 AM Bruce Merry <bmerry@ska.ac.za> wrote:
>
> On 18 July 2018 at 17:26, Shakeel Butt <shakeelb@google.com> wrote:
> > On Wed, Jul 18, 2018 at 7:29 AM Bruce Merry <bmerry@ska.ac.za> wrote:
> > It seems like you are using cgroup-v1. How many nodes are there in
> > your memcg tree and also how many cpus does the system have?
>
> From my original email: "there are 106 memory.stat files in
> /sys/fs/cgroup/memory." - is that what you mean by the number of
> nodes?

Yes but it seems like your system might be suffering with zombies.

>
> The affected systems all have 8 CPU cores (hyperthreading is disabled).
>
> > Please note that memcg_stat_show or reading memory.stat in cgroup-v1
> > is not optimized as cgroup-v2. The function memcg_stat_show() in 4.13
> > does ~17 tree walks and then for ~12 of those tree walks, it goes
> > through all cpus for each node in the memcg tree. In 4.16,
> > a983b5ebee57 ("mm: memcontrol: fix excessive complexity in memory.stat
> > reporting") optimizes aways the cpu traversal at the expense of some
> > accuracy. Next optimization would be to do just one memcg tree
> > traversal similar to cgroup-v2's memory_stat_show().
>
> On most machines it is still fast (1-2ms), and there is no difference
> in the number of CPUs and only very small differences in the number of
> live memory cgroups, so presumably something else is going on.
>
> > The memcg tree does include all zombie memcgs and these zombies does
> > contribute to the memcg_stat_show cost.
>
> That sounds promising. Is there any way to tell how many zombies there
> are, and is there any way to deliberately create zombies? If I can
> produce zombies that might give me a reliable way to reproduce the
> problem, which could then sensibly be tested against newer kernel
> versions.
>

Yes, very easy to produce zombies, though I don't think kernel
provides any way to tell how many zombies exist on the system.

To create a zombie, first create a memcg node, enter that memcg,
create a tmpfs file of few KiBs, exit the memcg and rmdir the memcg.
That memcg will be a zombie until you delete that tmpfs file.

Shakeel
