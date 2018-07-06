Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415E7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE58208E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoxuAR5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE58208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933823AbeGFRab (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:30:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43995 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932840AbeGFRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:30:29 -0400
Received: by mail-lf0-f68.google.com with SMTP id m12-v6so10386265lfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ndVXfon+VtLxnkCnEfFr/72aXB8OehCqbhM2ZEuS0Fw=;
        b=LoxuAR5NqfLM5jGpbZWKCId6LNy/Dmnw5kQxA+4iTDvhX6TCRQFIf14TwyLTnAyRur
         4FI//qmyQjlbKN5WHQ6VntN+6Mb2nr6Hj98WeXAgIIieIXO2jZgN4aj+Zbqxt9bbKh5i
         V80R35j/KZyvpu53mpw+8pX9lXac1adeIMF/r8HQp+ije7FFBnRbFnIY+oyb7kBVutti
         Tm1hZc1sjKd8vgkcAIOJTLwLDQofQGjBRIs/avO/j40sL4ukBwH4dWFXDy93KTEMSKRA
         uEhbNd4/dEItx9at5aPJV4aRwPtsFGbJ50qzHjlTW/3cL7rXKVdSl9l/6HGXgGnIieGd
         n5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndVXfon+VtLxnkCnEfFr/72aXB8OehCqbhM2ZEuS0Fw=;
        b=Xp+vzLE1aSstx/f6Jzrp9rhX3wIJTCXY1D0PzylbRobiSxrATYPXD3Mvqq+MEGB/BR
         MhYPMGhoS28Grasf6gy8N9huZDCngWAIVgOJSqzFcTelF1cwNyPExGsH7nXOTXK9seYC
         67A7ZSHB1T2ntCnxbxuLWydKiS9GbUO3SS0T60AOK1ZSnOykhhcA3JfIzKx0sKhQWuxM
         /0EROcLMTNhAz9y/8VUw3nXXP8Wf2sidSX06gK0CX1/xmgjen0b4cY4weXYl0rhk0Z2M
         4RQR4z1O+wEpias6JhOoAmMaslA/JBzg/my2Msqj4v/qZfosqS7vinTd1cJ3Nk2Hbq9z
         N56A==
X-Gm-Message-State: APt69E3vGGRcyYVqBEFU5rAF1p+NS7eH5OXYwUeZ+nAClHOgd9ltX7Co
        gntYPvRVyqoclBaWZVA/wJ8=
X-Google-Smtp-Source: AAOMgpfxYFRKQD2ttfVJQUFi69OpHny6H9ufql4yXCYWW8jEOiYBFf7sDKPZpx89EJPHgguonEAVjA==
X-Received: by 2002:a19:7609:: with SMTP id c9-v6mr7781977lff.73.1530898228446;
        Fri, 06 Jul 2018 10:30:28 -0700 (PDT)
Received: from esperanza ([185.6.245.156])
        by smtp.gmail.com with ESMTPSA id r6-v6sm2344328lfi.34.2018.07.06.10.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:30:27 -0700 (PDT)
Date:   Fri, 6 Jul 2018 20:30:25 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Subject: Re: [PATCH v8 05/17] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <20180706173025.nkpq5o2yfdtb7d7x@esperanza>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063056619.1818.12550500883688681076.stgit@localhost.localdomain>
 <20180703135000.b2322ae0e514f028e7941d3c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703135000.b2322ae0e514f028e7941d3c@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:50:00PM -0700, Andrew Morton wrote:
> On Tue, 03 Jul 2018 18:09:26 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
> > Imagine a big node with many cpus, memory cgroups and containers.
> > Let we have 200 containers, every container has 10 mounts,
> > and 10 cgroups. All container tasks don't touch foreign
> > containers mounts. If there is intensive pages write,
> > and global reclaim happens, a writing task has to iterate
> > over all memcgs to shrink slab, before it's able to go
> > to shrink_page_list().
> > 
> > Iteration over all the memcg slabs is very expensive:
> > the task has to visit 200 * 10 = 2000 shrinkers
> > for every memcg, and since there are 2000 memcgs,
> > the total calls are 2000 * 2000 = 4000000.
> > 
> > So, the shrinker makes 4 million do_shrink_slab() calls
> > just to try to isolate SWAP_CLUSTER_MAX pages in one
> > of the actively writing memcg via shrink_page_list().
> > I've observed a node spending almost 100% in kernel,
> > making useless iteration over already shrinked slab.
> > 
> > This patch adds bitmap of memcg-aware shrinkers to memcg.
> > The size of the bitmap depends on bitmap_nr_ids, and during
> > memcg life it's maintained to be enough to fit bitmap_nr_ids
> > shrinkers. Every bit in the map is related to corresponding
> > shrinker id.
> > 
> > Next patches will maintain set bit only for really charged
> > memcg. This will allow shrink_slab() to increase its
> > performance in significant way. See the last patch for
> > the numbers.
> > 
> > ...
> >
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -182,6 +182,11 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >  	if (id < 0)
> >  		goto unlock;
> >  
> > +	if (memcg_expand_shrinker_maps(id)) {
> > +		idr_remove(&shrinker_idr, id);
> > +		goto unlock;
> > +	}
> > +
> >  	if (id >= shrinker_nr_max)
> >  		shrinker_nr_max = id + 1;
> >  	shrinker->id = id;
> 
> This function ends up being a rather sad little thing.
> 
> : static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> : {
> : 	int id, ret = -ENOMEM;
> : 
> : 	down_write(&shrinker_rwsem);
> : 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> : 	if (id < 0)
> : 		goto unlock;
> : 
> : 	if (memcg_expand_shrinker_maps(id)) {
> : 		idr_remove(&shrinker_idr, id);
> : 		goto unlock;
> : 	}
> : 
> : 	if (id >= shrinker_nr_max)
> : 		shrinker_nr_max = id + 1;
> : 	shrinker->id = id;
> : 	ret = 0;
> : unlock:
> : 	up_write(&shrinker_rwsem);
> : 	return ret;
> : }
> 
> - there's no need to call memcg_expand_shrinker_maps() unless id >=
>   shrinker_nr_max so why not move the code and avoid calling
>   memcg_expand_shrinker_maps() in most cases.

memcg_expand_shrinker_maps will return immediately if per memcg shrinker
maps can accommodate the new id. Since prealloc_memcg_shrinker is
definitely not a hot path, I don't see any penalty in calling this
function on each prealloc_memcg_shrinker invocation.

> 
> - why aren't we decreasing shrinker_nr_max in
>   unregister_memcg_shrinker()?  That's easy to do, avoids pointless
>   work in shrink_slab_memcg() and avoids memory waste in future
>   prealloc_memcg_shrinker() calls.

We can shrink the maps, but IMHO it isn't worth the complexity it would
introduce, because in my experience if a workload used N mount points
(containers, whatever) at some point of its lifetime, it is likely to
use the same amount in the future.

> 
>   It should be possible to find the highest ID in an IDR tree with a
>   straightforward descent of the underlying radix tree, but I doubt if
>   that has been wired up.  Otherwise a simple loop in
>   unregister_memcg_shrinker() would be needed.
> 
> 
