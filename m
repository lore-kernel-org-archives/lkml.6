Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3842726-1526037098-2-1959833648329173238
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
    1526037097; b=mVFYRsltub9s7SJbLKfwB942E4CltEObtF+3I/aVpYS1BkSsEx
    qhhDbeHIBQ/hfxoAi0hDbBrsMexJ+hChtcEkrpZ1ts2VSThpPwn81ukd2KArr6sI
    gt1OVmu4+sUUg+P/QYNhQ/qUa9xYIxNvHPWeOkgHEOzflBP3NkUKCLVNL1lErwaK
    mQvo2ZRV3miIuKmDbRNI+oDMyqh7LyxrqLZo/bfW1ifypbRjUookfZuwtr5jk4DJ
    M67tSw6O49tosEwnV4M/SFa3sPK4akfFwiFHt+7FVgGKoNCQFXP/q94YutT3BlEM
    GoxUYOV+STKtIuoFMg09rq/AQ0XngsI5NfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037097; bh=
    nAsaxNH+XNVJT0ankrG9qVVP6bx2DAHHTRCMf+m0l1c=; b=jTlD0DAR92diZFd0
    LkHFe4Z8vGdDRGJMgl2R6MXKfsgxUuFVnMGDw/VJEL5mB5iHNKZHdyg+DzjBVMlj
    mxUdDecpV7o6QECZksAz5w+aTQwE0G+v/WIj2fha4CWdxkVFPN6PqV5Qsrbc5Sxk
    sGtOkC2UDO6rjtRj0yLQkbYtmVMzIYqmBnbQbezicTwYeBajpXDNvUk9A+m+dla+
    Vr5h2H0bl+5mg5obaWSXICKGIUAnwhFYATF+BzyVrOCvE4JMLKBizpjZg+5TcSTA
    SaFFg09ZdwMlEwPTv85mmlMSKezBDWGJXBjoPLwM9KfSppn0xrw1zI6ARZ1+7a7E
    BpasqA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=AVki1zkV
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
      header.d=infradead.org header.i=@infradead.org header.b=AVki1zkV
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
X-CM-Envelope: MS4wfNdmhYWaBGbZxhqM5yP/NJhDZqPUVeFp1M8NkuWXQY/XSZ0R7NI4IO/zs+gUcy9ATq8xjhwT6asCFKxphnOhcGNXraEF0UnkAUMkHiyzfyMxCmVSb36T
    AlHA0mMZXQVNWBGC9tkzgjIrmcMwtkfqxpxQfrSiYRkkI/98L5Sv4UO0BZsG5hdN8wAXx9KnnFwXK7RArXNBgRHJZDJiUlMVHQc67SIoD5fE+1JbB7f1Kiz4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=8_ZwOryNcspL-OaGdIgA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbeEKLLE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:11:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753373AbeEKLJh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:09:37 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/32] pipe: convert to ->poll_mask
Date: Fri, 11 May 2018 13:08:00 +0200
Message-Id: <20180511110803.10910-30-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
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
index 39d6f431da83..bb0840e234f3 100644
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
@@ -1020,7 +1023,8 @@ const struct file_operations pipefifo_fops = {
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
2.17.0

