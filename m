Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A86AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7862087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVhLQ+ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7862087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeILV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:27:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36974 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeILV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:27:16 -0400
Received: by mail-io1-f66.google.com with SMTP id v14-v6so690129iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A9TRAdIM/Ws//6T2i62BrH632SkUJID9ih/QsfzeHr4=;
        b=tVhLQ+utBu+7Z8mh7yzT5qU3XutsN6huL6o6giwHMMyxXjS2sooewELYfaLFG4x1Qp
         qP/06oKr9lQaBgUgmVL6VZjFVeOhcnEXIOrh9uLpctZst9mBLSND2CyOC+9zds9+3RBh
         rgun8+jB3B98GD4+321zDQuamxCa7fTrLnCBNv8HPIwpM3h7IYKHaZIbMhR8HfWXaA2r
         oauOmMBiXFE9FQXNtG+xVlHi9bdUYR5jX4ZyaG6O68PeJlwwis4NbQsdz87cp73em7JX
         CHZOSsTLEFUGkZqtdShyaUuvRUUpclfdmNjOFfKFXHSyI3EgHgJvqyrWXTBO1bdhb0t8
         Vhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A9TRAdIM/Ws//6T2i62BrH632SkUJID9ih/QsfzeHr4=;
        b=NKSg6/ReQJbYR73FOE5P3OyjA7b5QM4CHfsWLfZu9lfHnyTwBrhkHR4njvfPIb2YBv
         iGlIkIYqiSDl1gSLtx0ZLjAWIXGbQ9GvDzZYAG1Hf00XLX/m8zDmGt/2xdpRY+BJEJDB
         sEaZg/PslrhJe/mZxTcEeTYf91+EncKCyS7Cg7KeqZWSrEkqXP7op8CSDWHZEdaiFaRC
         tLms6h4D7mIZ9l0vawv/nyzE7daUdIy933Scrb36hFZcDfdAzVFMu19jRoD8lu0Fqx2f
         +eteQsEeKPXDFy9pSxcaNFo0falBX2A7TOnxEPrrluhkEqB16GFcHgbrGt/f0O6sEtll
         dU2A==
X-Gm-Message-State: APzg51Cwdk/CFb/gX0BHOLooU2ShVAFicbUN0K4/lW7G0F9tk3am8rkN
        0i7Z4eAOBz0wl8NBGBP0dRpCeE25nST/kv0SQE5POg==
X-Google-Smtp-Source: ANB0VdbZR6fUt9YbvuwgL1RDBB9wjO0Pkl+s9OacyXBddJjzAY4SPc2XHDWm/LuTiBH/WygHiGs7bBBB2jYcYyMyW+c=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr2265215ioe.282.1536769319284;
 Wed, 12 Sep 2018 09:21:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 09:21:38
 -0700 (PDT)
