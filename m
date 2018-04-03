Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeDCRcz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:32:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751602AbeDCRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:32:54 -0400
Date: Tue, 3 Apr 2018 13:32:54 -0400 (EDT)
From: Bob Peterson <rpeterso@redhat.com>
To: torvalds@linux-foundation.org
Cc: cluster-devel <cluster-devel@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <1728469166.15741124.1522776774217.JavaMail.zimbra@redhat.com>
In-Reply-To: <242799785.15741010.1522776740239.JavaMail.zimbra@redhat.com>
Subject: GFS2: Pull request (merge window)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.80, 10.4.195.11]
Thread-Topic: GFS2: Pull request (merge window)
Thread-Index: YIOGeWG8iGRU+vYjHWzm75bRm2+fUQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the following changes for the GFS2 file system.

Regards,

Bob Peterson
----------------------------------------------------------------
The following changes since commit 1b88accf6a659c46d5c8e68912896f112bf882bb:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2018-03-07 17:49:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-4.17.fixes

for you to fetch changes up to 5e86d9d122d0d6fae00d9dff41c22d6f4d09f566:

  gfs2: time journal recovery steps accurately (2018-03-29 10:41:27 -0700)

----------------------------------------------------------------
We've only got 9 GFS2 patches for this merge window:

1. Abhi Das contributed a patch to report journal recovery times more
   accurately during journal replay.
2. Andreas Gruenbacher contributed a patch to fix fallocate chunk size.
3. Andreas added a patch to correctly dirty inodes during rename.
4. Andreas added a patch to improve the comment for function gfs2_block_map.
5. Andreas added a patch to improve kernel trace point iomap end:
   The physical block address was added.
6. Andreas added a patch to fix a nasty file system corruption bug that
   surfaced in xfstests 476 in punch-hole/truncate.
7. Andreas fixed a problem Christoph Helwig pointed out, namely, that GFS2
   was misusing the IOMAP_ZERO flag. The zeroing of new blocks was moved
   to the proper fallocate code.
8. I contributed a patch to declare function gfs2_remove_from_ail as static.
9. I added a patch to only set PageChecked for jdata page writes.

----------------------------------------------------------------
Abhi Das (1):
      gfs2: time journal recovery steps accurately

Andreas Gruenbacher (6):
      gfs2: Fix fallocate chunk size
      gfs2: Dirty source inode during rename
      gfs2: Improve gfs2_block_map comment
      gfs2: gfs2_iomap_end tracepoint: log block address
      gfs2: Check for the end of metadata in punch_hole
      gfs2: Zero out fallocated blocks in fallocate_chunk

Bob Peterson (2):
      GFS2: Make function gfs2_remove_from_ail static
      GFS2: Only set PageChecked for jdata pages

 fs/gfs2/aops.c       |  8 ++++----
 fs/gfs2/bmap.c       | 38 ++++++++++++++++++++------------------
 fs/gfs2/dir.c        | 13 ++-----------
 fs/gfs2/file.c       | 34 +++++++++++++++++-----------------
 fs/gfs2/incore.h     |  3 ---
 fs/gfs2/inode.c      | 10 +---------
 fs/gfs2/log.c        |  2 +-
 fs/gfs2/log.h        |  1 -
 fs/gfs2/quota.h      |  2 ++
 fs/gfs2/recovery.c   | 20 ++++++++++++++------
 fs/gfs2/trace_gfs2.h |  9 +++++++--
 11 files changed, 68 insertions(+), 72 deletions(-)
