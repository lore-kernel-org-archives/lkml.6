Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbeAaOyK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:54:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbeAaOyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:54:08 -0500
Date: Wed, 31 Jan 2018 09:54:08 -0500 (EST)
From: Bob Peterson <rpeterso@redhat.com>
To: torvalds@linux-foundation.org
Cc: cluster-devel <cluster-devel@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <1922986948.5567511.1517410448686.JavaMail.zimbra@redhat.com>
In-Reply-To: <2035999397.5567269.1517410350526.JavaMail.zimbra@redhat.com>
Subject: GFS2: Pull request (merge window)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.117.112, 10.4.195.5]
Thread-Topic: GFS2: Pull request (merge window)
Thread-Index: nVKcEu+8YCfCKb6lFB0CkZRpVBxktA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the following changes for the GFS2 file system.

Regards,

Bob Peterson
----------------------------------------------------------------
The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-4.16.fixes

for you to fetch changes up to af38816e4801d2868258085831172a003d1634ff:

  gfs2: Add a few missing newlines in messages (2018-01-30 10:32:30 -0700)

----------------------------------------------------------------
We've got 30 patches for this merge window. These generally fall into
five categories: (1) code cleanups, (2) patches related to adding
PUNCH_HOLE support to GFS2, (3) support for new fields in resource group
headers, (4) a few bug fixes, and (5) support for new fields in journal
log headers. These new fields, which were previously unused, are designed
to make it easier to track down file system corruption, and allow fsck.gfs2
to make more intelligent decisions when finding and fixing file system
corruption.

1. Abhi Das contributed a patch to trim the ordered writes list, which
   used to grow uncontrollably until unmount.
2. Abhi also added a second patch to trim the ordered writes list.
3. Andreas Gruenbacher removed an unused parameter from function
   gfs2_write_jdata_pagevec.
4. Andreas also removed a pointless BUG_ON.
5. Andreas cleaned up an error patch in trunc_start.
6. Andreas removed some unused parameters from truncate.
7. Andreas made gfs2_journaled_truncate more efficient.
8. Andreas cleaned up the support functions for truncate.
9. Andreas fixed metadata read-ahead for truncate to make it faster.
10. Andreas fixed up the non-recursive truncate code.
11. Andreas reworked and renamed function gfs2_block_truncate_page.
12. Andreas generalized the non-recursive truncate code so it can
    take a range of values for punch_hole support.
13. Andreas introduced new PUNCH_HOLE support that take advantage
    of the previous patches.
14. Andreas contributed a patch to add fallocate with PUNCH_HOLE.
15. Andreas fixed some typos in the comments.
16. Andreas added function gfs2_max_stuffed_size to replace a piece
    of code that was needlessly repeated throughout GFS2.
17. Andreas made a minor cleanup to function gfs2_page_add_databufs.
18. Andreas got rid of function gfs2_log_header_in in preparation for
    the new log header fields.
19. Andreas also fixed up some missing newlines in kernel messages.
20. Andy Price added a new field to resource groups to indicate where
    the next one should be, to allow fsck.gfs2 to make better repairs.
21. Andy also added new rindex fields for consistency checking.
22. Andy added a crc field to resource group headers for consistency
    checking.
23. I added a patch to reduce redundancy in functions common to
    freeing dinodes.
24. I added a patch to reduce redundancy when writing log headers
    between the journalling code and journal recovery code.
25. I added a patch to add new fields to journal log headers based
    on a prototype from Steve Whitehouse.
26. I added a patch to log the source of journal log headers so we
    can better track down journal corruption.
27. I added a patch to fix a minor comment typo.
28. I also added a patch to fix a BUG in an unlink error path.
29. Steve Whitehouse contributed a patch to fix an incorrect use
    of the gfs2_blk2rgrpd function.
30. Tetsuo Handa contributed a patch that fixes incorrect error
    handling in function init_gfs2_fs.

----------------------------------------------------------------
Abhi Das (2):
      gfs2: Trim the ordered write list in gfs2_ordered_write()
      gfs2: Remove inode from ordered write list in gfs2_write_inode()

Andreas Gruenbacher (17):
      gfs2: Remove unused gfs2_write_jdata_pagevec parameter
      gfs2: Remove pointless BUG_ON
      gfs2: Clean up trunc_start error path
      gfs2: truncate: Remove unnecessary oldsize parameters
      gfs2: Remove minor gfs2_journaled_truncate inefficiencies
      gfs2: Clean up {lookup,fillup}_metapath
      gfs2: Fix metadata read-ahead during truncate
      gfs2: Improve non-recursive delete algorithm
      Turn gfs2_block_truncate_page into gfs2_block_zero_range
      gfs2: Generalize truncate code
      gfs2: Turn trunc_dealloc into punch_hole
      gfs2: Implement fallocate(FALLOC_FL_PUNCH_HOLE)
      gfs2: Typo fixes
      gfs2: Add gfs2_max_stuffed_size
      gfs2: Minor gfs2_page_add_databufs cleanup
      gfs2: Get rid of gfs2_log_header_in
      gfs2: Add a few missing newlines in messages

Andrew Price (3):
      gfs2: Add a next-resource-group pointer to resource groups
      gfs2: Add rindex fields to rgrp headers
      gfs2: Add a crc field to resource group headers

Bob Peterson (7):
      GFS2: Combine gfs2_free_di with gfs2_free_uninit_di
      GFS2: Reduce code redundancy writing log headers
      Merge branch 'punch-hole' of git://git.kernel.org/.../gfs2/linux-gfs2.git
      GFS2: Introduce new gfs2_log_header_v2
      GFS2: Log the reason for log flushes in every log header
      GFS2: Fix minor comment typo
      GFS2: Don't try to end a non-existent transaction in unlink

Steven Whitehouse (1):
      gfs2: Add gfs2_blk2rgrpd comment and fix incorrect use

Tetsuo Handa (1):
      gfs2: Fix wrong error handling in init_gfs2_fs()

 fs/gfs2/Kconfig                  |   2 +
 fs/gfs2/aops.c                   |  35 +--
 fs/gfs2/bmap.c                   | 583 +++++++++++++++++++++++++++------------
 fs/gfs2/bmap.h                   |   1 +
 fs/gfs2/dir.c                    |   3 +-
 fs/gfs2/file.c                   |  23 +-
 fs/gfs2/glops.c                  |  19 +-
 fs/gfs2/incore.h                 |   6 +-
 fs/gfs2/inode.c                  |  11 +-
 fs/gfs2/lock_dlm.c               |   4 +-
 fs/gfs2/log.c                    | 124 ++++++---
 fs/gfs2/log.h                    |  10 +-
 fs/gfs2/lops.c                   |  18 +-
 fs/gfs2/lops.h                   |   3 +
 fs/gfs2/main.c                   |  90 +++---
 fs/gfs2/ops_fstype.c             |   2 +-
 fs/gfs2/quota.c                  |   3 +-
 fs/gfs2/recovery.c               | 110 +++-----
 fs/gfs2/rgrp.c                   |  38 ++-
 fs/gfs2/super.c                  |  19 +-
 fs/gfs2/sys.c                    |   4 +-
 fs/gfs2/trace_gfs2.h             |  11 +-
 fs/gfs2/trans.c                  |   4 +-
 include/uapi/linux/gfs2_ondisk.h |  62 ++++-
 24 files changed, 758 insertions(+), 427 deletions(-)