In-Reply-To: <6cd298a90d02068969713f2fd440eae21227467b.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com> <6cd298a90d02068969713f2fd440eae21227467b.1535462971.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Sep 2018 18:21:38 +0200
Message-ID: <CACT4Y+adO3n4Nb4XOPyXdt43DbYjb=Kz6__tPTmb1CX=00qNSQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/18] khwasan: add tag related helper functions
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
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> w=
rote:
> This commit adds a few helper functions, that are meant to be used to
> work with tags embedded in the top byte of kernel pointers: to set, to
> get or to reset (set to 0xff) the top byte.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/mm/kasan_init.c |  2 ++
>  include/linux/kasan.h      | 29 +++++++++++++++++
>  mm/kasan/kasan.h           | 55 ++++++++++++++++++++++++++++++++
>  mm/kasan/khwasan.c         | 65 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 151 insertions(+)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 7a31e8ccbad2..e7f37c0b7e14 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -250,6 +250,8 @@ void __init kasan_init(void)
>         memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
>         cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
>
> +       khwasan_init();
> +
>         /* At this point kasan is fully initialized. Enable error message=
s */
>         init_task.kasan_depth =3D 0;
>         pr_info("KernelAddressSanitizer initialized\n");
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 1c31bb089154..1f852244e739 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -166,6 +166,35 @@ static inline void kasan_cache_shutdown(struct kmem_=
cache *cache) {}
>
>  #define KASAN_SHADOW_INIT 0xFF
>
> +void khwasan_init(void);
> +
> +void *khwasan_reset_tag(const void *addr);
> +
> +void *khwasan_preset_slub_tag(struct kmem_cache *cache, const void *addr=
);
> +void *khwasan_preset_slab_tag(struct kmem_cache *cache, unsigned int idx=
,
> +                                       const void *addr);
> +
> +#else /* CONFIG_KASAN_HW */
> +
> +static inline void khwasan_init(void) { }
> +
> +static inline void *khwasan_reset_tag(const void *addr)
> +{
> +       return (void *)addr;
> +}
> +
> +static inline void *khwasan_preset_slub_tag(struct kmem_cache *cache,
> +                                               const void *addr)
> +{
> +       return (void *)addr;
> +}
> +
> +static inline void *khwasan_preset_slab_tag(struct kmem_cache *cache,
> +                                       unsigned int idx, const void *add=
r)
> +{
> +       return (void *)addr;
> +}
> +
>  #endif /* CONFIG_KASAN_HW */
>
>  #endif /* LINUX_KASAN_H */
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 19b950eaccff..a7cc27d96608 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -8,6 +8,10 @@
>  #define KASAN_SHADOW_SCALE_SIZE (1UL << KASAN_SHADOW_SCALE_SHIFT)
>  #define KASAN_SHADOW_MASK       (KASAN_SHADOW_SCALE_SIZE - 1)
>
> +#define KHWASAN_TAG_KERNEL     0xFF /* native kernel pointers tag */
> +#define KHWASAN_TAG_INVALID    0xFE /* inaccessible memory tag */
> +#define KHWASAN_TAG_MAX                0xFD /* maximum value for random =
tags */
> +
>  #define KASAN_FREE_PAGE         0xFF  /* page was freed */
>  #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large alloc=
ations */
>  #define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
> @@ -126,6 +130,57 @@ static inline void quarantine_reduce(void) { }
>  static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
>  #endif
>
> +#ifdef CONFIG_KASAN_HW
> +
> +#define KHWASAN_TAG_SHIFT 56
> +#define KHWASAN_TAG_MASK (0xFFUL << KHWASAN_TAG_SHIFT)
> +
> +u8 random_tag(void);
> +
> +static inline void *set_tag(const void *addr, u8 tag)
> +{
> +       u64 a =3D (u64)addr;
> +
> +       a &=3D ~KHWASAN_TAG_MASK;
> +       a |=3D ((u64)tag << KHWASAN_TAG_SHIFT);
> +
> +       return (void *)a;
> +}
> +
> +static inline u8 get_tag(const void *addr)
> +{
> +       return (u8)((u64)addr >> KHWASAN_TAG_SHIFT);
> +}
> +
> +static inline void *reset_tag(const void *addr)
> +{
> +       return set_tag(addr, KHWASAN_TAG_KERNEL);
> +}
> +
> +#else /* CONFIG_KASAN_HW */
> +
> +static inline u8 random_tag(void)
> +{
> +       return 0;
> +}
> +
> +static inline void *set_tag(const void *addr, u8 tag)
> +{
> +       return (void *)addr;
> +}
> +
> +static inline u8 get_tag(const void *addr)
> +{
> +       return 0;
> +}
> +
> +static inline void *reset_tag(const void *addr)
> +{
> +       return (void *)addr;
> +}
> +
> +#endif /* CONFIG_KASAN_HW */
> +
>  /*
>   * Exported functions for interfaces called from assembly or from genera=
ted
>   * code. Declarations here to avoid warning about missing declarations.
> diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
> index e2c3a7f7fd1f..9d91bf3c8246 100644
> --- a/mm/kasan/khwasan.c
> +++ b/mm/kasan/khwasan.c
> @@ -38,6 +38,71 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> +static DEFINE_PER_CPU(u32, prng_state);
> +
> +void khwasan_init(void)
> +{
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu)
> +               per_cpu(prng_state, cpu) =3D get_random_u32();
> +}
> +
> +/*
> + * If a preemption happens between this_cpu_read and this_cpu_write, the=
 only
> + * side effect is that we'll give a few allocated in different contexts =
objects
> + * the same tag. Since KHWASAN is meant to be used a probabilistic bug-d=
etection
> + * debug feature, this doesn=E2=80=99t have significant negative impact.
> + *
> + * Ideally the tags use strong randomness to prevent any attempts to pre=
dict
> + * them during explicit exploit attempts. But strong randomness is expen=
sive,
> + * and we did an intentional trade-off to use a PRNG. This non-atomic RM=
W
> + * sequence has in fact positive effect, since interrupts that randomly =
skew
> + * PRNG at unpredictable points do only good.
> + */
> +u8 random_tag(void)
> +{
> +       u32 state =3D this_cpu_read(prng_state);
> +
> +       state =3D 1664525 * state + 1013904223;
> +       this_cpu_write(prng_state, state);
> +
> +       return (u8)(state % (KHWASAN_TAG_MAX + 1));
> +}
> +
> +void *khwasan_reset_tag(const void *addr)
> +{
> +       return reset_tag(addr);
> +}
> +
> +void *khwasan_preset_slub_tag(struct kmem_cache *cache, const void *addr=
)

Can't we do this in the existing kasan_init_slab_obj() hook? It looks
like it should do exactly this -- allow any one-time initialization
for objects. We could extend it to accept index and return a new
pointer.
If that does not work for some reason, I would try to at least unify
the hook for slab/slub, e.g. pass idx=3D-1 from slub and then use
random_tag().
It also seems that we do preset tag for slab multiple times (from
slab_get_obj()). Using kasan_init_slab_obj() should resolve this too
(hopefully we don't call it multiple times).


> +{
> +       /*
> +        * Since it's desirable to only call object contructors ones duri=
ng
> +        * slab allocation, we preassign tags to all such objects.
> +        * Also preassign tags for SLAB_TYPESAFE_BY_RCU slabs to avoid
> +        * use-after-free reports.
> +        */
> +       if (cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU)
> +               return set_tag(addr, random_tag());
> +       return (void *)addr;
> +}
> +
> +void *khwasan_preset_slab_tag(struct kmem_cache *cache, unsigned int idx=
,
> +                               const void *addr)
> +{
> +       /*
> +        * See comment in khwasan_preset_slub_tag.
> +        * For SLAB allocator we can't preassign tags randomly since the
> +        * freelist is stored as an array of indexes instead of a linked
> +        * list. Assign tags based on objects indexes, so that objects th=
at
> +        * are next to each other get different tags.
> +        */
> +       if (cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU)
> +               return set_tag(addr, (u8)idx);
> +       return (void *)addr;
> +}
> +
>  void check_memory_region(unsigned long addr, size_t size, bool write,
>                                 unsigned long ret_ip)
>  {
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
