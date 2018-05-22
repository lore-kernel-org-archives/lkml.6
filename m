Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389970-1526988712-2-16973880101633606898
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526988711; b=NbZZeh7B0JFkiAuDfYrW6Tfr4vBZQMgikD4p0IpEs4YB9fylsp
    E5PjZWNlXohjeDST91o4+ZQQ74NKBj235BKPMcvxH9kvalURZlkVVj/e8E8ICTUo
    h1eYIqIZclNKyFC97jc6eRC47+nIHv/Yqpev1vp0O8vvEVFa7eWBxpADwUViKpuB
    byFMmNX8JKMdVvADSL2k+5bgQUDH1IO9gj1R8br4a8WEMEnxmssudjrkWcGRbaHw
    z1OaDbKzXcgdXQWhDw77eiSQMgEwUm7vOl0AlkW37vVxkfifVECZvqXqUOGCDwk2
    nR9gHfV9bDk8h0kRPDamMeV8wwlohF5BG32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526988711; bh=
    42/nOOPk1HzCpxB1PnGRwCB4lm3qxvMCU8SFvKATQcw=; b=KS7WDpk2DpkW8tpY
    IAWX9QgxQsx2kr33loGJ4iiRLCsD9R1iIYFWZK3hK7/B+PWqnGWeYnWu0a/qGMiU
    klZyK3HlBudHdOYgiMRXSzrJZ7+7HzOYVrV6nHyBaP9kgJ6rt5yBlIpPneinotcF
    +Qzco+Lt//tWCmPIG19/H5I64R95V9lfax2FogFCTewxwtFh2QbGZf56RnwCxwZO
    pEH97yoeeXyG4OhReZAzpN4Erfr3SZe49ZzaoulGrfmY8tjLu6DRxlsUVaNa+Oyj
    u0Gpmxf1IrGL/NsYE0Xg9bZNxGx4zspYfSp5xjBIygSt/uqoPDUbIfCX6kjRaxqg
    R5TGQA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=gW3DmgRo
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
      header.d=infradead.org header.i=@infradead.org header.b=gW3DmgRo
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
X-CM-Envelope: MS4wfG0ok59eLEpOr6dsiW253js1ARxzZUaiE7p2bgnQIdSdW7Y3up8agtHRza+X7iNoIkba4SYjW2BDOlDVd5QNDmIEPFYCJUM1cu729B0B+pjFSGnJktyp
    s9AxOpySBFQeR7/1dHLr7q4vhXbga3+KCs01JTo1YgjCkP/EOLI72uzbiVe+aqy5FYKrD+GlncKM/47W0RrtUyS5CCgx2lf2Hc6/JY4Dm7qxkga3GktUdtHj
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=c5ubECay0r_8uFjs2PcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEVLbr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:31:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeEVLbo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:31:44 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/31] aio: simplify KIOCB_KEY handling
Date: Tue, 22 May 2018 13:30:43 +0200
Message-Id: <20180522113108.25713-7-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522113108.25713-1-hch@lst.de>
References: <20180522113108.25713-1-hch@lst.de>
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

