Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260EAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA29822506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="j2cU8fL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA29822506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeKMFQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:16:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45900 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:16:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so8480007ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zgemmezCnXlAhFKOCHfjyU1ITmPG9Sso5Nh29gCTaE=;
        b=j2cU8fL666oKKLeaqTtx7LiRetxlWeR0IRAiFhxZJFbqeA6OubyzjVl+3MYPKEtJB/
         fhJjwRjBKWLtF3kGQSlDTy+dHU3P3VzLlDlybKWZBi5nqSXwIn4KG1gJhaZv46JDLU93
         aA6kZbvW/V9afvUGOytTGR8HcVS+s3mBl/irTPGfSHobkYLkVvdnBpFLJ09s89JqROV8
         /Caduh1PHXyrYkwUpFdoJ/gfQO+hCvONZtvW6+8piYng5b6staAGw6tWPOLMzifJs01d
         VJDbvDTgvxcfd5aPZirkIIXfQdKB6EhzRoTJd2O2Hy5xHErA0V/ALN/8KKAUVrvVQPv1
         WRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zgemmezCnXlAhFKOCHfjyU1ITmPG9Sso5Nh29gCTaE=;
        b=X/SugI5uN4eH+ZvhkTqH7WeIE9UR1KjS/ElgC6wkcnk1m1BQwCPraE5RyAjV56BEVt
         XSksBcTjKQy/iQz/dH7SB6+TLOaML5iKu/Q1OwSRZPtd6NRcsdZg5Cwnj///pRzHoiYI
         tqeQPv4hppNUYb3EgEiEjI8nw3+MZTcQ6e9+sjp22TbmYErN5jGPnYcGVS7LU//2H+fL
         NgK4dvddPJQrz0V94rFYg5FfKQUYFh8drXo4eTQuZO0B8k3KBYfQ3NvRuE90Gm2gadZP
         1pYlBh0mf30WRZYXTi0jneCUQy74njdrsLk0MwGV2907a7/ukXpqnVRJorGV9K3b25bm
         qGzA==
X-Gm-Message-State: AGRZ1gKhaMTxuzDfEz6jHKvq6NqhLnWzv0pEbPzuxGyyvW3bCIF4oeiV
        CKFvoySVjE91XUNXAO0ZRcVRjmp7YB4boAPa2h1SBA==
X-Google-Smtp-Source: AJdET5ftiJo5YarF+hh1N5ORWGh+cy6kW/WVDL2cPC8ftGBfVSAQEU9PTKto6LTZv/1OoPDgcrQAtRC88T9P02DGsTg=
X-Received: by 2002:a9d:41ef:: with SMTP id v44mr1250178oti.95.1542050511817;
 Mon, 12 Nov 2018 11:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20181015153034.32203-1-osalvador@techadventures.net> <20181015153034.32203-3-osalvador@techadventures.net>
In-Reply-To: <20181015153034.32203-3-osalvador@techadventures.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 12 Nov 2018 11:21:39 -0800
Message-ID: <CAPcyv4jM-EJCmOwFkPqXhtgR54UueNtHjfCUbnnJqFLmgj7Jvw@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/memory_hotplug: Create add/del_device_memory functions
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Yasuaki Ishimatsu <yasu.isimatu@gmail.com>,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jonathan.Cameron@huawei.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        alexander.h.duyck@linux.intel.com, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 8:31 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> From: Oscar Salvador <osalvador@suse.de>
>
> HMM/devm have a particular handling of memory-hotplug.
> They do not go through the common path, and so, they do not
> call either offline_pages() or online_pages().
>
> The operations they perform are the following ones:
>
> 1) Create the linear mapping in case the memory is not private
> 2) Initialize the pages and add the sections
> 3) Move the pages to ZONE_DEVICE
>
> Due to this particular handling of hot-add/remove memory from HMM/devm,
> I think it would be nice to provide a helper function in order to
> make this cleaner, and not populate other regions with code
> that should belong to memory-hotplug.
>
> The helpers are named:
>
> del_device_memory
> add_device_memory
>
> The idea is that add_device_memory will be in charge of:
>
> a) call either arch_add_memory() or add_pages(), depending on whether
>    we want a linear mapping
> b) online the memory sections that correspond to the pfn range
> c) call move_pfn_range_to_zone() being zone ZONE_DEVICE to
>    expand zone/pgdat spanned pages and initialize its pages
>
> del_device_memory, on the other hand, will be in charge of:
>
> a) offline the memory sections that correspond to the pfn range
> b) call shrink_zone_pgdat_pages(), which shrinks node/zone spanned pages.
> c) call either arch_remove_memory() or __remove_pages(), depending on
>    whether we need to tear down the linear mapping or not
>
> The reason behind step b) from add_device_memory() and step a)
> from del_device_memory is that now find_smallest/biggest_section_pfn
> will have to check for online sections, and not for valid sections as
> they used to do, because we call offline_mem_sections() in
> offline_pages().
>
> In order to split up better the patches and ease the review,
> this patch will only make a) case work for add_device_memory(),
> and case c) for del_device_memory.
>
> The other cases will be added in the next patch.
>
> These two functions have to be called from devm/HMM code:
>
> dd_device_memory:
>         - devm_memremap_pages()
>         - hmm_devmem_pages_create()
>
> del_device_memory:
>         - hmm_devmem_release
>         - devm_memremap_pages_release
>
> One thing I do not know is whether we can move kasan calls out of the
> hotplug lock or not.
> If we can, we could move the hotplug lock within add/del_device_memory().
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/memory_hotplug.h | 11 +++++++++++
>  kernel/memremap.c              | 11 ++++-------
>  mm/hmm.c                       | 33 +++++++++++++++++----------------
>  mm/memory_hotplug.c            | 41 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 73 insertions(+), 23 deletions(-)

This collides with the refactoring of hmm, to be done in terms of
devm_memremap_pages(). I'd rather not introduce another common
function *beneath* hmm and devm_memremap_pages() and rather make
devm_memremap_pages() the common function.

I plan to resubmit that cleanup after Plumbers. So, unless I'm
misunderstanding some other benefit a nak from me on this patch as it
stands currently.
