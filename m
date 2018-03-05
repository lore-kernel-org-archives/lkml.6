Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2624115-1520285385-2-12827304199374298927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520285385; b=j5/ghS5qxlSQBuroJcqLswZdDHKcF8jrZceOc1iXsk4VXRQ
    CQ4UQcHUsyz9Tq31iJto8+1sUqcZ/mfIwsUe56yfIowICuThWHn44q0Riag1KgTO
    tsJYhpKeo//FkuP9NyXDXXJswt0Xl6L99vRxPCuDK4fzFFToBM2CdhN/XxJqhwzh
    liZeq2Q2L4AiziYL6prF/YTE2IkEgXlnWd5ehzCePp2f0wh2KUyZxoIL7EiNhTgG
    oV2IVrYLSe5Witbv/s8NML6uR1ZSBliUeAK8DsrSfjkI2eSUONqzpgueEqEzkNrB
    YQ+Cc2Fj9w35I6BjxfH/ecJwDEa1WEjUPD4ZLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520285385;
    bh=uo2eln1VlZAV26umCN+rr36lsCXD1wCmgus6dYJl8r4=; b=CWjsssiPCVLZ
    IL/INgu4VMmTC0tsajdjJ16uY7NcYHv6opIJydm5bmsQNCpoP7GsT6+hIyZ83EvD
    V+PvaYgo7wo+KABXpFi2zoKmjKdk4c+QyYYqKSqMpYzRM+RXMNdfnKjIXl60KNex
    j/eIOZ63CFk+hkCGgX1xUojytx7BLWbM6LKx+bW/g/kg/OJWRcU8euDaw6gKfPoK
    bfzdYrcUPPwz8oFEtslLruu5SPGPWsU6BrxwQsR4BmC+ey87e3FiYlh5GvUncAEs
    ynDol2vmbQ0lLHi2Jz78kplCRGNxJjxA2ZfJY+0tIJyTCIdJLSMO0BzhV+xLduXq
    GDOzyksM9g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HbS51J+O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HbS51J+O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeCEV2o (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:28:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbeCEV2B (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:28:01 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 35/36] timerfd: convert to ->poll_mask
Date: Mon,  5 Mar 2018 13:27:42 -0800
Message-Id: <20180305212743.16664-36-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
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

