Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F7BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B32089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTJFD8L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfAHGNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:13:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37072 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfAHGNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:13:47 -0500
Received: by mail-io1-f65.google.com with SMTP id g8so2305305iok.4;
        Mon, 07 Jan 2019 22:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ox64a/yC3qLLjF9n5uAx7+v1XSScVyOongunkuI6os=;
        b=lTJFD8L2TtB2aoFFZKtYweTog9uLAUtPnOKT/dinKGbY9wnLgc9VL4LOwmejQs0c9V
         jgiuUaEd/7I+vpFRHkj6gy7xUPdp8NQmGlbWSMHmYOTIvuCW86KNJs/MU7SlV89wQ1NC
         ky+ICYV4mQJakzkE1hqPhJCTJKSb6v9LnquUml6jpcMMKZkhIKlWd6j1dA5/loNTvTgP
         6GRCIK6FMSlAnWFVIQv15Mwy9hAwztH43Mz9484TbZUVb5JkbZi5UmA9otzSSK0F4L82
         XAbAE9v2rAFcbNiN/NYoDjZFtwZDdT+rmy7eqp3HEul36r1CqbKn6NVmy4Owu5jjC+zT
         Zjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ox64a/yC3qLLjF9n5uAx7+v1XSScVyOongunkuI6os=;
        b=BCgCGgwBnGKM1SB8EwVmlrucAssyjl3fT/3fPpGQNJp96Vv9VyyIP+rj2NMDMlwua1
         Ddg2nJ4Vxk73fuNbp2cytxTLHrlBM5aXRTv6dGJDAdB1sM+LyzNVAKH29aLOppZMsBHu
         QZn0jxvR4cJHZaXB9sDLFzQyunWH21bJpPAYt/EaARsMb1vBguxZ4JvBowHF4gILFqdg
         /2FHvAL1FLLSH5Nztmsu4rRtzrw7IPS84YJDhHkDMcFjDldxRpFALOeI7NtOQ4JN5B+a
         f0lbJ3gEySBieL6OgC62OwyPBqw9d3gsZi+wy++GWzhaz5n9aSBzFHXwMLX2CVgFQgwi
         hdlw==
X-Gm-Message-State: AJcUukcHTard54rgwY5oFsLgwDeFmN1NJxwPe9fw7dvovUT7xqKdc1xt
        vh+Q7IVWTFdgYHGJhI7HezMQBxHbtZ1FsJ4prQ==
X-Google-Smtp-Source: ALg8bN5Jdsd4SpnEPBJ1Ibg2ud5xc4CfqNe/OyJwnRt5rmwI0W8XWFZThP/3qQ0aYqNXpGNYfpLiJmxWDFG0jsY/0LY=
X-Received: by 2002:a6b:39c6:: with SMTP id g189mr235158ioa.255.1546928026109;
 Mon, 07 Jan 2019 22:13:46 -0800 (PST)
MIME-Version: 1.0
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
 <1546849485-27933-5-git-send-email-kernelfans@gmail.com> <57ca63ef-ac5b-edd7-710b-f7ee698207c9@intel.com>
