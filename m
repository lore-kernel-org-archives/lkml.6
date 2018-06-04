Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbeFDSSQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:18:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39910 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeFDSSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:18:15 -0400
Date: Mon, 4 Jun 2018 19:18:13 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs, pile 4
Message-ID: <20180604181813.GK30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Cleaning ->lookup() instances up - mostly d_splice_alias() conversions.

The following changes since commit baf10564fbb66ea222cae66fbff11c444590ffd9:

  aio: fix io_destroy(2) vs. lookup_ioctx() race (2018-05-21 14:30:11 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.lookup

for you to fetch changes up to 888e2b03ef56694290e58bd9ac23f8033bf6369f:

  switch the rest of procfs lookups to d_splice_alias() (2018-05-26 14:20:50 -0400)

----------------------------------------------------------------
Al Viro (30):
      Merge branch 'work.misc' into work.lookup
      bfs_lookup(): use d_splice_alias()
      bfs_find_entry: pass name/len as qstr pointer
      bfs_add_entry: pass name/len as qstr pointer
      cramfs_lookup(): use d_splice_alias()
      freevxfs_lookup(): use d_splice_alias()
      minix_lookup: use d_splice_alias()
      qnx4_lookup: use d_splice_alias()
      sysv_lookup: use d_splice_alias()
      ubifs_lookup: use d_splice_alias()
      qnx6_lookup: switch to d_splice_alias()
      romfs_lookup: switch to d_splice_alias()
      adfs_lookup_byname: .. *is* taken care of in fs/namei.c
      adfs_lookup: do not fail with ENOENT on negatives, use d_splice_alias()
      xfs_vn_lookup: simplify a bit
      openpromfs: switch to d_splice_alias()
      orangefs_lookup: simplify
      omfs_lookup(): report IO errors, use d_splice_alias()
      hfs: use d_splice_alias()
      hfs: don't allow mounting over .../rsrc
      hfsplus: switch to d_splice_alias()
      ncp_lookup(): use d_splice_alias()
      9p: unify paths in v9fs_vfs_lookup()
      cifs_lookup(): cifs_get_inode_...() never returns 0 with *inode left NULL
      cifs_lookup(): switch to d_splice_alias()
      procfs: get rid of ancient BS in pid_revalidate() uses
      proc_lookupfd_common(): don't bother with instantiate unless the file is open
      don't bother with tid_fd_revalidate() in lookups
      procfs: switch instantiate_t to d_splice_alias()
      switch the rest of procfs lookups to d_splice_alias()

 drivers/staging/ncpfs/dir.c        |  42 ++++-------
 fs/9p/vfs_inode.c                  |  35 ++++------
 fs/adfs/dir.c                      |  24 ++-----
 fs/bfs/dir.c                       |  43 +++++-------
 fs/cifs/dir.c                      |  38 +++++-----
 fs/cramfs/inode.c                  |   5 +-
 fs/dcache.c                        |  83 +++++++++-------------
 fs/fat/namei_msdos.c               |   4 --
 fs/fat/namei_vfat.c                |  13 +---
 fs/freevxfs/vxfs_lookup.c          |   8 +--
 fs/hfs/dir.c                       |  20 ++----
 fs/hfs/inode.c                     |   4 +-
 fs/hfsplus/dir.c                   |   3 +-
 fs/minix/namei.c                   |   8 +--
 fs/namei.c                         |   4 +-
 fs/omfs/dir.c                      |   7 +-
 fs/openpromfs/inode.c              |   3 +-
 fs/orangefs/namei.c                |  64 +++--------------
 fs/proc/base.c                     | 136 ++++++++++++++++--------------------
 fs/proc/fd.c                       | 138 ++++++++++++++++++++-----------------
 fs/proc/generic.c                  |   3 +-
 fs/proc/internal.h                 |   4 +-
 fs/proc/namespaces.c               |  24 +++----
 fs/proc/proc_sysctl.c              |  15 +++-
 fs/qnx4/namei.c                    |   8 +--
 fs/qnx6/namei.c                    |   8 +--
 fs/read_write.c                    |   6 +-
 fs/romfs/super.c                   |  36 +++-------
 fs/super.c                         |   2 +-
 fs/sysv/namei.c                    |   9 +--
 fs/ubifs/dir.c                     |  43 ++++--------
 fs/xattr.c                         |   3 +-
 fs/xfs/xfs_iops.c                  |  16 ++---
 include/linux/fs.h                 |   2 +-
 include/linux/sunrpc/rpc_pipe_fs.h |   2 -
 include/linux/xattr.h              |   1 -
 net/sunrpc/rpc_pipe.c              |  16 -----
 security/selinux/hooks.c           |   7 +-
 38 files changed, 338 insertions(+), 549 deletions(-)
