Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758309AbeBPPtj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:49:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:35489 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758247AbeBPPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:49:37 -0500
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 4.16-rc1
Date: Fri, 16 Feb 2018 16:47:16 +0100
Message-Id: <cover.1518793408.git.dsterba@suse.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have a few assorted fixes, some of them show up during fstests so
I gave them more testing. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 3acbcbfc8f06d4ade2aab2ebba0a2542a05ce90c:

  btrfs: drop devid as device_list_add() arg (2018-01-29 19:31:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-4.16-rc1-tag

for you to fetch changes up to fd649f10c3d21ee9d7542c609f29978bdf73ab94:

  btrfs: Fix use-after-free when cleaning up fs_devs with a single stale device (2018-02-05 17:15:14 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      Btrfs: fix null pointer dereference when replacing missing device

Liu Bo (6):
      Btrfs: fix deadlock in run_delalloc_nocow
      Btrfs: fix crash due to not cleaning up tree log block's dirty bits
      Btrfs: fix extent state leak from tree log
      Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly
      Btrfs: fix use-after-free on root->orphan_block_rsv
      Btrfs: fix unexpected -EEXIST when creating new inode

Nikolay Borisov (2):
      btrfs: Ignore errors from btrfs_qgroup_trace_extent_post
      btrfs: Fix use-after-free when cleaning up fs_devs with a single stale device

Zygo Blaxell (1):
      btrfs: remove spurious WARN_ON(ref->count < 0) in find_parent_nodes

 fs/btrfs/backref.c     | 11 ++++++++++-
 fs/btrfs/delayed-ref.c |  3 ++-
 fs/btrfs/extent-tree.c |  4 ++++
 fs/btrfs/inode.c       | 41 ++++++++++++++++++++++++++---------------
 fs/btrfs/qgroup.c      |  9 +++++++--
 fs/btrfs/tree-log.c    | 32 ++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.c     |  1 +
 7 files changed, 80 insertions(+), 21 deletions(-)
