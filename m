Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763006-1522223088-2-7565001962107075197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522223087; b=Lr+00BkW4JLT2IAPsPCjtTCsF5gVOknic9zoP6dxUnvb3aU
    DU0wlz/l6962KQVPCzOBvqo+nMeVt5qfB5cTMrryJMOjDQcVsCjVDtqtz3U+9JhY
    sCnc+ApFauEzYm77BgPms/ELVkfvVlOJBPrv2n2vDgej/AUuszfnYdWQuS44RU5Q
    fUWtLycS0C9+Z6G3SlsUsDwbBQ6mc4XXaO/xYSZ1lJNV42nZNMf6OhcFMKHf5tRY
    6BMHc/Y9RJveiSvAKODXfzpVgReV3ATWpyWhcrkX5CX3ZRpKfCny4cNp5H6eyj0z
    5LHpdxmhe1ggmpdISCkGTodJvcOrTSFJTlpQeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522223087;
    bh=oGvHuD3UNGV7e0b7pIN8s5omxclYRJF5n+yBTZVndAA=; b=Q+zwYTQbr14T
    hy8DbEuhVa5DHq06R1j+O/k3obEhvD8FeilA+XJXuB0llX8Ww7TbXOPs3TaL9hl4
    OSAt9xRyB+RBDPO/yx0cIXZvFKjy6XBK+yP8PJr5oEvrlvWtpKsbhMyNHIeEBB7T
    sGvvDjyBvLuyZRqdx7wYNUg4anmg65Mz2g27YXnooPi6oZj+NKH8y218awiVjOvl
    DJ6Ze7fD2qEC5ROjZZdW2hR4vBBea21Y7tvWJW8sIs8NY0oWENd6JiENY3wkLW1v
    gNyBvzAuc+SUtkfa6llG+kIMZeQBPbMOXGjNziOVJZ+LnEX5j5jMZXlzP/pdpHxa
    uLxrmrhcFg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Iw3tL4t6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Iw3tL4t6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJwDAoB0ZpGUu2LIEHRjNIP+0THKurBLOOdN5/C5vmjtPBaQtO4IwgPjfz2K/5mmuS0yXqLiXE93Mkwm9r1PxhK+skm2FJyqlUG1BXNa/NvVb8g3y2j+
    j5ZJE4WCa6EOtBfLN8QKhF0mt3SUS7drbEJPKgwYgz087WF7kRRxAs7urSYKJC2NC5GzbuCZyTKCR/OvltHLQQKZ44Degs5r0HFkkc6fJJKOKLuW/R+SHacX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=lV_6GLmuSAtDAE5aasoA:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeC1HoC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:44:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeC1H1F (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:27:05 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] aio: implement IOCB_CMD_FSYNC and IOCB_CMD_FDSYNC
Date: Wed, 28 Mar 2018 09:26:38 +0200
Message-Id: <20180328072639.16885-6-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072639.16885-1-hch@lst.de>
References: <20180328072639.16885-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Simple workqueue offload for now, but prepared for adding a real aio_fsync
method if the need arises.  Based on an earlier patch from Dave Chinner.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/aio.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index f35801d73e0b..fd6c72918a8e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -156,6 +156,12 @@ struct kioctx {
 	unsigned		id;
 };
 
+struct fsync_iocb {
+	struct work_struct	work;
+	struct file		*file;
+	bool			datasync;
+};
+
 /*
  * We use ki_cancel == KIOCB_CANCELLED to indicate that a kiocb has been either
  * cancelled or completed (this makes a certain amount of sense because
@@ -172,6 +178,7 @@ struct kioctx {
 struct aio_kiocb {
 	union {
 		struct kiocb		rw;
+		struct fsync_iocb	fsync;
 	};
 
 	struct kioctx		*ki_ctx;
@@ -1565,6 +1572,43 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
 	return ret;
 }
 
+static void aio_fsync_work(struct work_struct *work)
+{
+	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
+	int ret;
+
+	ret = vfs_fsync(req->file, req->datasync);
+	fput(req->file);
+	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
+}
+
+static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
+{
+	int ret;
+
+	if (iocb->aio_buf)
+		return -EINVAL;
+	if (iocb->aio_offset || iocb->aio_nbytes || iocb->aio_rw_flags)
+		return -EINVAL;
+
+	req->file = fget(iocb->aio_fildes);
+	if (unlikely(!req->file))
+		return -EBADF;
+
+	ret = -EINVAL;
+	if (!req->file->f_op->fsync)
+		goto out_fput;
+
+	req->datasync = datasync;
+	INIT_WORK(&req->work, aio_fsync_work);
+	schedule_work(&req->work);
+	return -EIOCBQUEUED;
+out_fput:
+	if (unlikely(ret && ret != -EIOCBQUEUED))
+		fput(req->file);
+	return ret;
+}
+
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 struct iocb *iocb, bool compat)
 {
@@ -1628,6 +1672,12 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	case IOCB_CMD_PWRITEV:
 		ret = aio_write(&req->rw, iocb, true, compat);
 		break;
+	case IOCB_CMD_FSYNC:
+		ret = aio_fsync(&req->fsync, iocb, false);
+		break;
+	case IOCB_CMD_FDSYNC:
+		ret = aio_fsync(&req->fsync, iocb, true);
+		break;
 	default:
 		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
 		ret = -EINVAL;
-- 
2.14.2