In-Reply-To: <57ca63ef-ac5b-edd7-710b-f7ee698207c9@intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 8 Jan 2019 14:13:34 +0800
Message-ID: <CAFgQCTudfQDAzKGYLAo_TuoEaEExzGn018mRewQ_LZvZbVDU+A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] x86/mm: remove bottom-up allocation style for x86_64
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 1:42 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/7/19 12:24 AM, Pingfan Liu wrote:
> > There are two acheivements by this patch.
> > -1st. keep the subtree of pgtable away from movable node.
> > Background about the defect of the current bottom-up allocation style, take
> > the following scenario:
> >   |  unmovable node |     movable node                           |
> >      | kaslr-kernel |subtree of pgtable for phy<->virt |
>
>
>
> > Although kaslr-kernel can avoid to stain the movable node. [1] But the
> > pgtable can still stain the movable node. That is a probability problem,
> > with low probability, but still exist. This patch tries to eliminate the
> > probability. With the previous patch, at the point of init_mem_mapping(),
> > memblock allocator can work with the knowledge of acpi memory hotmovable
> > info, and avoid to stain the movable node. As a result,
> > memory_map_bottom_up() is not needed any more.
> >
> > -2nd. simplify the logic of memory_map_top_down()
> > Thanks to the help of early_make_pgtable(), x86_64 can directly set up the
> > subtree of pgtable at any place, hence the careful iteration in
> > memory_map_top_down() can be discard.
>
> >  void __init init_mem_mapping(void)
> >  {
> >       unsigned long end;
> > @@ -663,6 +540,7 @@ void __init init_mem_mapping(void)
> >
> >  #ifdef CONFIG_X86_64
> >       end = max_pfn << PAGE_SHIFT;
> > +     set_alloc_range(0x100000, end);
> >  #else
>
> Why is this 0x100000 open-coded?  Why is this needed *now*?
>

Memory under 1MB should be used by BIOS. For x86_64, after
e820__memblock_setup(), the memblock allocator has already been ready
to work. But there are two factors to in order to
set_alloc_range(0x100000, end). The major one is to be compatible with
x86_32, please refer to alloc_low_pages->memblock_find_in_range() uses
[min_pfn_mapped, max_pfn_mapped] to limit the range, which is ready to
be allocated from. The minor one is to prevent unexpected allocation
from memblock allocator through allow_low_pages() at very early stage.
>
> >       /*
> >        * If the allocation is in bottom-up direction, we setup direct mapping
> >        * in bottom-up, otherwise we setup direct mapping in top-down.
> > @@ -692,13 +577,6 @@ void __init init_mem_mapping(void)
> >       } else {
> >               memory_map_top_down(ISA_END_ADDRESS, end);
> >       }
> > -
> > -#ifdef CONFIG_X86_64
> > -     if (max_pfn > max_low_pfn) {
> > -             /* can we preseve max_low_pfn ?*/
> > -             max_low_pfn = max_pfn;
> > -     }
> > -#else
> >       early_ioremap_page_table_range_init();
> >  #endif
> >
> > diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> > index 85c94f9..ecf7243 100644
> > --- a/arch/x86/mm/init_32.c
> > +++ b/arch/x86/mm/init_32.c
> > @@ -58,6 +58,8 @@ unsigned long highstart_pfn, highend_pfn;
> >
> >  bool __read_mostly __vmalloc_start_set = false;
> >
> > +static unsigned long min_pfn_mapped;
> > +
> >  /*
> >   * Creates a middle page table and puts a pointer to it in the
> >   * given global directory entry. This only returns the gd entry
> > @@ -516,6 +518,127 @@ void __init native_pagetable_init(void)
> >       paging_init();
> >  }
> >
> > +static unsigned long __init get_new_step_size(unsigned long step_size)
> > +{
> > +     /*
> > +      * Initial mapped size is PMD_SIZE (2M).
> > +      * We can not set step_size to be PUD_SIZE (1G) yet.
> > +      * In worse case, when we cross the 1G boundary, and
> > +      * PG_LEVEL_2M is not set, we will need 1+1+512 pages (2M + 8k)
> > +      * to map 1G range with PTE. Hence we use one less than the
> > +      * difference of page table level shifts.
> > +      *
> > +      * Don't need to worry about overflow in the top-down case, on 32bit,
> > +      * when step_size is 0, round_down() returns 0 for start, and that
> > +      * turns it into 0x100000000ULL.
> > +      * In the bottom-up case, round_up(x, 0) returns 0 though too, which
> > +      * needs to be taken into consideration by the code below.
> > +      */
> > +     return step_size << (PMD_SHIFT - PAGE_SHIFT - 1);
> > +}
> > +
> > +/**
> > + * memory_map_top_down - Map [map_start, map_end) top down
> > + * @map_start: start address of the target memory range
> > + * @map_end: end address of the target memory range
> > + *
> > + * This function will setup direct mapping for memory range
> > + * [map_start, map_end) in top-down. That said, the page tables
> > + * will be allocated at the end of the memory, and we map the
> > + * memory in top-down.
> > + */
> > +void __init memory_map_top_down(unsigned long map_start,
> > +                                    unsigned long map_end)
> > +{
> > +     unsigned long real_end, start, last_start;
> > +     unsigned long step_size;
> > +     unsigned long addr;
> > +     unsigned long mapped_ram_size = 0;
> > +
> > +     /* xen has big range in reserved near end of ram, skip it at first.*/
> > +     addr = memblock_find_in_range(map_start, map_end, PMD_SIZE, PMD_SIZE);
> > +     real_end = addr + PMD_SIZE;
> > +
> > +     /* step_size need to be small so pgt_buf from BRK could cover it */
> > +     step_size = PMD_SIZE;
> > +     max_pfn_mapped = 0; /* will get exact value next */
> > +     min_pfn_mapped = real_end >> PAGE_SHIFT;
> > +     last_start = start = real_end;
> > +
> > +     /*
> > +      * We start from the top (end of memory) and go to the bottom.
> > +      * The memblock_find_in_range() gets us a block of RAM from the
> > +      * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
> > +      * for page table.
> > +      */
> > +     while (last_start > map_start) {
> > +             if (last_start > step_size) {
> > +                     start = round_down(last_start - 1, step_size);
> > +                     if (start < map_start)
> > +                             start = map_start;
> > +             } else
> > +                     start = map_start;
> > +             mapped_ram_size += init_range_memory_mapping(start,
> > +                                                     last_start);
> > +             set_alloc_range(min_pfn_mapped, max_pfn_mapped);
> > +             last_start = start;
> > +             min_pfn_mapped = last_start >> PAGE_SHIFT;
> > +             if (mapped_ram_size >= step_size)
> > +                     step_size = get_new_step_size(step_size);
> > +     }
> > +
> > +     if (real_end < map_end) {
> > +             init_range_memory_mapping(real_end, map_end);
> > +             set_alloc_range(min_pfn_mapped, max_pfn_mapped);
> > +     }
> > +}
> > +
> > +/**
> > + * memory_map_bottom_up - Map [map_start, map_end) bottom up
> > + * @map_start: start address of the target memory range
> > + * @map_end: end address of the target memory range
> > + *
> > + * This function will setup direct mapping for memory range
> > + * [map_start, map_end) in bottom-up. Since we have limited the
> > + * bottom-up allocation above the kernel, the page tables will
> > + * be allocated just above the kernel and we map the memory
> > + * in [map_start, map_end) in bottom-up.
> > + */
> > +void __init memory_map_bottom_up(unsigned long map_start,
> > +                                     unsigned long map_end)
> > +{
> > +     unsigned long next, start;
> > +     unsigned long mapped_ram_size = 0;
> > +     /* step_size need to be small so pgt_buf from BRK could cover it */
> > +     unsigned long step_size = PMD_SIZE;
> > +
> > +     start = map_start;
> > +     min_pfn_mapped = start >> PAGE_SHIFT;
> > +
> > +     /*
> > +      * We start from the bottom (@map_start) and go to the top (@map_end).
> > +      * The memblock_find_in_range() gets us a block of RAM from the
> > +      * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
> > +      * for page table.
> > +      */
> > +     while (start < map_end) {
> > +             if (step_size && map_end - start > step_size) {
> > +                     next = round_up(start + 1, step_size);
> > +                     if (next > map_end)
> > +                             next = map_end;
> > +             } else {
> > +                     next = map_end;
> > +             }
> > +
> > +             mapped_ram_size += init_range_memory_mapping(start, next);
> > +             set_alloc_range(min_pfn_mapped, max_pfn_mapped);
> > +             start = next;
> > +
> > +             if (mapped_ram_size >= step_size)
> > +                     step_size = get_new_step_size(step_size);
> > +     }
> > +}
>
> One more suggestion:  Can you *move* the code in a separate patch?
> Un-use it in this patch, but wait for one more patch to actually move it.
>

