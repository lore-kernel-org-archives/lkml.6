Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC90C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3097255EC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHODTGNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3097255EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbeGBA5k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:57:40 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40468 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeGBA5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:57:35 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so6056432oie.7;
        Sun, 01 Jul 2018 17:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AidDj29RtuV0jeEJEUfNKW78+sGz14aXoWxsFWh9zFU=;
        b=vHODTGNbcbAaY+HXlcYdtPlqq+50CAhkSkliX1O2LL7yGAxkcZVNyAFBFkezHERF2v
         GiH2g31s2aneaeS32tkUM/c6IhVNeaNqU1rgbptSTfoHYcucGLzFg67t9++H0+S1mYj3
         iFIYGpM7GJHjrwHhZU5869oVJrI42fTKsNb4vhomnlAe6YOpvXs8Me+aYHncVZxIg7An
         6QZY1zcqUg+fcjRE1gh0VmnJRwZljuqZBP1KsSJM4gaV/Jx7gorEGfm3eqTUs5qkqadP
         jF1frkgHlwsRvYa2t8ETMx+64JmyNEoi2q3wghO2kQvlXRY9S/jawvxc/Inukf3nSzxd
         AGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AidDj29RtuV0jeEJEUfNKW78+sGz14aXoWxsFWh9zFU=;
        b=UfHImiTG/KtdFOX/ZT85liO4nXvX6lAH5t2HuRurkPSDFC4C2ymXUWMg/swCpuJZr+
         ZW00s6JJDHk2hKolZwC/zoMk5QfyBGdnEyjkIHxDJNrMU9lQ9ad2YiRMh2ABQflR7zW1
         sU23r1PtLdHHMbAfnA6LeBTtdT4W+gjusyJ70B9bLoQbeoQWvjZxdkwTSXH1bdnsTcP7
         RR4b0eZ8nQidvajbyrojGffmSbyF6P99f51eYP5zwvL7NPjv2Ae/rPka5nA7QGy4T0ef
         rkDxr3xgD31mzdue3WY/9UiE001cqARCTcDGpZZXZ6jvunE/Wv8LDnjX5Z8fcFzRO87F
         s+pQ==
X-Gm-Message-State: APt69E10lPtIL8GGIGEyFl5onvUkAYWzPjISpNhowvyYTwFC4AuZb3Yh
        1Ju9o5XazGoTcQTc+N8Mzss=
X-Google-Smtp-Source: AAOMgpdZov0k6Ciw2pwagffJ40EOgD72Vf2xWXFjhWDM6/UBQ4aic1cIyBfcrwinNEx7wfzHf0zvDg==
X-Received: by 2002:aca:3f57:: with SMTP id m84-v6mr12572970oia.280.1530493054893;
        Sun, 01 Jul 2018 17:57:34 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4111672oix.30.2018.07.01.17.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 17:57:33 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/6] mm/fs: gup: don't unmap or drop filesystem buffers
Date:   Sun,  1 Jul 2018 17:56:48 -0700
Message-Id: <20180702005654.20369-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.18.0
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

This fixes a few problems that came up when using devices (NICs, GPUs,
for example) that want to have direct access to a chunk of system (CPU)
memory, so that they can DMA to/from that memory. Problems [1] come up
if that memory is backed by persistence storage; for example, an ext4
file system. I've been working on several customer bugs that are hitting
this, and this patchset fixes those bugs.

The bugs happen via:

-- get_user_pages() on some ext4-backed pages
-- device does DMA for a while to/from those pages

    -- Somewhere in here, some of the pages get disconnected from the
       file system, via try_to_unmap() and eventually drop_buffers()

-- device is all done, device driver calls set_page_dirty_locked, then
   put_page()

And then at some point, we see a this BUG():

    kernel BUG at /build/linux-fQ94TU/linux-4.4.0/fs/ext4/inode.c:1899!
    backtrace:
        ext4_writepage
        __writepage
        write_cache_pages
        ext4_writepages
        do_writepages
        __writeback_single_inode
        writeback_sb_inodes
        __writeback_inodes_wb
        wb_writeback
        wb_workfn
        process_one_work
        worker_thread
        kthread
        ret_from_fork

