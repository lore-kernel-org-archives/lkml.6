Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180FDC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9524120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQR2ii3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9524120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeILW4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:56:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37161 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeILW4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:56:07 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so4233748itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yB2w1gbgtaNETt+9zWvsTDaSmaiy1ogRF5+/YJO15HY=;
        b=wQR2ii3B+lHYLw5VC/Rr3hTLUBq9DZZ9bSTU5WYVYSpJ3SuLKVU4i2tZvEvda1FAMt
         fMRgtrJ6T/N6SGiTt1ba/3x48uJAsqTjSQ1Mb/CQAWWRyqGItOMWp6mQp9r/ZXvRtOhC
         HYWKgGVi7ogLAzRc6iPuhrvp6+z1rYlL/IZbOS3G+0rqF9E9qzZdBfq1T+lmuP/NGgXn
         KonqViRknEkyAK7Luwi+OyT9DW5sjTu+T5ICEz2dES+vcXqmAdojuOS2hpQzAxCkYES7
         sI7BECEblCRO9mh5XsOpeuw85Mo94gHGenk79HVTuClPSTmJrCTocVAF2xBt1+VYaj5Y
         Um4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yB2w1gbgtaNETt+9zWvsTDaSmaiy1ogRF5+/YJO15HY=;
        b=eoIgGDW7Ma4h96BAKq+zkDYe+/Y2KiLy09CZERnY7nBF19YQqYc3QTDZnl+lYTxE+U
         LFa4eE7lNcsRhagDnQPErj7j7AVog05ZuhATvcsyO6t8kQgrnRjwe1lIFfJvGrIyKJ4j
         1YSfQ/cMdArgfZvxJ49wtFOqfcuYOTwjY37XJRpfc5Vb6TtfpN2Gi1+hDfHY/VQI6pt5
         EUT0tqzFiSkGZ5iaFBrreOCCnbdReC1WO4bnj0sEawRQ/R74HVhTjCdlKqlx0712vXsV
         OfmKIg+yLPzB8DMPLDxHUYypMe9F/K8oELNtBdVNykncte3st6gz8gbHv/17EwvfxeoQ
         cTog==
X-Gm-Message-State: APzg51DK9Gb102e9dvfX//uE1r13xNL3QNJt/IbFv8YjiOFhqYpQzXqA
        9MTQvIKLJOJuO8ao+/4iU0oqSNBl0eQ+MsFp0oGXUg==
X-Google-Smtp-Source: ANB0Vdaa7ErToMZXfaVMCYScTU2pG6lCnldwcIOB3G2GpaWL/b2B9/op0Zh753elMj5J7tYM9txUo9IU39GFa4TS4P0=
X-Received: by 2002:a24:ef43:: with SMTP id i64-v6mr3055233ith.47.1536774629822;
 Wed, 12 Sep 2018 10:50:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 10:50:09
 -0700 (PDT)
In-Reply-To: <f39cdef4fde40b6d2ef356db3e0126bda0e1e8c7.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com> <f39cdef4fde40b6d2ef356db3e0126bda0e1e8c7.1535462971.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Sep 2018 19:50:09 +0200
Message-ID: <CACT4Y+aNhNeR==XKQ9gHxt1p-9JS0EkjMSyWtgYi886oumh9rA@mail.gmail.com>
Subject: Re: [PATCH v6 13/18] khwasan: add bug reporting routines
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
> This commit adds rountines, that print KHWASAN error reports. Those are
> quite similar to KASAN, the difference is:
>
> 1. The way KHWASAN finds the first bad shadow cell (with a mismatching
>    tag). KHWASAN compares memory tags from the shadow memory to the pointer
>    tag.
>
> 2. KHWASAN reports all bugs with the "KASAN: invalid-access" header. This
>    is done, so various external tools that already parse the kernel logs
>    looking for KASAN reports wouldn't need to be changed.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/kasan.h     |  3 +++
>  mm/kasan/kasan.h          |  7 +++++
>  mm/kasan/kasan_report.c   |  7 ++---
>  mm/kasan/khwasan_report.c | 21 +++++++++++++++
>  mm/kasan/report.c         | 57 +++++++++++++++++++++------------------
>  5 files changed, 64 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 1f852244e739..4424359a9dfa 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -174,6 +174,9 @@ void *khwasan_preset_slub_tag(struct kmem_cache *cache, const void *addr);
>  void *khwasan_preset_slab_tag(struct kmem_cache *cache, unsigned int idx,
>                                         const void *addr);
>
> +void kasan_report(unsigned long addr, size_t size,
> +                       bool write, unsigned long ip);
> +
>  #else /* CONFIG_KASAN_HW */
>
>  static inline void khwasan_init(void) { }
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 82672473740c..d60859d26be7 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -119,8 +119,15 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value);
>  void check_memory_region(unsigned long addr, size_t size, bool write,
>                                 unsigned long ret_ip);
>
> +void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
>
> +#ifdef CONFIG_KASAN_HW

We already have #ifdef CONFIG_KASAN_HW section below with additional
functions for KASAN_HW and empty stubs otherwise. I would add this one
there as well.

