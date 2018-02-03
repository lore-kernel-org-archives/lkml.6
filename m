Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752741AbeBCROt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:14:49 -0500
Received: from imap.thunk.org ([74.207.234.97]:33280 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeBCROn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:14:43 -0500
Date: Sat, 3 Feb 2018 12:14:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 updates for 4.16
Message-ID: <20180203171439.GA24492@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 5dc397113d195a004899ee672c5a8a19809495ba:

  ext4: create ext4_kset dynamically (2018-01-11 15:34:04 -0500)

----------------------------------------------------------------
Only miscellaneous cleanups and bug fixes for ext4 this cycle.

----------------------------------------------------------------
Alexander Potapenko (1):
      mbcache: initialize entry->e_referenced in mb_cache_entry_create()

Colin Ian King (1):
      ext4: fix incorrect indentation of if statement

Eric Biggers (1):
      mbcache: revert "fs/mbcache.c: make count_objects() more robust"

Ernesto A. Fernández (1):
      ext4: correct documentation for grpid mount option

Harshad Shirwadkar (1):
      ext4: fix a race in the ext4 shutdown path

Jan Kara (2):
      dax: pass detailed error code from dax_iomap_fault()
      ext4: fix ENOSPC handling in DAX page fault handler

Jiang Biao (1):
      mbcache: make sure c_entry_count is not decremented past zero

Jun Piao (1):
      ext4: use 'sbi' instead of 'EXT4_SB(sb)'

Petros Koutoupis (1):
      ext4: fixed alignment and minor code cleanup in ext4.h

Riccardo Schirone (3):
      ext4: release kobject/kset even when init/register fail
      ext4: create ext4_feat kobject dynamically
      ext4: create ext4_kset dynamically

Theodore Ts'o (1):
      ext4: fix up remaining files with SPDX cleanups

Tobin C. Harding (1):
      jbd2: fix sphinx kernel-doc build warnings

Zhouyi Zhou (1):
      ext4: save error to disk in __ext4_grp_locked_error()

piaojun (1):
      ext4: no need flush workqueue before destroying it

 Documentation/filesystems/ext4.txt |   2 +-
 fs/dax.c                           |   9 +-
 fs/ext2/file.c                     |   2 +-
 fs/ext4/acl.h                      |   2 +-
 fs/ext4/balloc.c                   |   4 +-
 fs/ext4/block_validity.c           |   6 +-
 fs/ext4/ext4.h                     |  22 ++--
 fs/ext4/ext4_extents.h             |  14 +--
 fs/ext4/ext4_jbd2.h                |   5 +-
 fs/ext4/extents.c                  |  14 +--
 fs/ext4/extents_status.h           |   2 +-
 fs/ext4/file.c                     |  10 +-
 fs/ext4/fsmap.c                    |  15 +--
 fs/ext4/fsmap.h                    |  15 +--
 fs/ext4/hash.c                     |   6 +-
 fs/ext4/ialloc.c                   |   4 +-
 fs/ext4/inline.c                   |  10 +-
 fs/ext4/inode.c                    |  16 ++-
 fs/ext4/mballoc.c                  |  28 ++----
 fs/ext4/mballoc.h                  |   2 +-
 fs/ext4/migrate.c                  |   9 +-
 fs/ext4/move_extent.c              |  10 +-
 fs/ext4/namei.c                    |   6 +-
 fs/ext4/resize.c                   |   2 +-
 fs/ext4/super.c                    |   9 +-
 fs/ext4/sysfs.c                    |  65 ++++++++----
 fs/ext4/truncate.h                 |   2 +-
 fs/ext4/xattr.h                    |   2 +-
 fs/jbd2/checkpoint.c               |   5 +-
 fs/jbd2/commit.c                   |   5 +-
 fs/jbd2/journal.c                  |   5 +-
 fs/jbd2/recovery.c                 |   5 +-
 fs/jbd2/revoke.c                   |   5 +-
 fs/jbd2/transaction.c              |  10 +-
 fs/mbcache.c                       |   8 +-
 fs/xfs/xfs_file.c                  |   2 +-
 include/linux/dax.h                |   2 +-
 include/linux/jbd2.h               | 431 +++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 38 files changed, 407 insertions(+), 364 deletions(-)
