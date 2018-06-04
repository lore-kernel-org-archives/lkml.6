Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeFDRxg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbeFDRxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:53:35 -0400
Date: Mon, 4 Jun 2018 13:53:35 -0400 (EDT)
From: Bob Peterson <rpeterso@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <159205243.39899342.1528134815167.JavaMail.zimbra@redhat.com>
In-Reply-To: <1772901878.39899227.1528134744434.JavaMail.zimbra@redhat.com>
Subject: GFS2: Pull request (merge window)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.15, 10.4.195.2]
Thread-Topic: GFS2: Pull request (merge window)
Thread-Index: PA3wtNNobXyY844K9iaVTMkEeboFlg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the following changes for the GFS2 file system.
Note that I'm on holiday the rest of this week, but I added Andreas
Gruenbacher to the MAINTAINERS file, so he can react if there are
problems that can't wait until I'm back on 11 June.

Regards,

Bob Peterson
----------------------------------------------------------------
The following changes since commit 16e205cf42da1f497b10a4a24f563e6c0d574eec:

  Merge tag 'drm-fixes-for-v4.17-rc1' of git://people.freedesktop.org/~airlied/linux (2018-04-12 20:56:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-4.18.fixes

for you to fetch changes up to 6d1c2cf2247599c5b50df7d04e254ef0edec812c:

  MAINTAINERS: Add Andreas Gruenbacher as a maintainer for gfs2 (2018-06-04 09:33:07 -0500)

----------------------------------------------------------------
We've got 9 more patches for this merge window.

1. Andreas Gruenbacher contributed a patch to remove sd_jheightsize to
   greatly simplify some code.
2. Andreas fixed some comments.
3. Andreas fixed a glock recursion bug when allocation errors occur.
4. Andreas improved the hole_size function so it returns the entire hole
   rather than figuring it out piecemeal.
5. Andreas cleaned up gfs2_stuffed_write_end to remove a lot of redundancy.
6. Andreas clarified code with regard to the way ordered writes are processed.
7. Andreas did a bunch of improvements and cleanups of the iomap code to
   pave the way for iomap writes, which is a future patch set.
8. I fixed a bug where block reservations can run off the end of a bitmap.
9. I added Andreas to the MAINTAINERS file.

----------------------------------------------------------------
Andreas Gruenbacher (7):
      gfs2: Remove sdp->sd_jheightsize
      gfs2: Update find_metapath comment
      GFS2: Fix allocation error bug with recursive rgrp glocking
      gfs2: hole_size improvement
      gfs2: gfs2_stuffed_write_end cleanup
      gfs2: Remove ordered write mode handling from gfs2_trans_add_data
      gfs2: Iomap cleanups and improvements

Bob Peterson (2):
      GFS2: gfs2_free_extlen can return an extent that is too long
      MAINTAINERS: Add Andreas Gruenbacher as a maintainer for gfs2

 MAINTAINERS          |   2 +-
 fs/gfs2/aops.c       |  69 ++++-----
 fs/gfs2/bmap.c       | 428 +++++++++++++++++++++++++++++++++------------------
 fs/gfs2/bmap.h       |   6 +-
 fs/gfs2/file.c       |   6 +-
 fs/gfs2/incore.h     |   3 +-
 fs/gfs2/inode.c      |   4 -
 fs/gfs2/log.h        |   7 +-
 fs/gfs2/ops_fstype.c |  19 ---
 fs/gfs2/quota.c      |   5 +-
 fs/gfs2/rgrp.c       |   2 +-
 fs/gfs2/trans.c      |  27 +---
 12 files changed, 332 insertions(+), 246 deletions(-)
