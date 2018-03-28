Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763006-1522222654-2-14998419343750034572
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
    t=1522222653; b=ebUzj4U9xRTP/EmoABbOEN8ACI8qY5gNRJCsiEiwO840gYV
    x1YMarnNVRXCguUhjOP42yjcUJsBBLC7X5J3VUwgF6r1DbaOOdZ5Q7Uc3MjRWAyd
    4xnfkyScs+YFupPwqzoz5ALuSBO78WD4RYLZpNpHCBE3CO9FkzYgKcHjRwol6ohL
    WsDVk5F3eywaVAOgk4Wo8V+pPo4d0KsDM0ImyamVT+x/T/Ts9/aWuunLL0Sj/ocv
    R8cknmgL3vAbwi+eHO3B+7/qB0UROVItxUhz6BvZ94QSbrKqOz0+2JYRvOgy0VOi
    YS1qzwdjrzEDGQWmGf+8AcfkOGGH8Qlj7idbigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222653;
    bh=1p7l/B0qizGynkbosMja/QlZ9F4hcVlLlfiedQ14Iao=; b=l59QkLAUP05R
    WdBxp8Amivd8z3Cb5smzL9y0wWsxPf822ib4/IJS0hGt0cyumnWtxZ5/KEkYYPFj
    mUIzFf1iUPBp7xzbECegsfjWbevRN+3D5pwVne7WwLdYaJ+lTCm8CO2b04tc6bDE
    1OPVXFaR8d9E73W0QqnJQNjlsaHZa2T7Q8Xx9KliRkDVHyZKoig5VhaIBdTNmOV6
    2Im9LiCnZixucMbaHPH4jEzWC3bKYbXJbbDJ7ao3b58giBtOPZ0ekEI78G/FL3Gh
    ZIjCd/DBxvotIyiIOXw2iRH9f3ehakPgAgw+Mji8h56QuULdOdGvGI8uDIr9ODeC
    +ef2tYckSg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=KP+b6UBP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=KP+b6UBP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMKOFK/03qtojRFw7oZ2yFMQmjuESXlWhcoO1Y8FpP6NHrqB5z/CCECYTK2pMrq9yavc5BgCIm1tgYgIRwf4uVFS3rkWkpcf5O0iFh/uIu4kvkU/DfZM
    +R+2Ex8dhXmRWCPe8Q9fZ7hJL5VOhy6DBsbZ9UWjsnXgAv7W2CUhrSIXqmOHeQusSgTPvUSRVRtKCsgn/hmcXr3Nd3ynjAx+FExBXpPlmo/dDwzFMFhVkoYl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=hHHsL0CiJGZsAvVjzFYA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeC1HhM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:37:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbeC1Ha2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:30:28 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/30] net/atm: convert to ->poll_mask
Date: Wed, 28 Mar 2018 09:29:12 +0200
Message-Id: <20180328072926.17131-17-hch@lst.de>
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
 net/atm/common.c | 11 +++--------
 net/atm/common.h |  2 +-
 net/atm/pvc.c    |  2 +-
 net/atm/svc.c    |  2 +-
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index fc78a0508ae1..1f2af59935db 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -648,16 +648,11 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 	return error;
 }
 
-__poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait)
+__poll_t vcc_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
-	struct atm_vcc *vcc;
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
-
-	vcc = ATM_SD(sock);
+	struct atm_vcc *vcc = ATM_SD(sock);
+	__poll_t mask = 0;
 
 	/* exceptional events */
 	if (sk->sk_err)
diff --git a/net/atm/common.h b/net/atm/common.h
index 5850649068bb..526796ad230f 100644
--- a/net/atm/common.h
+++ b/net/atm/common.h
@@ -17,7 +17,7 @@ int vcc_connect(struct socket *sock, int itf, short vpi, int vci);
 int vcc_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		int flags);
 int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len);
-__poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait);
+__poll_t vcc_poll_mask(struct socket *sock, __poll_t events);
 int vcc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int vcc_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int vcc_setsockopt(struct socket *sock, int level, int optname,
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index e1140b3bdcaa..930651c5e77c 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -114,7 +114,7 @@ static const struct proto_ops pvc_proto_ops = {
 	.socketpair =	sock_no_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	pvc_getname,
-	.poll =		vcc_poll,
+	.poll_mask =	vcc_poll_mask,
 	.ioctl =	vcc_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = vcc_compat_ioctl,
diff --git a/net/atm/svc.c b/net/atm/svc.c
index c458adcbc177..ad0e6ffb9cfe 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -637,7 +637,7 @@ static const struct proto_ops svc_proto_ops = {
 	.socketpair =	sock_no_socketpair,
 	.accept =	svc_accept,
 	.getname =	svc_getname,
-	.poll =		vcc_poll,
+	.poll_mask =	vcc_poll_mask,
 	.ioctl =	svc_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	svc_compat_ioctl,
-- 
2.14.2

