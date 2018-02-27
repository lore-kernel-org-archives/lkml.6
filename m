Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-983322-1519719648-2-2758677908028791715
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519719647; b=HMszlFK6ekRLZJqY/uTX9cZVKH13hs8Mu9yv8UhDDzo33Hm
    xZ0ajueg8fwTU1sbgMiiP0COZKFKems5DYndkutRsxzlrIzOwBW2TP8wpqDC7l4N
    IuVgOVB6eJiqiYUjnSg/1j507H5+Z4ZaBpf+MRKH8rwsAmKRw5v8tecDfcaf9Ayd
    V5ErmjebyTgbvKI0sx0+2JfJPpJwZdIgVmrPa3hS9hPAVopQO7bcWe9tjfOyPc/V
    nlqk3rq3r898dtIS2yV5q5rVAMIj0KZjmM7q5QHAA9qktP2mOPzNtt9mOqTOCnAb
    BgGm3uq6CXoPXPQqAwwAM8UnQg3wQ3SEjcPkndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=arctest; t=1519719647;
    bh=IRhd0qIikd3eRXeemzhXUPqqqiwkONTLGsw/bCWCf5I=; b=M2XYo7Nb+M13
    QH+kaE5f/jT5k+msqWQlTqjRjzzw0x9lpqY77Cix5BM7ZwrJJtWf9MTJ7JsO//Bv
    oVxkXvR2dMRwWWEjBsOw/CvvjvdXcqoxukaoAshxgfr3hngCCDAqEiJPWXFRmEVj
    XPUAKUqMQ6Fa0/Z0IHsy/nOqYeNfIL2JUHqo0it0QA+KZxaMOwjBaeP5+dCMp7Lh
    WTqv2cEpXZkNc2pgLoR8Qo4TlE0EjJ160/mNmaaLMraQv3w3OVy9hYMnUHMNe5/K
    xglvvWLEu42SE0B0ADfbIVyUqpkJl3hG3jkGRR62EswSI9bbYR0eGnX3v0tx/jZg
    I91z0xotpg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeB0IU3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 03:20:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752206AbeB0IUK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Feb 2018 03:20:10 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-api <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, crml <criu@openvz.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 3/3] userfaultfd: non-cooperative: allow synchronous EVENT_REMOVE
Date: Tue, 27 Feb 2018 10:19:52 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022708-0008-0000-0000-000004D4F049
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022708-0009-0000-0000-00001E680E6B
Message-Id: <1519719592-22668-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270100
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In non-cooperative case, userfaultfd monitor may encounter a race between
UFFDIO_COPY or UFFDIO_UNREGISTER and the processing of UFFD_EVENT_REMOVE.

Unlike the page faults that suspend the faulting thread until the page
fault is resolved, other events resume execution of the thread that caused
the event immediately after delivering the notification to the userfaultfd
monitor. The monitor may run UFFDIO_COPY in parallel with the event
processing and this may result in memory corruption.

Another race condition is caused if the faulting thread consequently calls
a system call causing UFFD_EVENT_REMOVE and munmap(). In this case, uffd
monitor will try to unregister the removed range as the response for
UFFD_EVENT_REMOVE, but the VMA linked to the uffd context might already be
gone because of munmap().

With UFFD_EVENT_REMOVE_SYNC introduced by this patch, it would be possible
to block the non-cooperative thread until the userfaultfd monitor will
explicitly wake it and thus allow uffd monitor proper processing of
UFFD_EVENT_REMOVE.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 fs/userfaultfd.c                 | 65 ++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/userfaultfd.h | 14 +++++++++
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index d9f74b389706..af813b3a3397 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -50,6 +50,8 @@ struct userfaultfd_ctx {
 	wait_queue_head_t fd_wqh;
 	/* waitqueue head for events */
 	wait_queue_head_t event_wqh;
+	/* waitqueue head for sync events */
+	wait_queue_head_t event_sync_wqh;
 	/* a refile sequence protected by fault_pending_wqh lock */
 	struct seqcount refile_seq;
 	/* pseudo fd refcounting */
@@ -116,6 +118,17 @@ static bool userfaultfd_should_wake(struct userfaultfd_wait_queue *uwq,
 			return false;
 	}
 
+	if (key->event == UFFD_EVENT_REMOVE_SYNC) {
+		unsigned long start, end;
+
+		start = key->arg.range.start;
+		end = start + key->arg.range.len;
+
+		if (start != uwq->msg.arg.remove.start ||
+		    end != uwq->msg.arg.remove.end)
+			return false;
+	}
+
 	return true;
 }
 
