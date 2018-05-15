Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3144061-1526414064-2-7643795020665855881
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
    1526414063; b=dvlh4wdiwhTjKNHvSii4lBWn9agVIh8YsqkXtWUix2SijAkgpt
    /smENo0BwViF7r/cl2OH2lKNsXY8gV2loSRgplL/CcDi53J52drE6lhoU6AcEQUh
    +SYhjqAHPKRXcA7GHnK3itixLWdrDlj4yaLZFKfoUnxBeoSL6NlYJ9eizfiGDO5M
    C7V8C2KHqyk+VZkvWWb+OBnzWzXipCIbhh3oo5RAaDoQxv6HjXHVPjjKKIMhvCzN
    0CLmeh7pPcsHx/eiBtRijuMpHTE+srFqcDhZbDEzcmumrWY0CWP9gwmH4aoa6SxE
    FL47IPXYTTVvZXcHITcNJQ2FOWWDEu8g0mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526414063; bh=
    9qkiprRPqKz2BzRdBzJf6xhK154xCThJCrn8PtF/j/A=; b=WnhrDoIAnUsZ2Gsl
    Dz+xbixTdytz54jddjvJpd2P9/I6SvnknVj8OATM5WqnFZL2KkWFSmFN5rqaCA7A
    yT9G768vRrESmxQDYbBbz9eeKXjwUJLCxA1uhm9fJNCXtifFHNVyE3VzVLX+Ih5M
    BjlBbIy3tsIXqoDfQl658R+ag7kRvK+G/JZzUam+m4PpHTBrwlMhiHlS4Q9MgiQr
    +JRVPTU4Tk3ljYQbFi/ESQAEmFwiqjipcWHsZfGgsQhlmBC2aXVI9drrZDmGLPzO
    e/Z2VrKqJfxBJvKkPrZtq0iRAEmAK4QP9pg76tp5NDyqM6yn4B9VIxSRXkty1MOL
    gNA3BQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=SkecBhds
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
      header.d=infradead.org header.i=@infradead.org header.b=SkecBhds
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
X-CM-Envelope: MS4wfEMwKf9pbuI0IHQCOHDPtKukZb3sreVohgToEtkpIjh9s54WWXB4bUi97qrNM0rS90/8mUK6M1Jsccyb9On6P7n4UWtz4070gXoZ34DaiWk/2vA/Ye7r
    9qGm6oD2nQHs9cg+QKTMj/wYqOYngS1dNE0JlZnACW1hoJi8qJEa0daKhngDGThRO9PWoMc+dLxF4SZBaM8RZY9NwXBEOa+XPBzZn7I3UHvyag/vFKCagBPW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=JAGRcNAvqmLdBlwhYKUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeEOTuQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:50:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbeEOTuO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:50:14 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/32] net/caif: convert to ->poll_mask
Date: Tue, 15 May 2018 21:48:24 +0200
Message-Id: <20180515194833.6906-24-hch@lst.de>
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
 net/caif/caif_socket.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index a6fb1b3bcad9..c7991867d622 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -934,15 +934,11 @@ static int caif_release(struct socket *sock)
 }
 
 /* Copied from af_unix.c:unix_poll(), added CAIF tx_flow handling */
-static __poll_t caif_poll(struct file *file,
-			      struct socket *sock, poll_table *wait)
+static __poll_t caif_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
-	__poll_t mask;
 	struct caifsock *cf_sk = container_of(sk, struct caifsock, sk);
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	__poll_t mask = 0;
 
 	/* exceptional events? */
 	if (sk->sk_err)
@@ -976,7 +972,7 @@ static const struct proto_ops caif_seqpacket_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = sock_no_accept,
 	.getname = sock_no_getname,
-	.poll = caif_poll,
+	.poll_mask = caif_poll_mask,
 	.ioctl = sock_no_ioctl,
 	.listen = sock_no_listen,
 	.shutdown = sock_no_shutdown,
@@ -997,7 +993,7 @@ static const struct proto_ops caif_stream_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = sock_no_accept,
 	.getname = sock_no_getname,
-	.poll = caif_poll,
+	.poll_mask = caif_poll_mask,
 	.ioctl = sock_no_ioctl,
 	.listen = sock_no_listen,
 	.shutdown = sock_no_shutdown,
-- 
2.17.0

