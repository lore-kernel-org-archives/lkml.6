Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763006-1522222517-2-4900852389247666508
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
    t=1522222516; b=I116irFIJFLJgMbIm4wrQF5p7Bi/bK1lwHqS0Q9wKHQYX0b
    dY87NWTeI5XTcOx/trce3tG2hq7RHzXHJ8K+6kZuiUiA7reLa0X8HFQ7+rU3EDKV
    fQPjJiKJlVCRQJ6lINSoPZdIr+BC5GYJuOd9Wwc6sPpIG/Ydw3V26oR7d2YPoVFw
    YlsmSKvEmwzIn4Kr29qTQACKZwHLy4Dxv1VyWXxbGYYBnO7R/nbgUFZKilV8nHFl
    +0NsLL7WLMwAF0yawPtXL3c43vb+HqpzW3hjwgos/a8XUgknR0fO5PhUPrOCPJ8Q
    dtrTc7l/Nc2VmAxoUawy3yy4cWjXzEoGHstk/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222516;
    bh=/3+Qhd3Ju2YEidUX+M/ffcXKzQMzxaZdsGVrWFQtNz8=; b=GS/J1C7NuWVQ
    TIA+aAKg+gQ33dN6XYOAiGyrRfwIWyKPEUcWRc4Jmiz7gasex8xKnpci4Uz9oEV/
    sTCRniqVVvGyIuvW0qr0Fno9NCYNDGjcymxW9FyxinGofhMF1QMkoLsnyl6KUhNA
    bnqHj/EfpZp6GLIgRmNZ3hWMrMDFjfDFifPMcgcglK+dvFKaVFxdhsmiEVzz0Qw2
    3BZOMyCYgh0NDI546aunu9ssPW9J1ORVtUY0jkYVevC5XnKSU5b6VKUBipp8tFCx
    mwpZiRp6CRmTnmt47xkrsSWef6Ug1X69Eee04AvQXOJWspnr0mpVCl7YqSTPKKV8
    XaRHp8WHeA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=b8hQAhie x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=b8hQAhie x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGG9ar6ycdGOko1rwLb3EeVF0TayhQfVfROhg24hmiDFxr7DnJoMQ1R/sx5hF9Jr1lHcRsHuDQvDLGmN7NFt+HwiC6Q0hRkXQ8qoeDAoz893F6C8JEj7
    DGsxVy5AyAdF2VpEkGE0b1JaFIjjqvS0tO/kG6uV7tx1LdZr313fo51K+ytmCFEnNuz3SbcG3F4Rs++T/Co0sVR+Z9ewyiQ+lWl2SRZGOOILXpAajeJxlzxI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=BwNymlt9F6pNbMexjPIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeC1Haq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:30:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeC1Han (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:30:43 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/30] net/bluetooth: convert to ->poll_mask
Date: Wed, 28 Mar 2018 09:29:16 +0200
Message-Id: <20180328072926.17131-21-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072926.17131-1-hch@lst.de>
References: <20180328072926.17131-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/bluetooth/bluetooth.h | 2 +-
 net/bluetooth/af_bluetooth.c      | 7 ++-----
 net/bluetooth/l2cap_sock.c        | 2 +-
 net/bluetooth/rfcomm/sock.c       | 2 +-
 net/bluetooth/sco.c               | 2 +-
 5 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ec9d6bc65855..53ce8176c313 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -271,7 +271,7 @@ int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags);
-__poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
+__poll_t bt_sock_poll_mask(struct socket *sock, __poll_t events);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 int  bt_sock_wait_ready(struct sock *sk, unsigned long flags);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 84d92a077834..80033a7e1de2 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -437,16 +437,13 @@ static inline __poll_t bt_accept_poll(struct sock *parent)
 	return 0;
 }
 
-__poll_t bt_sock_poll(struct file *file, struct socket *sock,
-			  poll_table *wait)
+__poll_t bt_sock_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_state == BT_LISTEN)
 		return bt_accept_poll(sk);
 
@@ -478,7 +475,7 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 
 	return mask;
 }
-EXPORT_SYMBOL(bt_sock_poll);
+EXPORT_SYMBOL(bt_sock_poll_mask);
 
 int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 67a8642f57ea..d20b33daa80f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1654,7 +1654,7 @@ static const struct proto_ops l2cap_sock_ops = {
 	.getname	= l2cap_sock_getname,
 	.sendmsg	= l2cap_sock_sendmsg,
 	.recvmsg	= l2cap_sock_recvmsg,
-	.poll		= bt_sock_poll,
+	.poll_mask	= bt_sock_poll_mask,
 	.ioctl		= bt_sock_ioctl,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 1aaccf637479..b4dc96481d92 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -1049,7 +1049,7 @@ static const struct proto_ops rfcomm_sock_ops = {
 	.setsockopt	= rfcomm_sock_setsockopt,
 	.getsockopt	= rfcomm_sock_getsockopt,
 	.ioctl		= rfcomm_sock_ioctl,
-	.poll		= bt_sock_poll,
+	.poll_mask	= bt_sock_poll_mask,
 	.socketpair	= sock_no_socketpair,
 	.mmap		= sock_no_mmap
 };
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 08df57665e1f..b2bf5c767b3e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1198,7 +1198,7 @@ static const struct proto_ops sco_sock_ops = {
 	.getname	= sco_sock_getname,
 	.sendmsg	= sco_sock_sendmsg,
 	.recvmsg	= sco_sock_recvmsg,
-	.poll		= bt_sock_poll,
+	.poll_mask	= bt_sock_poll_mask,
 	.ioctl		= bt_sock_ioctl,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
-- 
2.14.2

