Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D4CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FFE208B6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="g7WNB8Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FFE208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeFQTxI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 15:53:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35890 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933174AbeFQTxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 15:53:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id 14-v6so13042315oie.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QvnDn1zxxbK7SgpPBIvw7tlD5NtAKJoqb/CXrPhQlFM=;
        b=g7WNB8HqISzB8OP/4VQ4Qte9sv1PHx68cZXq0AKCukwJVPdnw7cdwB5/BF3jSf8u/y
         oBjPGKOZpRVrM6S7Cbz4Ly9hCaUrSMKUEqzbV52yAAza+/+M8+Qb0m0k9F1KOufGNs7M
         hHH0McwuwiRhLRubSt58J8J+4lZjJ+S1cJ6GtzIFV4MJRZnIhAbzV9157nTelYBCfYR6
         BUuaBskwKtvyDG2+1p6CCUJ+SbgHEeFhVW/sUcq5OC8fy/upKq1ReDMBtchPjjBzdT1E
         ytzLVIbK/WF8hBLaupraGgMqJYrX0spjFwuea0O7+GF+O6WBtVk6nNSJ0EbeqPjYgHvT
         33Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QvnDn1zxxbK7SgpPBIvw7tlD5NtAKJoqb/CXrPhQlFM=;
        b=LRRRefdmcxqvyqPIjLV1CCatEAZMTConY/2hIw1Z1Rt3xPsE/cPHmKoaHrlynbtwL/
         9RJalCKWC1EDhBOCrSg9gR4QLRS1nt6CAgw7RuRPVLt1O9uwtUgwH2I/ftm9bJdURRKo
         CDJA6uGC1P/qYztfYgvo4majtdexbcqXyfRi0az1a22TNf65SM+jbW4ydHObEvlrV3lQ
         GcRIYj1umyP3dd+6M4rqIeBYrSrGY5K1B9Y+W1xUOEofn8h4TobbQfdNZkwsxXluMEw/
         LhTwSq2zrbc3gGkV2cDHFFbceKtGSkDG+8Xi4DC956axuXmWsgJPFxUnWJfEjdZOerha
         0SFg==
X-Gm-Message-State: APt69E3mYgUVl8B3veSmuKb8RNEK7XcVOcDtMrlNKjxPd0UcHxGkFJni
        6NdgmYHS7ihrMNiBOLwDYH06eg5aF51DAkIO8PZXAw==
X-Google-Smtp-Source: ADUXVKJ3XCfMXPp6Ki8HQ+0+akHlaigFx+QsiE4CCYJbsg8yW3uxFkvFuB66SFR0ixHipBrK5uIBLywPd/zFawzy+Hs=
X-Received: by 2002:aca:51cb:: with SMTP id f194-v6mr5993117oib.110.1529265184943;
 Sun, 17 Jun 2018 12:53:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 12:53:04
 -0700 (PDT)
In-Reply-To: <20180617012510.20139-3-jhubbard@nvidia.com>
References: <20180617012510.20139-1-jhubbard@nvidia.com> <20180617012510.20139-3-jhubbard@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 17 Jun 2018 12:53:04 -0700
Message-ID: <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 6:25 PM,  <john.hubbard@gmail.com> wrote:
> From: John Hubbard <jhubbard@nvidia.com>
>
> This fixes a few problems that come up when using devices (NICs, GPUs,
> for example) that want to have direct access to a chunk of system (CPU)
> memory, so that they can DMA to/from that memory. Problems [1] come up
> if that memory is backed by persistence storage; for example, an ext4
> file system. I've been working on several customer bugs that are hitting
> this, and this patchset fixes those bugs.
>
> The bugs happen via:
>
> 1) get_user_pages() on some ext4-backed pages
> 2) device does DMA for a while to/from those pages
>
>     a) Somewhere in here, some of the pages get disconnected from the
>        file system, via try_to_unmap() and eventually drop_buffers()
>
> 3) device is all done, device driver calls set_page_dirty_lock(), then
>    put_page()
>
> And then at some point, we see a this BUG():
>
>     kernel BUG at /build/linux-fQ94TU/linux-4.4.0/fs/ext4/inode.c:1899!
>     backtrace:
>         ext4_writepage
>         __writepage
>         write_cache_pages
>         ext4_writepages
>         do_writepages
>         __writeback_single_inode
>         writeback_sb_inodes
>         __writeback_inodes_wb
>         wb_writeback
>         wb_workfn
>         process_one_work
>         worker_thread
>         kthread
>         ret_from_fork
>
> ...which is due to the file system asserting that there are still buffer
> heads attached:
>
>         ({                                                                  \
>                 BUG_ON(!PagePrivate(page));                     \
>                 ((struct buffer_head *)page_private(page));     \
>         })
>
> How to fix this:
> ----------------
> Introduce a new page flag: PG_dma_pinned, and set this flag on
> all pages that are returned by the get_user_pages*() family of
> functions. Leave it set nearly forever: until the page is freed.
>
> Then, check this flag before attempting to unmap pages. This will
> cause a very early return from try_to_unmap_one(), and will avoid
> doing things such as, notably, removing page buffers via drop_buffers().
>
> This uses a new struct page flag, but only on 64-bit systems.
>
> Obviously, this is heavy-handed, but given the long, broken history of
> get_user_pages in combination with file-backed memory, and given the
> problems with alternative designs, it's a reasonable fix for now: small,
> simple, and easy to revert if and when a more comprehensive design solution
> is chosen.
>
> Some alternatives, and why they were not taken:
>
> 1. It would be better, if possible, to clear PG_dma_pinned, once all
> get_user_pages callers returned the page (via something more specific than
> put_page), but that would significantly change the usage for get_user_pages
> callers. That's too intrusive for such a widely used and old API, so let's
> leave it alone.
>
> Also, such a design would require a new counter that would be associated
> with each page. There's no room in struct page, so it would require
> separate tracking, which is not acceptable for general page management.
>
> 2. There are other more complicated approaches[2], but these depend on
> trying to solve very specific call paths that, in the end, are just
> downstream effects of the root cause. And so these did not actually fix the
> customer bugs that I was working on.
>
> References:
>
> [1] https://lwn.net/Articles/753027/ : "The trouble with get_user_pages()"
>
> [2] https://marc.info/?l=linux-mm&m=<20180521143830.GA25109@bombadil.infradead.org>
>    (Matthew Wilcox listed two ideas here)
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
[..]
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 6db729dc4c50..37576f0a4645 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1360,6 +1360,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>                                 flags & TTU_SPLIT_FREEZE, page);
>         }
>
> +       if (PageDmaPinned(page))
> +               return false;
>         /*
>          * We have to assume the worse case ie pmd for invalidation. Note that
>          * the page can not be free in this function as call of try_to_unmap()

We have a similiar problem with DAX and the conclusion we came to is
that it is not acceptable for userspace to arbitrarily block kernel
actions. The conclusion there was: 'wait' if the DMA is transient, and
'revoke' if the DMA is long lived, or otherwise 'block' long-lived DMA
if a revocation mechanism is not available.
