Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103578-2-14708151134468282879
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527103578; b=VKmzU3te34Jx5JmrBwZpD9kPNDZJYaaCtExLUFfmB4pT3oOSFv
    4ZldFqPd7yZ/qqck+fQPcrzXbpnMkw6oDbaKSMGXf1RzYnqKVDGRCBg9wNFkWWBV
    a4vxUE4eqjvUQFd6VtRx5iCt5e7T+zJabVSm+dU15NKmZW+n+DFqUotoh3Vo55NP
    qUa2OdbTaAOQ+rJC/mW1c/qEuc8FXbhCN8ERG/szpyI01Ka+TcCurVwjEhxazw+9
    /6nu8SFrsvJmoTZxEpdYjInHb9HVRsdOlI8/7AsH3YeJ26l+wfRqMwhfVoWMh2r+
    NXwLZoahXZjWQ2ae34OJaVZxhlI9fBWuX+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103578; bh=
    jOnRF9SHaf4vjB13zbQNLlY4eR5MxvJVa4HgaHVCSaQ=; b=P7KrhlqX9C0LXU64
    n1rSJdxFIjfvYwrydvn2uPSyhaYl4pTVaufP+62T4GB/foypWJjysfFx1AyliHwF
    TQ//EAcYO8WjNrlfVDIbV122MBzk3gQ9pTrp8dbs7yaDgogqySDxnCD5oNPZtBtg
    AAMjQU9TZg/aFyzaqTVYSRz8N+uFZzvlQPG++0p5nRxFlzkCumrXmWWNZ6Rj36eQ
    K7S5BKKt5GTl3suJ9C0kzawFX3FS01c8KGLMe4kGCNbSAZUeM3tYOzsDmkrjHFsG
    pvdPL2C0wf3dX03Rpe7G8eAP9lCnlI6OKuDNVBLlxTlUlWxI3Lau7cIYr13NTz8g
    ZShn+w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=jKq1DJEu
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=jKq1DJEu
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
X-CM-Envelope: MS4wfEuM3idz6/Scd2/Qo7fAujYFAiV2VZlQ51H/Zhlf8IYByu2As/LYSWkN4rJJzx/onmHXa9kzlesNcUr6Ce3kMtBRvev749rD3GURohXFlxJ36YyPERcl
    775m2an/jhTg35d4DLK4rHYL2iDYnmdKhA1Lj/XRp3UocCoEzJN3P9umq8B0OMKRKbAPyHEM41x9AlOhCK2n+ZU0G4BnT6YkP3Tdi5aSW1OtzV0ao7F4ijBc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=ad68_8OTSUJq81Ci_wQA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934522AbeEWTVc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:21:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934518AbeEWTV1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:21:27 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/33] net/tipc: convert to ->poll_mask
Date: Wed, 23 May 2018 21:20:10 +0200
Message-Id: <20180523192022.1703-22-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/tipc/socket.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 6be21575503a..3bb45042e833 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -692,10 +692,9 @@ static int tipc_getname(struct socket *sock, struct sockaddr *uaddr,
 }
 
 /**
- * tipc_poll - read and possibly block on pollmask
+ * tipc_poll - read pollmask
  * @file: file structure associated with the socket
  * @sock: socket for which to calculate the poll bits
- * @wait: ???
  *
  * Returns pollmask value
  *
@@ -709,15 +708,12 @@ static int tipc_getname(struct socket *sock, struct sockaddr *uaddr,
  * imply that the operation will succeed, merely that it should be performed
  * and will not block.
  */
-static __poll_t tipc_poll(struct file *file, struct socket *sock,
-			      poll_table *wait)
+static __poll_t tipc_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct tipc_sock *tsk = tipc_sk(sk);
 	__poll_t revents = 0;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		revents |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
 	if (sk->sk_shutdown == SHUTDOWN_MASK)
@@ -3028,7 +3024,7 @@ static const struct proto_ops msg_ops = {
 	.socketpair	= tipc_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= tipc_getname,
-	.poll		= tipc_poll,
+	.poll_mask	= tipc_poll_mask,
 	.ioctl		= tipc_ioctl,
 	.listen		= sock_no_listen,
 	.shutdown	= tipc_shutdown,
@@ -3049,7 +3045,7 @@ static const struct proto_ops packet_ops = {
 	.socketpair	= tipc_socketpair,
 	.accept		= tipc_accept,
 	.getname	= tipc_getname,
-	.poll		= tipc_poll,
+	.poll_mask	= tipc_poll_mask,
 	.ioctl		= tipc_ioctl,
 	.listen		= tipc_listen,
 	.shutdown	= tipc_shutdown,
@@ -3070,7 +3066,7 @@ static const struct proto_ops stream_ops = {
 	.socketpair	= tipc_socketpair,
 	.accept		= tipc_accept,
 	.getname	= tipc_getname,
-	.poll		= tipc_poll,
+	.poll_mask	= tipc_poll_mask,
 	.ioctl		= tipc_ioctl,
 	.listen		= tipc_listen,
 	.shutdown	= tipc_shutdown,
-- 
2.17.0

