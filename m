Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3D5C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A182521738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+BtHPWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfAIFoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:44:44 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:32964 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfAIFoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:44:44 -0500
Received: by mail-yb1-f196.google.com with SMTP id o73so2567804ybc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 21:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nHgzPv8OHHMQOhvL9odj368V6gyeIizn/EW268BFmo=;
        b=T+BtHPWAN7zFhlQJ3Vh7wdCJ+9Db2lsKHltj0bZCAebH1WiEy/bGepN15kGNiU6469
         ma5r8vkSiWbBVxLwouI02LIchw3YoIyHYBRZwkB5Mi09ldoK0U4m4ykkg5iORhBPlrPh
         g1WBZrFyVRuFCEyVU3B6VRzFk0aUui5Hr22SMVyzXMDfAkmF4CdNPksyjrJumw0d4q4D
         93Ro/R63gHWvIeT4IwK7z2HTr+0dokmPc2Cwsj47wUMBzNlbRFkDi5tOyOnI90QT9+Wi
         m9V53rJfzirHyQAUR3sIjq1htXAy4TLE2wChDX4H9psoaB26huD3zIy+8n0ZD0i+c+H+
         0rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nHgzPv8OHHMQOhvL9odj368V6gyeIizn/EW268BFmo=;
        b=KFVDHoB6ckHsiWxZ/y42aAn1ZeZ15Es29Br5KMtmDP11dVcBL/WXEwOZiLXsLDJG8t
         ce/c5rRotRI7t0bA6qovxAomnJ6y73WvKNxiAhQmnyfLgFRrvvnLlYI4fYAdRbShETuo
         rmOJJwp99Jai5z/R10f8ycV+HZnsWAQPD3sdSw46A/zt7HGyw9Bq02b0Hw9Qpj/uUP0R
         mwW+dshAtBgHEVc+oIzuh//fgsUFBEiJwP935aFvGMmWBHiWF9AJrcvbHbYzqHItvy4+
         zBzqSM30O2GAThNE5I8kH/K5Rh/g/dUtbXVWaKUlegQ0qyi5eU7Bw4E6mgOywW8L6+Vx
         N5bQ==
X-Gm-Message-State: AJcUuke/k8tXp7kC/Af+Wbs+AjIxqf4wIrPYsLb5Ngk1DT9cb1HjO6xz
        C75cU77ppkq+w91yuWihfLrOhuL1FfOs/pmEIApcAO0LpNI2og==
X-Google-Smtp-Source: ALg8bN7WC9YarGVhTwVTk4rmmMzeT1JUxVUtrATiopraERlgM5IN/iq9S9pbXWCiF6mNWSpgMszQDXsj1t05ClcxXUw=
X-Received: by 2002:a25:26c8:: with SMTP id m191mr4384247ybm.377.1547012683115;
 Tue, 08 Jan 2019 21:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20190109040107.4110-1-riel@surriel.com> <CALvZod6=-kdUk23i7eOr5AO-_2Fk_BmJiL3QjSJ4S4QOs0xKkw@mail.gmail.com>
In-Reply-To: <CALvZod6=-kdUk23i7eOr5AO-_2Fk_BmJiL3QjSJ4S4QOs0xKkw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 8 Jan 2019 21:44:32 -0800
Message-ID: <CALvZod5+QFLtn4D+xn2REy3sHUR5z3EsJQPGrfzWobK5wmRnjg@mail.gmail.com>
Subject: Re: [PATCH] mm,slab,memcg: call memcg kmem put cache with same
 condition as get
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Linux MM <linux-mm@kvack.org>, stable@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 9:36 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Jan 8, 2019 at 8:01 PM Rik van Riel <riel@surriel.com> wrote:
> >
> > There is an imbalance between when slab_pre_alloc_hook calls
> > memcg_kmem_get_cache and when slab_post_alloc_hook calls
> > memcg_kmem_put_cache.
> >
>
> Can you explain how there is an imbalance? If the returned kmem cache
> from memcg_kmem_get_cache() is the memcg kmem cache then the refcnt of
> memcg is elevated and the memcg_kmem_put_cache() will correctly
> decrement the refcnt of the memcg.
>
> > This can cause a memcg kmem cache to be destroyed right as
> > an object from that cache is being allocated,

Also please note that the memcg kmem caches are destroyed (if empty)
on memcg offline. The css_tryget_online() within
memcg_kmem_get_cache() will fail.

See kernel/cgroup/cgroup.c
* 2. When the percpu_ref is confirmed to be visible as killed on all CPUs
 *    and thus css_tryget_online() is guaranteed to fail, the css can be
 *    offlined by invoking offline_css().  After offlining, the base ref is
 *    put.  Implemented in css_killed_work_fn().

> > which is probably
> > not good. It could lead to things like a memcg allocating new
> > kmalloc slabs instead of using freed space in old ones, maybe
> > memory leaks, and maybe oopses as a memcg kmalloc slab is getting
> > destroyed on one CPU while another CPU is trying to do an allocation
> > from that same memcg.
> >
> > The obvious fix would be to use the same condition for calling
> > memcg_kmem_put_cache that we also use to decide whether to call
> > memcg_kmem_get_cache.
> >
> > I am not sure how long this bug has been around, since the last
> > changeset to touch that code - 452647784b2f ("mm: memcontrol: cleanup
> >  kmem charge functions") - merely moved the bug from one location to
> > another. I am still tagging that changeset, because the fix should
> > automatically apply that far back.
> >
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Fixes: 452647784b2f ("mm: memcontrol: cleanup kmem charge functions")
> > Cc: kernel-team@fb.com
> > Cc: linux-mm@kvack.org
> > Cc: stable@vger.kernel.org
> > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > ---
> >  mm/slab.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 4190c24ef0e9..ab3d95bef8a0 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -444,7 +444,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
> >                 p[i] = kasan_slab_alloc(s, object, flags);
> >         }
> >
> > -       if (memcg_kmem_enabled())
> > +       if (memcg_kmem_enabled() &&
> > +           ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
>
> I don't think these extra checks are needed. They are safe but not needed.
>
> >                 memcg_kmem_put_cache(s);
> >  }
> >
> > --
> > 2.17.1
> >
>
> thanks,
> Shakeel
