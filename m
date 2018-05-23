Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103847-2-7692427957284515082
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
    1527103846; b=Gwn+94LMVfl7tl42HI6uUS8e6FgDDN0s5AX0WZBij5W/LmS/m9
    Kq5Ai3s6KqlQHPQk2sGwD9zMzLK6MfOMQzKcIrA31BCLQEAhMvLhaHPwrgUw766j
    FUCV1ZOP3zRrJFxpXN1+y5a7zOPPJopb7YvyVOIwoK9iuRI92vTo3iEuSea9jYhK
    VnNL0WWAEj7ptFWqjHzIDcRxI+sGXQM5oOPg5xCoCLXFtoqCQBqatwsq7ZBuNkO7
    uuTIdSzPp9N0PqBye5DWj7ItvyGME1w5uLDwMu26gTPyv3x0R28WBvIixWtDLkvT
    y6n6pjT4GFAPb+vjP7FUXXTQ3s3Tg1FnqH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103846; bh=
    l5EWq9ZC9pIlo6q0TD6FHxkdeHpytbJV9upsWussQik=; b=ThCObilUbcOISkjR
    xcqxKRoIaR2Rvz1SdK+pS2B44bN06MEfSY24/Mwxfe46fODcStpo/EsKDubp7iKK
    sXIxPiNGzSUrNJ4FDQWAjmG4Dc/+cRwl5k/paLLNWRpP5tyPw6IkuZlZqw+MSpfJ
    41SeMVfLaSWVAW8aoGTORXUYS3ux+bKWsWyC2rvpLPUfcxc/0tiOctiinVBMpNVb
    MN0WpFjn5LKqg8STEqGZKFB+4N5OCtjtyXMSXeet8ZUDnBlvP/y9wotbIQ8g2PBP
    U8lgkeJXnADF8U6cvMxiWa2Se8jXH/0Cor9XbctBOwV5r8ZMV++denl/mBJhr0cM
    DBYTMA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=F4INhj38
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=F4INhj38
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
X-CM-Envelope: MS4wfGa/yUn/YaXohQN+qDsbtGn7fvvbIqCsuOSRX0tEpuuI+Xjw2CJgq5nDYw+SxxYkM1+CcFIGPA08LrSWcUMme98CupLxUwQDdAB5cjuk8epEl2lbDPUD
    3JaCL/gglfnupIk7enx9a0AG8Fhmph1qW+90CleqzHyWOhd3XQQQZlEVsg6EPc1+TasVTxLKN4wGix2oCHymUFjTODkFb9j+tGCrDnXFx1QZNzDwDQrSlfLw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=xkpDaeRCmLSUBmX8ZpQA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934417AbeEWTVE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:21:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbeEWTU6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:20:58 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/33] aio: try to complete poll iocbs without context switch
Date: Wed, 23 May 2018 21:20:00 +0200
Message-Id: <20180523192022.1703-12-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If we can acquire ctx_lock without spinning we can just remove our
iocb from the active_reqs list, and thus complete the iocbs from the
wakeup context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index bd711cfa4a1f..8274d09d44a2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1633,6 +1633,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		void *key)
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
 	struct file *file = req->file;
 	__poll_t mask = key_to_poll(key);
 
@@ -1648,9 +1649,22 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	__aio_poll_remove(req);
 
-	req->events = mask;
-	INIT_WORK(&req->work, aio_poll_work);
-	schedule_work(&req->work);
+	/*
+	 * Try completing without a context switch if we can acquire ctx_lock
+	 * without spinning.  Otherwise we need to defer to a workqueue to
+	 * avoid a deadlock due to the lock order.
+	 */
+	if (spin_trylock(&iocb->ki_ctx->ctx_lock)) {
+		list_del_init(&iocb->ki_list);
+		spin_unlock(&iocb->ki_ctx->ctx_lock);
+
+		__aio_poll_complete(req, mask);
+	} else {
+		req->events = mask;
+		INIT_WORK(&req->work, aio_poll_work);
+		schedule_work(&req->work);
+	}
+
 	return 1;
 }
 
-- 
2.17.0

