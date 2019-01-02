Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1C1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FD521871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AarWDTTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfABGrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:47:49 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44556 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfABGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:47:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so25269619edd.11;
        Tue, 01 Jan 2019 22:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIoU4+9M1RTnqRONsQUWgZIa15vjsfmwfT62Wv+5qbA=;
        b=AarWDTTimcyTaaLhv3O3qNyVdqSMXAd9AKZv2Zp/hM4Hb4b5/xL842xDD6rsCeGnur
         hEnQmGzkGCGTaNA4lGhwpOk5NFVmDQcidK1VnJ9TvvrHIkzBVZvatHthi6Oebd+lKE32
         adepKJHMrFZn9gT5oJvzO5wdK5/5dZ0803IDW1oFGmsGQatYNHEJRuebzVl4RUSaoOPk
         BC1vEVvMalS63mqT7fG9kAtMJiQ+RtFm+QE/1KtO/jYFq0wG245rrTCS7OJlc+zp6Sme
         t01XU68hs7t6DSjmoEnKLvcpkMgEHaKWQTR4GuG1AcAwEoreIa2uXmC/HIdMq2ghhnxl
         3SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIoU4+9M1RTnqRONsQUWgZIa15vjsfmwfT62Wv+5qbA=;
        b=o7Sx0uv+AbzTPKOy4YtHLGY9WxO8fyFoOaIG9DuXMy+7Wm0h0iEsJYaeeb/tjoQfVN
         Sg6gKYxYTPIEFLd3XhmJEF/FWr1wza0LhCs5gT00inmJL8MygH+X3ZOykLOadbkWxGU0
         NoPg135Z0jXz4FB6RopcoNO6aJ2LctvJEUbZI63zFKoYT9e0Cfqb3+MquK/2vQrfz+dR
         HpQ7Deig3sxUFVGrjGEjiZksWbjz1X1tGt+fDnJDxBwTYT+SseULCXI8P5FOw0lqXesQ
         V+ZGnpH4BiTu1xBL6REqXS0tfWAF8w7xQTAIHHRTupmg5AVXo8Kfgt7m+jRuWlPwKo3c
         4mSQ==
X-Gm-Message-State: AA+aEWYC7iHpeRGNfNh4MwOxheLAicxhk71heYDnrBq8gN/Puuv+3Ttr
        5I/FGwrsOer/EcrQ+CKf1kl9WrjOomW6wG9BmQ==
X-Google-Smtp-Source: AFSGD/Xy5gHqp6/th8sKAa40TN//CqSZiQlNjczk+klhyErmRPCXd/3cZY70Ldx+zAwBfXoRPCp0fylZ7KssazGUmBs=
X-Received: by 2002:a50:d551:: with SMTP id f17mr37921398edj.87.1546411666210;
 Tue, 01 Jan 2019 22:47:46 -0800 (PST)
MIME-Version: 1.0
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-2-git-send-email-kernelfans@gmail.com> <20181231084018.GA28478@rapoport-lnx>
In-Reply-To: <20181231084018.GA28478@rapoport-lnx>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 2 Jan 2019 14:47:34 +0800
Message-ID: <CAFgQCTvQnj7zReFvH_gmfVJdPXE325o+z4Xx76fupvsLR_7H2A@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mm/memblock: extend the limit inferior of bottom-up
 after parsing hotplug attr
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 4:40 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Fri, Dec 28, 2018 at 11:00:01AM +0800, Pingfan Liu wrote:
> > The bottom-up allocation style is introduced to cope with movable_node,
> > where the limit inferior of allocation starts from kernel's end, due to
> > lack of knowledge of memory hotplug info at this early time. But if later,
> > hotplug info has been got, the limit inferior can be extend to 0.
> > 'kexec -c' prefers to reuse this style to alloc mem at lower address,
> > since if the reserved region is beyond 4G, then it requires extra mem
> > (default is 16M) for swiotlb.
>
> I fail to understand why the availability of memory hotplug information
> would allow to extend the lower limit of bottom-up memblock allocations
> below the kernel. The memory in the physical range [0, kernel_start) can be
> allocated as soon as the kernel memory is reserved.
>
Yes, the  [0, kernel_start) can be allocated at this time by some func
e.g. memblock_reserve(). But there is trick. For the func like
memblock_find_in_range(), this is hotplug attr checking ,,it will
check the hotmovable attr in __next_mem_range()
{
if (movable_node_is_enabled() && memblock_is_hotpluggable(m))
continue
}.  So the movable memory can be safely skipped.

Thanks for your kindly review.

Regards,
Pingfan

