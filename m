Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3488533-1521618624-2-7084921187687447050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521618624; b=runB+63jJcLjIhxqUoS4ReDIPCWnbzSyGwDLp4Lt2icZLzC
    UDmI8aeppvl+l+fC6v49uzTFhmHq4llhP5NcqSBpxS5J4UEAhegNCpokGQgzA3+x
    uLNCZ4pSNrcx7EAw46rssDRU8AHg71V9c92MBxlvkZMhCF4eRb0eVTJy3CCkHW52
    a7ATPInMEeeGL2PEMJ6+UcVI3PFUciGiOno641PHLzKcg0nS4koLifmJiKjt372O
    NCqzOD1XPTBb2MgwSS+YNuA6NCtWtuJnCX09UFJ3baxC4eXqD9Ywl/4gF+BMvGZR
    +OXqXglEHf9ChCwrxFq2gb/mqGTbF+efYYVJtUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618624;
    bh=QtjLpjaSjP0DtmB9wOIYopLRg0BYQxZ+tWpN1dnt800=; b=SNJGt3k/8hx3
    DBTYHD23AO/ARlzaLiRCalG98Kx0at5XqXzsZiTfU+39hlDLmmQfoPqtBpS74g95
    viS+JpS1uLTkoYXDHQI+8NDfNgJVALnvLXF+koVJyyMXcoKZMvdVeMb3dWWtCBIU
    srslASLdL+P3RTXxrhlQOKTCihtKECm9jFW6yQeiJfUkzPQKg1CeMdEQSUO1K8kz
    oEVH4gt3CxRtrIGb793VlSBAK8wif89LLViZzo608U0pQWDT7BEl9nSl5Mq97duh
    vWeN/LXClFlIYTzuRYWrYKy1TBKl9LBSk5Kx7Ws+0/opkVmbbBjuqOXt+GDMRJXe
    AkzaXPdsNw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=js4ugnIJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=js4ugnIJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeCUHlC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:41:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeCUHk6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:40:58 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/28] fs: introduce new ->get_poll_head and ->poll_mask methods
Date: Wed, 21 Mar 2018 08:40:09 +0100
Message-Id: <20180321074032.14211-6-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321074032.14211-1-hch@lst.de>
References: <20180321074032.14211-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

->get_poll_head returns the waitqueue that the poll operation is going
to sleep on.  Note that this means we can only use a single waitqueue
for the poll, unlike some current drivers that use two waitqueues for
different events.  But now that we have keyed wakeups and heavily use
those for poll there aren't that many good reason left to keep the
multiple waitqueues, and if there are any ->poll is still around, the
driver just won't support aio poll.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/Locking |  7 ++++++-
 Documentation/filesystems/vfs.txt | 13 +++++++++++++
 fs/select.c                       | 28 ++++++++++++++++++++++++++++
 include/linux/fs.h                |  2 ++
 include/linux/poll.h              | 27 +++++++++++++++++++++++----
 5 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 220bba28f72b..6d227f9d7bd9 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -440,6 +440,8 @@ prototypes:
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iterate) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
+	struct wait_queue_head * (*get_poll_head)(struct file *, __poll_t);
+	__poll_t (*poll_mask) (struct file *, __poll_t);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
@@ -470,7 +472,7 @@ prototypes:
 };
 
 locking rules:
-	All may block.
+	All except for ->poll_mask may block.
 
 ->llseek() locking has moved from llseek to the individual llseek
 implementations.  If your fs is not using generic_file_llseek, you
@@ -498,6 +500,9 @@ in sys_read() and friends.
 the lease within the individual filesystem to record the result of the
 operation
 
+->poll_mask can be called with or without the waitqueue lock for the waitqueue
+returned from ->get_poll_head.
+
 --------------------------- dquot_operations -------------------------------
 prototypes:
 	int (*write_dquot) (struct dquot *);
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index f608180ad59d..50ee13563271 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -857,6 +857,8 @@ struct file_operations {
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iterate) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
+	struct wait_queue_head * (*get_poll_head)(struct file *, __poll_t);
+	__poll_t (*poll_mask) (struct file *, __poll_t);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
@@ -901,6 +903,17 @@ otherwise noted.
 	activity on this file and (optionally) go to sleep until there
 	is activity. Called by the select(2) and poll(2) system calls
 
