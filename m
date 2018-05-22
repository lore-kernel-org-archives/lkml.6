Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389970-1526989365-2-14049282493372403284
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526989364; b=Zeuag9JIUeMH+sZXrjy4E1Ifl9C/CNi8KlEzIlTqX3RUaNChy8
    aYqdnbbnrfL0216/s6C8cfDSrFSmJcfuuksYXMnGRlbIuTNaHTH1D5rf8FXqq9xE
    Bd858xWMCsGIygenpw63hJHwymwmyq9oIc2T4eyagBAODUK7stEcCUNusSGZa/Z+
    soW+g0kBGYC70aYBxVl0tPisVHU+FSl1tGXmUGoQDbJgjSnuDEOyu515gd8sLcgl
    rPfJ5rnEos8xPEKUTwJqNv4WKaFSA3d0tslYDm28u3k8uSvkzdqY/rOTnlinBRFT
    b8xLSVxDL3f2NNoFwkYR7tWb31xJH70LBT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526989364; bh=
    HJhDUV8L2GsyXQ1T8toorsxG6fhG+1i6aszK0SHoN1k=; b=VEPUbOV/k/PpoBjG
    Cr/4PjnHwfXd5598HnkJNX1ETI4+8UbyWUqfv/oyNAU5wEXDau+JNgrIxyAfekBy
    idCregGiI3360esDYLLjds4879kmT3YHHI+SA1HQR+B3MQa7ZPynN/uBnPnHEIhP
    ET/+Se4qEwfcqgKRh5njLrxJydsmxb/Vyoqct1nF+Fe5M6wVqtiyNa7zaKTBUkbI
    4U0hiHphaj+awM1aejxIXNK1hya8au/VFT6U3XDtf/jYsz4hpKed4oeeepqW65TO
    y2KlUjvc/lpn3FvhXfdlfyqymRKUOYR3FJEPR+II8j92JjGc6e+B5ZEycvBBlWxa
    UfY1Yg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=h9ykheL1
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=h9ykheL1
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP2l+6ANiWV2mzGdPqXpXxftJMiN8DaTP3Oa6wlIwcBirBC1PzH3CA5yxmEvtmNRZGWWmZDOfi21yz1NzO5sQcrihI3/bHgi2c9uTzFSk4fSd7AXusq1
    QMkwUxW/rKAwJqkDyboHKsZ7FvCJDKCNaPTuOOqor9tqFIlPko6pdjCkcSSUX7c3tGE84pQReFEYDpmMXQ49v3hWhSvcEb6AZxU8kONINMy1vNtXzb2gAEdl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=55WT4w9jd6wi9aO12W4A:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeEVLbj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:31:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeEVLbf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:31:35 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/31] fs: add new vfs_poll and file_can_poll helpers
Date: Tue, 22 May 2018 13:30:41 +0200
Message-Id: <20180522113108.25713-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522113108.25713-1-hch@lst.de>
References: <20180522113108.25713-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These abstract out calls to the poll method in preparation for changes
in how we poll.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 drivers/staging/comedi/drivers/serial2002.c |  4 ++--
 drivers/vfio/virqfd.c                       |  2 +-
 drivers/vhost/vhost.c                       |  2 +-
 fs/eventpoll.c                              |  5 ++---
 fs/select.c                                 | 23 +++++++--------------
 include/linux/poll.h                        | 12 +++++++++++
 mm/memcontrol.c                             |  2 +-
 net/9p/trans_fd.c                           | 18 ++++------------
 virt/kvm/eventfd.c                          |  2 +-
 9 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/comedi/drivers/serial2002.c b/drivers/staging/comedi/drivers/serial2002.c
index b3f3b4a201af..5471b2212a62 100644
--- a/drivers/staging/comedi/drivers/serial2002.c
+++ b/drivers/staging/comedi/drivers/serial2002.c
@@ -113,7 +113,7 @@ static void serial2002_tty_read_poll_wait(struct file *f, int timeout)
 		long elapsed;
 		__poll_t mask;
 
