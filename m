Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756027AbeDTP6v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:58:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38320 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755318AbeDTP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:58:48 -0400
Date: Fri, 20 Apr 2018 16:58:46 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs fixes
Message-ID: <20180420155846.GO30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Assorted fixes.  Some of that is only a matter with fault injection
(broken handling of small allocation failure in various mount-related places),
but the last one is a root-triggerable stack overflow, and combined with
userns it gets really nasty ;-/

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-linus

for you to fetch changes up to 16a34adb9392b2fe4195267475ab5b472e55292c:

  Don't leak MNT_INTERNAL away from internal mounts (2018-04-19 23:52:15 -0400)

----------------------------------------------------------------
Al Viro (5):
      hypfs_kill_super(): deal with failed allocations
      jffs2_kill_sb(): deal with failed allocations
      orangefs_kill_sb(): deal with allocation failures
      rpc_pipefs: fix double-dput()
      Don't leak MNT_INTERNAL away from internal mounts

Tetsuo Handa (1):
      mm,vmscan: Allow preallocating memory for register_shrinker().

 arch/s390/hypfs/inode.c  |  2 +-
 fs/jffs2/super.c         |  2 +-
 fs/namespace.c           |  3 ++-
 fs/orangefs/super.c      |  5 +++++
 fs/super.c               |  9 ++++-----
 include/linux/shrinker.h |  7 +++++--
 mm/vmscan.c              | 21 ++++++++++++++++++++-
 net/sunrpc/rpc_pipe.c    |  1 +
 8 files changed, 39 insertions(+), 11 deletions(-)