Good suggestion. It will make it easier to review. I will do it in next version
> >  /*
> >   * Build a proper pagetable for the kernel mappings.  Up until this
> >   * point, we've been running on some set of pagetables constructed by
> > diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
> > index 319bde3..28006de 100644
> > --- a/arch/x86/mm/mm_internal.h
> > +++ b/arch/x86/mm/mm_internal.h
> > @@ -8,6 +8,13 @@ static inline void *alloc_low_page(void)
> >       return alloc_low_pages(1);
> >  }
> >
> > +unsigned long __init init_range_memory_mapping(unsigned long r_start,
> > +     unsigned long r_end);
> > +void set_alloc_range(unsigned long low, unsigned long high);
> > +void __init memory_map_top_down(unsigned long map_start,
> > +                                    unsigned long map_end);
> > +void __init memory_map_bottom_up(unsigned long map_start,
> > +                                     unsigned long map_end);
>
> Is there a reason we can't just move all these calls into init_32.c?
>
> Seems like we probably just want one, new function, like:
>
>         init_mem_mapping_x86_32(end);
>
> And then we just export *that* instead of exporting all of these helpers
> that only get used on x86_32.  It also makes init_mem_mapping() more
> readable since the #ifdef's are shorter.

Yes, I will do like this.

Thanks for your kindly review.

Regards,
Pingfan