-		mask = f->f_op->poll(f, &table.pt);
+		mask = vfs_poll(f, &table.pt);
 		if (mask & (EPOLLRDNORM | EPOLLRDBAND | EPOLLIN |
 			    EPOLLHUP | EPOLLERR)) {
 			break;
@@ -136,7 +136,7 @@ static int serial2002_tty_read(struct file *f, int timeout)
 
 	result = -1;
 	if (!IS_ERR(f)) {
-		if (f->f_op->poll) {
+		if (file_can_poll(f)) {
 			serial2002_tty_read_poll_wait(f, timeout);
 
 			if (kernel_read(f, &ch, 1, &pos) == 1)
diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 085700f1be10..2a1be859ee71 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -166,7 +166,7 @@ int vfio_virqfd_enable(void *opaque,
 	init_waitqueue_func_entry(&virqfd->wait, virqfd_wakeup);
 	init_poll_funcptr(&virqfd->pt, virqfd_ptable_queue_proc);
 
-	events = irqfd.file->f_op->poll(irqfd.file, &virqfd->pt);
+	events = vfs_poll(irqfd.file, &virqfd->pt);
 
 	/*
 	 * Check if there was an event already pending on the eventfd
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f3bd8e941224..f6022881f147 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -208,7 +208,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file)
 	if (poll->wqh)
 		return 0;
 
-	mask = file->f_op->poll(file, &poll->table);
+	mask = vfs_poll(file, &poll->table);
 	if (mask)
 		vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
 	if (mask & EPOLLERR) {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 602ca4285b2e..67db22fe99c5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -884,8 +884,7 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 
 	pt->_key = epi->event.events;
 	if (!is_file_epoll(epi->ffd.file))
-		return epi->ffd.file->f_op->poll(epi->ffd.file, pt) &
-		       epi->event.events;
+		return vfs_poll(epi->ffd.file, pt) & epi->event.events;
 
 	ep = epi->ffd.file->private_data;
 	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
@@ -2025,7 +2024,7 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 
 	/* The target file descriptor must support poll */
 	error = -EPERM;
-	if (!tf.file->f_op->poll)
+	if (!file_can_poll(tf.file))
 		goto error_tgt_fput;
 
 	/* Check if EPOLLWAKEUP is allowed */
diff --git a/fs/select.c b/fs/select.c
index 25da26253485..e30def680b2e 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -502,14 +502,10 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 					continue;
 				f = fdget(i);
 				if (f.file) {
-					const struct file_operations *f_op;
-					f_op = f.file->f_op;
-					mask = DEFAULT_POLLMASK;
-					if (f_op->poll) {
-						wait_key_set(wait, in, out,
-							     bit, busy_flag);
-						mask = (*f_op->poll)(f.file, wait);
-					}
+					wait_key_set(wait, in, out, bit,
+						     busy_flag);
+					mask = vfs_poll(f.file, wait);
+
 					fdput(f);
 					if ((mask & POLLIN_SET) && (in & bit)) {
 						res_in |= bit;
@@ -825,13 +821,10 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 
 	/* userland u16 ->events contains POLL... bitmap */
 	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
-	mask = DEFAULT_POLLMASK;
-	if (f.file->f_op->poll) {
-		pwait->_key = filter | busy_flag;
-		mask = f.file->f_op->poll(f.file, pwait);
-		if (mask & busy_flag)
-			*can_busy_poll = true;
-	}
+	pwait->_key = filter | busy_flag;
+	mask = vfs_poll(f.file, pwait);
+	if (mask & busy_flag)
+		*can_busy_poll = true;
 	mask &= filter;		/* Mask out unneeded events. */
 	fdput(f);
 
diff --git a/include/linux/poll.h b/include/linux/poll.h
index a3576da63377..7e0fdcf905d2 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -74,6 +74,18 @@ static inline void init_poll_funcptr(poll_table *pt, poll_queue_proc qproc)
 	pt->_key   = ~(__poll_t)0; /* all events enabled */
 }
 
+static inline bool file_can_poll(struct file *file)
+{
+	return file->f_op->poll;
+}
+
+static inline __poll_t vfs_poll(struct file *file, struct poll_table_struct *pt)
+{
+	if (unlikely(!file->f_op->poll))
+		return DEFAULT_POLLMASK;
+	return file->f_op->poll(file, pt);
+}
+
 struct poll_table_entry {
 	struct file *filp;
 	__poll_t key;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2bd3df3d101a..1695f38630f1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3849,7 +3849,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	if (ret)
 		goto out_put_css;
 
-	efile.file->f_op->poll(efile.file, &event->pt);
+	vfs_poll(efile.file, &event->pt);
 
 	spin_lock(&memcg->event_list_lock);
 	list_add(&event->list, &memcg->event_list);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 0cfba919d167..3811775692d0 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -231,7 +231,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 static __poll_t
 p9_fd_poll(struct p9_client *client, struct poll_table_struct *pt, int *err)
 {
-	__poll_t ret, n;
+	__poll_t ret;
 	struct p9_trans_fd *ts = NULL;
 
 	if (client && client->status == Connected)
@@ -243,19 +243,9 @@ p9_fd_poll(struct p9_client *client, struct poll_table_struct *pt, int *err)
 		return EPOLLERR;
 	}
 
-	if (!ts->rd->f_op->poll)
-		ret = DEFAULT_POLLMASK;
-	else
-		ret = ts->rd->f_op->poll(ts->rd, pt);
-
-	if (ts->rd != ts->wr) {
-		if (!ts->wr->f_op->poll)
-			n = DEFAULT_POLLMASK;
-		else
-			n = ts->wr->f_op->poll(ts->wr, pt);
-		ret = (ret & ~EPOLLOUT) | (n & ~EPOLLIN);
-	}
-
+	ret = vfs_poll(ts->rd, pt);
+	if (ts->rd != ts->wr)
+		ret = (ret & ~EPOLLOUT) | (vfs_poll(ts->wr, pt) & ~EPOLLIN);
 	return ret;
 }
 
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 6e865e8b5b10..90d30fbe95ae 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -397,7 +397,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	 * Check if there was an event already pending on the eventfd
 	 * before we registered, and trigger it as if we didn't miss it.
 	 */
-	events = f.file->f_op->poll(f.file, &irqfd->pt);
+	events = vfs_poll(f.file, &irqfd->pt);
 
 	if (events & EPOLLIN)
 		schedule_work(&irqfd->inject);
-- 
2.17.0

