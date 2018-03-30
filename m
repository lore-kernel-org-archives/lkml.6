Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3731766-1522424329-2-1285374888651868747
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
    1522424328; b=YJ4NzjQW597ziRst9hjCaI9ZxBLDnLVaAZQLEnVo6gSi4x+OPu
    Tex6Ob9+IWkcMqVRnSnWJg0G8/Vu8YsZW6IIA4SHHLHWzjO6q43gUdddjySTWBvw
    CKjxMEsqHClNkqO948PmqJGYL2zxzikITNVPADBk6aJd0yIuJqWFf/1Jrr5zY5sG
    F9JqN8fIJ+XOOL73pzCR6/+fN41v9SlxS6NhGfmdvcZAlptX3+h0jkPrV+RxXzwz
    H73r5Yr+61hM4zxCFm0tQIiMehh2avZl+9h9f3l9qEaqQ4/SJ9ppDeLPZVRgkdc3
    jvxst5HSZg0mazUBS50uh9lE1vsV+H8WBXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522424328; bh=
    ceB35ypi3WAjxBzV/lqJwiHjBufY8BtDiViQqE+RTwk=; b=WLS5DTppYl3mRcIC
    nNlrSfkJVhE3yGNPdnI4u4iedq46WxQ1+UQt0e8Xq0P23it1k2VxHqIjPJTPT02N
    otJ5O9uDptRG6T6VeU05u0jmL270mk2I1gqe0KLysenA/46j80+vN4sQ8Qjr6sIy
    zHknkf9ktvgp8i77wp7HFrLd0hbzuOLe9/jJwTzNXBWQYyzT5MYFyaLGUhHD26Jr
    IIYPhKHsy7hmXYCH+b/6Vbq5uo/dwZNNHL1lB2xBkXd1Jj3Aw8bxHH8RRqwumM3Y
    NkrybIoR6QfalxSV+0QrNt/Y7Jdp7uqWyN7c5YyAdX6JbDOeJwuesv22NVr4k0dS
    +0Xp/Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=fJ/Qywzp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=fJ/Qywzp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGJJiwiZc5G+degPbnC3Okt42lt+TVO8fP8tnDRyv1slTDiABz0EK7yNWrCMvecskusWv25/VlgvsNPVZRsnB0oi6lVZG6kbtqI8jL1DrrRX0xi6uETc
    SQ78lPzouDi2IKbDXWtb0wgbjjVUQFT9vr1ZoRKemHP5K3YlLbV/4Uod6M09v0RJ1nPrMeLcwRuy6FJgdmZZ0lBo+xJB60sxH8Z47DbR7IWqui92otKK8IbZ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=sBy_PAm624FdtEvdJhYA:9
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeC3Pdz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:33:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbeC3Pdw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Mar 2018 11:33:52 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/32] aio: implement IOCB_CMD_POLL
Date: Fri, 30 Mar 2018 17:07:47 +0200
Message-Id: <20180330150809.28094-11-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180330150809.28094-1-hch@lst.de>
References: <20180330150809.28094-1-hch@lst.de>
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
 fs/aio.c                     | 90 +++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/aio_abi.h |  6 +--
 2 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 57c6cb20fd57..36953e01ec30 100644
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
@@ -165,10 +166,18 @@ struct fsync_iocb {
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
@@ -1564,7 +1573,6 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
 		return -EINVAL;
 	if (iocb->aio_offset || iocb->aio_nbytes || iocb->aio_rw_flags)
 		return -EINVAL;
-
 	req->file = fget(iocb->aio_fildes);
 	if (unlikely(!req->file))
 		return -EBADF;
@@ -1583,6 +1591,84 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
 	return ret;
 }
 
+static int aio_poll_cancel(struct aio_kiocb *iocb)
+{
+	remove_wait_queue(iocb->poll.head, &iocb->poll.wait);
+	aio_complete(iocb, iocb->poll.file, 0, 0, AIO_COMPLETE_CANCEL);
+	return 0;
+}
+
+static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
+		void *key)
+{
+	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
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
+	aio_complete(iocb, req->file, mangle_poll(mask), 0, 0);
+	return 1;
+}
+
+static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
+{
+	struct kioctx *ctx = aiocb->ki_ctx;
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
+	aiocb->ki_cancel = aio_poll_cancel;
+
+	spin_lock_irqsave(&req->head->lock, flags);
+	mask = vfs_poll_mask(req->file, req->events);
+	if (!mask) {
+		__add_wait_queue(req->head, &req->wait);
+
+		spin_lock(&ctx->ctx_lock);
+		list_add_tail(&aiocb->ki_list, &ctx->delayed_cancel_reqs);
+		spin_unlock(&ctx->ctx_lock);
+	}
+	spin_unlock_irqrestore(&req->head->lock, flags);
+done:
+	if (mask)
+		aio_complete(aiocb, req->file, mangle_poll(mask), 0, 0);
+	return -EIOCBQUEUED;
+}
+
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb, bool compat)
 {
@@ -1651,6 +1737,8 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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

