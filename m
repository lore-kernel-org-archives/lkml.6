Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1668128-1522356318-2-17661389272369080218
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
    1522356318; b=R5PEw9G940c/d6vm2HRAY5KG0ESTkZJ+CblHylIWV5kh3vgfsB
    +A6a/LSTybr/5LBCBDqhB+mIe7EifcMYATO1yKFYMI4xbG4FOpELAa1HrfZoqyCV
    tkR1fADlv9diXeAJTLrnaEmcpW/rVGZfbSoyLk6L1qfZfWM+ZMW0kOA2qPW55K+p
    ZbyXxNfmdJAcRci6ipaz/L4csb3oeJGXPl1Q21B3ZaAbdkYGW0mlS7AbL/s68fG0
    fIW2jAYwBYankXs87oc0JsnIU+xnWjAhCufy6ssFbAjEwf2y3VBwpS0Yt7SEwFFA
    KD+nth7XKU1KvLRV+RuhcF6rx8StrXhfb7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522356318; bh=
    t9huIAv7wVZSpZrTFB4hDC8EFy77JkjtHZX7pp8+pFc=; b=NGz4BRKDEi651kuT
    A6fnxqs0SjnTRnbf6XQt6IrHFxyJdbRy69LDoGiHpLvEgcCSG5ekN6Oh9gcU0XMh
    HPjg79f/XoWGDu+FgDOWBLjZ+VZIcD/3G8Gt0rz9Uo3PG085mrnCNpLJD9Ho8YIX
    Vd4lpc1fjzgGHhDxl3lGgsWy/i3XQYEqoU8vyPqh49lbs5c0HyTWLuZ1teAhwMAJ
    xYPNDZrWNoinXNt5j7w2rY8zRzFE4p0WYzpceJa3qy0ZlEwqgTDQVn5Ed2knK/P7
    N8/xY7yhfqBSgc0kHHZJ++nqYlC5NRE5wyRI3llP4cziao1SPrIgEnLWpEdvUPbV
    mANn8Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=pAhcmOkY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=pAhcmOkY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIvsOsh+KTRjvoO/MA/8otCRHQF10JpKm0LXLbc0y06knwQayJu0Y68swu6wNTlb5ETm1sN2AJntm6demyzM0XUiJsU+/KYr+qDTEvcC8nzs84EMM+uR
    dquPhJeTjiFy5kAL1EEaOV/SdRuAZwCckq/4Co4WL6MGiFNHj0JoxYeAdM9uYCQw3IJb+nzN0WXMV38XQ8jSMHtvd8E9ZzfdaatT0+DqZvYc15CXMOuOett7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=sBy_PAm624FdtEvdJhYA:9
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeC2Uov (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:44:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeC2UeC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:34:02 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/30] aio: implement IOCB_CMD_POLL
Date: Thu, 29 Mar 2018 22:33:06 +0200
Message-Id: <20180329203328.3248-9-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180329203328.3248-1-hch@lst.de>
References: <20180329203328.3248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Simple one-shot poll through the io_submit() interface.  To poll for
a file descriptor the application should submit an iocb of type
IOCB_CMD_POLL.  It will poll the fd for the events specified in the
the first 32 bits of the aio_buf field of the iocb.

Unlike poll or epoll without EPOLLONESHOT this interface always works
in one shot mode, that is once the iocb is completed, it will have to be
resubmitted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c                     | 97 +++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/aio_abi.h |  6 +--
 2 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 2406644e1ecc..e61e04b01f50 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -5,6 +5,7 @@
  *	Implements an efficient asynchronous io interface.
  *
  *	Copyright 2000, 2001, 2002 Red Hat, Inc.  All Rights Reserved.
+ *	Copyright 2018 Christoph Hellwig.
  *
  *	See ../COPYING for licensing terms.
  */
@@ -162,10 +163,18 @@ struct fsync_iocb {
 	bool			datasync;
 };
 
