Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966570AbeBPPKK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:10:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56539 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966449AbeBPPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:10:08 -0500
From: John Ogness <john.ogness@linutronix.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] fs/dcache: Remove stale comment from dentry_kill()
Date: Fri, 16 Feb 2018 16:09:30 +0100
Message-Id: <20180216150933.971-2-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180216150933.971-1-john.ogness@linutronix.de>
References: <20180216150933.971-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0d98439ea3c6 ("vfs: use lockred "dead" flag to mark unrecoverably
dead dentries") removed the `ref' parameter in dentry_kill() but its
documentation remained. Remove it.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/dcache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7c38f39958bc..3c7e0148b453 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -592,7 +592,6 @@ static void __dentry_kill(struct dentry *dentry)
 /*
  * Finish off a dentry we've decided to kill.
  * dentry->d_lock must be held, returns with it unlocked.
- * If ref is non-zero, then decrement the refcount too.
  * Returns dentry requiring refcount drop, or NULL if we're done.
  */
 static struct dentry *dentry_kill(struct dentry *dentry)
-- 
2.11.0
