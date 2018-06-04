Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeFDA7k (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 20:59:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43148 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeFDA7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 20:59:39 -0400
Date: Mon, 4 Jun 2018 01:59:38 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs, pile 1
Message-ID: <20180604005937.GD30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	That pile is the first part of dealing with livelocks, etc. around
shrink_dcache_parent().

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

for you to fetch changes up to 4fb48871409e2fcd375087d526d07f7600c88f94:

  restore cond_resched() in shrink_dcache_parent() (2018-04-19 23:58:48 -0400)

----------------------------------------------------------------
Al Viro (5):
      d_invalidate(): unhash immediately
      d_walk(): kill 'finish' callback
      dcache: move cond_resched() into the end of __dentry_kill()
      dput(): turn into explicit while() loop
      restore cond_resched() in shrink_dcache_parent()

 fs/dcache.c | 122 +++++++++++++++++++++---------------------------------------
 1 file changed, 43 insertions(+), 79 deletions(-)