+struct poll_iocb {
+	struct file		*file;
+	__poll_t		events;
+	struct wait_queue_head	*head;
+	struct wait_queue_entry	wait;
+};
+
 struct aio_kiocb {
 	union {
 		struct kiocb		rw;
 		struct fsync_iocb	fsync;
+		struct poll_iocb	poll;
 	};
 
 	struct kioctx		*ki_ctx;
@@ -1577,7 +1586,6 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
 		return -EINVAL;
 	if (iocb->aio_offset || iocb->aio_nbytes || iocb->aio_rw_flags)
 		return -EINVAL;
-
 	req->file = fget(iocb->aio_fildes);
 	if (unlikely(!req->file))
 		return -EBADF;
@@ -1596,6 +1604,91 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
 	return ret;
 }
 
+static void aio_complete_poll(struct poll_iocb *req, __poll_t mask)
+{
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
+	struct file *file = req->file;
+
+	if (aio_complete(iocb, mangle_poll(mask), 0, 0))
+		fput(file);
+}
+
+static int aio_poll_cancel(struct kiocb *rw)
+{
+	struct aio_kiocb *iocb = container_of(rw, struct aio_kiocb, rw);
+	struct file *file = iocb->poll.file;
+
+	remove_wait_queue(iocb->poll.head, &iocb->poll.wait);
+	if (aio_complete(iocb, 0, 0, AIO_COMPLETE_CANCEL))
+		fput(file);
+	return 0;
+}
+
+static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
+		void *key)
+{
+	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
+	struct file *file = req->file;
+	__poll_t mask = key_to_poll(key);
+
+	assert_spin_locked(&req->head->lock);
+
+	/* for instances that support it check for an event match first: */
+	if (mask && !(mask & req->events))
+		return 0;
+
+	mask = vfs_poll_mask(file, req->events);
+	if (!mask)
+		return 0;
+
+	__remove_wait_queue(req->head, &req->wait);
+	aio_complete_poll(req, mask);
+	return 1;
+}
+
+static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
+{
+	struct poll_iocb *req = &aiocb->poll;
+	unsigned long flags;
+	__poll_t mask;
+
+	/* reject any unknown events outside the normal event mask. */
+	if ((u16)iocb->aio_buf != iocb->aio_buf)
+		return -EINVAL;
+	/* reject fields that are not defined for poll */
+	if (iocb->aio_offset || iocb->aio_nbytes || iocb->aio_rw_flags)
+		return -EINVAL;
+
+	req->events = demangle_poll(iocb->aio_buf) | POLLERR | POLLHUP;
+	req->file = fget(iocb->aio_fildes);
+	if (unlikely(!req->file))
+		return -EBADF;
+
+	req->head = vfs_get_poll_head(req->file, req->events);
+	if (!req->head) {
+		fput(req->file);
+		return -EINVAL; /* same as no support for IOCB_CMD_POLL */
+	}
+	if (IS_ERR(req->head)) {
+		mask = PTR_TO_POLL(req->head);
+		goto done;
+	}
+
+	init_waitqueue_func_entry(&req->wait, aio_poll_wake);
+
+	spin_lock_irqsave(&req->head->lock, flags);
+	mask = vfs_poll_mask(req->file, req->events);
+	if (!mask) {
+		__kiocb_set_cancel_fn(aiocb, aio_poll_cancel);
+		__add_wait_queue(req->head, &req->wait);
+	}
+	spin_unlock_irqrestore(&req->head->lock, flags);
+done:
+	if (mask)
+		aio_complete_poll(req, mask);
+	return -EIOCBQUEUED;
+}
+
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb, bool compat)
 {
@@ -1664,6 +1757,8 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		break;
 	case IOCB_CMD_FDSYNC:
 		ret = aio_fsync(&req->fsync, iocb, true);
+	case IOCB_CMD_POLL:
+		ret = aio_poll(req, iocb);
 		break;
 	default:
 		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 2c0a3415beee..ed0185945bb2 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -39,10 +39,8 @@ enum {
 	IOCB_CMD_PWRITE = 1,
 	IOCB_CMD_FSYNC = 2,
 	IOCB_CMD_FDSYNC = 3,
-	/* These two are experimental.
-	 * IOCB_CMD_PREADX = 4,
-	 * IOCB_CMD_POLL = 5,
-	 */
+	/* 4 was the experimental IOCB_CMD_PREADX */
+	IOCB_CMD_POLL = 5,
 	IOCB_CMD_NOOP = 6,
 	IOCB_CMD_PREADV = 7,
 	IOCB_CMD_PWRITEV = 8,
-- 
2.14.2

