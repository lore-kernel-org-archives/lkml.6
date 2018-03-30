Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3779118-1522424239-2-10513567174353159275
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522424239; b=Filx6AjmXOm8HFwoQ5FOcrWPHq5VL0SdtbxEBGeGmbutTDJjSN
    Qke5g3KNuqLQbDS/YMO+vIB9WcvC/pOTQh2ddu01EgdYX4g21QqusMByr+bnN2q4
    SYeYxxVkg5t/Qgfo5nRKL6Gcp7rBUejSXddb6ZsIdEQqf32dFmI/FQ2fqLupwIqt
    KGDPnZQ9AGVwdEmIrZGJxmikPSV8dChjdbLAJJSN3UVPKyaE2XfScTV5ndnn73Tw
    oUOJwUs0MST4t6juXvVFwEtX84GFiYjAX7qza1Y6Mqgi4jFVxkPapE8JTPKdUw4Z
    Zopf9pfOq6pzU+5TChof2zpXhFJzMQPBxhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522424239; bh=
    zw0o7dABAaA0BurdHKCuDdlhtkPzHfSGExBy7a5p3ec=; b=dQii/webpJ86fQ/x
    sinmVXmvs4iG6ebDbxbR9Tr2WFjIWPmOu3vbBMiqYs5zmpZlLcimASSbOKBrD2On
    sm9UcwkoRnX8zd2wbHy+VGJ4vtyU6/Y3fwNjDUvsP++tbYl7AG8NJYejc4JQweGq
    Kz+7RQeExPH/fptctajZza+Jf24UspOlf/OqFtLo8VN9sQa4KaP/GJCXxjKyDNE9
    OkiRgApcQoeBb1W6AbCjRnAxXKD9n4KUEiTnDzmh60A3D+BqEmwyNkn6V12Z0TqT
    fofH510nW532cPC63SQYJLZbPCHdmqYc2NPKUcCOVXmOIkw3zyGV+WMH98Lz9nga
    hXQWDg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=DSX7ncmR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=DSX7ncmR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAaI2nMMfZo15g4AmL3sF/8jsZb6XVhnXALavLfkWJjWUFhGafkDKBnJEDhKax+MPC93ZOZ9TcfmUdEaumK698KD9/vrgQRF8sCnsXt0oMfrA5oEiman
    hSK5SrEpayrXFbegbYRyrOES6L9cE3+fWd/O656eJhmqdBsVAORvU/1488Tq3gfzqkwdYmovL5ZMTw5mY+c8+59rn7i8XwfeBX/YQDF8x39MGW0ebVKv8Xbj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=c5ubECay0r_8uFjs2PcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeC3PeO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:34:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbeC3PeK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Mar 2018 11:34:10 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/32] aio: simplify KIOCB_KEY handling
Date: Fri, 30 Mar 2018 17:07:43 +0200
Message-Id: <20180330150809.28094-7-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180330150809.28094-1-hch@lst.de>
References: <20180330150809.28094-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No need to pass the key field to lookup_iocb to compare it with KIOCB_KEY,
as we can do that right after retrieving it from userspace.  Also move the
KIOCB_KEY definition to aio.c as it is an internal value not used by any
other place in the kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c            | 14 +++++++-------
 include/linux/aio.h |  2 --
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 0df07d399a05..cec42b4e3c3a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -46,6 +46,8 @@
 
 #include "internal.h"
 
+#define KIOCB_KEY		0
+
 #define AIO_RING_MAGIC			0xa10a10a1
 #define AIO_RING_COMPAT_FEATURES	1
 #define AIO_RING_INCOMPAT_FEATURES	0
@@ -1805,15 +1807,12 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
  *	Finds a given iocb for cancellation.
  */
 static struct aio_kiocb *
-lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb, u32 key)
+lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb)
 {
 	struct aio_kiocb *kiocb;
 
 	assert_spin_locked(&ctx->ctx_lock);
 
-	if (key != KIOCB_KEY)
-		return NULL;
-
 	/* TODO: use a hash or array, this sucks. */
 	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
 		if (kiocb->ki_user_iocb == iocb)
@@ -1840,9 +1839,10 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	u32 key;
 	int ret;
 
-	ret = get_user(key, &iocb->aio_key);
-	if (unlikely(ret))
+	if (unlikely(get_user(key, &iocb->aio_key)))
 		return -EFAULT;
+	if (unlikely(key != KIOCB_KEY))
+		return -EINVAL;
 
 	ctx = lookup_ioctx(ctx_id);
 	if (unlikely(!ctx))
@@ -1850,7 +1850,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 
 	spin_lock_irq(&ctx->ctx_lock);
 
-	kiocb = lookup_kiocb(ctx, iocb, key);
+	kiocb = lookup_kiocb(ctx, iocb);
 	if (kiocb)
 		ret = kiocb_cancel(kiocb);
 	else
diff --git a/include/linux/aio.h b/include/linux/aio.h
index 9d8aabecfe2d..b83e68dd006f 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -8,8 +8,6 @@ struct kioctx;
 struct kiocb;
 struct mm_struct;
 
-#define KIOCB_KEY		0
-
 typedef int (kiocb_cancel_fn)(struct kiocb *);
 
 /* prototypes */
-- 
2.14.2

