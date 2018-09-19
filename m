Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C9ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA76214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYuijPmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA76214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbeISRcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:32:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40470 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbeISRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:32:00 -0400
Received: by mail-io1-f66.google.com with SMTP id l14-v6so4213013iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 04:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TN3QNhjkYmw+HaBkvgCjeas8QL9MY9/JuWC0ExTNN4o=;
        b=PYuijPmDpDUM5Hb3P+jRogRYdga0+2EzCa9Sqq5z9BIgrwUVwZQ8dE5LQTQPaMqz+a
         8fiBxh7PtngyuI7n2nluQovcivuvczjAGFAyKowM2V0nuCs96jqo1hsYwylJ61PXBZGV
         bbhragISEp7Ye4Z2oFx5DSeEmA55fWNhc2JTmduIMwzBNW00bSDvDwsiYd0Z0vnHFflL
         k4YNy9Gsz5GO//BYNRshaLumRIG9Y/oy5PsuGsur2yqdHCbv7YZwKkJg0i5VWfT2kWXE
         ymoWZnSlqOH9zPPjE7MyezNleyYOEGlcNseQJkQz1tW7fIR2jZvk+JNp7ghEsVeeTE29
         AeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TN3QNhjkYmw+HaBkvgCjeas8QL9MY9/JuWC0ExTNN4o=;
        b=JG6nsEHIMBiJcQz7XwtfU+r2fX988vx7AuGhJsNUuiV4l/xl+UGXy/ljOFVQDSTVKu
         iKGiJc9Z2lKqdPYAunA7S7VpvVq6V2SMmAXXxVwAbQzMY3kdUtE+hSCdCIQRJOasYI8I
         5jlNh53czpg3v2RXmQenGlaC/e+EfgE/rFidL6+8flD8Rq+VztX+VnGDzTva8j0fiFf7
         ba6Z699MqSdxUDpN7FOFBV/WHC6Yt8vzHzzxJH7IjT+wbtGNm11JAt43x00xv0wze5oz
         gmfhNW/1sb4YMmR+N+JINBSTUsA7f1h/4YTOT/voqtcGpRk1QgVzECtQ9WQNT4eIIQsP
         f0iA==
X-Gm-Message-State: APzg51BHaC6ERrjczEQKmVSNQyVn+40xvkmG2hjr41LWq2S3ji7hoeOI
        kVKDh2/BxaSa8Oe+EZexKCwapqwuVtkdJDB3chbf+g==
X-Google-Smtp-Source: ANB0Vda/TSY5GBQv89JSajwxw8ANC9OEuaIBS3CoGpgBvPLzzhDlrCxmenhqlK89cazbWen0QpQ4VlXoG+pv5XijtSE=
X-Received: by 2002:a6b:1707:: with SMTP id 7-v6mr28516531iox.119.1537358064356;
 Wed, 19 Sep 2018 04:54:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 04:54:23
 -0700 (PDT)
In-Reply-To: <CACT4Y+YicYhmzrKf84=oJJErdFKSNM70cmoN3m_zzERcUQ_-Fg@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <4267d0903e0fdf9c261b91cf8a2bf0f71047a43c.1535462971.git.andreyknvl@google.com>
 <CACT4Y+YicYhmzrKf84=oJJErdFKSNM70cmoN3m_zzERcUQ_-Fg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 19 Sep 2018 13:54:23 +0200
Message-ID: <CAAeHK+xMjDwZkKDn_0aVWERkjv6B-hFKjn0coGo4LbcPBds4Ew@mail.gmail.com>
Subject: Re: [PATCH v6 14/18] khwasan: add hooks implementation
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Wed, Sep 12, 2018 at 8:30 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>>  void kasan_unpoison_shadow(const void *address, size_t size)
>>  {
>> -       kasan_poison_shadow(address, size, 0);
>> +       u8 tag = get_tag(address);
>> +
>> +       /* Perform shadow offset calculation based on untagged address */
>
> The comment is not super-useful. It would be more useful to say why we
> need to do this.
> Most callers explicitly untag pointer passed to this function, for
> some it's unclear if the pointer contains tag or not.
> For example, __hwasan_tag_memory -- what does it accept? Tagged or untagged?

There are some callers that pass tagged pointers to this functions,
e.g. ksize or kasan_unpoison_object_data. I'll expand the comment.

>
>
>> +       address = reset_tag(address);
>> +
>> +       kasan_poison_shadow(address, size, tag);
>>
>>         if (size & KASAN_SHADOW_MASK) {
>>                 u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
>> -               *shadow = size & KASAN_SHADOW_MASK;
>> +
>> +               if (IS_ENABLED(CONFIG_KASAN_HW))
>> +                       *shadow = tag;
>> +               else
>> +                       *shadow = size & KASAN_SHADOW_MASK;
>>         }
>>  }
>
>
> It seems that this function is just different for kasan and khwasan.
> Currently for kasan we have:
>
> kasan_poison_shadow(address, size, tag);
> if (size & KASAN_SHADOW_MASK) {
>         u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
>         *shadow = size & KASAN_SHADOW_MASK;
> }
>
> But what we want to say for khwasan is:
>
> kasan_poison_shadow(address, round_up(size, KASAN_SHADOW_SCALE_SIZE),
> get_tag(address));
>
> Not sure if we want to keep a common implementation or just have
> separate implementations...

As per offline discussion leaving as is.


>>  void kasan_free_pages(struct page *page, unsigned int order)
>> @@ -235,6 +248,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>>                         slab_flags_t *flags)
>>  {
>>         unsigned int orig_size = *size;
>> +       unsigned int redzone_size = 0;
>
> This variable seems to be always initialized below. We don't general
> initialize local variables in this case.

Will fix in v7.

>>  void check_memory_region(unsigned long addr, size_t size, bool write,
>>                                 unsigned long ret_ip)
>>  {
>> +       u8 tag;
>> +       u8 *shadow_first, *shadow_last, *shadow;
>> +       void *untagged_addr;
>> +
>> +       tag = get_tag((const void *)addr);
>> +
>> +       /* Ignore accesses for pointers tagged with 0xff (native kernel
>
> /* on a separate line

Will fix in v7.

>
>> +        * pointer tag) to suppress false positives caused by kmap.
>> +        *
>> +        * Some kernel code was written to account for archs that don't keep
>> +        * high memory mapped all the time, but rather map and unmap particular
>> +        * pages when needed. Instead of storing a pointer to the kernel memory,
>> +        * this code saves the address of the page structure and offset within
>> +        * that page for later use. Those pages are then mapped and unmapped
>> +        * with kmap/kunmap when necessary and virt_to_page is used to get the
>> +        * virtual address of the page. For arm64 (that keeps the high memory
>> +        * mapped all the time), kmap is turned into a page_address call.
>> +
>> +        * The issue is that with use of the page_address + virt_to_page
>> +        * sequence the top byte value of the original pointer gets lost (gets
>> +        * set to KHWASAN_TAG_KERNEL (0xFF).
>
> Missed closing bracket.

Will fix in v7.