@@ -191,6 +204,8 @@ static void userfaultfd_ctx_put(struct userfaultfd_ctx *ctx)
 		VM_BUG_ON(waitqueue_active(&ctx->fault_wqh));
 		VM_BUG_ON(spin_is_locked(&ctx->event_wqh.lock));
 		VM_BUG_ON(waitqueue_active(&ctx->event_wqh));
+		VM_BUG_ON(spin_is_locked(&ctx->event_sync_wqh.lock));
+		VM_BUG_ON(waitqueue_active(&ctx->event_sync_wqh));
 		VM_BUG_ON(spin_is_locked(&ctx->fd_wqh.lock));
 		VM_BUG_ON(waitqueue_active(&ctx->fd_wqh));
 		mmdrop(ctx->mm);
@@ -676,7 +691,19 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 static void userfaultfd_event_complete(struct userfaultfd_ctx *ctx,
 				       struct userfaultfd_wait_queue *ewq)
 {
-	struct userfaultfd_wake_key key = { 0 };
+	struct userfaultfd_wake_key key;
+
+	/*
+	 * For synchronous events we don't wake up the thread that
+	 * caused the event, but rather refile it onto
+	 * event_sync_wqh. The userfault monitor has to explicitly
+	 * wake it with ioctl(UFFDIO_WAKE_SYNC_EVENT)
+	 */
+	if (ewq->msg.event & UFFD_EVENT_FLAG_SYNC) {
+		list_del(&ewq->wq.entry);
+		__add_wait_queue(&ctx->event_sync_wqh, &ewq->wq);
+		return;
+	}
 
 	key.event = ewq->msg.event;
 	 __wake_up_locked_key(&ctx->event_wqh, TASK_NORMAL, &key);
@@ -798,7 +825,8 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
 	struct userfaultfd_wait_queue ewq;
 
 	ctx = vma->vm_userfaultfd_ctx.ctx;
-	if (!ctx || !(ctx->features & UFFD_FEATURE_EVENT_REMOVE))
+	if (!ctx || !(ctx->features & UFFD_FEATURE_EVENT_REMOVE ||
+		      ctx->features & UFFD_FEATURE_EVENT_REMOVE_SYNC))
 		return true;
 
 	userfaultfd_ctx_get(ctx);
@@ -807,6 +835,9 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
 	msg_init(&ewq.msg);
 
 	ewq.msg.event = UFFD_EVENT_REMOVE;
+	if (ctx->features & UFFD_FEATURE_EVENT_REMOVE_SYNC)
+		ewq.msg.event |= UFFD_EVENT_FLAG_SYNC;
+
 	ewq.msg.arg.remove.start = start;
 	ewq.msg.arg.remove.end = end;
 
@@ -935,6 +966,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 
 	/* Flush pending events that may still wait on event_wqh */
 	__wake_up(&ctx->event_wqh, TASK_NORMAL, 0, &key);
+	__wake_up(&ctx->event_sync_wqh, TASK_NORMAL, 0, &key);
 
 	wake_up_poll(&ctx->fd_wqh, EPOLLHUP);
 	userfaultfd_ctx_put(ctx);
@@ -1677,6 +1709,31 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
+static int userfaultfd_wake_sync_event(struct userfaultfd_ctx *ctx,
+				       unsigned long arg)
+{
+	struct uffd_msg uffd_msg;
+	struct userfaultfd_wake_key key;
+	const void __user *buf = (void __user *)arg;
+
+	if (copy_from_user(&uffd_msg, buf, sizeof(uffd_msg)))
+		return -EFAULT;
+
+	if (uffd_msg.event != UFFD_EVENT_REMOVE_SYNC)
+		return -EINVAL;
+
+	key.event = uffd_msg.event;
+	key.arg.range.start = uffd_msg.arg.remove.start;
+	key.arg.range.len = uffd_msg.arg.remove.end - uffd_msg.arg.remove.start;
+
+	spin_lock(&ctx->event_wqh.lock);
+	if (waitqueue_active(&ctx->event_sync_wqh))
+		__wake_up_locked_key(&ctx->event_sync_wqh, TASK_NORMAL, &key);
+	spin_unlock(&ctx->event_wqh.lock);
+
+	return 0;
+}
+
 static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 			    unsigned long arg)
 {
@@ -1849,6 +1906,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_WAKE:
 		ret = userfaultfd_wake(ctx, arg);
 		break;
+	case UFFDIO_WAKE_SYNC_EVENT:
+		ret = userfaultfd_wake_sync_event(ctx, arg);
+		break;
 	case UFFDIO_COPY:
 		ret = userfaultfd_copy(ctx, arg);
 		break;
@@ -1909,6 +1969,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->fault_pending_wqh);
 	init_waitqueue_head(&ctx->fault_wqh);
 	init_waitqueue_head(&ctx->event_wqh);