+  get_poll_head: Returns the struct wait_queue_head that poll, select,
+  epoll or aio poll should wait on in case this instance only has single
+  waitqueue.  Can return NULL to indicate polling is not supported,
+  or a POLL* value using the POLL_TO_PTR helper in case a grave error
+  occured and ->poll_mask shall not be called.
+
+  poll_mask: return the mask of POLL* values describing the file descriptor
+  state.  Called either before going to sleep on the waitqueue returned by
+  get_poll_head, or after it has been woken.  If ->get_poll_head and
+  ->poll_mask are implemented ->poll does not need to be implement.
+
   unlocked_ioctl: called by the ioctl(2) system call.
 
   compat_ioctl: called by the ioctl(2) system call when 32 bit system calls
diff --git a/fs/select.c b/fs/select.c
index ba91103707ea..cc270d7f6192 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -34,6 +34,34 @@
 
 #include <linux/uaccess.h>
 
+__poll_t vfs_poll(struct file *file, struct poll_table_struct *pt)
+{
+	unsigned int events = poll_requested_events(pt);
+	struct wait_queue_head *head;
+
+	if (unlikely(!file_can_poll(file)))
+		return DEFAULT_POLLMASK;
+
+	if (file->f_op->poll)
+		return file->f_op->poll(file, pt);
+
+	/*
+	 * Only get the poll head and do the first mask check if we are actually
+	 * going to sleep on this file:
+	 */
+	if (pt && pt->_qproc) {
+		head = vfs_get_poll_head(file, events);
+		if (!head)
+			return DEFAULT_POLLMASK;
+		if (IS_ERR(head))
+			return PTR_TO_POLL(head);
+
+		pt->_qproc(file, head, pt);
+	}
+
+	return file->f_op->poll_mask(file, events);
+}
+EXPORT_SYMBOL_GPL(vfs_poll);
 
 /*
  * Estimate expected accuracy in ns from a timeval.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 79c413985305..6ea2c0843bb1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1708,6 +1708,8 @@ struct file_operations {
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
+	struct wait_queue_head * (*get_poll_head)(struct file *, __poll_t);
+	__poll_t (*poll_mask) (struct file *, __poll_t);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
diff --git a/include/linux/poll.h b/include/linux/poll.h
index 7e0fdcf905d2..42e8e8665fb0 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -74,18 +74,37 @@ static inline void init_poll_funcptr(poll_table *pt, poll_queue_proc qproc)
 	pt->_key   = ~(__poll_t)0; /* all events enabled */
 }
 
+/*
+ * ->get_poll_head can return a __poll_t in the PTR_ERR, use these macros
+ * to return the value and recover it.  It takes care of the negation as
+ * well as off the annotations.
+ */
+#define POLL_TO_PTR(mask)	(ERR_PTR(-(__force int)(mask)))
+#define PTR_TO_POLL(ptr)	((__force __poll_t)-PTR_ERR((ptr)))
+
 static inline bool file_can_poll(struct file *file)
 {
-	return file->f_op->poll;
+	return file->f_op->poll ||
+		(file->f_op->get_poll_head && file->f_op->poll_mask);
 }
 
-static inline __poll_t vfs_poll(struct file *file, struct poll_table_struct *pt)
+static inline struct wait_queue_head *vfs_get_poll_head(struct file *file,
+		__poll_t events)
 {
-	if (unlikely(!file->f_op->poll))
+	if (unlikely(!file->f_op->get_poll_head || !file->f_op->poll_mask))
+		return NULL;
+	return file->f_op->get_poll_head(file, events);
+}
+
+static inline __poll_t vfs_poll_mask(struct file *file, __poll_t events)
+{
+	if (unlikely(!file->f_op->poll_mask))
 		return DEFAULT_POLLMASK;
-	return file->f_op->poll(file, pt);
+	return file->f_op->poll_mask(file, events) & events;
 }
 
+__poll_t vfs_poll(struct file *file, struct poll_table_struct *pt);
+
 struct poll_table_entry {
 	struct file *filp;
 	__poll_t key;
-- 
2.14.2

