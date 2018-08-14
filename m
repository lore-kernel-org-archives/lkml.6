Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E2AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEA221735
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEA221735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeHNM3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:29:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728541AbeHNM3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:29:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B70C4401DED7;
        Tue, 14 Aug 2018 09:43:09 +0000 (UTC)
Received: from max.home.com (ovpn-117-44.ams2.redhat.com [10.36.117.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88511111AF34;
        Tue, 14 Aug 2018 09:43:06 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong " <darrick.wong@oracle.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [GIT PULL] gfs2: 4.19 merge
Date:   Tue, 14 Aug 2018 11:43:04 +0200
Message-Id: <20180814094304.18850-1-agruenba@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 14 Aug 2018 09:43:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 14 Aug 2018 09:43:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'agruenba@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following changes for gfs2:

  1. Iomap support for buffered writes and for direct I/O.
  2. Two patches that reduce the size of struct gfs2_inode.
  3. Lots of fixes and cleanups.

The following merge commit is non-empty on purpuse:

  Merge branch 'iomap-4.19-merge' into linux-gfs2/for-next

There we set the IOMAP_F_BUFFER_HEAD flag: this flag is introduced by commit
"iomap: add initial support for writes without buffer heads"; setting it after
the merge commit would break bisecting.

Thanks,
Andreas

-- 

The following changes since commit 806a1477b10a153cd01ee7ccba8ca2492df3e0b2:

  iomap: add inline data support to iomap_readpage_actor (2018-07-03 09:07:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git gfs2-4.19.fixes

for you to fetch changes up to f5580d0f8bf60993a5fbc73ee04678070ffbba57:

  gfs2: eliminate update_rgrp_lvb_unlinked (2018-08-08 10:34:39 -0500)

----------------------------------------------------------------
Andreas Gruenbacher (16):
      gfs2: Don't withdraw under a spin lock
      gfs2: Minor clarification to __gfs2_punch_hole
      gfs2: Further iomap cleanups
      gfs2: iomap buffered write support
      gfs2: gfs2_extent_length cleanup
      gfs2: iomap direct I/O support
      gfs2: Remove gfs2_write_{begin,end}
      gfs2: Stop messing with ip->i_rgd in the rlist code
      gfs2: Eliminate redundant ip->i_rgd
      Merge branch 'iomap-write' into linux-gfs2/for-next
      gfs2: fallocate_chunk: Always initialize struct iomap
      Merge branch 'iomap-4.19-merge' into linux-gfs2/for-next
      gfs2: Use iomap for stuffed direct I/O reads
      gfs2: use iomap_readpage for blocksize == PAGE_SIZE
      gfs2: Special-case rindex for gfs2_grow
      gfs2: Get rid of gfs2_ea_strlen

Arnd Bergmann (1):
      gfs2: call ktime_get_coarse_real_ts64() directly

Bob Peterson (7):
      gfs2: eliminate rs_inum and reduce the size of gfs2 inodes
      gfs2: Don't reject a supposedly full bitmap if we have blocks reserved
      GFS2: Fix recovery issues for spectators
      GFS2: rgrp free blocks used incorrectly
      gfs2: cleanup: call gfs2_rgrp_ondisk2lvb from gfs2_rgrp_out
      gfs2: Fix gfs2_testbit to use clone bitmaps
      gfs2: eliminate update_rgrp_lvb_unlinked

Chengguang Xu (1):
      gfs2: using posix_acl_xattr_size instead of posix_acl_to_xattr

Colin Ian King (1):
      gfs2: remove redundant variable 'moved'

Souptick Joarder (1):
      fs: gfs2: Adding new return type vm_fault_t

 fs/gfs2/acl.c        |   6 +-
 fs/gfs2/aops.c       | 337 +++--------------------------------------
 fs/gfs2/aops.h       |  19 +++
 fs/gfs2/bmap.c       | 414 +++++++++++++++++++++++++++++++++++++++++----------
 fs/gfs2/dir.c        |   4 +-
 fs/gfs2/file.c       | 161 ++++++++++++++++++--
 fs/gfs2/incore.h     |  23 ++-
 fs/gfs2/lock_dlm.c   |  20 ++-
 fs/gfs2/log.c        |  28 +++-
 fs/gfs2/lops.c       |   2 +-
 fs/gfs2/meta_io.c    |   4 +-
 fs/gfs2/recovery.c   |   7 +-
 fs/gfs2/rgrp.c       | 169 ++++++++++++---------
 fs/gfs2/super.c      |   1 -
 fs/gfs2/sys.c        |  11 +-
 fs/gfs2/trace_gfs2.h |   3 +-
 fs/gfs2/trans.h      |   6 +-
 fs/gfs2/util.c       |  38 ++---
 fs/gfs2/util.h       |  10 +-
 fs/gfs2/xattr.c      |  59 +++-----
 20 files changed, 752 insertions(+), 570 deletions(-)
 create mode 100644 fs/gfs2/aops.h
