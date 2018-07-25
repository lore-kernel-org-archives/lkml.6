Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE14EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DB22088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxxB33XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DB22088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeGYPkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:40:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39033 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeGYPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:40:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so6200818wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPxlBjp9IJJj6SZNOZXY2s4FyyZaG0r+B7Dvp6lfg5w=;
        b=GxxB33XOBqTnuMHkXS2VMnZIVvqhHS59wcU0IGCzL+qX5Lunl7M/2tU2hXvjEXRiwr
         sGOjyDI7zzC9UZbDROD3/XITzgZEIboIqNuhCIJpquF4MbkSUjgsE6tM6m6syPs2id7y
         bMYPURH4VCvltpX0VKyM4mqx/Gc/Nd3JMGXGgrYJEP8OhRyEn6aqdnxZcWweyCPw8Jug
         KS2LB1eQAlI48kr3Y7dzZ+fZVBUPgrjcUWuD4gt15FoEEpx89I/R81HHmBSdDVm4kQ5k
         +Nv+iuWsxfFD3Hfs6Xb3nSo/poHQOmuep5Df8zvw7KZG9sI8yQBhLHETdrFVD8fleJRn
         nMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPxlBjp9IJJj6SZNOZXY2s4FyyZaG0r+B7Dvp6lfg5w=;
        b=RqdUfhsqi+b/uLFxi6GPkY4Jiv5y8kcm+S7KKfTsNJOcmKSICNJkhmHZv4ij/gCAy7
         ICibL13JUT5nCjzZ7/jsjtwtmQCPAE+VlElKA7UnZlcfvmI/3VSYwxj/oio0uT5aFvWV
         +acORmuOtuNNeuVOqOkOJf/VpURKFxh40UwXltXE5SGMjLLoZaTu+P7a+5YqDW/C/dlo
         TWSYE+HrceMyQKQGl9ZF1omi5LtXBRqfa86pos2shOuiJQqNzEU6SxL8TqV4efp3nMTX
         8kj9hfxGwb8Gk8oyJD/nOf7iQCUhhF6HcI5g5IhjTJNeaE4WRS6ZzVjlqpwqwSR3rDF1
         9vNA==
X-Gm-Message-State: AOUpUlH+sXnu4pbCtti2t11NFYcKz0LDG+LgZUzPBdnd29IjjdNGUF9F
        kaJV/uM1l+9eJGSHvACIXZLHchwL7jKGM2GYL2JSTA==
X-Google-Smtp-Source: AAOMgpf2SM24lp97xiqEe20C2s9zCGJU3kzndotS9TAvb0++FJ2Azr7+Z3Qgbkuoim2+95FzA9gF3Prl8+o5Ukwjns0=
X-Received: by 2002:a1c:91c7:: with SMTP id t190-v6mr5017723wmd.2.1532528885996;
 Wed, 25 Jul 2018 07:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180724224635.143944-1-shakeelb@google.com> <CAOm-9arFu63A9YJ6yVtm6_LdtbRKZg1Q3dz8WugdkBBQfoOWYw@mail.gmail.com>
In-Reply-To: <CAOm-9arFu63A9YJ6yVtm6_LdtbRKZg1Q3dz8WugdkBBQfoOWYw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 25 Jul 2018 07:27:50 -0700
Message-ID: <CALvZod7Fqj_pJ2sn+XiDsoDX4jBLM22iGUrB9PeJXg+8S5xExQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: reduce memcg tree traversals for stats collection
To:     bmerry@ska.ac.za
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 4:26 AM Bruce Merry <bmerry@ska.ac.za> wrote:
>
> On 25 July 2018 at 00:46, Shakeel Butt <shakeelb@google.com> wrote:
> > I ran a simple benchmark which reads the root_mem_cgroup's stat file
> > 1000 times in the presense of 2500 memcgs on cgroup-v1. The results are:
> >
> > Without the patch:
> > $ time ./read-root-stat-1000-times
> >
> > real    0m1.663s
> > user    0m0.000s
> > sys     0m1.660s
> >
> > With the patch:
> > $ time ./read-root-stat-1000-times
> >
> > real    0m0.468s
> > user    0m0.000s
> > sys     0m0.467s
>
> Thanks for cc'ing me. I've tried this patch using my test case and the
> results are interesting. With the patch applied, running my script
> only generates about 8000 new cgroups, compared to 40,000 before -
> presumably because the optimisation has altered the timing.
>
> On the other hand, if I run the script 5 times to generate 40000
> zombie cgroups, the time to get stats for the root cgroup (cgroup-v1)
> is almost unchanged at around 18ms (was 20ms, but there were slightly
> more cgroups as well), compared to the almost 4x speedup you're seeing
> in your test.
>

Hi Bruce, I think your script is trying to create zombies, so, the
experiments after that script will be non-deterministic. Why not just
create 40k cgroups ,no need for zombies, and the see how much this
patch affects reading stats.

Shakeel
