Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeCPBlI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 21:41:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56022 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeCPBlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 21:41:07 -0400
Date: Fri, 16 Mar 2018 01:41:06 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20180316014106.GB30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Backport-friendly part of lock_parent() race fix, a fix for assumption
in the heurisic used by path_connected() that is not true on NFS and livelock
fixes for d_alloc_parallel().

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-linus

for you to fetch changes up to 95dd77580ccd66a0da96e6d4696945b8cea39431:

  fs: Teach path_connected to handle nfs filesystems with multiple roots. (2018-03-15 18:48:38 -0400)

----------------------------------------------------------------
Al Viro (1):
      lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Eric W. Biederman (1):
      fs: Teach path_connected to handle nfs filesystems with multiple roots.

Will Deacon (2):
      fs: dcache: Avoid livelock between d_alloc_parallel and __d_add
      fs: dcache: Use READ_ONCE when accessing i_dir_seq

 fs/dcache.c        | 21 ++++++++++++++++-----
 fs/namei.c         |  5 +++--
 fs/nfs/super.c     |  2 ++
 include/linux/fs.h |  1 +
 4 files changed, 22 insertions(+), 7 deletions(-)
