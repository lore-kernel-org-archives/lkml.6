Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2624115-1520285620-2-15857664877513104725
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
    t=1520285619; b=mYMAqK1YOY6qoa1k5nM/BJ73/bG6Q0bN2+J+LTFullks5iX
    moEXt9h9Vq4Sq7Tmz1mf5pKvQ0lLacUI+LyStBfEwyIIhuAGxa14A6Xm8ub7wTa7
    r0Woz5/rMfV1djMjmfsnSqialjzxtST1b7tN720Q9bhN9v3RRTJTmCpNGjnC/znL
    QBNQR7bLU0+ANr3H/FOX7MicPPK/SEHtfyYpcxrhmatWyxXHm30teTTWyAVVBdk8
    iDYCQBvaB5OU/Hlip9+iG2sJkRSA7D+VwcsOEG5baust3u2GR54VdU7Dk1lVBZ4X
    HkpDl/OivM6VY/GWSUT5UTBGnritSOvJezHPjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520285619;
    bh=1p7l/B0qizGynkbosMja/QlZ9F4hcVlLlfiedQ14Iao=; b=voLUjdWPKoHC
    E2zUPavVgg+gza3Dy67u+oF7/yWmMia3Ga27U+L6TfYSabAE5MtzBVmaGK3Gkssv
    QX7hX5/gVvX9eMJkBMAt55tGbVZHYX8X88QdTE2OBr+ObYfBFca9lT0lXueP1F3k
    t3ogfVLSMcCnb+2Ny4iyAHDAc2Jsr/wTY5Fdv7strjyTSz/RJX6O20eQgi4AQPHL
    agzARQGM72UilB3l4Jbasbox+EGBOO5LZqmnk/PyoS1wwXLdmUoFNaeBs0WS25Cy
    /xnbhGvL+0gOvl0PAz5NhnWGB4ToW4UnJ/NLOq9eOMR5G3penyIifD+Dup3aBPei
    wmd5upUqDQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=rPRVT9db x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=rPRVT9db x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeCEVdQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:33:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeCEV14 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:56 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/36] net/atm: convert to ->poll_mask
Date: Mon,  5 Mar 2018 13:27:29 -0800
Message-Id: <20180305212743.16664-23-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
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

