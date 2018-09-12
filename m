Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AFFC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F52120854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="doI9s09I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F52120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeILXgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:36:39 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37959 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeILXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:36:38 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so4401167ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fT+dhbnrlZazdyfjvpCBhvJ5suNcD/0tJNIj2yCUalc=;
        b=doI9s09IedWwfinCgyY8g3tw++EUdz/F7Z2czq2X3BzEA8h7850Cv+mmWExZ4uMxa3
         FXXybSa5mO5c2Oq7Ev/zE1p26Z97YOTiwR6yXOxm5Cn8ix4EcqzDUWXn1kbxQt9to1Fb
         HrNabN970LT4xYbF4gUwoCalUmM9AXsfJvduqCLRKe+axBpZT6AJf/qntHWft3V+tjAE
         B4SyUqHkcmSqxLqRyKSYsycWaN/j+ih0XyaDQOx9yoCnh+XgugPQ6dnYdXVEDChjKFzh
         8pwRri2DDDvRwVy00g+VGJ5ob9dYEF6iW7MU/nhdfGIJaa2CCqjS6ntMc/gx0CrBYd3G
         CnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fT+dhbnrlZazdyfjvpCBhvJ5suNcD/0tJNIj2yCUalc=;
        b=Q+gJiZr3sOxbA3aaL27tW8C9f7RDcdH9F1fUVhD34vRWmw69NeWzvoc9oPqj2Wrqmo
         7H80hNCFKW1Klsd5PK0NVeMsnDgkRsADwbntcEMftPHTfEtyroWulQKGS4lopTcD2mai
         4nNS/gMaUme0lMuL+//jo6SXSENuw86RUl18Kwp0S0Ss91F/2cb5Mpg48yzUlycU8FHo
         /Gg21NOH8ov6RosqHa+tGLWijCoCkIqt11SNptR7g73Q36l2O533RS3fn+8oC5zpYRwT
         A/KQr6cysBdsWQ7+nOgjW7J0UGuYK6pySomI1TdmgAvBIOdA68ckgCiuVFeXty7y7tJr
         ySIw==
X-Gm-Message-State: APzg51BFBquuG0MMVoJllk2NAEolDm0IvCRcqzF/VJ55JMHglBxPMzRp
        r0q4cIt3Y5FIyKZtn7t84PSHfSqj0OiTrWVhxkPUew==
X-Google-Smtp-Source: ANB0VdZ7w+UH1Y/Sv/H5qrUryFve3cykKgcFITjJZsVOjEN5hGV6dkmOA1NpzybBUE3EJ+3LvvOpeyhckqrvKzOk9i0=
X-Received: by 2002:a02:c04e:: with SMTP id u14-v6mr3224435jam.110.1536777052914;
 Wed, 12 Sep 2018 11:30:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 11:30:32
 -0700 (PDT)
