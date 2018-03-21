Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3333851-1521617611-2-13201023211104757264
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521617611; b=j2FR69LlN+bM6uXAwEZfc2707AgNnMpMWTNgPXWoy944GLt
    UpTszpoMrSnTrlFnqaGVRLdG0ht0W9GV0J6n7zvP/1Pop2uSYZtP6A9K1UQDaaBD
    JdnI20ZFmYePbJ2m7+2tYmrEmW+SR1mAzktalD3pSOERvSo4z0KAFl/moQlS28FJ
    adScq4PzIXhUG6QQsq90CetRezT66faX/+OJppJBjCXcNGOuCQLbbZg7Cn8/VtkZ
    CcK1alaYUdWJ34G1zSmeji5t9Aiqx7PGavL2YnFrbOg92lvStW1AYeAOE0ZWDu34
    i7gzXahBtskctDpwjw0PQfFUnITmqbAfVlNw4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521617611;
    bh=De7PNDWLVVDSNkO8Yu7gdiUMhd7XOzSm8xe++rMx03g=; b=dfSvqyYro2sL
    PrJ8APagPkKu/Wf6EQpIze8s+zsHAb3VW9n+SRoqxZwjfkUgEiZlQfvY+oAVH+Jd
    a8D4hNJiV7WtrdXJSMxVKJMyTgly9TdTZi2RFHXZboMih8QdN502x9qaoKxrOKKJ
    1FKW4oRxd0QTtu7+6/4MzvEnV/KdS+QuLwqyOn9bsVIjkcAL3MXzg3PSp2GTIXVz
    u06MT7qYVpcUECYLirl1xBjFJLQL/0mOW3/Wl4vK4FPmIaiOsJxy+k9DhStdChMP
    OEdoQ00obLjyyzhEeatTHZWnkOsQCLXFRIEV/MojBXTnUrUT83wEZIOcLtfW+PoB
    Ds7xIW/wjQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dwo/Dt9i x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dwo/Dt9i x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeCUHdQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:33:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeCUHdN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:33:13 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] aio: implement IOCB_CMD_FSYNC and IOCB_CMD_FDSYNC
Date: Wed, 21 Mar 2018 08:32:32 +0100
Message-Id: <20180321073232.13366-10-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321073232.13366-1-hch@lst.de>
References: <20180321073232.13366-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Simple workqueue offload for now, but prepared for adding a real aio_fsync
method if the need arises.  Based on an earlier patch from Dave Chinner.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index da87cbf7c67a..79d3eb3d2dd9 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -156,9 +156,16 @@ struct kioctx {
 	unsigned		id;
 };
 
+struct fsync_iocb {
+	struct work_struct	work;
+	struct file		*file;
+	bool			datasync;
+};
+
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

