Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeFDBSL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:18:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43494 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeFDBSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:18:10 -0400
Date: Mon, 4 Jun 2018 02:18:09 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs, pile 4
Message-ID: <20180604011808.GG30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	misc bits and pieces not fitting into anything more specific.
That's probably it for tonight; more to follow tomorrow...

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to eb915375757cd32c5abf7aea4caa76fe7edf8ef4:

  vfs: delete unnecessary assignment in vfs_listxattr (2018-05-29 13:22:41 -0400)

----------------------------------------------------------------
Al Viro (7):
      remove rpc_rmdir()
      msdos_rmdir(): kill BS comment
      it's SB_BORN, not MS_BORN...
      get rid of dead code in d_find_alias()
      vfat: simplify checks in vfat_lookup()
      make xattr_getsecurity() static
      __inode_security_revalidate() never gets NULL opt_dentry

Chengguang Xu (1):
      vfs: delete unnecessary assignment in vfs_listxattr

Danilo Krummrich (1):
      vfs: namei: use path_equal() in follow_dotdot()

Li Qiang (1):
      fs.h: fix outdated comment about file flags

Sean Anderson (1):
      Documentation: filesystems: update filesystem locking documentation

Zev Weiss (1):
      fs: avoid fdput() after failed fdget() in vfs_dedupe_file_range()

 Documentation/filesystems/Locking  | 43 +++++++++++---------
 fs/dcache.c                        | 83 ++++++++++++++++----------------------
 fs/fat/namei_msdos.c               |  4 --
 fs/fat/namei_vfat.c                | 13 +-----
 fs/namei.c                         |  4 +-
 fs/read_write.c                    |  6 +--
 fs/super.c                         |  2 +-
 fs/xattr.c                         |  4 +-
 include/linux/fs.h                 |  2 +-
 include/linux/sunrpc/rpc_pipe_fs.h |  2 -
 include/linux/xattr.h              |  1 -
 net/sunrpc/rpc_pipe.c              | 16 --------
 security/selinux/hooks.c           |  7 ++--
 13 files changed, 69 insertions(+), 118 deletions(-)
