Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90884C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60058218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOZNU3tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeL2GiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 01:38:22 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39995 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeL2GiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 01:38:21 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so29213421ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 22:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZeViuD5AR+Y+bp3iOoy+E0zr6PwSy4elFOzmd/xbXE=;
        b=DOZNU3tnUpe3S5szXlK+1lPigHq7aVQtRCwSeOBr7gaBXGdeui6Lefv2gCbxrvhn4o
         RbWLUDO8qEUnJkMxq2zEAXSLxJ9/y6o38Quqt8VWYmKWtsDYidlFGwwiEw6t8OMzBTG+
         S/aU4oCrIqovMK1nGSYaaGRixhV9i89JAAvKbR+1pMFyrbUCovEI8QCrUFE7VdktPkED
         ys5KH1faWRcfS+JZuLyl7MGHsvHjtmfquZkvtPX1Pq0h1gHNDZzmFl8eUsmeWZPon+kS
         8J1zfM8LHG7bvwC6Ek8aZ1zpYi7THDHhnCU67rj8XgpCZ9szi7bfYJAQgfOJwLTKZVIm
         wPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZeViuD5AR+Y+bp3iOoy+E0zr6PwSy4elFOzmd/xbXE=;
        b=hPEClq3OfNpAXLcXVZL+jXac8HWzMhLrfUTrNLnmF/foNhFGyi9RtwjJAxEYtUZ2qn
         xJwzZhCs7b8mQ8vRKN/ouH+xhMyfR3jR8gEf+UN+x2mi4d2BsSiNI+3np7ws0j/p8zhy
         erZt8iyCtmG1XhnuMe5N1hhmUcsAl9a/MiGlnqpWFzEHKlPBfDoTjVOdaBbC1iqqUYsn
         74YMBhs1xhe5m6WpJSv3OrT0X1EvKEVneX6KVn/m5dWsyDs8vY2H3Rw2ge+y0rmSFAGp
         soHCy7+CY9+1mDBfMUa6XEKr4wVE8X0mIVqZ6pL+XcELv3SHYqXlfwu1koD7PWKfGQtC
         v6Ag==
X-Gm-Message-State: AA+aEWYYmZqrr+UL/pHvKQ9AxW3YXwPTuQwsNAPGp5r69iqlf2vLoz2u
        ScYJwty/2YL4mMy/sDgeUivpkmkF9GTL5chcAddGTQ==
X-Google-Smtp-Source: AFSGD/VTVfmZo7L+A3EKKs5v5i701C7j+p049SieQz8gnFKGhE1cYMuWcvH8o1w6L7mw6Z5qngDH1UXv/vP88thKM84=
X-Received: by 2002:a24:b20e:: with SMTP id u14mr19830088ite.12.1546065500564;
 Fri, 28 Dec 2018 22:38:20 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b57d19057e1b383d@google.com> <20181228130938.c9e42c213cdcc35a93dd0dac@linux-foundation.org>
 <20181228235106.okk3oastsnpxusxs@kshutemo-mobl1>
In-Reply-To: <20181228235106.okk3oastsnpxusxs@kshutemo-mobl1>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 29 Dec 2018 07:38:08 +0100
Message-ID: <CACT4Y+Ynm+LPupT0OM=E8AdF0bQDKc-arPy3M=V1D5V0tCmZ=g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in filemap_fault
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+b437b5a429d680cf2217@syzkaller.appspotmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        josef@toxicpanda.com, Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 12:51 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> On Fri, Dec 28, 2018 at 01:09:38PM -0800, Andrew Morton wrote:
> > On Fri, 28 Dec 2018 12:51:04 -0800 syzbot <syzbot+b437b5a429d680cf2217@syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> >
> > uh-oh.  Josef, could you please take a look?
> >
> > :     page = find_get_page(mapping, offset);
> > :     if (likely(page) && !(vmf->flags & FAULT_FLAG_TRIED)) {
> > :             /*
> > :              * We found the page, so try async readahead before
> > :              * waiting for the lock.
> > :              */
> > :             fpin = do_async_mmap_readahead(vmf, page);
> > :     } else if (!page) {
> > :             /* No page in the page cache at all */
> > :             fpin = do_sync_mmap_readahead(vmf);
> > :             count_vm_event(PGMAJFAULT);
> > :             count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
> >
> > vmf->vma has been freed at this point.
> >
> > :             ret = VM_FAULT_MAJOR;
> > : retry_find:
> > :             page = pagecache_get_page(mapping, offset,
> > :                                       FGP_CREAT|FGP_FOR_MMAP,
> > :                                       vmf->gfp_mask);
> > :             if (!page) {
> > :                     if (fpin)
> > :                             goto out_retry;
> > :                     return vmf_error(-ENOMEM);
> > :             }
> > :     }
> >
>
> Here's a fixup for "filemap: drop the mmap_sem for all blocking operations".

If you are going to squash this, please add:

Tested-by: syzbot+b437b5a429d680cf2217@syzkaller.appspotmail.com


> do_sync_mmap_readahead() drops mmap_sem now, so by the time of
> dereferencing vmf->vma for count_memcg_event_mm() the VMA can be gone.
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 00a9315f45d4..65c85c47bdb1 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2554,10 +2554,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>                 fpin = do_async_mmap_readahead(vmf, page);
>         } else if (!page) {
>                 /* No page in the page cache at all */
> -               fpin = do_sync_mmap_readahead(vmf);
>                 count_vm_event(PGMAJFAULT);
>                 count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
>                 ret = VM_FAULT_MAJOR;
> +               fpin = do_sync_mmap_readahead(vmf);
>  retry_find:
>                 page = pagecache_get_page(mapping, offset,
>                                           FGP_CREAT|FGP_FOR_MMAP,
> --
>  Kirill A. Shutemov
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20181228235106.okk3oastsnpxusxs%40kshutemo-mobl1.
> For more options, visit https://groups.google.com/d/optout.