> +void print_tags(u8 addr_tag, const void *addr);
> +#else
> +static inline void print_tags(u8 addr_tag, const void *addr) { }
> +#endif
> +
>  void kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
>  void kasan_report_invalid_free(void *object, unsigned long ip);
> diff --git a/mm/kasan/kasan_report.c b/mm/kasan/kasan_report.c
> index 2d8decbecbd5..fdf2d77e3125 100644
> --- a/mm/kasan/kasan_report.c
> +++ b/mm/kasan/kasan_report.c
> @@ -33,10 +33,10 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> -static const void *find_first_bad_addr(const void *addr, size_t size)
> +void *find_first_bad_addr(void *addr, size_t size)
>  {
>         u8 shadow_val = *(u8 *)kasan_mem_to_shadow(addr);
> -       const void *first_bad_addr = addr;
> +       void *first_bad_addr = addr;
>
>         while (!shadow_val && first_bad_addr < addr + size) {
>                 first_bad_addr += KASAN_SHADOW_SCALE_SIZE;
> @@ -50,9 +50,6 @@ static const char *get_shadow_bug_type(struct kasan_access_info *info)
>         const char *bug_type = "unknown-crash";
>         u8 *shadow_addr;
>
> -       info->first_bad_addr = find_first_bad_addr(info->access_addr,
> -                                               info->access_size);
> -
>         shadow_addr = (u8 *)kasan_mem_to_shadow(info->first_bad_addr);
>
>         /*
> diff --git a/mm/kasan/khwasan_report.c b/mm/kasan/khwasan_report.c
> index 2edbc3c76be5..51238b404b08 100644
> --- a/mm/kasan/khwasan_report.c
> +++ b/mm/kasan/khwasan_report.c
> @@ -37,3 +37,24 @@ const char *get_bug_type(struct kasan_access_info *info)
>  {
>         return "invalid-access";
>  }
> +
> +void *find_first_bad_addr(void *addr, size_t size)
> +{
> +       u8 tag = get_tag(addr);
> +       void *untagged_addr = reset_tag(addr);
> +       u8 *shadow = (u8 *)kasan_mem_to_shadow(untagged_addr);
> +       void *first_bad_addr = untagged_addr;
> +
> +       while (*shadow == tag && first_bad_addr < untagged_addr + size) {

I think it's better to check that are within bounds before accessing
shadow. Otherwise it's kinda potential out-of-bounds access ;)
I know that we _should_ not do an oob here, but still.
Also feels that this function can be shortened to something like:

u8 tag = get_tag(addr);
void *p = reset_tag(addr);
void *end = p + size;

while (p < end && tag == *(u8 *)kasan_mem_to_shadow(p))
        p += KASAN_SHADOW_SCALE_SIZE;
return p;


> +               first_bad_addr += KASAN_SHADOW_SCALE_SIZE;
> +               shadow = (u8 *)kasan_mem_to_shadow(first_bad_addr);
> +       }
> +       return first_bad_addr;
> +}
> +
> +void print_tags(u8 addr_tag, const void *addr)
> +{
> +       u8 *shadow = (u8 *)kasan_mem_to_shadow(addr);
> +
> +       pr_err("Pointer tag: [%02x], memory tag: [%02x]\n", addr_tag, *shadow);
> +}
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 155247a6f8a8..e031c78f2e52 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -64,11 +64,10 @@ static int __init kasan_set_multi_shot(char *str)
>  }
>  __setup("kasan_multi_shot", kasan_set_multi_shot);
>
> -static void print_error_description(struct kasan_access_info *info,
> -                                       const char *bug_type)
> +static void print_error_description(struct kasan_access_info *info)
>  {
>         pr_err("BUG: KASAN: %s in %pS\n",
> -               bug_type, (void *)info->ip);
> +               get_bug_type(info), (void *)info->ip);
>         pr_err("%s of size %zu at addr %px by task %s/%d\n",
>                 info->is_write ? "Write" : "Read", info->access_size,
>                 info->access_addr, current->comm, task_pid_nr(current));
> @@ -272,6 +271,8 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>
>         start_report(&flags);
>         pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
> +       print_tags(get_tag(object), reset_tag(object));
> +       object = reset_tag(object);
>         pr_err("\n");
>         print_address_description(object);
>         pr_err("\n");
> @@ -279,41 +280,45 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>         end_report(&flags);
>  }
>
> -static void kasan_report_error(struct kasan_access_info *info)
> -{
> -       unsigned long flags;
> -
> -       start_report(&flags);
> -
> -       print_error_description(info, get_bug_type(info));
> -       pr_err("\n");
> -
> -       if (!addr_has_shadow(info->access_addr)) {
> -               dump_stack();
> -       } else {
> -               print_address_description((void *)info->access_addr);
> -               pr_err("\n");
> -               print_shadow_for_address(info->first_bad_addr);
> -       }
> -
> -       end_report(&flags);
> -}
> -
>  void kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip)
>  {
>         struct kasan_access_info info;
> +       void *tagged_addr;
> +       void *untagged_addr;
> +       unsigned long flags;
>
>         if (likely(!report_enabled()))
>                 return;
>
>         disable_trace_on_warning();
>
> -       info.access_addr = (void *)addr;
> -       info.first_bad_addr = (void *)addr;
> +       tagged_addr = (void *)addr;
> +       untagged_addr = reset_tag(tagged_addr);
> +
> +       info.access_addr = tagged_addr;
> +       if (addr_has_shadow(untagged_addr))
> +               info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
> +       else
> +               info.first_bad_addr = untagged_addr;
>         info.access_size = size;
>         info.is_write = is_write;
>         info.ip = ip;
>
> -       kasan_report_error(&info);
> +       start_report(&flags);
> +
> +       print_error_description(&info);
> +       if (addr_has_shadow(untagged_addr))
> +               print_tags(get_tag(tagged_addr), info.first_bad_addr);
> +       pr_err("\n");
> +
> +       if (addr_has_shadow(untagged_addr)) {
> +               print_address_description(untagged_addr);
> +               pr_err("\n");
> +               print_shadow_for_address(info.first_bad_addr);
> +       } else {
> +               dump_stack();
> +       }
> +
> +       end_report(&flags);
>  }
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
