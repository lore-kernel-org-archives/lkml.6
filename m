Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AAAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2AD20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRbk6JCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfAIFhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:37:05 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41172 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfAIFhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:37:04 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so2518678ywc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 21:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwQxFHxz+8PmQyG66B5Bjl07PiypQuWXpFzP5iBeaM8=;
        b=gRbk6JCmU2CIyHjhyHknRGFjIUVAKs8xvIdigwAVIuSKyCvxBfKWmEVjYCcWtobprT
         CFjC+9Ysm2Sfi+DZMJXPWo/LbwpFsCQwO7e6qGJRBeaO93PU6iaYHnw5x1UZnSeAD2gK
         8qhsPxU2Yt26YHYZNGhCTkdYvFn8i/7MCumbpFWJxnozabI+0tD5qT543MX104MNw1Qj
         LXMeGwoPePRaiii4eIRn3hoHYT/lBwz/3Jkfx/rheYyfrwh22/9QBPdxhQg4rPIcxWo9
         /Ug7ua5VVJP59LjSnuhLi8I02u5nIcio6baD8MHHu/SLdbQyFb8a23b+CQ/Y3YvV4V0j
         2Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwQxFHxz+8PmQyG66B5Bjl07PiypQuWXpFzP5iBeaM8=;
        b=mmPcIzHEqexRRSAAYkzttdgIxaaU3WumtfaCc5oLqHI+WHXSQe5XNO54VAuzvAcnyQ
         1oI3yh1PhZSSH3qNDWi74wlmIe3bcvQCMGEDgL0Q8Pv8Dy4/NUFhkjO6g3tARHjJhn5p
         C9XcxxE6pvz5mH9ObZBZtj9l6q8Eml+WON4QRCRJef4IewzynU6l9HXF0w/bjNlFIEn7
         JJPNsCjPDMBWCKnxgQcgZAriTtpdqs5ZPdGQpWQj62JCWvawMTBbgGSOEk1VmFXLAH9d
         fSudYMweRzsRGm0mkbjHOsvWjvjTUjwH7rB7E2b5QhP4uaegJJ/UzRHYCjEAxW+25nOf
         AT/A==
X-Gm-Message-State: AJcUukd7qXOxpCQq49lcy97ZhVmB6DOh+e95gD9l/J4Q7sUX5ErnsgJ8
        t22CIS9BiLraMIts72iAdhHb6DVTgwflf2VtSPqsGg==
X-Google-Smtp-Source: ALg8bN69HzwcjQgfkTDmg9mJXNVwwm85Eeo0s32ItOAKgn1RGoRtq2+sreNKXEGKTRMIl4fv8vrRuuhE1TopsLiEz0M=
X-Received: by 2002:a81:29d5:: with SMTP id p204mr4406394ywp.285.1547012223494;
 Tue, 08 Jan 2019 21:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20190109040107.4110-1-riel@surriel.com>
In-Reply-To: <20190109040107.4110-1-riel@surriel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 8 Jan 2019 21:36:52 -0800
Message-ID: <CALvZod6=-kdUk23i7eOr5AO-_2Fk_BmJiL3QjSJ4S4QOs0xKkw@mail.gmail.com>
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

On Tue, Jan 8, 2019 at 8:01 PM Rik van Riel <riel@surriel.com> wrote:
>
> There is an imbalance between when slab_pre_alloc_hook calls
> memcg_kmem_get_cache and when slab_post_alloc_hook calls
> memcg_kmem_put_cache.
>

Can you explain how there is an imbalance? If the returned kmem cache
from memcg_kmem_get_cache() is the memcg kmem cache then the refcnt of
memcg is elevated and the memcg_kmem_put_cache() will correctly
decrement the refcnt of the memcg.

> This can cause a memcg kmem cache to be destroyed right as
> an object from that cache is being allocated, which is probably
> not good. It could lead to things like a memcg allocating new
> kmalloc slabs instead of using freed space in old ones, maybe
> memory leaks, and maybe oopses as a memcg kmalloc slab is getting
> destroyed on one CPU while another CPU is trying to do an allocation
> from that same memcg.
>
> The obvious fix would be to use the same condition for calling
> memcg_kmem_put_cache that we also use to decide whether to call
> memcg_kmem_get_cache.
>
> I am not sure how long this bug has been around, since the last
> changeset to touch that code - 452647784b2f ("mm: memcontrol: cleanup
>  kmem charge functions") - merely moved the bug from one location to
> another. I am still tagging that changeset, because the fix should
> automatically apply that far back.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Fixes: 452647784b2f ("mm: memcontrol: cleanup kmem charge functions")
> Cc: kernel-team@fb.com
> Cc: linux-mm@kvack.org
> Cc: stable@vger.kernel.org
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> ---
>  mm/slab.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 4190c24ef0e9..ab3d95bef8a0 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -444,7 +444,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
>                 p[i] = kasan_slab_alloc(s, object, flags);
>         }
>
> -       if (memcg_kmem_enabled())
> +       if (memcg_kmem_enabled() &&
> +           ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))

I don't think these extra checks are needed. They are safe but not needed.

>                 memcg_kmem_put_cache(s);
>  }
>
> --
> 2.17.1
>

thanks,
Shakeel
