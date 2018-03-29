Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684034-1522356411-2-5626086410644357842
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522356410; b=M8BwXfaoj2YqBkK2OxIVHLIbVdd3MlCBazNOAL+9spIsGhwdNx
    QJN6Legjebvjqxfu9zZSVvIjXtTuhkE5it2kW7hPn7bKI3KG3t/m2VYrFoWsnw2A
    qn+xzxQ8Zc66Hl4iJ/8aTr5ABD9BzLR8kOJX9YyZbF9//5KvbhXf+ot5/z8u0lFI
    NTlsbJbR+vTdZjp60EdgVwAHfWtqrO/2dcKyJI+omn7dKAQ5cQseOLspEljA+urb
    LlwgkY5WA4OLaz23q5aLnwO8FmL36KSZDGU8RXAXBCxUV/zDgx2bKrGo3mkE8enW
    mZp3RaKNZctHWl5MqUn/OfGYzvRI/Sn+a1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522356410; bh=
    xpMtCuXlwthFnqKW0ptfVtXUHarFTAXMdTg9BA6m6Ns=; b=Hnzz4IyQAe8cHU2v
    9R7lPmfXzPZLGwG19wjy2KqrCOenwUHhG0OQYGwX+tfqvETFrTG/9ulHf30V3YyY
    g5Ox5U6T+zfs0qGrXbKlCzrZKfCr1u0JM7OqkMR/JDW8QcgvJa18OIKzylL7RdHp
    Ia0UIXGzHkQAWbJYSaeFoNC+NPDxoZGCalbRQUoN3XLosZKSeyxXyRqStedbSE5H
    jwT9IVleLLRtj78RZQB5TauuRaYun8tnsKEOjfg4sUe8/UuVsWQ9MMqnv+6kd59+
    oNvJLQ9Vypz6tAZod/Ou9Q9aubdX92ezjwtlia/BdVcgcOU1sjm3S1bH/H2I+2lq
    bMx3+g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GsQ5xepv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GsQ5xepv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG2cVcwMja7BgS/xdlIFmDUVgRI2vC7lQHQVGEx2mFfAp/NVkjiLJ9j312of5y8JdyV7AGn6ubByYbT5ZU3EeOh87+9s8kzaFsixenBcK3XrsffW1/ow
    OUt3M9CXCF/151an64uTglw6fwVbCBM58Vn7ChfQfWL22SeTabqS2ZUa1kVcoGAD6KJfnNDCVtUWUz19ennJuUQTcwbRHTPz6+EbGh2/afiUshLd9qkGB1AB
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=55WT4w9jd6wi9aO12W4A:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeC2Udu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:33:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeC2Udr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:33:47 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/30] fs: add new vfs_poll and file_can_poll helpers
Date: Thu, 29 Mar 2018 22:33:02 +0200
Message-Id: <20180329203328.3248-5-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180329203328.3248-1-hch@lst.de>
References: <20180329203328.3248-1-hch@lst.de>
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
 fs/select.c                                 | 23 ++++++++---------------
 include/linux/poll.h                        | 12 ++++++++++++
 mm/memcontrol.c                             |  2 +-
 net/9p/trans_fd.c                           | 18 ++++--------------
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
index 1b3e8d2d5c8b..4d27e288bb1d 100644
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
index 0f3494ed3ed0..2bebae5a38cf 100644
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
@@ -2020,7 +2019,7 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 
 	/* The target file descriptor must support poll */
 	error = -EPERM;
-	if (!tf.file->f_op->poll)
+	if (!file_can_poll(tf.file))
 		goto error_tgt_fput;
 
 	/* Check if EPOLLWAKEUP is allowed */
diff --git a/fs/select.c b/fs/select.c
index c6c504a814f9..ba91103707ea 100644
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
@@ -819,13 +815,10 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 
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
index 670e99b68aa6..8774ece5c3c3 100644
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
2.14.2