In-Reply-To: <4267d0903e0fdf9c261b91cf8a2bf0f71047a43c.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com> <4267d0903e0fdf9c261b91cf8a2bf0f71047a43c.1535462971.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Sep 2018 20:30:32 +0200
Message-ID: <CACT4Y+YicYhmzrKf84=oJJErdFKSNM70cmoN3m_zzERcUQ_-Fg@mail.gmail.com>
Subject: Re: [PATCH v6 14/18] khwasan: add hooks implementation
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> This commit adds KHWASAN specific hooks implementation and adjusts
> common KASAN and KHWASAN ones.
>
> 1. When a new slab cache is created, KHWASAN rounds up the size of the
>    objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).
>
> 2. On each kmalloc KHWASAN generates a random tag, sets the shadow memory,
>    that corresponds to this object to this tag, and embeds this tag value
>    into the top byte of the returned pointer.
>
> 3. On each kfree KHWASAN poisons the shadow memory with a random tag to
>    allow detection of use-after-free bugs.
>
> The rest of the logic of the hook implementation is very much similar to
> the one provided by KASAN. KHWASAN saves allocation and free stack metadata
> to the slab object the same was KASAN does this.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/common.c  | 82 +++++++++++++++++++++++++++++++++++-----------
>  mm/kasan/kasan.h   |  8 +++++
>  mm/kasan/khwasan.c | 40 ++++++++++++++++++++++
>  3 files changed, 111 insertions(+), 19 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index bed8e13c6e1d..938229b26f3a 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -140,6 +140,9 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
>  {
>         void *shadow_start, *shadow_end;
>
> +       /* Perform shadow offset calculation based on untagged address */
> +       address = reset_tag(address);
> +
>         shadow_start = kasan_mem_to_shadow(address);
>         shadow_end = kasan_mem_to_shadow(address + size);
>
> @@ -148,11 +151,20 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
>
>  void kasan_unpoison_shadow(const void *address, size_t size)
>  {
> -       kasan_poison_shadow(address, size, 0);
> +       u8 tag = get_tag(address);
> +
> +       /* Perform shadow offset calculation based on untagged address */

The comment is not super-useful. It would be more useful to say why we
need to do this.
Most callers explicitly untag pointer passed to this function, for
some it's unclear if the pointer contains tag or not.
For example, __hwasan_tag_memory -- what does it accept? Tagged or untagged?


> +       address = reset_tag(address);
> +
> +       kasan_poison_shadow(address, size, tag);
>
>         if (size & KASAN_SHADOW_MASK) {
>                 u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
> -               *shadow = size & KASAN_SHADOW_MASK;
> +
> +               if (IS_ENABLED(CONFIG_KASAN_HW))
> +                       *shadow = tag;
> +               else
> +                       *shadow = size & KASAN_SHADOW_MASK;
>         }
>  }


It seems that this function is just different for kasan and khwasan.
Currently for kasan we have:

kasan_poison_shadow(address, size, tag);
if (size & KASAN_SHADOW_MASK) {
        u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
        *shadow = size & KASAN_SHADOW_MASK;
}

But what we want to say for khwasan is:

kasan_poison_shadow(address, round_up(size, KASAN_SHADOW_SCALE_SIZE),
get_tag(address));

Not sure if we want to keep a common implementation or just have
separate implementations...


>
> @@ -200,8 +212,9 @@ void kasan_unpoison_stack_above_sp_to(const void *watermark)
>
>  void kasan_alloc_pages(struct page *page, unsigned int order)
>  {
> -       if (likely(!PageHighMem(page)))
> -               kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
> +       if (unlikely(PageHighMem(page)))
> +               return;
> +       kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
>  }
>
>  void kasan_free_pages(struct page *page, unsigned int order)
> @@ -235,6 +248,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                         slab_flags_t *flags)
>  {
>         unsigned int orig_size = *size;
> +       unsigned int redzone_size = 0;

This variable seems to be always initialized below. We don't general
initialize local variables in this case.

>         int redzone_adjust;
>
>         /* Add alloc meta. */
> @@ -242,20 +256,20 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>         *size += sizeof(struct kasan_alloc_meta);
>
>         /* Add free meta. */
> -       if (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
> -           cache->object_size < sizeof(struct kasan_free_meta)) {
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> +           (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
> +            cache->object_size < sizeof(struct kasan_free_meta))) {
>                 cache->kasan_info.free_meta_offset = *size;
>                 *size += sizeof(struct kasan_free_meta);
>         }
> -       redzone_adjust = optimal_redzone(cache->object_size) -
> -               (*size - cache->object_size);
>
> +       redzone_size = optimal_redzone(cache->object_size);
> +       redzone_adjust = redzone_size - (*size - cache->object_size);
>         if (redzone_adjust > 0)
>                 *size += redzone_adjust;
>
>         *size = min_t(unsigned int, KMALLOC_MAX_SIZE,
> -                       max(*size, cache->object_size +
> -                                       optimal_redzone(cache->object_size)));
> +                       max(*size, cache->object_size + redzone_size));
>
>         /*
>          * If the metadata doesn't fit, don't enable KASAN at all.
> @@ -268,6 +282,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                 return;
>         }
>
> +       cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> +
>         *flags |= SLAB_KASAN;
>  }
>
> @@ -328,15 +344,30 @@ void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
>         return kasan_kmalloc(cache, object, cache->object_size, flags);
>  }
>
> +static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
> +{
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               return shadow_byte < 0 ||
> +                       shadow_byte >= KASAN_SHADOW_SCALE_SIZE;
> +       else
> +               return tag != (u8)shadow_byte;
> +}
> +
>  static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>                               unsigned long ip, bool quarantine)
>  {
>         s8 shadow_byte;
> +       u8 tag;
> +       void *tagged_object;
>         unsigned long rounded_up_size;
>
> +       tag = get_tag(object);
> +       tagged_object = object;
> +       object = reset_tag(object);
> +
>         if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
>             object)) {
> -               kasan_report_invalid_free(object, ip);
> +               kasan_report_invalid_free(tagged_object, ip);
>                 return true;
>         }
>
> @@ -345,20 +376,22 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>                 return false;
>
>         shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
> -       if (shadow_byte < 0 || shadow_byte >= KASAN_SHADOW_SCALE_SIZE) {
> -               kasan_report_invalid_free(object, ip);
> +       if (shadow_invalid(tag, shadow_byte)) {
> +               kasan_report_invalid_free(tagged_object, ip);
>                 return true;
>         }
>
>         rounded_up_size = round_up(cache->object_size, KASAN_SHADOW_SCALE_SIZE);
>         kasan_poison_shadow(object, rounded_up_size, KASAN_KMALLOC_FREE);
>
> -       if (!quarantine || unlikely(!(cache->flags & SLAB_KASAN)))
> +       if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
> +                       unlikely(!(cache->flags & SLAB_KASAN)))
>                 return false;
>
>         set_track(&get_alloc_info(cache, object)->free_track, GFP_NOWAIT);
>         quarantine_put(get_free_info(cache, object), cache);
> -       return true;
> +
> +       return IS_ENABLED(CONFIG_KASAN_GENERIC);
>  }
>
>  bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
> @@ -371,6 +404,7 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
>  {
>         unsigned long redzone_start;
>         unsigned long redzone_end;
> +       u8 tag;
>
>         if (gfpflags_allow_blocking(flags))
>                 quarantine_reduce();
> @@ -383,14 +417,24 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
>         redzone_end = round_up((unsigned long)object + cache->object_size,
>                                 KASAN_SHADOW_SCALE_SIZE);
>
> -       kasan_unpoison_shadow(object, size);
> +       /*
> +        * Objects with contructors and objects from SLAB_TYPESAFE_BY_RCU slabs
> +        * have tags preassigned and are already tagged.
> +        */
> +       if (IS_ENABLED(CONFIG_KASAN_HW) &&
> +                       (cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU))
> +               tag = get_tag(object);
> +       else
> +               tag = random_tag();
> +
> +       kasan_unpoison_shadow(set_tag(object, tag), size);
>         kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
>                 KASAN_KMALLOC_REDZONE);
>
>         if (cache->flags & SLAB_KASAN)
>                 set_track(&get_alloc_info(cache, object)->alloc_track, flags);
>
> -       return (void *)object;
> +       return set_tag(object, tag);
>  }
>  EXPORT_SYMBOL(kasan_kmalloc);
>
> @@ -440,7 +484,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
>         page = virt_to_head_page(ptr);
>
>         if (unlikely(!PageSlab(page))) {
> -               if (ptr != page_address(page)) {
> +               if (reset_tag(ptr) != page_address(page)) {
>                         kasan_report_invalid_free(ptr, ip);
>                         return;
>                 }
> @@ -453,7 +497,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
>
>  void kasan_kfree_large(void *ptr, unsigned long ip)
>  {
> -       if (ptr != page_address(virt_to_head_page(ptr)))
> +       if (reset_tag(ptr) != page_address(virt_to_head_page(ptr)))
>                 kasan_report_invalid_free(ptr, ip);
>         /* The object will be poisoned by page_alloc. */
>  }
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index d60859d26be7..6f4f2ebf5f57 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -12,10 +12,18 @@
>  #define KHWASAN_TAG_INVALID    0xFE /* inaccessible memory tag */
>  #define KHWASAN_TAG_MAX                0xFD /* maximum value for random tags */
>
> +#ifdef CONFIG_KASAN_GENERIC
>  #define KASAN_FREE_PAGE         0xFF  /* page was freed */
>  #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
>  #define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
>  #define KASAN_KMALLOC_FREE      0xFB  /* object was freed (kmem_cache_free/kfree) */
> +#else
> +#define KASAN_FREE_PAGE         KHWASAN_TAG_INVALID
> +#define KASAN_PAGE_REDZONE      KHWASAN_TAG_INVALID
> +#define KASAN_KMALLOC_REDZONE   KHWASAN_TAG_INVALID
> +#define KASAN_KMALLOC_FREE      KHWASAN_TAG_INVALID
> +#endif
> +
>  #define KASAN_GLOBAL_REDZONE    0xFA  /* redzone for global variable */
>
>  /*
> diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
> index 9d91bf3c8246..6b1309278e39 100644
> --- a/mm/kasan/khwasan.c
> +++ b/mm/kasan/khwasan.c
> @@ -106,15 +106,52 @@ void *khwasan_preset_slab_tag(struct kmem_cache *cache, unsigned int idx,
>  void check_memory_region(unsigned long addr, size_t size, bool write,
>                                 unsigned long ret_ip)
>  {
> +       u8 tag;
> +       u8 *shadow_first, *shadow_last, *shadow;
> +       void *untagged_addr;
> +
> +       tag = get_tag((const void *)addr);
> +
> +       /* Ignore accesses for pointers tagged with 0xff (native kernel

/* on a separate line

> +        * pointer tag) to suppress false positives caused by kmap.
> +        *
> +        * Some kernel code was written to account for archs that don't keep
> +        * high memory mapped all the time, but rather map and unmap particular
> +        * pages when needed. Instead of storing a pointer to the kernel memory,
> +        * this code saves the address of the page structure and offset within
> +        * that page for later use. Those pages are then mapped and unmapped
> +        * with kmap/kunmap when necessary and virt_to_page is used to get the
> +        * virtual address of the page. For arm64 (that keeps the high memory
> +        * mapped all the time), kmap is turned into a page_address call.
> +
> +        * The issue is that with use of the page_address + virt_to_page
> +        * sequence the top byte value of the original pointer gets lost (gets
> +        * set to KHWASAN_TAG_KERNEL (0xFF).

Missed closing bracket.

> +        */
> +       if (tag == KHWASAN_TAG_KERNEL)
> +               return;
> +
> +       untagged_addr = reset_tag((const void *)addr);
> +       shadow_first = kasan_mem_to_shadow(untagged_addr);
> +       shadow_last = kasan_mem_to_shadow(untagged_addr + size - 1);
> +
> +       for (shadow = shadow_first; shadow <= shadow_last; shadow++) {
> +               if (*shadow != tag) {
> +                       kasan_report(addr, size, write, ret_ip);
> +                       return;
> +               }
> +       }
>  }
>
>  #define DEFINE_HWASAN_LOAD_STORE(size)                                 \
>         void __hwasan_load##size##_noabort(unsigned long addr)          \
>         {                                                               \
> +               check_memory_region(addr, size, false, _RET_IP_);       \
>         }                                                               \
>         EXPORT_SYMBOL(__hwasan_load##size##_noabort);                   \
>         void __hwasan_store##size##_noabort(unsigned long addr)         \
>         {                                                               \
> +               check_memory_region(addr, size, true, _RET_IP_);        \
>         }                                                               \
>         EXPORT_SYMBOL(__hwasan_store##size##_noabort)
>
> @@ -126,15 +163,18 @@ DEFINE_HWASAN_LOAD_STORE(16);
>
>  void __hwasan_loadN_noabort(unsigned long addr, unsigned long size)
>  {
> +       check_memory_region(addr, size, false, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__hwasan_loadN_noabort);
>
>  void __hwasan_storeN_noabort(unsigned long addr, unsigned long size)
>  {
> +       check_memory_region(addr, size, true, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__hwasan_storeN_noabort);
>
>  void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
>  {
> +       kasan_poison_shadow((void *)addr, size, tag);
>  }
>  EXPORT_SYMBOL(__hwasan_tag_memory);
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
