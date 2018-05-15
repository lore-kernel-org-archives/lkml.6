Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3144061-1526414028-2-14302810141807180893
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526414027; b=Q4vXr351ZEh3Xn21WNGW+2nOy9ipu3x+xqbTGJ/k/rG0zhLgnL
    7NFuMT8o75Dq2+M2ItQm9YlN915Za7fCLDK6GsRgLa9OLf8AvpIU5Px7vakratKE
    td+tr2FryqubSHw5+R7A4+bdp+jTQCDshxAYjZ28EckleVHz+GYfZf7WDqBA/v1L
    zhgVFNeb4I4p1bZw+wQr7h2V6vi2cJJxoHOfKaZjjs7Dh7dYry6fZYHjdPhq+sew
    V4qIgAnUTMfSEfJotB96gkHUrkbXM0qOYgHXb4y/UbO0iVFIJUaEz1lRtIW8ASEb
    nWG7DUWoZq2dfCJT6ajVQY6oQR8Ap6PZjEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526414027; bh=
    Eqmc4RFzj8Aiw+X9KlH3Rf6w8BUC755odUCkG/pVOPc=; b=S0n7zKHwbfv/4ib+
    TB4Wnu8psfI4SeqvKjXyIBnuWDeshrs0UxQ/E6s2iEen9vxKQFlJ/vmL68YeGOTX
    /5nFqC4BmIlmwolVq3/J8u3O0d0k0hMIEBK9uxH7zcMcg9iN7aGBwayRM3sbarFn
    Eq/ksEJI7vDqumhqaQaGu8i8OBV16mw5/asCUcGeKtI0SpqYQ1mEnuF1pEw2XIUU
    w/9YQk5UCMvvU7OFIRUf7xe+lJFNyc/I00M8VE1O2+xn4xJEFrzxmZLM0N91Egk6
    Sdu0f3v3JDMJ7G2sFpwDIFLhJp9885dWucWGJhmv1Rkx4936pFEfn82Uaowuh90z
    47GoGA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=RNzLgv2A
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=RNzLgv2A
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
X-CM-Envelope: MS4wfGFB00DkwL+LTEi1SmXBmbovKv9IwS6geJ09gbRlAdaBSOxlAqMNUzSsgkpFQ0DI5ChCI067TmPsal8tICwd1qOQkhhJnrS7zfngfg37b7HX93vR3Ha4
    zA4mm3Z/jUduQLMqZIHWcenWSpvHnZOpNCYg71PyDtTFZc+Wh94C4kXOXLYX+Yc87XHGSwa9MkIdO1VA7RMPDpfIaG15dUbk80bayfdzM67zgiFpTS64d9Yd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=93xJhb5qFrg3jIcMEpwA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeEOTxd (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:53:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753060AbeEOTu1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:50:27 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/32] net/iucv: convert to ->poll_mask
Date: Tue, 15 May 2018 21:48:27 +0200
Message-Id: <20180515194833.6906-27-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515194833.6906-1-hch@lst.de>
References: <20180515194833.6906-1-hch@lst.de>
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
index 893a022f9620..68e86257a549 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1488,14 +1488,11 @@ static inline __poll_t iucv_accept_poll(struct sock *parent)
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
 
@@ -2388,7 +2385,7 @@ static const struct proto_ops iucv_sock_ops = {
 	.getname	= iucv_sock_getname,
 	.sendmsg	= iucv_sock_sendmsg,
 	.recvmsg	= iucv_sock_recvmsg,
-	.poll		= iucv_sock_poll,
+	.poll_mask	= iucv_sock_poll_mask,
 	.ioctl		= sock_no_ioctl,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
-- 
2.17.0