> The extents of the memory node hosting the kernel image can be used to
> limit memblok allocations from that particular node, even in top-down mode.
>
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Tang Chen <tangchen@cn.fujitsu.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> > Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Cc: Daniel Vacek <neelx@redhat.com>
> > Cc: Mathieu Malaterre <malat@debian.org>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/acpi/numa.c      |  4 ++++
> >  include/linux/memblock.h |  1 +
> >  mm/memblock.c            | 58 +++++++++++++++++++++++++++++-------------------
> >  3 files changed, 40 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > index 2746994..3eea4e4 100644
> > --- a/drivers/acpi/numa.c
> > +++ b/drivers/acpi/numa.c
> > @@ -462,6 +462,10 @@ int __init acpi_numa_init(void)
> >
> >               cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
> >                                           acpi_parse_memory_affinity, 0);
> > +
> > +#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> > +             mark_mem_hotplug_parsed();
> > +#endif
> >       }
> >
> >       /* SLIT: System Locality Information Table */
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index aee299a..d89ed9e 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -125,6 +125,7 @@ int memblock_reserve(phys_addr_t base, phys_addr_t size);
> >  void memblock_trim_memory(phys_addr_t align);
> >  bool memblock_overlaps_region(struct memblock_type *type,
> >                             phys_addr_t base, phys_addr_t size);
> > +void mark_mem_hotplug_parsed(void);
> >  int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
> >  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
> >  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 81ae63c..a3f5e46 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -231,6 +231,12 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
> >       return 0;
> >  }
> >
> > +static bool mem_hotmovable_parsed __initdata_memblock;
> > +void __init_memblock mark_mem_hotplug_parsed(void)
> > +{
> > +     mem_hotmovable_parsed = true;
> > +}
> > +
> >  /**
> >   * memblock_find_in_range_node - find free area in given range and node
> >   * @size: size of free area to find
> > @@ -259,7 +265,7 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
> >                                       phys_addr_t end, int nid,
> >                                       enum memblock_flags flags)
> >  {
> > -     phys_addr_t kernel_end, ret;
> > +     phys_addr_t kernel_end, ret = 0;
> >
> >       /* pump up @end */
> >       if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
> > @@ -270,34 +276,40 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
> >       end = max(start, end);
> >       kernel_end = __pa_symbol(_end);
> >
> > -     /*
> > -      * try bottom-up allocation only when bottom-up mode
> > -      * is set and @end is above the kernel image.
> > -      */
> > -     if (memblock_bottom_up() && end > kernel_end) {
> > -             phys_addr_t bottom_up_start;
> > +     if (memblock_bottom_up()) {
> > +             phys_addr_t bottom_up_start = start;
> >
> > -             /* make sure we will allocate above the kernel */
> > -             bottom_up_start = max(start, kernel_end);
> > -
> > -             /* ok, try bottom-up allocation first */
> > -             ret = __memblock_find_range_bottom_up(bottom_up_start, end,
> > -                                                   size, align, nid, flags);
> > -             if (ret)
> > +             if (mem_hotmovable_parsed) {
> > +                     ret = __memblock_find_range_bottom_up(
> > +                             bottom_up_start, end, size, align, nid,
> > +                             flags);
> >                       return ret;
> >
> >               /*
> > -              * we always limit bottom-up allocation above the kernel,
> > -              * but top-down allocation doesn't have the limit, so
> > -              * retrying top-down allocation may succeed when bottom-up
> > -              * allocation failed.
> > -              *
> > -              * bottom-up allocation is expected to be fail very rarely,
> > -              * so we use WARN_ONCE() here to see the stack trace if
> > -              * fail happens.
> > +              * if mem hotplug info is not parsed yet, try bottom-up
> > +              * allocation with @end above the kernel image.
> >                */
> > -             WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
> > +             } else if (!mem_hotmovable_parsed && end > kernel_end) {
> > +                     /* make sure we will allocate above the kernel */
> > +                     bottom_up_start = max(start, kernel_end);
> > +                     ret = __memblock_find_range_bottom_up(
> > +                             bottom_up_start, end, size, align, nid,
> > +                             flags);
> > +                     if (ret)
> > +                             return ret;
> > +                     /*
> > +                      * we always limit bottom-up allocation above the
> > +                      * kernel, but top-down allocation doesn't have
> > +                      * the limit, so retrying top-down allocation may
> > +                      * succeed when bottom-up allocation failed.
> > +                      *
> > +                      * bottom-up allocation is expected to be fail
> > +                      * very rarely, so we use WARN_ONCE() here to see
> > +                      * the stack trace if fail happens.
> > +                      */
> > +                     WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
> >                         "memblock: bottom-up allocation failed, memory hotremove may be affected\n");
> > +             }
> >       }
> >
> >       return __memblock_find_range_top_down(start, end, size, align, nid,
> > --
> > 2.7.4
> >
>
> --
> Sincerely yours,
> Mike.
>
