Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2624115-1520285355-2-5960354012669336538
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
    t=1520285354; b=AdbhrfLiQGLcuUh9qRKSA4wawgteGMYFSnvBxDkJwmyAR+f
    NYpg3JJvgfvXF4F8K6Q8M535VEiSnN1tThj5EX72o8h1pkRFXXE+IpJJQXuyiN0+
    7TK93pc29m2lapdOZJpQJSNoEIpfv4mGI7s7VgYyhLu6H7BWY8BdhtqukCa4cpJS
    UBiR4nX99WeahBwnkovbFSNphR++ZV67VHLcqBW3Y89BcqYiDQStnxgXyW7UHtRf
    xSAJmXmlDDcsKtt2g/vyKsJ8oSNCdhddUv7UEf3Sfz/tSZJCTOadQ+voX9s9ZXzs
    W17+FtNPsQazt+saIlQPWEQkrIlO+2Gl2GpljKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520285354;
    bh=fWCLq16GNBjwDaSIqAACJDC6F2S+jYWRtJKqSXFhZjw=; b=TecS+AYrwXhu
    P4tNKc3SvDyeQIWWtP1MpSkB6Vw22nP8jT3z3zqd6PP68phG8APpqlGrv4YwQ+Uh
    BOWeTLaT/dXfxs6jhxKESzA7JuS+MHT0X01RBUouxZ8DcPEkoZTckU1z2WtNacfH
    xhe7U9RaE3sYr+2acd6k2BlbGO9bwFS93xtBno3bVKCxraaLT3RtQB+0scgnlkub
    p4HXKayUK61gmIXgw59l52OthnwTZt1RNPHhRytYcPLguegk/HGh8ehOjxGM9A6Y
    V1abWMAGWK1ypl/1pdXz5iLsLYg7xhYjwinwiY1GYFtV15Ih4hA2DMvNmDqmcnnY
    qVgAf9mBtw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sf59X8b6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sf59X8b6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932816AbeCEV2q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:28:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932611AbeCEV2B (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:28:01 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 33/36] pipe: convert to ->poll_mask
Date: Mon,  5 Mar 2018 13:27:40 -0800
Message-Id: <20180305212743.16664-34-hch@lst.de>
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
 fs/pipe.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 7b1954caf388..81937590ea0a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -509,19 +509,22 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 }
 
-/* No kernel lock held - fine */
-static __poll_t
-pipe_poll(struct file *filp, poll_table *wait)
+static struct wait_queue_head *
+pipe_get_poll_head(struct file *filp, __poll_t events)
 {
-	__poll_t mask;
 	struct pipe_inode_info *pipe = filp->private_data;
-	int nrbufs;
 
-	poll_wait(filp, &pipe->wait, wait);
+	return &pipe->wait;
+}
+
+/* No kernel lock held - fine */
+static __poll_t pipe_poll_mask(struct file *filp, __poll_t events)
+{
+	struct pipe_inode_info *pipe = filp->private_data;
+	int nrbufs = pipe->nrbufs;
+	__poll_t mask = 0;
 
 	/* Reading only -- no need for acquiring the semaphore.  */
-	nrbufs = pipe->nrbufs;
-	mask = 0;
 	if (filp->f_mode & FMODE_READ) {
 		mask = (nrbufs > 0) ? EPOLLIN | EPOLLRDNORM : 0;
 		if (!pipe->writers && filp->f_version != pipe->w_counter)
@@ -1015,7 +1018,8 @@ const struct file_operations pipefifo_fops = {
 	.llseek		= no_llseek,
 	.read_iter	= pipe_read,
 	.write_iter	= pipe_write,
-	.poll		= pipe_poll,
+	.get_poll_head	= pipe_get_poll_head,
+	.poll_mask	= pipe_poll_mask,
 	.unlocked_ioctl	= pipe_ioctl,
 	.release	= pipe_release,
 	.fasync		= pipe_fasync,
-- 
2.14.2

