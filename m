Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeDLDks (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 23:40:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54966 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLDkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 23:40:47 -0400
Date: Thu, 12 Apr 2018 04:40:46 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] afs series
Message-ID: <20180412034046.GR30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	AFS series posted by dhowells depended upon lookup_one_len()
rework; now that prereq is in the mainline, that series had been
rebased on top of it and got some exposure and testing...

The following changes since commit fd3b36d275660c905da9900b078eea341847d5e4:

  Merge branch 'work.namei' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2018-04-09 12:48:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git afs-dh

for you to fetch changes up to 5a8132761609bd7e42db642d6f157140d5bf2ae8:

  afs: Do better accretion of small writes on newly created content (2018-04-09 21:54:48 +0100)

----------------------------------------------------------------
David Howells (20):
      vfs: Remove the const from dir_context::actor
      afs: Fix checker warnings
      afs: Don't over-increment the cell usage count when pinning it
      afs: Prospectively look up extra files when doing a single lookup
      afs: Implement @sys substitution handling
      afs: Implement @cell substitution handling
      afs: Dump bad status record
      afs: Introduce a statistics proc file
      afs: Init inode before accessing cache
      afs: Make it possible to get the data version in readpage
      afs: Rearrange status mapping
      afs: Keep track of invalid-before version for dentry coherency
      afs: Split the dynroot stuff out and give it its own ops tables
      afs: Fix directory handling
      afs: Split the directory content defs into a header
      afs: Adjust the directory XDR structures
      afs: Locally edit directory data for mkdir/create/unlink/...
      afs: Trace protocol errors
      afs: Add stats for data transfer operations
      afs: Do better accretion of small writes on newly created content

 Documentation/filesystems/afs.txt |  28 +-
 fs/afs/Makefile                   |   2 +
 fs/afs/addr_list.c                |   6 +-
 fs/afs/afs.h                      |  27 +-
 fs/afs/afs_fs.h                   |   2 +
 fs/afs/callback.c                 |  29 +-
 fs/afs/cell.c                     |  12 +-
 fs/afs/cmservice.c                |  22 +-
 fs/afs/dir.c                      | 923 ++++++++++++++++++++++++++------------
 fs/afs/dir_edit.c                 | 505 +++++++++++++++++++++
 fs/afs/dynroot.c                  | 209 +++++++++
 fs/afs/file.c                     |  27 +-
 fs/afs/flock.c                    |   2 +-
 fs/afs/fsclient.c                 | 622 ++++++++++++++++++++-----
 fs/afs/inode.c                    |  69 ++-
 fs/afs/internal.h                 | 105 ++++-
 fs/afs/main.c                     |  44 ++
 fs/afs/proc.c                     | 326 +++++++++++++-
 fs/afs/rotate.c                   |   2 +-
 fs/afs/rxrpc.c                    |   9 +
 fs/afs/security.c                 |  13 +-
 fs/afs/server.c                   |  14 +-
 fs/afs/super.c                    |  11 +-
 fs/afs/vlclient.c                 |  28 +-
 fs/afs/write.c                    |  41 +-
 fs/afs/xdr_fs.h                   | 103 +++++
 include/linux/fs.h                |   2 +-
 include/trace/events/afs.h        | 113 +++++
 28 files changed, 2703 insertions(+), 593 deletions(-)
 create mode 100644 fs/afs/dir_edit.c
 create mode 100644 fs/afs/dynroot.c
 create mode 100644 fs/afs/xdr_fs.h
