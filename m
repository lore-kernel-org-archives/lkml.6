Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3333851-1521618241-2-6911218148708411110
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
    t=1521618240; b=lawrh2Ct0552m34OsoYyGH9mPT26yqjGEWkRmnysipIs+KY
    Bz/jIyNl8JH8bFzA56tGHgqDR4jzSVW2uWjcwiyOwerA+qoGDVm4LWSuBTbXxbgc
    FsPKzA14QxqyVzE8Cxl1Hu6Zhv9JoMDuiNq3NaiXjafGI5lGeksIIFW0zpR/FH2y
    BwrNHE00qQKBmKtJU5jgQR684KLNfPvcT5rwHXpReRO6Das4eFMhdymXpybfuz2I
    +ym+md80uFY1cvb+ggRqNulgv67Hx6j2jFDC6C2uArLWt4Jv7TvJFB/Il5foekrm
    BtWQN5bF/dn4HMPLOg//mC7hptqLOhpauELXj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618240;
    bh=fWCLq16GNBjwDaSIqAACJDC6F2S+jYWRtJKqSXFhZjw=; b=MTq/EV6zw5Qx
    3OyFaeImoR87uaT+b46OV9sOLuRFUqMDNqdcMwHvEeMaGVK3jzcV5YM0ZuhHcz5X
    zoyg1dgpqgV9MKDfCJEo7cMaaeR7wxZ5X3cZPDTDWaTu+sHUEb/euhSkyXgu8JqA
    mMc3UzIOKhG1M8xZhrBDPuTv8iQ6OcaOHZK4wcnzixCMm2wDdouX/vkqPr4NUqvA
    RrlkrHg4546fRrXA4H7I2Tzaooe4Js0qiRfl1gW6g7yJXLLUz0hWPD/MW95e9Ips
    fzSciPqcYLwkTVp0+bnq3rnGZ/ZY3TBLzmxReEVs2ppdKaqOoUx5AdtUErqTbjbH
    6L8kZwcd/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=hGQLScB7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=hGQLScB7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeCUHnj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:43:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeCUHmQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:42:16 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/28] pipe: convert to ->poll_mask
Date: Wed, 21 Mar 2018 08:40:29 +0100
Message-Id: <20180321074032.14211-26-hch@lst.de>
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

