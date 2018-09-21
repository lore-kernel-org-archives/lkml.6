Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08554C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A590621531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoPFDMQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A590621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389914AbeIUROK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:14:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40015 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUROK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:14:10 -0400
Received: by mail-it1-f195.google.com with SMTP id h23-v6so1515651ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TE77MA4ag5cUwzU/qmu3qYmTdqef2HVGTM23qFE/jrU=;
        b=uoPFDMQvKu1SDEdAXH8CFrFbkACdxLdKQxE1ryXw8tVfEaR20sP4lrLlxeZ3+tHn+8
         hneU2uCbtbbW21aJEqc+nmqP16/tO5bK++6mAMGdmFq9nXaMfazwIUrD71R0tW4V8SvL
         O5S4MhiuJZVxnNoEVn0ODT2rlHulpEiZrHzqPSQkxAiR9BAooAG5/D3bA4Myz4X0iQJm
         QlxZG6+tOu9AuoFe0UHpHbc0hv/z0YZRHZWVBRWy4Cdcxp3Hkniqf/1npNXKQjufmcMS
         bPMbb0ReDLk8TPbjED76qCpkl0TCML8J7VFPVQW1JdBA3YDiYXERGQtPUV0QUWvPLPz/
         iLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TE77MA4ag5cUwzU/qmu3qYmTdqef2HVGTM23qFE/jrU=;
        b=Dk49BKMM4RJi/Y9JbKCGKmg9rv/cowl7aAYT6AaNKFbPhFU+0YhRpERXWwnFs9obrq
         8Ls5bRAmS1OpH+nQY7ZifygA1Wy2Jq5IJYkJDCI0H4SMh84zUT0YGgP7Ij48GHxw+pi6
         lkM0OuTVL2xzXYYwwuv1GhnYZGysBdomZO6qIo2OsAFjy1jYSfD1IgwL6ZBiMysxSBif
         BLh2LQKKH+EMKNp8zKS1QW1nSTghRHqVpNwWpFPA6ItXwVgQgLKbu80quUc1NaZHmNYq
         aBo/uRMTnn/aPCL687350Ot1nxbpQJUl13UmYsQ+uBevZpDsluIFDeaSkbQ7xV8bTTaV
         pT/g==
X-Gm-Message-State: APzg51DG8LE4xk8Z7L4bR8zalXokPJYk8sZPieAvqjNK4QpXXhzg7kyC
        6L9Ye2F/75+ZrmgH49089G15qc63iJnwZYvgI5cntQ==
X-Google-Smtp-Source: ANB0VdZgwpQluLou8SXL3jD+aNR+Pik6byg7jBOb8RFmErQ+roUxqymUFqlL3XvAgDRUbjPtHcCasv/TB8DM6NMki54=
X-Received: by 2002:a24:140f:: with SMTP id 15-v6mr5527808itg.57.1537529143478;
 Fri, 21 Sep 2018 04:25:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 04:25:22
 -0700 (PDT)
In-Reply-To: <d74e710797323db0e43f047ea698fbc85060fc57.1537383101.git.andreyknvl@google.com>
References: <cover.1537383101.git.andreyknvl@google.com> <d74e710797323db0e43f047ea698fbc85060fc57.1537383101.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Sep 2018 13:25:22 +0200
Message-ID: <CACT4Y+aoFSySFTd9FzA0xzRYQXSbs-wzX7B67hD3jTGAQEXBOA@mail.gmail.com>
Subject: Re: [PATCH v8 09/20] kasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 8:54 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> An object constructor can initialize pointers within this objects based on
> the address of the object. Since the object address might be tagged, we
> need to assign a tag before calling constructor.
>
> The implemented approach is to assign tags to objects with constructors
> when a slab is allocated and call constructors once as usual. The
> downside is that such object would always have the same tag when it is
> reallocated, so we won't catch use-after-frees on it.
>
> Also pressign tags for objects from SLAB_TYPESAFE_BY_RCU caches, since
> they can be validy accessed after having been freed.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/slab.c |  2 +-
>  mm/slub.c | 24 ++++++++++++++----------
>  2 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 6fdca9ec2ea4..fe0ddf08aa2c 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2574,7 +2574,7 @@ static void cache_init_objs(struct kmem_cache *cachep,
>
>         for (i = 0; i < cachep->num; i++) {
>                 objp = index_to_obj(cachep, page, i);
> -               kasan_init_slab_obj(cachep, objp);
> +               objp = kasan_init_slab_obj(cachep, objp);
>
>                 /* constructor could break poison info */
>                 if (DEBUG == 0 && cachep->ctor) {
> diff --git a/mm/slub.c b/mm/slub.c
> index c4d5f4442ff1..75fc76e42a1e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1413,16 +1413,17 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  #endif
>  }
>
> -static void setup_object(struct kmem_cache *s, struct page *page,
> +static void *setup_object(struct kmem_cache *s, struct page *page,
>                                 void *object)
>  {
>         setup_object_debug(s, page, object);
> -       kasan_init_slab_obj(s, object);
> +       object = kasan_init_slab_obj(s, object);
>         if (unlikely(s->ctor)) {
>                 kasan_unpoison_object_data(s, object);
>                 s->ctor(object);
>                 kasan_poison_object_data(s, object);
>         }
> +       return object;
>  }
>
>  /*
> @@ -1530,16 +1531,16 @@ static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
>         /* First entry is used as the base of the freelist */
>         cur = next_freelist_entry(s, page, &pos, start, page_limit,
>                                 freelist_count);
> +       cur = setup_object(s, page, cur);
>         page->freelist = cur;
>
>         for (idx = 1; idx < page->objects; idx++) {
> -               setup_object(s, page, cur);
>                 next = next_freelist_entry(s, page, &pos, start, page_limit,
>                         freelist_count);
> +               next = setup_object(s, page, next);
>                 set_freepointer(s, cur, next);
>                 cur = next;
>         }
> -       setup_object(s, page, cur);
>         set_freepointer(s, cur, NULL);
>
>         return true;
> @@ -1561,7 +1562,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>         struct page *page;
>         struct kmem_cache_order_objects oo = s->oo;
>         gfp_t alloc_gfp;
> -       void *start, *p;
> +       void *start, *p, *next;
>         int idx, order;
>         bool shuffle;
>
> @@ -1613,13 +1614,16 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>
>         if (!shuffle) {
>                 for_each_object_idx(p, idx, s, start, page->objects) {
> -                       setup_object(s, page, p);
> -                       if (likely(idx < page->objects))
> -                               set_freepointer(s, p, p + s->size);
> -                       else
> +                       if (likely(idx < page->objects)) {
> +                               next = p + s->size;
> +                               next = setup_object(s, page, next);
> +                               set_freepointer(s, p, next);
> +                       } else
>                                 set_freepointer(s, p, NULL);
>                 }
> -               page->freelist = fixup_red_left(s, start);
> +               start = fixup_red_left(s, start);
> +               start = setup_object(s, page, start);
> +               page->freelist = start;
>         }

Just want to double-check that this is correct.
We now do an additional setup_object call after the loop, but we do 1
less in the loop. So total number of calls should be the same, right?
However, after the loop we call setup_object for the first object (?),
but inside of the loop we skip the call for the last object (?). Am I
missing something, or we call ctor twice for the last object and don't
call it for the first one?


>         page->inuse = page->objects;
> --
> 2.19.0.397.gdd90340f6a-goog
