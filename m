Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57820850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RU3wQDFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeGRQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:05:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39647 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbeGRQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:05:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so5094965wre.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33vbXn3Nz+ghuAIAje/Tzt78HUFkpNM2I7sQKnE5g0M=;
        b=RU3wQDFQ+oCm2qMiukyriAIpkLk9Sx8H0asKpsF2v10dh+gokb9aUg5UDhSzSw72Zr
         /WklyQKWJFpft2ZbNmV7QuO3YmXaQ4dokUEEVjynGXDEFkb4orXZpsJ/QBMDUBwqVEnz
         FNMYZR6tz/UMY4Jy0m0DZvvnNQo2KfUXdH6WkgCOj/T6r1ckvcn0j0I/QwPQn6Q2dh3Z
         bN+G34We01XN9gxVshAEUuvqbflsrIzdkbCwC0N+vbKQUmJ+zI5wAhT3gtKyKzPrZn4L
         Tvbugy1Abao7gQFdEzcgeuAC/0kuLp+yYCwcDs3ajTLt6ljbVoN2Riq5gznZC/5mGwNu
         j73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33vbXn3Nz+ghuAIAje/Tzt78HUFkpNM2I7sQKnE5g0M=;
        b=BxwcslRSHmIf3VzQbSxsW/ii9LQtVmzb0k/T7kZ5V66N1bBp6v8f/oevHhG0/hNuLN
         6MlYsJkq3vZuIYePsBAY+Cb3RSii/zrVQYI1vMu9a8VtwpErWbJIhELxO9HCF0E44i71
         CrKziAxwJsweIsXPo64rlOE7yCohXe59yCprPYWr1KQiWa21CrbTUJJExoqfBT4ZXegt
         G8W2ZHIwDFwoxf3CyXyChGN0XsgfTocvtMUDZHmOOFMWLsuX65O8YhycYKJgkGyc1uqQ
         nVfgXAkr3/wceXkTFhoA7VQ6LZZrRPAn8Cd+Lf+dNUGzuMH+fB9HSZoQtvqvc1nGTj6D
         GANw==
X-Gm-Message-State: AOUpUlEwzz6jKY1gxYNUF5hkH2L5UBDkl3bCbYQ6YQ1oW2j4Jvlg5cOx
        mwRzBUUHCIyYImOWsaGeOTfSL5bl/lPVkz+DCai9DQ==
X-Google-Smtp-Source: AAOMgpdPLUU1lWG+uV8d8bg4UjSKNDC2HS6gZsBExCiSXRGGWAAkwV/hiBeI45dVIxci3n7YcA/wb/x1td20efq5V0o=
X-Received: by 2002:a5d:4a07:: with SMTP id m7-v6mr5179920wrq.8.1531927616618;
 Wed, 18 Jul 2018 08:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
In-Reply-To: <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Jul 2018 08:26:45 -0700
Message-ID: <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
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

On Wed, Jul 18, 2018 at 7:29 AM Bruce Merry <bmerry@ska.ac.za> wrote:
>
> On 18 July 2018 at 12:42, Michal Hocko <mhocko@kernel.org> wrote:
> > [CC some more people]
> >
> > On Tue 17-07-18 21:23:07, Andrew Morton wrote:
> >> (cc linux-mm)
> >>
> >> On Tue, 3 Jul 2018 08:43:23 +0200 Bruce Merry <bmerry@ska.ac.za> wrote:
> >>
> >> > Hi
> >> >
> >> > I've run into an odd performance issue in the kernel, and not being a
> >> > kernel dev or knowing terribly much about cgroups, am looking for
> >> > advice on diagnosing the problem further (I discovered this while
> >> > trying to pin down high CPU load in cadvisor).
> >> >
> >> > On some machines in our production system, cat
> >> > /sys/fs/cgroup/memory/memory.stat is extremely slow (500ms on one
> >> > machine), while on other nominally identical machines it is fast
> >> > (2ms).
> >
> > Could you try to use ftrace to see where the time is spent?
>
> Thanks for looking into this. I'm not familiar with ftrace. Can you
> give me a specific command line to run? Based on "perf record cat
> /sys/fs/cgroup/memory/memory.stat"/"perf report", I see the following:
>
>   42.09%  cat      [kernel.kallsyms]  [k] memcg_stat_show
>   29.19%  cat      [kernel.kallsyms]  [k] memcg_sum_events.isra.22
>   12.41%  cat      [kernel.kallsyms]  [k] mem_cgroup_iter
>    5.42%  cat      [kernel.kallsyms]  [k] _find_next_bit
>    4.14%  cat      [kernel.kallsyms]  [k] css_next_descendant_pre
>    3.44%  cat      [kernel.kallsyms]  [k] find_next_bit
>    2.84%  cat      [kernel.kallsyms]  [k] mem_cgroup_node_nr_lru_pages
>

It seems like you are using cgroup-v1. How many nodes are there in
your memcg tree and also how many cpus does the system have?

Please note that memcg_stat_show or reading memory.stat in cgroup-v1
is not optimized as cgroup-v2. The function memcg_stat_show() in 4.13
does ~17 tree walks and then for ~12 of those tree walks, it goes
through all cpus for each node in the memcg tree. In 4.16,
a983b5ebee57 ("mm: memcontrol: fix excessive complexity in memory.stat
reporting") optimizes aways the cpu traversal at the expense of some
accuracy. Next optimization would be to do just one memcg tree
traversal similar to cgroup-v2's memory_stat_show().

Anyways, is it possible for you to try 4.16 kernel?

Shakeel
