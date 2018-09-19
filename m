Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A0ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23DF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5yScQ6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23DF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeISJO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:14:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36262 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeISJO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:14:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id w17-v6so4312016otk.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 20:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Is/kiqCUVr99kg0KI+RzyHvmwWvwglppJkETJIOoEL0=;
        b=i5yScQ6rrkrmgNBUQjItKyzosqSToiYJqaoPZjjcwbTdk/POqR3iaYdk6De73TF78C
         CFKiWgTwQXHPFAWTT2++uZRC/2FHPvQHq8dfgjNpESh9722GAGok9EUmz8qKqYtN/I3S
         +plm7njrLnjN7NRhxFQO8ojTOpSdeAZi9G/gIcnOSKVlApXZqWMGQTX0b3/L4xb1Sqfc
         5vzfVFfWDbN31WppxhhcVkVXjjOR0Htg4lGJFrmsiIo0fQcKtZfZIS7dLFFr1dGMwvRV
         zOzhPPESFyJ5bx4WbzjL5qApL7mSOLlW/Ac0txhxjpfDkU5nPO4yZKhEDKWM3RuH9JWT
         hxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Is/kiqCUVr99kg0KI+RzyHvmwWvwglppJkETJIOoEL0=;
        b=IvnDp48iyrmpYiknD4QPMr/bt0PdkIizdimiQeTINukNZOyQlwS4enze0z/1+pSEur
         A59qvvmyd8e05Dh2HstvxeII7d0hhzmz3Y2lhhhGqxxR/+C64cF7gmQPtnS3EO6ifQ6m
         iQUF9zodSqHYDK+ym4GNKcP8PAwPQ+sNxMloSOgYxd2SLn8ggIcl7dH+JrjOevV+UGTC
         FunV+ByvPT16Z/dOqQuIw2I1JUVf3SSRbIGCAOD22mL5PAZHZmZwzmQtboXoJxvEs+j+
         ZMmGe8ygXusssgW2xm8BzEbXYoQUE118SZJfb067h1fM3T6PoIcr9U/itoJdJ4wFHMdZ
         OEqA==
X-Gm-Message-State: APzg51Az2vvVs0kexUrbSWk/tZ4HZjkWXmOQ7UMGzxjxZR6GIWjurQxo
        2ZOKRBCMDomEupHT4LfPNMxRTX0LvLjJheD77Yw=
X-Google-Smtp-Source: ANB0Vdacikv7NCwzlMk/x3tRWXlwUORkpBwBk1Sz+McXnylnIivGIX7jDRqZsTz0O3TMIwUB53OzgrN/oeYY+1mjRY0=
X-Received: by 2002:a9d:2ac8:: with SMTP id e66-v6mr18421452otb.143.1537328316297;
 Tue, 18 Sep 2018 20:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180905042736.11904-1-ganapatrao.kulkarni@cavium.com>
In-Reply-To: <20180905042736.11904-1-ganapatrao.kulkarni@cavium.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Wed, 19 Sep 2018 09:08:25 +0530
Message-ID: <CAKTKpr7SokNx304PbVzhn6Xj05m962tmsCzmBec1R0Q9Pon3Zw@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/iova: Optimise attempts to allocate iova from
 32bit address range
To:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, tomasz.nowicki@cavium.com,
        jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

can you please pull this patch?

On Wed, Sep 5, 2018 at 9:58 AM Ganapatrao Kulkarni
<ganapatrao.kulkarni@cavium.com> wrote:
>
> As an optimisation for PCI devices, there is always first attempt
> been made to allocate iova from SAC address range. This will lead
> to unnecessary attempts, when there are no free ranges
> available. Adding fix to track recently failed iova address size and
> allow further attempts, only if requested size is lesser than a failed
> size. The size is updated when any replenish happens.
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
> v4:
>     Rebsaed to 4.19-rc2
> v3:
>     Update with comments [3] from Robin Murphy <robin.murphy@arm.com>
>
> [3] https://lkml.org/lkml/2018/8/13/116
>
> v2: update with comments [2] from Robin Murphy <robin.murphy@arm.com>
>
> [2] https://lkml.org/lkml/2018/8/7/166
>
> v1: Based on comments from Robin Murphy <robin.murphy@arm.com>
> for patch [1]
>
> [1] https://lkml.org/lkml/2018/4/19/780
>
>  drivers/iommu/iova.c | 22 +++++++++++++++-------
>  include/linux/iova.h |  1 +
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 83fe2621effe..f8d3ba247523 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>         iovad->granule = granule;
>         iovad->start_pfn = start_pfn;
>         iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
> +       iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>         iovad->flush_cb = NULL;
>         iovad->fq = NULL;
>         iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
> @@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>
>         cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
>         if (free->pfn_hi < iovad->dma_32bit_pfn &&
> -           free->pfn_lo >= cached_iova->pfn_lo)
> +           free->pfn_lo >= cached_iova->pfn_lo) {
>                 iovad->cached32_node = rb_next(&free->node);
> +               iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> +       }
>
>         cached_iova = rb_entry(iovad->cached_node, struct iova, node);
>         if (free->pfn_lo >= cached_iova->pfn_lo)
> @@ -190,6 +193,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>
>         /* Walk the tree backwards */
>         spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +       if (limit_pfn <= iovad->dma_32bit_pfn &&
> +                       size >= iovad->max32_alloc_size)
> +               goto iova32_full;
> +
>         curr = __get_cached_rbnode(iovad, limit_pfn);
>         curr_iova = rb_entry(curr, struct iova, node);
>         do {
> @@ -200,10 +207,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>                 curr_iova = rb_entry(curr, struct iova, node);
>         } while (curr && new_pfn <= curr_iova->pfn_hi);
>
> -       if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> -               spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -               return -ENOMEM;
> -       }
> +       if (limit_pfn < size || new_pfn < iovad->start_pfn)
> +               goto iova32_full;
>
>         /* pfn_lo will point to size aligned address if size_aligned is set */
>         new->pfn_lo = new_pfn;
> @@ -214,9 +219,12 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>         __cached_rbnode_insert_update(iovad, new);
>
>         spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -
> -
>         return 0;
> +
> +iova32_full:
> +       iovad->max32_alloc_size = size;
> +       spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +       return -ENOMEM;
>  }
>
>  static struct kmem_cache *iova_cache;
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 928442dda565..0b93bf96693e 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -75,6 +75,7 @@ struct iova_domain {
>         unsigned long   granule;        /* pfn granularity for this domain */
>         unsigned long   start_pfn;      /* Lower limit for this domain */
>         unsigned long   dma_32bit_pfn;
> +       unsigned long   max32_alloc_size; /* Size of last failed allocation */
>         struct iova     anchor;         /* rbtree lookup anchor */
>         struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];  /* IOVA range caches */
>
> --
> 2.18.0
>
thanks,
Ganapat