...which is due to the file system asserting that there are still buffer
heads attached:

        ({                                                      \
                BUG_ON(!PagePrivate(page));                     \
                ((struct buffer_head *)page_private(page));     \
        })

How to fix this:

If a page is pinned by any of the get_user_page("gup", here) variants, then
there is no need for that page to be on an LRU. So, this patchset removes
such pages from their LRU, thus leaving the page->lru fields *mostly*
available for tracking gup pages. (The lowest bit of page->lru.next is used
as PageTail, and these flags have to be checked when we don't know if it
really is a tail page or not, so avoid that bit.)

After that, the page is reference-counted via page->dma_pinned_count, and
flagged via page->dma_pinned_flags. The PageDmaPinned flag is cleared when
the reference count hits zero, and the reference count is only used when
the flag is set.

All of the above provides a reliable PageDmaPinned flag, which is then used
to decide when to abort or wait for operations such as:

    try_to_unmap()
    page_mkclean()

In order to handle page_mkclean(), new information had to be plumbed down
from the filesystems, so that page_mkclean can decide whether to skip
dma-pinned pages, or to wait for them.

Thanks to Matthew Wilcox for suggesting re-using page->lru fields for a
new refcount and flag, and to Jan Kara for explaining the rest of the
design details (how to deal with page_mkclean() and try_to_unmap(),
especially). Also thanks to Dan Williams for design advice and DAX,
long-term pinning, and page flag thoughts.

References:

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

Changes since v1:

 -- Use page->lru and full reference counting, instead of a single page flag.
 -- Proper handling of page_mkclean().

John Hubbard (6):
  mm: get_user_pages: consolidate error handling
  mm: introduce page->dma_pinned_flags, _count
  mm: introduce zone_gup_lock, for dma-pinned pages
  mm/fs: add a sync_mode param for clear_page_dirty_for_io()
  mm: track gup pages with page->dma_pinned_* fields
  mm: page_mkclean, ttu: handle pinned pages

 drivers/video/fbdev/core/fb_defio.c |  3 +-
 fs/9p/vfs_addr.c                    |  2 +-
 fs/afs/write.c                      |  6 +-
 fs/btrfs/extent_io.c                | 14 ++---
 fs/btrfs/file.c                     |  2 +-
 fs/btrfs/free-space-cache.c         |  2 +-
 fs/btrfs/ioctl.c                    |  2 +-
 fs/ceph/addr.c                      |  4 +-
 fs/cifs/cifssmb.c                   |  3 +-
 fs/cifs/file.c                      |  5 +-
 fs/ext4/inode.c                     |  5 +-
 fs/f2fs/checkpoint.c                |  4 +-
 fs/f2fs/data.c                      |  2 +-
 fs/f2fs/dir.c                       |  2 +-
 fs/f2fs/gc.c                        |  4 +-
 fs/f2fs/inline.c                    |  2 +-
 fs/f2fs/node.c                      | 10 ++--
 fs/f2fs/segment.c                   |  3 +-
 fs/fuse/file.c                      |  2 +-
 fs/gfs2/aops.c                      |  2 +-
 fs/nfs/write.c                      |  2 +-
 fs/nilfs2/page.c                    |  2 +-
 fs/nilfs2/segment.c                 | 10 ++--
 fs/ubifs/file.c                     |  2 +-
 fs/xfs/xfs_aops.c                   |  2 +-
 include/linux/mm.h                  | 22 ++++++-
 include/linux/mm_types.h            | 22 +++++--
 include/linux/mmzone.h              |  7 +++
 include/linux/page-flags.h          | 50 ++++++++++++++++
 include/linux/rmap.h                |  4 +-
 mm/gup.c                            | 93 +++++++++++++++++++++++------
 mm/memcontrol.c                     |  7 +++
 mm/memory-failure.c                 |  3 +-
 mm/migrate.c                        |  2 +-
 mm/page-writeback.c                 | 14 +++--
 mm/page_alloc.c                     |  1 +
 mm/rmap.c                           | 71 ++++++++++++++++++++--
 mm/swap.c                           | 48 +++++++++++++++
 mm/truncate.c                       |  3 +-
 mm/vmscan.c                         |  2 +-
 40 files changed, 361 insertions(+), 85 deletions(-)

-- 
2.18.0

