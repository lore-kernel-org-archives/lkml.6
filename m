Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3454413-1521618194-2-17030855936864525761
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521618193; b=C5Eb2Vsb7qYbzebCy5pSIrKaUVYym3EOFpW2TnCi0T6wn14
    JP+UQfJzK8Cm/5WghxDQfgN6uDhJetoOjXxfr5+7fZKX7e1wZcAjVry6ITOtYXSj
    MROU5G1A+xZxgh2D/eR/1l7ShTN42T7vB0ZaIgAEe4N7gguV4gCQy+xRjTiSQycY
    ESBaWchrZXwhV6jwx2mKoF450ij6LRR+9HURNrkWiKE8RTEhO4H4H87ZeWJh5M+u
    5NVM2aNvaix05rVVU+PSwxlo7f7L6mpywOcdlv2NZmZLVd1H88osBGCJFKamKUXm
    vAomiEZjenavhKVdzrxgzssfglzy+7Qt7IFDftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618193;
    bh=uo2eln1VlZAV26umCN+rr36lsCXD1wCmgus6dYJl8r4=; b=djvBE5BYifXs
    YaIlzv0rSKRreBqJcK9NvumLyNRuWh0ud3It8/+dvp0QycebeeiR7KaJLPjiXOCi
    ofDQ7b6tWxpjry8ZjuiTMQmlFzQnLdNlHtBuqy+75rNRywG8eyhtShAeXZrMkJ+I
    sOcNZqL/ObUD873uM3y67Lz0XA9JFBxsrPqharodkkjYqVDjc/Oupo1aykkvMBjl
    8dhPZwDz8edpBG6OX7JG2LLEKlW2APInQ6+1YgQiXu5qhW/cAoKdpwHg4QVW1C6V
    0nXPrv+l0ouom7d0FyRC736nyaSU/P+bbTQf2BMcaMFSezr+FzZfNqqzYOgLY7Dy
    1Wy2ftHasw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=DEUv+0Zh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=DEUv+0Zh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeCUHma (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:42:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbeCUHm0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:42:26 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/28] timerfd: convert to ->poll_mask
Date: Wed, 21 Mar 2018 08:40:31 +0100
Message-Id: <20180321074032.14211-28-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321074032.14211-1-hch@lst.de>
References: <20180321074032.14211-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/timerfd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index cdad49da3ff7..d84a2bee4f82 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -226,21 +226,20 @@ static int timerfd_release(struct inode *inode, struct file *file)
 	kfree_rcu(ctx, rcu);
 	return 0;
 }
-
-static __poll_t timerfd_poll(struct file *file, poll_table *wait)
+	
+static struct wait_queue_head *timerfd_get_poll_head(struct file *file,
+		__poll_t eventmask)
 {
 	struct timerfd_ctx *ctx = file->private_data;
-	__poll_t events = 0;
-	unsigned long flags;
 
-	poll_wait(file, &ctx->wqh, wait);
+	return &ctx->wqh;
+}
 
-	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	if (ctx->ticks)
-		events |= EPOLLIN;
-	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
+static __poll_t timerfd_poll_mask(struct file *file, __poll_t eventmask)
+{
+	struct timerfd_ctx *ctx = file->private_data;
 
-	return events;
+	return ctx->ticks ? EPOLLIN : 0;
 }
 
 static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
@@ -364,7 +363,8 @@ static long timerfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 
 static const struct file_operations timerfd_fops = {
 	.release	= timerfd_release,
-	.poll		= timerfd_poll,
+	.get_poll_head	= timerfd_get_poll_head,
+	.poll_mask	= timerfd_poll_mask,
 	.read		= timerfd_read,
 	.llseek		= noop_llseek,
 	.show_fdinfo	= timerfd_show,
-- 
2.14.2

