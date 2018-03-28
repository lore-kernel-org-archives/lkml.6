Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1661265-1522222434-2-4193448362265524618
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
    t=1522222434; b=tCLdF43cnA+18QcrjV0gY2a76bhm2W/SUBD442GpQ47Zs7l
    8KysnDoltw8VWbukyBLyonBQRcJSxWuI4y1DCCvh+ENfBV6m9eParbO6iIlDWA9/
    hjZpx/Oo+kyDfRDTCx8ZTK6yG/rLIF4JKgQ1CmkXJQALiGn9ItbSOoXv6c2aEmi/
    lshfQtJHwisdiw/m1oPlo1HojGfmuWXMNToyJ+rVM5psRkeEODyO1963ynExLNKx
    Q2h4uTyXQCLI7yk0xSPzSpKmtJoGKJr7X1O3rNQxDrDVyYl2WZMnmEmZt9FDgXRR
    52hjA0nNjZHxCFvoaT89N6pE7pbqOnF6rmjgbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222434;
    bh=Pk3+G53masUqCvGg+9ZJVQANHedsSP2rQmUlAw9sCrA=; b=dQAZIFLfclSa
    IWX8EETaljdfj6jR1fMdk0WQOSwwsS9ZreXpjO2DNbHDCFUJ2/Cq02TAqP5IcHHr
    mopY0wfWQO/mXB+ks1KSjqLDOHFtLsiCxNfXgL/XB1aYay/d2am26jgmuLeymh1o
    nTa/h74IKfFD5YBrj/IPqapmG2H3NGOFA5pYeCZa+oARyTBlkQgGv+dn+bUBRNes
    LFQsMaMMifKENvUwwspo3QtF3SxHGWVQugyvBNx+iuyPNdbR6bGro0mpL7L63ArA
    lWEZX+tLfVfhv8GYuZaQt7CC5LNxb/oGYuDmUuRhpgb/36bHupG4fCNsabvOOOtX
    9FDTGh7SVw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=jqxmA7j0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=jqxmA7j0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK8AR5NIFaleal38JfazYRoSElV1ocysrilVPsOuGqkIeAyJEFx7VMqIKD3b6DvM6wyomk2vOfdmow8kX04Xl+rPPTuhLf5c23gd+iN+RAHaPxRuBFTv
    v8CCEDCuODb8JOnDBJd/IjAUJo7fw/zXYM/+9e2oHW4d0DivHXnHCU/7sbF1DRILcVM0jTBZeGp7uDV9T+pMxibxcW3j67dPXz5WfHl6VCebvVwR1+rk8D/1
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=GvLFIiL7OleGfqNn4fMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeC1Hda (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:33:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753261AbeC1Haw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:30:52 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/30] net/phonet: convert to ->poll_mask
Date: Wed, 28 Mar 2018 09:29:19 +0200
Message-Id: <20180328072926.17131-24-hch@lst.de>
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
 net/phonet/socket.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 28d981512f5f..70ac4539d5b7 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -341,15 +341,12 @@ static int pn_socket_getname(struct socket *sock, struct sockaddr *addr,
 	return 0;
 }
 
-static __poll_t pn_socket_poll(struct file *file, struct socket *sock,
-					poll_table *wait)
+static __poll_t pn_socket_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct pep_sock *pn = pep_sk(sk);
 	__poll_t mask = 0;
 
-	poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_state == TCP_CLOSE)
 		return EPOLLERR;
 	if (!skb_queue_empty(&sk->sk_receive_queue))
@@ -474,7 +471,7 @@ const struct proto_ops phonet_stream_ops = {
 	.socketpair	= sock_no_socketpair,
 	.accept		= pn_socket_accept,
 	.getname	= pn_socket_getname,
-	.poll		= pn_socket_poll,
+	.poll_mask	= pn_socket_poll_mask,
 	.ioctl		= pn_socket_ioctl,
 	.listen		= pn_socket_listen,
 	.shutdown	= sock_no_shutdown,
-- 
2.14.2

