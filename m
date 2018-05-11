Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526037613-2-17594226827948295102
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-asciiro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037613; b=V5TFKp3o0FHR+TFaqdmLPjVQqpha6xtORlr21I8yZcO8zCck5k
    NHqBoXvnquJR3VW0JRxdanJrWObKWFtTnWpxHcrMxtMQfN311q7I8MXyuhQQZPS+
    cWo2tOLd98u5b5J6XXWOWmE2nlzGPzP1cFa+6NlQcXqaO7/KiVz0Eyjeec4ak9mg
    sGSy22r2p9aB1oxTAzc72QE5EtXPjAgw2scFkrlc+RJNrMgeHj+kCiuuqrlUDHRQ
    DnOiQlN/DfiVyNtvmfywDynVL2DykwoVjFOzvTfvxevZk3Hc0K5Tprw0sOWuCrJo
    ovpZzH2PA86f+AQiHJnm5494QLy3iinR7fjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037613; bh=
    jvkF0tUckVN+sU+s2KrOcYA4hcJkBAhlhg/TjIhRy+A=; b=AwPKHysHnGjE7+93
    dtsAXw3Y7R/OTOM73/wkJgY4XL0bajzu0Ue/DIwf/DlXb2sYVkrsm3gzsE3KAI5r
    bwIQL5tCaHDI6lZ11J/k0LL6YqTK/GKO/k4eVekfUdz1UsErvQYmBv8pKG49ipWk
    UIGWL3bc/6jtM5HIo0YKer/xm+33/f7K+h1Cez2dm8QJ18kRIWjz2f+LnRFv46GL
    zjuX1GWtFwXr+L5k475s7dVl9+vTv8TQMzxIMYCnEbOTvHDJWq0kJpBq07Lm2ece
    hqhjoaVzbkCOvyqCGBtyHGBPjpXeXEvW1/rzUF5XoE70NQ+ixvP9l/sCojum3OI2
    EVkGEw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=bZB7HzHc
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
      header.d=infradead.org header.i=@infradead.org header.b=bZB7HzHc
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
X-CM-Envelope: MS4wfBHjh/xLLlMRyrWunNV+rpf3/lbVdSeMjqwqYvTW3qaXKL30R+U7UfjzFjbRMnlUf4jBQgVOPfn+vV6XEQUGdKVCesLnhBRJdCTQCDzPPf9fk3dWbLd+
    PDLZN+JFu3ereZ7o5mzl5cqalXubu4YYFjmpn+6oNV9WOaG5RBGQYxGjErkUZNtewYpUwNl8gL7EQZEGrB/9+pQpTy0I73PHgzseRfhNMt6mCcVdit67JK/f
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=KaBQk26Pbc5VCaRScTQA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeEKLIt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:08:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeEKLIo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:44 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/32] net: refactor socket_poll
Date: Fri, 11 May 2018 13:07:42 +0200
Message-Id: <20180511110803.10910-12-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Factor out two busy poll related helpers for late reuse, and remove
a command that isn't very helpful, especially with the __poll_t
annotations in place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/busy_poll.h | 15 +++++++++++++++
 net/socket.c            | 21 ++++-----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 71c72a939bf8..c5187438af38 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -121,6 +121,21 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 #endif
 }
 
+static inline void sock_poll_busy_loop(struct socket *sock, __poll_t events)
+{
+	if (sk_can_busy_loop(sock->sk) &&
+	    events && (events & POLL_BUSY_LOOP)) {
+		/* once, only if requested by syscall */
+		sk_busy_loop(sock->sk, 1);
+	}
+}
+
+/* if this socket can poll_ll, tell the system call */
+static inline __poll_t sock_poll_busy_flag(struct socket *sock)
+{
+	return sk_can_busy_loop(sock->sk) ? POLL_BUSY_LOOP : 0;
+}
+
 /* used in the NIC receive handler to mark the skb */
 static inline void skb_mark_napi_id(struct sk_buff *skb,
 				    struct napi_struct *napi)
diff --git a/net/socket.c b/net/socket.c
index f10f1d947c78..571ee4005192 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1117,24 +1117,11 @@ EXPORT_SYMBOL(sock_create_lite);
 /* No kernel lock held - perfect */
 static __poll_t sock_poll(struct file *file, poll_table *wait)
 {
-	__poll_t busy_flag = 0;
-	struct socket *sock;
-
-	/*
-	 *      We can't return errors to poll, so it's either yes or no.
-	 */
-	sock = file->private_data;
-
-	if (sk_can_busy_loop(sock->sk)) {
-		/* this socket can poll_ll so tell the system call */
-		busy_flag = POLL_BUSY_LOOP;
-
-		/* once, only if requested by syscall */
-		if (wait && (wait->_key & POLL_BUSY_LOOP))
-			sk_busy_loop(sock->sk, 1);
-	}
+	struct socket *sock = file->private_data;
+	__poll_t events = poll_requested_events(wait);
 
-	return busy_flag | sock->ops->poll(file, sock, wait);
+	sock_poll_busy_loop(sock, events);
+	return sock->ops->poll(file, sock, wait) | sock_poll_busy_flag(sock);
 }
 
 static int sock_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.17.0

