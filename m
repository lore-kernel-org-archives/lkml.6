Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2357871-1526988965-2-4058579235892209129
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
    1526988964; b=KIWYfjXAQNYYsLaim4vBN2640TRteTQICJc32ucqKcxi1TBlZW
    3BQ8eZMRS8zCC/AMz9xRqZx/jZ9pRU0gDCBdn2UdD2YWsW4ZYCrt37VBv1ECdebZ
    Eq1w+omZZCZyf2kb+rtox4SZBKY92uCsiGpK89Dj1b2vxK3BvBANR2LG7B7vnE6Z
    hkQCENfjIpLcpHgIiyzmYiOeIhia76vAKKpOqVi06hzyyH8VkVOZU2t+ABmotcOO
    9Tx/RoJ9Vka3YnPg2t81HrRoJfvj+TeS8YZHLAAx0D/OdCuCweElEAvGB27M7CDU
    K9A2owJLKaUgssc9R2Ri0fq8EMxZ17F1kTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526988964; bh=
    OG/3FkKUPa/C2IpkpEYuVJ6JevawRbIXYMusu9CDMWY=; b=BfZq3yy+H9nc3Ki7
    SYfkfES+jkMICOPrHOV7XmHw2m/glX+F+Bm3AuNwaDJwq07cO0MTee63DRq1mwiu
    7NVrgbzCEHBL5EkCHqwz4fq/PSuVQ2PW3TYHql8K4tgV7GoCSvafKOqN7jF4NqeK
    PaTNSXInvmFlWpu+q1RvCcQ/pXy3UF8yWmPJRr99ZWc+/GKupLmC15vnN3VcYsXL
    +Cm5Awby9b/PjxjR6o4wOgaHYzWmqzas854r6jmTi9Ab1uW15fX0yDUYIEWS6wfl
    n8grmSieqn77TsziznghIwNzrFoyrTXhX3pZcjIkQrUk4uuHq1+ByOATc4yFayll
    92bTWw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=AKWElahU
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=AKWElahU
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
X-CM-Envelope: MS4wfG9XJlOHsuFFbXdsifbZDkWNTeUPygDMD77JxVG/9ieAlxzuMtH5qpndH0kFigQqbsuc/zXjnVASoE+0G9pT7hD31nKvnfOdrd1D3r6Fu83ijvEqYtSz
    A0DHQy1qg/pbvBYFJyfMkbctp3fIy6N78/hkgwGJpvpr0WJu5E7C59PY87jPjploX5o+YWOncVqZKWRSFCjX8BulFfTkwxgxAD3gsw6azf3zYlzqxEwD6ZTJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=2Q-G4Ex131KUB3becfsA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeEVLf6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:35:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeEVLcw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:32:52 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/31] net/phonet: convert to ->poll_mask
Date: Tue, 22 May 2018 13:31:01 +0200
Message-Id: <20180522113108.25713-25-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522113108.25713-1-hch@lst.de>
References: <20180522113108.25713-1-hch@lst.de>
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
index 9ecf02def928..ea2bfc3aafb9 100644
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

