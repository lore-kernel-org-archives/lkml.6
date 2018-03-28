Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1661265-1522222404-2-5900080459341956031
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
    t=1522222403; b=QA57N/P1KvqUj5lGk5t6PMCS5Zbg9/A7hY9qR4/02fwItWk
    Hl1RaI071pL2kfmNwE474YC9YYN5VvsxBqZpfiyP8ToUEogaLpdFAmHUMG6lt4/g
    /vTA5+v+2LuC58kMWfFfk3w6BG2lZp80PwQJIbliyzIk8R6zpjp9K0WB0CjzlGSc
    1LFAG1571XxilIPZqHl4QqWRQQCQMjPdXneO7Rm3S3cRE9j5lWgw9K+hc2nR4rrO
    5ViZuy9m9lXtiBlso+k26Lq7aPXxG0jbV/49CuAM9cmbarBmI54CVpkb0Hxx3+hu
    DB8ly1G5uJsj8NDoEYww1XOZ3n2F7j/rc0zkE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222403;
    bh=OHZ4aktvZgwBFU9y32htmcYpxVzm3/zUzCsSiAFBoU4=; b=IQy/DaoAOVnn
    j+DW7fE07tdszaR6W91lj/CPqq4rhQgwOgmxGXM3QNBND2lSl0AppHQ0Z0ktPjti
    dSH4deiV1xXedhh0WITRZVhbl93WgvyicQYbwldNx7sSBpA3VZoNv3G1nuOb1//U
    9QBGCzYqyJSgCUawdzSApej+c63R2770L8dgmzzeRenqoip7pWBecCu+m1E8b0d3
    RdXuyBfjpBm8Z/CiGJirkKjOOTA5ifNoWaQ4gw4VcTfrAUkrkuOoT+z2iMtUruPo
    yMXREoetY5CHHCiTfScyLt0mR71Z3bcnZb87LKIlAwTBxckLmt+yP5GZEseyubo7
    VF+h7dJE0Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=cUCvqBgz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=cUCvqBgz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH3ikF+nsz8WEotzG3DrySYECfWfwyhRBJAn0yKMN2fvm07942wm0w68Bq1Z9T+x1IueNrKftU9vvxFhY1C5RBXHSKLdZGzrdRw5oKGGregitX5PWArY
    B7sq2KWEle0GH8J/0IntBoT/cxyOKxM3rRRkkptfIz7SsBo2t3h/9j4/Vf/lL6GeCF4bNHl0EoyMqRaBApRDSaOZrTeNAkIL7ClD3VnThibRumFogzj3DpsG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=CdJLp5WRwxpRCsuKMh0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeC1Ha4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:30:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeC1Haz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:30:55 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/30] net/iucv: convert to ->poll_mask
Date: Wed, 28 Mar 2018 09:29:20 +0200
Message-Id: <20180328072926.17131-25-hch@lst.de>
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

