Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684081-1520286152-2-10539347074426828159
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
    t=1520286151; b=UKLu/8ZFRbzFkYAv8VgIZ+f9v+wJCuiVb/qZFp2XWney7lr
    2LVs2tsc0XXikZTSLHCIuTW8Xx33cwhm2a/5xStgS+CfhudL+z3OTPNPPVUfD3zP
    CSF4lYXtm3E/D7nhVyS4UcXkJaApVJgiB3bm93biLiCs1nhBSVXi3bOdWS0OLjJJ
    B+TWO+CK+QlKPfAAghoER3hEZ5BFVHkvhsE+YH/t1W05bYWQ4xeWqVch+ewceqPl
    Pcsu/z3eeLABSTH0SEgRPLzD+WC3pNgW8AMjEOC0mJgYzOOml6DfMKtQr2F2dS2w
    hxamd1rbDhCZSiAGivRH/+VJxAsB54cXs5VlDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520286151;
    bh=3sBVStFbtNe+n36LzEzh9qkrSeiGd8yDKcVP9/up6bw=; b=oNRdlu7sFjrM
    vQoK9dNor+xgm2ervdyLB5tg6GMRdzMKHywPqBb5QywT8P/PHldZfP0S5UXl9jYt
    mrgDf9YgGXhW2V37gmQHE8jA53Ioagdf37JpuyEPsWkcC1gYVDRFuRjSjMYgYXNx
    aidBrvNIk9RpOqi7Fqlli0dgmoPmqUIbwMdsTUV8ZbBrZJz3qxy0d+a84omCYabW
    OnfCj2cataxRLd0PfZC12VZzPSOpKdr4+w74w3ws8rBR90b51ek+ofuxkgPTv1PJ
    I9JHbFSMKMVgOAInJpsPC5Xq7i2KFlzhbpPEPIiFSYvDp7HJgNyMuIbYIkMzICAt
    2cBvvQbdNA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Y5Gv/9x3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Y5Gv/9x3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCEVkE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:40:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbeCEV1u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:50 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/36] fs: unexport poll_schedule_timeout
Date: Mon,  5 Mar 2018 13:27:16 -0800
Message-Id: <20180305212743.16664-10-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No users outside of select.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/select.c          | 3 +--
 include/linux/poll.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index b6c36254028a..686de7b3a1db 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -233,7 +233,7 @@ static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
 	add_wait_queue(wait_address, &entry->wait);
 }
 
-int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
+static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 			  ktime_t *expires, unsigned long slack)
 {
 	int rc = -EINTR;
@@ -258,7 +258,6 @@ int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 
 	return rc;
 }
-EXPORT_SYMBOL(poll_schedule_timeout);
 
 /**
  * poll_select_set_timeout - helper function to setup the timeout value
diff --git a/include/linux/poll.h b/include/linux/poll.h
index f45ebd017eaa..a3576da63377 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -96,8 +96,6 @@ struct poll_wqueues {
 
 extern void poll_initwait(struct poll_wqueues *pwq);
 extern void poll_freewait(struct poll_wqueues *pwq);
-extern int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
-				 ktime_t *expires, unsigned long slack);
 extern u64 select_estimate_accuracy(struct timespec64 *tv);
 
 #define MAX_INT64_SECONDS (((s64)(~((u64)0)>>1)/HZ)-1)
-- 
2.14.2