+	init_waitqueue_head(&ctx->event_sync_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
 	seqcount_init(&ctx->refile_seq);
 }
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 48f1a7c2f1f0..81e3e2e2eded 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -22,6 +22,7 @@
 #define UFFD_API_FEATURES (UFFD_FEATURE_EVENT_FORK |		\
 			   UFFD_FEATURE_EVENT_REMAP |		\
 			   UFFD_FEATURE_EVENT_REMOVE |	\
+			   UFFD_FEATURE_EVENT_REMOVE_SYNC |	\
 			   UFFD_FEATURE_EVENT_UNMAP |		\
 			   UFFD_FEATURE_MISSING_HUGETLBFS |	\
 			   UFFD_FEATURE_MISSING_SHMEM |		\
@@ -52,6 +53,7 @@
 #define _UFFDIO_WAKE			(0x02)
 #define _UFFDIO_COPY			(0x03)
 #define _UFFDIO_ZEROPAGE		(0x04)
+#define _UFFDIO_WAKE_SYNC_EVENT		(0x05)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -68,6 +70,8 @@
 				      struct uffdio_copy)
 #define UFFDIO_ZEROPAGE		_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,	\
 				      struct uffdio_zeropage)
+#define UFFDIO_WAKE_SYNC_EVENT	_IOR(UFFDIO, _UFFDIO_WAKE_SYNC_EVENT, \
+				     struct uffd_msg)
 
 /* read() structure */
 struct uffd_msg {
@@ -119,6 +123,15 @@ struct uffd_msg {
 #define UFFD_EVENT_REMOVE	0x15
 #define UFFD_EVENT_UNMAP	0x16
 
+/*
+ * Events that are delivered synchronously. The causing thread is
+ * blocked until the event is handled by the userfault monitor. The
+ * monitor is responsible to explictly wake up the thread after
+ * processing the event.
+ */
+#define UFFD_EVENT_FLAG_SYNC	0x80
+#define UFFD_EVENT_REMOVE_SYNC	(UFFD_EVENT_REMOVE | UFFD_EVENT_FLAG_SYNC)
+
 /* flags for UFFD_EVENT_PAGEFAULT */
 #define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
 #define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
@@ -176,6 +189,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
 #define UFFD_FEATURE_SIGBUS			(1<<7)
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
+#define UFFD_FEATURE_EVENT_REMOVE_SYNC		(1<<9)
 	__u64 features;
 
 	__u64 ioctls;
-- 
2.7.4

