Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526037727-2-14995316269636198450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037726; b=fpR3Q8od/PwCi+2E1+EC+AZ+ZQJbvtbGWP4jVyooYMLx204cAi
    +2W8h59anF/u+VXU67bEUORJbDUecg6+QgHlXBt9uS4xgfaW4kJaB6UNhc2IVy1U
    pW796F+k+MnyijV1Q4GrgTO+e/QFIWYHJ7Cb28ySRur+40BW1AJN+MogA2kTj4QN
    x3eLqiXHlD2/Pd0hN78veOOSjw7E4costsFwUqeOWpRZfQYilAsrJ3jWzyss52QU
    WLKkDsY3tMR1yZ4bXC3qAf0fIH5xTk8zep7fnB7PddAA1xF+7RnqM4THJNtOaWRE
    PUYqWTMe4D7+kwqjscNSW+PBR2178DTI8ygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037726; bh=
    42/nOOPk1HzCpxB1PnGRwCB4lm3qxvMCU8SFvKATQcw=; b=kRU7oKrU77GyByi8
    hSuULbGug6Rt7GmDRJMbCv7wM+SIKBzZ6QkqMLFuJWc1r7Cm3gXeyWOtU67ZJqfW
    cGDH5g4Fmbd50Bn34cLjrPTYEi6zgENDrvsxjEdhZn6hJq0YCxVJCgNzfBYaWY0S
    PtiDstDTL2KsNVw9pp7KT8czd2bKF6yXfLw2tvuULwED+Qa3n2Iz2CIX6tSqAE9V
    faisus+/9LF1elPBbLrx3p4Yj61fwYr6YmCs+IUpcGygK3zGEu/ZS0hL1t8ZvxUd
    ppryJ2hh/PkXII++G0DT7QQVKGrjsEOjN4zH0aDbWn0IBbSNtM8QVvYs6iWBE7BX
    0LFdnQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=g+FbrC5y
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=g+FbrC5y
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
X-CM-Envelope: MS4wfNq3MhJpu2FcrO6vI9jiamxVwiElviUEnkgl/6noVkeb0q8fCOyq6Ar1fz5R2S6dN9H4Vtwrzgz+7hR7eIhMuHqDZxgnVYyxACxstxPUmO4B+L0PjD5i
    S0oV9BhBX92N1caHFXw5jKbuYXTgHrL+4wHjtXdQWFkOUwwgYLN9Jb/vTaHnprzql1GvEfwa1VG0U6zwlTPFTgghw1otE/rkgnSNOr73bjEYOZwLw0Vevix0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=c5ubECay0r_8uFjs2PcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeEKLVs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:21:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbeEKLI3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/32] aio: simplify KIOCB_KEY handling
Date: Fri, 11 May 2018 13:07:37 +0200
Message-Id: <20180511110803.10910-7-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
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
index f3eae5d5771b..2e0bc04f7920 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -46,6 +46,8 @@
 
 #include "internal.h"
 
+#define KIOCB_KEY		0
+
 #define AIO_RING_MAGIC			0xa10a10a1
 #define AIO_RING_COMPAT_FEATURES	1
 #define AIO_RING_INCOMPAT_FEATURES	0
@@ -1812,15 +1814,12 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
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
@@ -1847,9 +1846,10 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
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
@@ -1857,7 +1857,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 
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
2.17.0

