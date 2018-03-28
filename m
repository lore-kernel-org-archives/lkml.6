Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763006-1522222826-2-10084561779733385325
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522222825; b=JiIWF4fNz6cIoIfN5a2CEgVHJATrqeiQMuAqzd3rBhn4asp
    qXTBSiGNZOoQK1ZMJwvEC6HG4ESjDkJKANdj6jPLuIxyyKvw3FZNOTxnZurKlPYc
    Tv20qQAmihmxUBdv97oOJ3sPFYc62lyawb6iBzzz11ZcHq/S5TpJC15GWCous+Ek
    7ScHJcRoEUiqR53hlKtwOA3lr1WXwKNpfj6cGmhm3SJ/rDu/py64Rrw7Lp8s4lI9
    kxaWMvPtKq+jOTAmAJ21j3BV0MNwbTPOHzYSeV0zRHp9Yg2vrgUXIteu1FkLOsfL
    XElqkmJPk3EWA9ntNsHtqfntA0xbqUyzdQ4qZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222825;
    bh=JNVdscXCCQiUwhgLW/bxTAACwhyL7g7fxqz9weX/MEI=; b=I6J8W5uCV63E
    6EcPsoHaTXznBgcXO08nhLJqbA6BjJt4Qta+XfsSf0ou9LXZAQxU3sf1divR8kfG
    ARMfzy9nU7dKL9f69MArNhuLZIZeUec1s9fYMKwOCm51yKxH+5DE8vcMUBh/iFZq
    nX16EWT8xd51fWrbq3/lRUchVnN2UcXmkrdf4N180JlCAXnQxZw4kOYGFmiZB49r
    i4IUfTlHSXYbXpjDK16/Tp68+/IHv2X8qj5K6/QsmCdgEstldzFs+Hod0wXbvHwt
    00ww2ekbAblSkl6PehyoTQXbDq07c9mj68aopibyHMfgE9tnA/HmJQCKyUwaAML0
    DJYvB5r+zg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=G/Ebj3mN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=G/Ebj3mN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDrAUrAibWxDsynfNr9MGVI7GPD04mBSPZc4pXyc9pCYPQtwbFzLOesNWk6eOKlA0/QfvpDUzV1B1zJazxK5p5suVSlgtymFr+AS3tuBMUQpdTSmCDdN
    diCHdhjz35cQXYP8hEBVwAVzjeb1rXGIxqLB8If50KNy9KV04qIEXwH02gm7lvhXE1wjdTijO6sDJAn2/qdpGVKeGZCsQRm69Q/ylEC0dIwYo328dajdEzaw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=KaBQk26Pbc5VCaRScTQA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeC1Hjq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:39:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeC1HaE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:30:04 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/30] net: refactor socket_poll
Date: Wed, 28 Mar 2018 09:29:05 +0200
Message-Id: <20180328072926.17131-10-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072926.17131-1-hch@lst.de>
References: <20180328072926.17131-1-hch@lst.de>
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
index a93c99b518ca..3f859a07641a 100644
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
2.14.2

