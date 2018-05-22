Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2401354-1526989263-2-11019035270208732895
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
    1526989263; b=GjZ3e3UvJslKzsGu4GextGPCkvklOLM5uob7cQjOy307zGeIM3
    ygXJuEr5Z+aHrEecypOy9icriZG4k6SkTccKTYl9HBaUc6nDroXM3yND2qio59/P
    kp41V+PevLIWKK3SbQCUF9/8ovbdnEbk5JQ8FiCOnUr9Vq1gGd5Nkap818qylXUe
    Crz25zCb0DX0JVMzhEvs18YScworoUFxHdwi1aY1cwnuIJx/wNPpwa0JRAHci8iZ
    EcbtYiGCoikZo0c2poMsuhZqqhjJ2PYbaqYiX7Q1r0YEn0XohDOe11eRYGuoQRLy
    c55OLLkBgZIJCs7LZf9/EXxwVmkSYsWnkAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526989263; bh=
    czZ1vQKH3kUTe3dm+q8SlezuUXHOk39hTISwN08Upf8=; b=f/M9xcGXn+LuKQ27
    +AZCJMAxPzbiOEcpBew8xuQLwjCXBuKb6E8+8bu3jYScmq/3495QmYVij6azmn0f
    g0HZunGXntyjORKq4M0pzccCougiSoGvGRwkcsbY8rk7WJHPYVLwVy+K6vtMIs3L
    rxlf802jrOXKZ4JJmtnjstONNSxz1WOEEw/tq70Qm4WcT/Rf2x/lh94/aURp1g3L
    3LWrhTRlIVlLNdq4Qom3J1a8cK0w7UWh/x7dsjie1i1bg3RaQcBM8rQNs796pe5A
    qm0dfc8wGVlumBR421WB3zbi4ePT1aEqA6xWknveb3Y+IKSckuydVii+i75uE4L3
    p7cyEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=IY09dpxY
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
      header.d=infradead.org header.i=@infradead.org header.b=IY09dpxY
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
X-CM-Envelope: MS4wfH6D9eCOoPejOIHF42EDtaPh5LPaxrJf4uuZMaU4iaBykA6ChG7CzkwB+7FZJaZEhAVglgWquHFnvRCePMlDDTnNs6I1xGha8CIVatReLKUcnU/eezfk
    KlXX84KCZBKjE3JRGGfCNwM58CuAeQy9E+xXWjYUMhQlM3KEiOH/IJb6Mpu6ZatJVPz86kAT1HyL2O4vSoogO1y2SksCw0a+n0EqLs7irWybJJDo4muG6O4c
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=xkpDaeRCmLSUBmX8ZpQA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeEVLkw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:40:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeEVLb5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:31:57 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/31] aio: try to complete poll iocbs without context switch
Date: Tue, 22 May 2018 13:30:46 +0200
Message-Id: <20180522113108.25713-10-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522113108.25713-1-hch@lst.de>
References: <20180522113108.25713-1-hch@lst.de>
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
index 4d1eabce6659..85d9102431db 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1632,6 +1632,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		void *key)
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
 	struct file *file = req->file;
 	__poll_t mask = key_to_poll(key);
 
@@ -1647,9 +1648,22 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
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

