Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103523-2-1905626873551373218
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
    1527103522; b=Aqp1X2bITn9F1BBQwWLZAQOPVDA/rLJyPzodA9TpgP5vQsWRF0
    pfVVuZaFc+rbnir+5cDCnFuL2Xta03O68MreUrlhYfV82G2d5yp7KSn6MjwVjWqz
    ShHTknJuku0OzeNIwvg4ST2M/dpgb4Np027j1zCYtpUPWd+AAgiW5SFTF6FYkMIm
    1PYiyalebrsMSqCbJLssM3QSXG1aud44ZCVR35XEK6qNjl/v9JTrpjkS/w54lwyT
    yMI2fxVLpSFvWRNz2vJkQ/cEOHthQGG7ImDPoHx2rsIpLtN5dPBzwtV9zlmwyq9K
    VtpozFqiwouO/Mil4cMUPPVJBhAfeLWjeubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103522; bh=
    UR8YztWS7+DUtm54xb0LvsjhXzJMKINrM5evx79BWqA=; b=K6M6qe48IaPELN1Z
    YUE8K0U6n9qX8Rd0gQ5rO6kuzmD3ewku8JXXfHy7ezA1ePa2BBxzdlub/rFyl5zd
    X/iDpL73aYJfhStTW+auaaLNsbP9m6TA7+WvisnaNsyMFYKheOe3zEadwCajuXlk
    6er9GKb2PjcuUZcusPmlw6l8lZ0vReqBvzB4/Phe/msQ0mL9YjI24bQCoOBbtgLi
    t+mbpHwBLBMTfpLJ6rbmfJiJHX3xM/zTudvi4qwTLHwS9g/dyV4T6Tmn2UoZKUUN
    iC5CzVSDPnvvr4FJ2vbwmTcmZTyjPMDfB/nOUXfk5nAVsNot7eV+waWrYgnX1TrJ
    Yu5Dgw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=n/E3AVzx
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
      header.d=infradead.org header.i=@infradead.org header.b=n/E3AVzx
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
X-CM-Envelope: MS4wfDhabSb5An0aFzm6OAXhrkKVbwXf4+6Tb69TV3xOHC821erV+rYOK19SVhu3fypkYGtyhyKEikm9W0Vc+6eNei4gB9pIg4qKHoTMVEIDmAzKhBNOVbF4
    dKrFmTjgkg79mRH7U6256YqkmARTjBMVfLMK+9m5o4GH+sSkmDVnEBE3+RTIU8A4yhgYcHt0PrU37jFRBdrZv5AEODGqqdPnV/BKkgBqUbA9HvRzohnqjUxa
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=2Q-G4Ex131KUB3becfsA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934463AbeEWTYl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:24:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934548AbeEWTVm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:21:42 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/33] net/phonet: convert to ->poll_mask
Date: Wed, 23 May 2018 21:20:15 +0200
Message-Id: <20180523192022.1703-27-hch@lst.de>
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
 net/phonet/socket.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 59f5b5dc5308..c295c4e20f01 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -340,15 +340,12 @@ static int pn_socket_getname(struct socket *sock, struct sockaddr *addr,
 	return sizeof(struct sockaddr_pn);
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
@@ -473,7 +470,7 @@ const struct proto_ops phonet_stream_ops = {
 	.socketpair	= sock_no_socketpair,
 	.accept		= pn_socket_accept,
 	.getname	= pn_socket_getname,
-	.poll		= pn_socket_poll,
+	.poll_mask	= pn_socket_poll_mask,
 	.ioctl		= pn_socket_ioctl,
 	.listen		= pn_socket_listen,
 	.shutdown	= sock_no_shutdown,
-- 
2.17.0

