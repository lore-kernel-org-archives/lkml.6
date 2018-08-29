Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC7EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8677E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXF4iuLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8677E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeH3B3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:29:15 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36720 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeH3B3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:29:15 -0400
Received: by mail-yb0-f195.google.com with SMTP id d34-v6so2610572yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CphjVue2o3o17XWYVNM0JlnFGUQbbef4ItukWd4EagA=;
        b=LXF4iuLUICRShq7V3mEYu8AsOOAIal4SlKY7nSH99BYDFv1eTUjkeDQbbOi6UlkT1i
         xJlAAnb7FC4n3Z4NM3sqITYHGg5qQ/3gLaH5OzyKaHD4Gq6t74xqHDGRgUhUkrhnP7Mb
         d4JpCeuZTydK83HiRUstP2h3Z3d6F2oo5c0Bkl/L3dfT2UQmOZgAljHa/ZbCrCsdcJ7L
         4YlJWUVWgmO/s/VG+Ddt8YKIMkjeW153z8icfGDC9LnbPBO9OzC3z3eGd7tcca2ObLl2
         F3wa0mt0baUNPqeQidV+SzCTXczzMcAn9GhdHd1pbqlIyy9RCk2Yk3e9OZTO1ev5iOJP
         hXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CphjVue2o3o17XWYVNM0JlnFGUQbbef4ItukWd4EagA=;
        b=KQXGLAkseP+1g44gn5s3jmsG3n98nm86VIHQg4rQs6CkBSO5d+9+IjzWDx4w0C7RVA
         uvuG9ay8oCH06nsO3oUaW/Iut3tFyYBRku4BF9/IGjM6dXavTAq270fKXhbk/gs0VPyg
         SjmxDqEIadklIO2QKuMraItZAPn+poshn1hherKseIiXs5bIWUYpqQY9a3CQ7910GATS
         T1NP2qtJSi8f2T4s3KAMCt3IKxOlBskR7JLP4jIVI4OQFjdcYKjXUg3uIgp67XgliSp0
         +a2B4OFWfL8I93gbyTQB7Z1S2OHhFsoYI02jY5vXAUxHMULVly8+cIsaIDl2z2pd005C
         FmKg==
X-Gm-Message-State: APzg51BxRi3Zl3PH5fPHovllGNFzdpbDrnePJXftHiXWF765K9+VUwj+
        lhlydK+XpuqD23ZRba3vX3KFXB+FU33nhTZS4stvjg==
X-Google-Smtp-Source: ANB0VdZxTdEzhaGwj8RfR07BI13da3jgATsa3N5BztwEw6cLQFgy2Aww5lmh8dhMPa856eWX41n1vAjq4PTczpoI+sY=
X-Received: by 2002:a25:d6c8:: with SMTP id n191-v6mr4447153ybg.150.1535578227877;
 Wed, 29 Aug 2018 14:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180821213559.14694-1-guro@fb.com> <CALvZod4HAf+iPXQx1v+dwJkTph3ySAiYo4kn4d2jRFNQS59Tgg@mail.gmail.com>
 <20180829212422.GA13097@castle>
In-Reply-To: <20180829212422.GA13097@castle>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 29 Aug 2018 14:30:16 -0700
Message-ID: <CALvZod5_kMtsiQqdEmktL3zMEf_3LL+_1khdr+TST2vFTChiVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, luto@kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 2:24 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Aug 21, 2018 at 03:10:52PM -0700, Shakeel Butt wrote:
> > On Tue, Aug 21, 2018 at 2:36 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > If CONFIG_VMAP_STACK is set, kernel stacks are allocated
> > > using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
> > > stack pages are charged against corresponding memory cgroups
> > > on allocation and uncharged on releasing them.
> > >
> > > The problem is that we do cache kernel stacks in small
> > > per-cpu caches and do reuse them for new tasks, which can
> > > belong to different memory cgroups.
> > >
> > > Each stack page still holds a reference to the original cgroup,
> > > so the cgroup can't be released until the vmap area is released.
> > >
> > > To make this happen we need more than two subsequent exits
> > > without forks in between on the current cpu, which makes it
> > > very unlikely to happen. As a result, I saw a significant number
> > > of dying cgroups (in theory, up to 2 * number_of_cpu +
> > > number_of_tasks), which can't be released even by significant
> > > memory pressure.
> > >
> > > As a cgroup structure can take a significant amount of memory
> > > (first of all, per-cpu data like memcg statistics), it leads
> > > to a noticeable waste of memory.
> > >
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> >
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> >
> > BTW this makes a very good use-case for optimizing kmem uncharging
> > similar to what you did for skmem uncharging.
>
> The only thing I'm slightly worried here is that it can make
> reclaiming of memory cgroups harder. Probably, it's still ok,
> but let me first finish the work I'm doing on optimizing the
> whole memcg reclaim process, and then return to this case.
>

Yes, maybe we can disable that optimization for offlined memcgs.
Anyways, we can discuss this later as you have suggested.

Shakeel
