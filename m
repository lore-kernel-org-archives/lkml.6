Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3488533-1521618598-2-9033373280325621989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciiro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521618598; b=e4mLURg8jKoDAiedZule7BpAl4lvjib0JVLZKCvMdYmfNbY
    IORPM2ZscS7XLbzvGkewvaH520XwohkOoSiJnvpGfC7qfm1M4I2qBmrc2zP/w9KE
    we1z9zn5mlI3xi74Aq5cH4MsIx2PQNgNZxg9IBZYKObr4cFJpC/rLvxaHWCMxYEf
    eFYvkyJpZOVRhZREflLQL3RC6z9T+2dL4kVFjEdXr3FpVImzZd8TSukz8aRWD0ou
    6B89QgxWVR0R1uq9b0MZTpQnt03zZhaLlzMeRUDZEVn61qyzgqgjWlHgDKreRJuF
    NAnK9h7ma2buKOq0ixJhp7NMXM6Oml48lJgKaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618598;
    bh=JNVdscXCCQiUwhgLW/bxTAACwhyL7g7fxqz9weX/MEI=; b=ncDNV+JEm+Ry
    0RF4fF2u/QcM96XHYRPc4htKW5BudAKf3k/3NlTJQH+AI/LxoG4ydd2WPRJy08pU
    Usa6EYL/lD4jGBDjA7nnw2eDH09PW7TGkmFAHcKAoGWk0uU02S0bk4MaqY5rfEOm
    uN3Qi+XRPAWKjZFck42pZlFjYFLjtdaLvjGc6XIQ+UZZ0jvq5/zAKtPAbyY/PL/7
    hekhgSdkcq5MfqtCpyBOjXIWojQnj4dicH/pVjZLyXwmtQuZChRUhpvZHZo7sevX
    MAqPXqEkcpe8tQX0peAaoIV7qcqfiRZtPwpEbkBmedDVW+0G0z/UrMJegf3d9jR0
    yNsB7ujXkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=oJEMXh2X x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=oJEMXh2X x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeCUHtd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:49:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeCUHlG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:41:06 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/28] net: refactor socket_poll
Date: Wed, 21 Mar 2018 08:40:11 +0100
Message-Id: <20180321074032.14211-8-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321074032.14211-1-hch@lst.de>
References: <20180321074032.14211-1-hch@lst.de>
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

