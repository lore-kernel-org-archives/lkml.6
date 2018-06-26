Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3DBC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C95C2653D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C95C2653D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeFZGO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:14:28 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42622 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeFZGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:14:26 -0400
Received: by mail-ot0-f193.google.com with SMTP id 92-v6so17785243otw.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 23:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrc/7YHObi9t4oCBE0Dl/dH4D/bkFoOas8RaklnARUg=;
        b=NZbQYPlc+PSRxNEaSSWN79cjxy8jQkOSabZRpf5Ca1Ji48o4yyxajm8GTr/g7FCLFI
         A+4dILxw6qkJNPdJN6V6Y9m35jJeFD57z9Dj88rYFFYiIsMYJ1oGJ+TCOVzQpjAtUNjv
         a0ooFQ7JjisFnNm+wJ7HK3diDi3pzUSjNhEN0gSZf7FsKwjJ43jIGDW3mBJxlnZvSWWj
         VNsec4GUtY14grx8KSr+BAatcEsx3bsuCL1LhQ8isDW89Cu/H9A/yb/cszqyOm5RcoQS
         iYbs7HjwiDJsBG6H5vqaHd6LSa3auT9XdckqD+sdvaFtsPCKhBS0JEyBd89LNksuICZN
         99qA==
X-Gm-Message-State: APt69E1dA6yQPtxoMX0JXc3hRm4z7eKjldjhQlZEj0wpBbGdHCIrlDjG
        I1HTaS8JPcveqnu82IA4PRbw7vncTWWxVxg32KQ=
X-Google-Smtp-Source: AAOMgpefGykPFfEDoI4FkJpy0UGRH/b18tQpRJ9FgwZSx3yZp7jc76NX1Y9vWpDQ1/osItxuHaJ1fgb3o1O943+02Tg=
X-Received: by 2002:a9d:3666:: with SMTP id w93-v6mr84589otb.394.1529993666137;
 Mon, 25 Jun 2018 23:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180622210542.2025-1-malat@debian.org> <20180625171513.31845-1-malat@debian.org>
 <20180625180717.GS28965@dhcp22.suse.cz>
In-Reply-To: <20180625180717.GS28965@dhcp22.suse.cz>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 26 Jun 2018 08:14:13 +0200
Message-ID: <CA+7wUsy5oxp2tYZA=9Nissj7Ztv6OHnLtdsQ9cHvvGX1KTDyew@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memblock: add missing include <linux/bootmem.h>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Stefan Agner <stefan@agner.ch>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:07 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 25-06-18 19:15:12, Mathieu Malaterre wrote:
> > Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> > introduced two new function definitions:
> >
> >   memblock_virt_alloc_try_nid_nopanic()
> >   memblock_virt_alloc_try_nid()
> >
> > Commit ea1f5f3712af ("mm: define memblock_virt_alloc_try_nid_raw")
> > introduced the following function definition:
> >
> >   memblock_virt_alloc_try_nid_raw()
> >
> > This commit adds an include of header file <linux/bootmem.h> to provide
> > the missing function prototypes. Silence the following gcc warning
> > (W=1):
> >
> >   mm/memblock.c:1334:15: warning: no previous prototype for `memblock_virt_alloc_try_nid_raw' [-Wmissing-prototypes]
> >   mm/memblock.c:1371:15: warning: no previous prototype for `memblock_virt_alloc_try_nid_nopanic' [-Wmissing-prototypes]
> >   mm/memblock.c:1407:15: warning: no previous prototype for `memblock_virt_alloc_try_nid' [-Wmissing-prototypes]
> >
> > It also adds #ifdef blockers to prevent compilation failure on mips/ia64
> > where CONFIG_NO_BOOTMEM=n. Because Makefile already does:
> >
> >   obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o
> >
> > The #ifdef has been simplified from:
> >
> >   #if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)
> >
> > to simply:
> >
> >   #if defined(CONFIG_NO_BOOTMEM)
>
> Well, I would apreciate an explanation why do we need NO_BOOTMEM guard
> in the first place rather than why HAVE_MEMBLOCK is not needed.

Right, I am missing the explicit reference to commit 6cc22dc08a247b
("revert "mm/memblock: add missing include <linux/bootmem.h>""), I can
tweak the commit message in a v3.

> > Suggested-by: Tony Luck <tony.luck@intel.com>
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> Anyway this looks better. I wish we can actually get rid of bootmem
> allocator which would simplify this as well but that is another topic.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks !

> > ---
> > v2: Simplify #ifdef
> >
> >  mm/memblock.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 03d48d8835ba..611a970ac902 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/kmemleak.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/memblock.h>
> > +#include <linux/bootmem.h>
> >
> >  #include <asm/sections.h>
> >  #include <linux/io.h>
> > @@ -1224,6 +1225,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
> >       return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
> >  }
> >
> > +#if defined(CONFIG_NO_BOOTMEM)
> >  /**
> >   * memblock_virt_alloc_internal - allocate boot memory block
> >   * @size: size of memory block to be allocated in bytes
> > @@ -1431,6 +1433,7 @@ void * __init memblock_virt_alloc_try_nid(
> >             (u64)max_addr);
> >       return NULL;
> >  }
> > +#endif
> >
> >  /**
> >   * __memblock_free_early - free boot memory block
> > --
> > 2.11.0
> >
>
> --
> Michal Hocko
> SUSE Labs
