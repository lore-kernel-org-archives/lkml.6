Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684034-1522355835-2-2658012893786397909
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522355834; b=ZgPbRVfUYPpbGRcWx22LZnTL9oZVSyTIDkAUvqlDX5hdYo8CMk
    zSVuG3VPbUrRcAasO9HePwoupDBQHeo7JEFcBniYAYgd7+6a5dSEHD3CwIfajb4i
    zIqmJpepxy6LCjXJk1fRy3y6PshBcaxQBQxtjQ/qGFDvrnd8oLeu0sgOmXaVQ5+x
    9V0zDhwFwkN3Dy9gVMQUoPK+Se3ijg1y0OXZuJN0DlWIeFp2qJXGMM35Z4Xa063G
    vQvc4Aij9n7nIR/detcLpluvqVlmRO3UnOiG6QnvLPMY9YemQOaoNQJ5kY9owoTi
    4fn+4clHfQp1S80GS7g9PWXV1RBVTl1Y03XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522355834; bh=
    8s3l2WEdAfY3Zli7acWKC0c1lZwgW0FRQMiQDnOq7Qw=; b=gCrKIWX8CnqyX1sG
    Ow5FNNA4INnmpgducLxlryTl1DEulAv9Wjb8iTeU3PtBjLumYPzGAipZ34heZkuO
    ybzIiOjtw9zTVSgNyBKO2k6J6i9N1NmqqBr68sXnuv8+5OG/QDQmICpXxwNaLVYF
    TC6GIbOVSsAO0Cl9/1qmJnVjQw8Zwd+3pwtRbKQLEikZQNLreYCRiDD/iXuIUwcS
    L/B4Ay7iL1VYR/ExNPkHsCHqimEhCo10FgXFY8VUxiC7hX9ltHYwQTdZM8OFgOCK
    lhA0jzIIcW/yz39ARyxglOJnENM0GkO95vaiC/gnFeS26L3zeInJPyA72rHJ0BRo
    Sg91Dw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ATfCACg4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ATfCACg4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEeyEZfXIzHGZJqW1dsW+uYrEkCOYz8FeTBh8a6135e+X1awsVYY8Mkx9O8PmqxeoeCC236MOP4vAJ50vs8X5Yv3Ky6Orb/uTxMTEmhpsUceGl8BmVEl
    qlKkebddqHp5W+3oWDURUdoJOrRsCg27ZewSUGGOXIC4Mk/oiI7IH3T6B15orVbuRPGyYScLehcxqiQl/fJ/jdiKwFdJINVLLh/7kvTAE+Jr8frIUuX9vxw5
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=F55Z69aUwsZ0p8WbI6QA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeC2Ugv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:36:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbeC2UfF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:35:05 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/30] net/rxrpc: convert to ->poll_mask
Date: Thu, 29 Mar 2018 22:33:23 +0200
Message-Id: <20180329203328.3248-26-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180329203328.3248-1-hch@lst.de>
References: <20180329203328.3248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/rxrpc/af_rxrpc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 0c9c18aa7c77..d2440d5c3ce8 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -729,15 +729,11 @@ static int rxrpc_getsockopt(struct socket *sock, int level, int optname,
 /*
  * permit an RxRPC socket to be polled
  */
-static __poll_t rxrpc_poll(struct file *file, struct socket *sock,
-			       poll_table *wait)
+static __poll_t rxrpc_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct rxrpc_sock *rx = rxrpc_sk(sk);
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	__poll_t mask = 0;
 
 	/* the socket is readable if there are any messages waiting on the Rx
 	 * queue */
@@ -940,7 +936,7 @@ static const struct proto_ops rxrpc_rpc_ops = {
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= sock_no_getname,
-	.poll		= rxrpc_poll,
+	.poll_mask	= rxrpc_poll_mask,
 	.ioctl		= sock_no_ioctl,
 	.listen		= rxrpc_listen,
 	.shutdown	= rxrpc_shutdown,
-- 
2.14.2

