Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF62ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8C120685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8C120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeKEKuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:50:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:60918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeKEKuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:50:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3ED86AFD9;
        Mon,  5 Nov 2018 01:32:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 05 Nov 2018 12:30:48 +1100
Subject: [PATCH 12/12] VFS: locks: remove unnecessary white space.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154138144804.31651.17874603642711748514.stgit@noble>
In-Reply-To: <154138128401.31651.1381177427603557514.stgit@noble>
References: <154138128401.31651.1381177427603557514.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - spaces before tabs,
 - spaces at the end of lines,
 - multiple blank lines,
 - blank lines before EXPORT_SYMBOL,
can all go.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index d00a36523c3f..17a72875b65c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -11,11 +11,11 @@
  *
  *  Miscellaneous edits, and a total rewrite of posix_lock_file() code.
  *  Kai Petzke (wpp@marie.physik.tu-berlin.de), 1994
- *  
+ *
  *  Converted file_lock_table to a linked list from an array, which eliminates
  *  the limits on how many active file locks are open.
  *  Chad Page (pageone@netcom.com), November 27, 1994
- * 
+ *
  *  Removed dependency on file descriptors. dup()'ed file descriptors now
  *  get the same locks as the original file descriptors, and a close() on
  *  any file descriptor removes ALL the locks on the file for the current
@@ -41,7 +41,7 @@
  *  with a file pointer (filp). As a result they can be shared by a parent
  *  process and its children after a fork(). They are removed when the last
  *  file descriptor referring to the file pointer is closed (unless explicitly
- *  unlocked). 
+ *  unlocked).
  *
  *  FL_FLOCK locks never deadlock, an existing lock is always removed before
  *  upgrading from shared to exclusive (or vice versa). When this happens
@@ -50,7 +50,7 @@
  *  Andy Walker (andy@lysaker.kvaerner.no), June 09, 1995
  *
  *  Removed some race conditions in flock_lock_file(), marked other possible
- *  races. Just grep for FIXME to see them. 
+ *  races. Just grep for FIXME to see them.
  *  Dmitry Gorodchanin (pgmdsg@ibi.com), February 09, 1996.
  *
  *  Addressed Dmitry's concerns. Deadlock checking no longer recursive.
@@ -359,7 +359,6 @@ void locks_init_lock(struct file_lock *fl)
 	memset(fl, 0, sizeof(struct file_lock));
 	locks_init_lock_heads(fl);
 }
-
 EXPORT_SYMBOL(locks_init_lock);
 
 /*
@@ -399,7 +398,6 @@ void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 			fl->fl_ops->fl_copy_lock(new, fl);
 	}
 }
-
 EXPORT_SYMBOL(locks_copy_lock);
 
 static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
@@ -435,7 +433,7 @@ flock_make_lock(struct file *filp, unsigned int cmd, struct file_lock *fl)
 
 	if (type < 0)
 		return ERR_PTR(type);
-	
+
 	if (fl == NULL)
 		fl = locks_alloc_lock();
 	if (fl == NULL)
@@ -447,7 +445,7 @@ flock_make_lock(struct file *filp, unsigned int cmd, struct file_lock *fl)
 	fl->fl_flags = FL_FLOCK;
 	fl->fl_type = type;
 	fl->fl_end = OFFSET_MAX;
-	
+
 	return fl;
 }
 
@@ -1104,8 +1102,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			}
 			spin_unlock(&blocked_lock_lock);
 			goto out;
-  		}
-  	}
+		}
+	}
 
 	/* If we're just looking for a conflict, we're done. */
 	error = 0;
@@ -1400,7 +1398,6 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
 
 	return error;
 }
-
 EXPORT_SYMBOL(locks_mandatory_area);
 #endif /* CONFIG_MANDATORY_FILE_LOCKING */
 
@@ -1602,7 +1599,6 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	locks_free_lock(new_fl);
 	return error;
 }
-
 EXPORT_SYMBOL(__break_lease);
 
 /**
@@ -1633,7 +1629,6 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 	if (has_lease)
 		*time = current_time(inode);
 }
-
 EXPORT_SYMBOL(lease_get_mtime);
 
 /**
@@ -1688,8 +1683,8 @@ int fcntl_getlease(struct file *filp)
 
 /**
  * check_conflicting_open - see if the given dentry points to a file that has
- * 			    an existing open that would conflict with the
- * 			    desired lease.
+ *			    an existing open that would conflict with the
+ *			    desired lease.
  * @dentry:	dentry to check
  * @arg:	type of lease that we're trying to acquire
  * @flags:	current lock flags
@@ -1913,7 +1908,7 @@ EXPORT_SYMBOL(generic_setlease);
  * @arg:	type of lease to obtain
  * @lease:	file_lock to use when adding a lease
  * @priv:	private info for lm_setup when adding a lease (may be
- * 		NULL if lm_setup doesn't require it)
+ *		NULL if lm_setup doesn't require it)
  *
  * Call this to establish a lease on the file. The "lease" argument is not
  * used for F_UNLCK requests and may be NULL. For commands that set or alter
@@ -2201,7 +2196,7 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
 	error = vfs_test_lock(filp, fl);
 	if (error)
 		goto out;
- 
+
 	flock->l_type = fl->fl_type;
 	if (fl->fl_type != F_UNLCK) {
 		error = posix_lock_to_flock(flock, fl);
@@ -2549,7 +2544,6 @@ void locks_remove_posix(struct file *filp, fl_owner_t owner)
 		lock.fl_ops->fl_release_private(&lock);
 	trace_locks_remove_posix(inode, &lock, error);
 }
-
 EXPORT_SYMBOL(locks_remove_posix);
 
 /* The i_flctx must be valid when calling into here */
@@ -2635,7 +2629,6 @@ int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
 		return filp->f_op->lock(filp, F_CANCELLK, fl);
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(vfs_cancel_lock);
 
 #ifdef CONFIG_PROC_FS
@@ -2835,7 +2828,6 @@ static int __init filelock_init(void)
 	filelock_cache = kmem_cache_create("file_lock_cache",
 			sizeof(struct file_lock), 0, SLAB_PANIC, NULL);
 
-
 	for_each_possible_cpu(i) {
 		struct file_lock_list_struct *fll = per_cpu_ptr(&file_lock_list, i);
 
@@ -2845,5 +2837,4 @@ static int __init filelock_init(void)
 
 	return 0;
 }
-
 core_initcall(filelock_init);


