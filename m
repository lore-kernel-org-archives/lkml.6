Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3815124-1522424618-2-11463329856546255312
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
    1522424617; b=uoCduiuNfDrlD/mr1DZOXxKEMFd4WFH2pI72Cx4DK3kGXIYNGD
    qyKN91KgggWE3UE4Bf+kXSYvIo4Wa3SWND/mZej5+INJnwOW8Gc7sLyvC3xtrN4N
    2oyWm+wLr6dPsMhxWl8JqieKHmpWSqzXWlQiZ0qYk2x+wBXc1tRDcQ74u259L7L8
    PnaWR7yhs4J95hYppil/62Vn4OmmlpHDC2amz2Wo7oW6fyZJHd/n/yfE/G/nC3Uy
    xFKsGiHx7WUlDZ/TgcH1sjEiAMium3nNOd1y0v6IkjB7MFIryRpL+IwJzaRDilr4
    LOcE9LH7hfDSqh+lpwpIz5vDVhnAnDov+C/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522424617; bh=
    OHZ4aktvZgwBFU9y32htmcYpxVzm3/zUzCsSiAFBoU4=; b=N9uaxXLZEOgY4gCi
    VJ8gd2Fgup9rEfLu9SY2qZefR+8JK5++1rZadIOwMo/7By4g13XN7fo1EdYRVWTs
    Zr409s/5jlYOYhhRqCUrtpb6ZsL/ALHeKSlNvu+svF68W88tPLVAqU+bwTpxTNDH
    2UXqSMaGN2efuyVFnpYijlSm9jO4I11zsGQS3s3riAIUQhxVdR9FM9hasMv3X28t
    pD9kw0Sg6J5wL1hXJ21Igd00h1/pl7HdH4QtURrS8TEMGijHdYtfoEt7ggbLRO7/
    pYVFM9oyAfeirM/u0sWcXZ4JW1DAt81voV5hBXHOVSY1crxmCKTENw4/EIfErcqe
    eMjjxQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=W1nUlWT+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=W1nUlWT+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAI/v742h2pI/THtzjUKAYua1x9fhtmAeCypqs7ir4jrYi2G+aKzRz5Hxj4T81dYWc8u5ycicIOSOcPmcjt/YNpNZkim3eDGjRMI/jqaTQYi+5pQDu9g
    HnCKJ1P3azPNAahCwl3lTPYjoGXIIBGQ852AiKF+NkRWXp65GziyKJxVlA9hPb2IJ1mReT3EE2Ehvva4gNRrq8pQ/of9s8gZJzElKSSOW9y0Xi2AT5wlQgaU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=CdJLp5WRwxpRCsuKMh0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeC3Pcp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:32:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeC3Pcn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Mar 2018 11:32:43 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/32] net/iucv: convert to ->poll_mask
Date: Fri, 30 Mar 2018 17:08:03 +0200
Message-Id: <20180330150809.28094-27-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180330150809.28094-1-hch@lst.de>
References: <20180330150809.28094-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/iucv/af_iucv.h | 2 --
 net/iucv/af_iucv.c         | 7 ++-----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/net/iucv/af_iucv.h b/include/net/iucv/af_iucv.h
index f4c21b5a1242..b0eaeb02d46d 100644
--- a/include/net/iucv/af_iucv.h
+++ b/include/net/iucv/af_iucv.h
@@ -153,8 +153,6 @@ struct iucv_sock_list {
 	atomic_t	  autobind_name;
 };
 
-__poll_t iucv_sock_poll(struct file *file, struct socket *sock,
-			    poll_table *wait);
 void iucv_sock_link(struct iucv_sock_list *l, struct sock *s);
 void iucv_sock_unlink(struct iucv_sock_list *l, struct sock *s);
 void iucv_accept_enqueue(struct sock *parent, struct sock *sk);
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 1e8cc7bcbca3..539a312dc481 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1489,14 +1489,11 @@ static inline __poll_t iucv_accept_poll(struct sock *parent)
 	return 0;
 }
 
-__poll_t iucv_sock_poll(struct file *file, struct socket *sock,
-			    poll_table *wait)
+static __poll_t iucv_sock_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_state == IUCV_LISTEN)
 		return iucv_accept_poll(sk);
 
@@ -2389,7 +2386,7 @@ static const struct proto_ops iucv_sock_ops = {
 	.getname	= iucv_sock_getname,
 	.sendmsg	= iucv_sock_sendmsg,
 	.recvmsg	= iucv_sock_recvmsg,
-	.poll		= iucv_sock_poll,
+	.poll_mask	= iucv_sock_poll_mask,
 	.ioctl		= sock_no_ioctl,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
-- 
2.14.2

