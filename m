Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBE4C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0012083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntoh8smW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0012083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937644AbeFSViZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:38:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34331 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937365AbeFSViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:38:22 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so1130982wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2F0jI+CA6cfoLi4EbDtVyIGjIAX/atVlgLdOJ64bNUI=;
        b=ntoh8smWqSHmEJvId/rii4PgTkSd0p+m5yQlFVC1Yox3WSVt+lU9Kiv5M8Rd2KIomJ
         jynJrNfNaDJ/P3nROCxPSGJYXgdGaCsy9daCA6gOTxSYNVqkmDTuvk1I2xR0ScgGqPjD
         Sfy4Matw/vvcSOU3N1Aks2yjRniTuDIabU+GT2tphv7ZicupGzdXcQkJ2VbN9VQPF38t
         sKfo2XFaSuc+bgGqgHTGTLhkFSFbdfrs08I/YRvVOMKSuCgX/7U6T4x4mNgRMaQ9KAZ2
         FahdOHR1k3Oeh/KSRtLlYQAVZDS3TMFxaNbgQOb9sMlB8bWtu6CGwAKOsj+ZARlNiX6B
         QJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F0jI+CA6cfoLi4EbDtVyIGjIAX/atVlgLdOJ64bNUI=;
        b=sYYVjQRz8HF/JKjAaRI+WZWphkgKgKxRTNtN/UTdE4iJ19XLg34IGUv3bvOAi83bzH
         VRHrGereoFiMroNuWu1ECz/pyWkE57jPumu6wvoTZYkluJWQs1RXgiUVVpiPVrZB2EpA
         8QMX9fEmzeH9CbXbxqk+gj+McUid14zhnmFcineA/XL9BAUP6vrV+yA2YSGeu97/BGaD
         oOQnE1EuBazznxpBMGxFdxk7akBkNX1t8usvhbCFrfwp5LghhEeLtZ0/x4jqDQ8jmxGY
         mKuCCqBR0dLL2+lv7prAqIT3dQy/tlfGwlpQgW5+j9Noq27z6DFzOkqG3GaAlqOlBeUb
         WnGw==
X-Gm-Message-State: APt69E25vvlFvPEQnXqb6/KxeNWSY4P/N/cSNia15ubhwXecQdSwFz78
        EC1gQ0le+2DXQe2r6iyGmBlREUdAlT7zpaoL42cBPw==
X-Google-Smtp-Source: ADUXVKK2gYFTH7LD9g2BXySSmYpS5DObwTYJyQSwS1heUvnMBLB1OTqfGS1oRURkyD+OQ1zwdJy8xgV0ioXiIcqV5u8=
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr16378212wrm.2.1529444300536;
 Tue, 19 Jun 2018 14:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180619213352.71740-1-shakeelb@google.com>
In-Reply-To: <20180619213352.71740-1-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Jun 2018 14:38:08 -0700
Message-ID: <CALvZod7UVenX76Lo611U-yaXv_nkc0oTFrBapMS-T0rw8Rh4hg@mail.gmail.com>
Subject: Re: [PATCH] slub: fix __kmem_cache_empty for !CONFIG_SLUB_DEBUG
To:     Jason@zx2c4.com, Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 2:33 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
> allocated per node for a kmem_cache. Thus, slabs_node() in
> __kmem_cache_empty() will always return 0. So, in such situation, it is
> required to check per-cpu slabs to make sure if a kmem_cache is empty or
> not.
>
> Please note that __kmem_cache_shutdown() and __kmem_cache_shrink() are
> not affected by !CONFIG_SLUB_DEBUG as they call flush_all() to clear
> per-cpu slabs.
>
> Fixes: f9e13c0a5a33 ("slab, slub: skip unnecessary kasan_cache_shutdown()")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: Jason A . Donenfeld <Jason@zx2c4.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org>

Forgot to Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>

> ---
>  mm/slub.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index a3b8467c14af..731c02b371ae 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3673,9 +3673,23 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>
>  bool __kmem_cache_empty(struct kmem_cache *s)
>  {
> -       int node;
> +       int cpu, node;
>         struct kmem_cache_node *n;
>
> +       /*
> +        * slabs_node will always be 0 for !CONFIG_SLUB_DEBUG. So, manually
> +        * check slabs for all cpus.
> +        */
> +       if (!IS_ENABLED(CONFIG_SLUB_DEBUG)) {
> +               for_each_online_cpu(cpu) {
> +                       struct kmem_cache_cpu *c;
> +
> +                       c = per_cpu_ptr(s->cpu_slab, cpu);
> +                       if (c->page || slub_percpu_partial(c))
> +                               return false;
> +               }
> +       }
> +
>         for_each_kmem_cache_node(s, node, n)
>                 if (n->nr_partial || slabs_node(s, node))
>                         return false;
> --
> 2.18.0.rc1.244.gcf134e6275-goog
>
