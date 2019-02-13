Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C0BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ECB222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXb5qnNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbfBMNHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:07:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44130 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733281AbfBMNHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:07:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so1132050plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYrfSHAT7eT7lR6t+0pt9fGRo4rQyrecCsCJETIVA34=;
        b=nXb5qnNnL35PnkCzwYA0t9qk3LeIUvzdFzqUgc3HfNw6XKujX0N9F4PMEc1J0smFwp
         baGeDtRtz/EmAIEsOpxxEdCjj2dkvRhWSbaek5tEdaoBJnzWHg1xmsuqiBsrDh7A5bu4
         X1Aka85RpZ0/DW0blmyF3+PdN3inqu79qIvyUq6QZ4I5flwQcXdwwvOjHk6jMzKzub19
         c7QwmFwO5g5s5xd/EI7vqwQlxJqpjucUyqCdCgTuIydMu8mFozKYOcAp19iEufp1I1G0
         /iEvJgOOr53xkFCh9x9Tifk9yF6e/Ksb8VOy2cyHj7AE35+lpqj3pap2cb3Z2ZoPtMLG
         fQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYrfSHAT7eT7lR6t+0pt9fGRo4rQyrecCsCJETIVA34=;
        b=lQ1X8UiOibiAZ8xtPsCEEyX5fInyW3UPjOiw2NGvHbw+tNG3ykzul6nhs6zBY40zs1
         9tljBaYI2MmQnQA8onirFWXoLuC/9WdGPn1DwVomyJF2t4wsa/NcSGFwvCaMbdUiVKPw
         vrfRfKn1g+EXOC5PBNgIEeE80xE0vrVlDCW4aOiMrtAIUxZRvApwMdFJi1RWpvGntOdI
         ahptpvXx80TXT/gHlH1fl3YlKO4y3vLfFBsPltfV6i9uurMLpr5lWOR6OIANwPf2Y4xF
         vFDuHfYGrMGneihRjbfvfwMvqDJSKnpoxfJfDuRqwXpKO5rJUKAs3Buvxi1oJZo1ngXq
         p1TQ==
X-Gm-Message-State: AHQUAub0Bp+h+Aznn7npgwgZXUieHjTUY4lZKv2rDVRlmcHe4HfSiB/y
        TFtXltAJeVunwZ5QcLciYzsT7KO+/xKOSJXUQtYhtA==
X-Google-Smtp-Source: AHgI3IammU4XKdw1jiSYG4IdVnZylWrkf8QLpFe83hXNhh7/4s8wn2T5j1LteGVq1mGw7MwIhKQcRSG+a2RfJ/pgPDg=
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr460245pld.236.1550063259161;
 Wed, 13 Feb 2019 05:07:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549921721.git.andreyknvl@google.com> <cd825aa4897b0fc37d3316838993881daccbe9f5.1549921721.git.andreyknvl@google.com>
 <f57831be-c57a-4a9e-992e-1f193866467b@arm.com>
In-Reply-To: <f57831be-c57a-4a9e-992e-1f193866467b@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 13 Feb 2019 14:07:28 +0100
Message-ID: <CAAeHK+y7q7BGYCnCNe1PDd+9jcmn7+F5EWxZ_hS+Ae7a2SBuew@mail.gmail.com>
Subject: Re: [PATCH 2/5] kasan, kmemleak: pass tagged pointers to kmemleak
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 4:57 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 11/02/2019 21:59, Andrey Konovalov wrote:
> > Right now we call kmemleak hooks before assigning tags to pointers in
> > KASAN hooks. As a result, when an objects gets allocated, kmemleak sees
> > a differently tagged pointer, compared to the one it sees when the object
> > gets freed. Fix it by calling KASAN hooks before kmemleak's ones.
> >
>
> Nit: Could you please add comments to the the code? It should prevent that the
> code gets refactored in future, reintroducing the same issue.

Sure, I'll send v2 with comments, thanks!

>
> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/slab.h        | 6 ++----
> >  mm/slab_common.c | 2 +-
> >  mm/slub.c        | 3 ++-
> >  3 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 4190c24ef0e9..638ea1b25d39 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -437,11 +437,9 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
> >
> >       flags &= gfp_allowed_mask;
> >       for (i = 0; i < size; i++) {
> > -             void *object = p[i];
> > -
> > -             kmemleak_alloc_recursive(object, s->object_size, 1,
> > +             p[i] = kasan_slab_alloc(s, p[i], flags);
> > +             kmemleak_alloc_recursive(p[i], s->object_size, 1,
> >                                        s->flags, flags);
> > -             p[i] = kasan_slab_alloc(s, object, flags);
> >       }
> >
> >       if (memcg_kmem_enabled())
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 81732d05e74a..fe524c8d0246 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1228,8 +1228,8 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
> >       flags |= __GFP_COMP;
> >       page = alloc_pages(flags, order);
> >       ret = page ? page_address(page) : NULL;
> > -     kmemleak_alloc(ret, size, 1, flags);
> >       ret = kasan_kmalloc_large(ret, size, flags);
> > +     kmemleak_alloc(ret, size, 1, flags);
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(kmalloc_order);
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1e3d0ec4e200..4a3d7686902f 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1374,8 +1374,9 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
> >   */
> >  static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
> >  {
> > +     ptr = kasan_kmalloc_large(ptr, size, flags);
> >       kmemleak_alloc(ptr, size, 1, flags);
> > -     return kasan_kmalloc_large(ptr, size, flags);
> > +     return ptr;
> >  }
> >
> >  static __always_inline void kfree_hook(void *x)
> >
>
> --
> Regards,
> Vincenzo
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/f57831be-c57a-4a9e-992e-1f193866467b%40arm.com.
> For more options, visit https://groups.google.com/d/optout.
