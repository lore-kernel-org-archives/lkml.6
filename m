Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3454413-1521618550-2-3008474230007455041
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521618549; b=FKeDDyqc08ZL0FQwlSDnrOwkCwxBw1MXZlozSzKdg52AsZi
    bKM4QJeJWfDemWD2pIR/dViWq+2uq9td8egTucmV+AQmwY7gJixgxNuwH+Kfbesg
    F41NqGV754C6HnIRG67v1cymPWUBv0CrT0NW26czb9OEAjj8Of3+BAhbFzOSlOby
    IO/F8UIXDMNy5FhvE5vWMh7KpfUl2F7jCZv8ssZ9KJvXJFdHtJJFzwEvpf3VnkMg
    HU4RRlYLOh+g5cTqrPH1yuL4y8QGe7PLAq9tYdSZBNamQqFo4G1HyXCpoPbyMK+f
    Gb7w621I4gjbWviLOL2N+mPMPu7k/0prkMxcJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618549;
    bh=rTfn2iSlPAvRyX7XbGaMsNayUW07yqL4zxp48lHDrzQ=; b=RHOI4KYhKrXs
    8OLPvLdrHRKxzZFR+VqOLCJDTvhCAjZ1+bRPruGlBHWdYYDCqiLf0fq9TCk6TEhM
    GAJMhNcBQbdp2jhUxqfYCc0sEXf8wz/IDE732biLTFaP/Rovcxw3+O+Qa3MiZNwP
    MvQhekEBhyptTCOWv3iu1Ep9P7BRkl5SXUrtWhQhy5iEUTIMOMA5LQGZ6FPNwfk6
    vZJL5ihmB+SvSLdA3rEv46ucpeaF3zgZuDD+0BrYP/6lJ1nBXR3sD50NdIcHXOxW
    ylCEXG+4WhI8rKE0kUgbq8x1+jpn82xivProU0go4Tt9VVljahlGtLCQT91D2kPX
    YvvjFID9vw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=PyRIbpY4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=PyRIbpY4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeCUHtB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:49:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeCUHlP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:41:15 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/28] net: remove sock_no_poll
Date: Wed, 21 Mar 2018 08:40:13 +0100
Message-Id: <20180321074032.14211-10-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321074032.14211-1-hch@lst.de>
References: <20180321074032.14211-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that sock_poll handles a NULL ->poll or ->poll_mask there is no need
for a stub.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/af_alg.c             | 1 -
 crypto/algif_hash.c         | 2 --
 crypto/algif_rng.c          | 1 -
 drivers/isdn/mISDN/socket.c | 1 -
 drivers/net/ppp/pptp.c      | 1 -
 include/net/sock.h          | 2 --
 net/bluetooth/bnep/sock.c   | 1 -
 net/bluetooth/cmtp/sock.c   | 1 -
 net/bluetooth/hidp/sock.c   | 1 -
 net/core/sock.c             | 6 ------
 10 files changed, 17 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index c49766b03165..50d75de539f5 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -347,7 +347,6 @@ static const struct proto_ops alg_proto_ops = {
 	.sendpage	=	sock_no_sendpage,
 	.sendmsg	=	sock_no_sendmsg,
 	.recvmsg	=	sock_no_recvmsg,
-	.poll		=	sock_no_poll,
 
 	.bind		=	alg_bind,
 	.release	=	af_alg_release,
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 6c9b1927a520..bfcf595fd8f9 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -288,7 +288,6 @@ static struct proto_ops algif_hash_ops = {
 	.mmap		=	sock_no_mmap,
 	.bind		=	sock_no_bind,
 	.setsockopt	=	sock_no_setsockopt,
-	.poll		=	sock_no_poll,
 
 	.release	=	af_alg_release,
 	.sendmsg	=	hash_sendmsg,
@@ -396,7 +395,6 @@ static struct proto_ops algif_hash_ops_nokey = {
 	.mmap		=	sock_no_mmap,
 	.bind		=	sock_no_bind,
 	.setsockopt	=	sock_no_setsockopt,
-	.poll		=	sock_no_poll,
 
 	.release	=	af_alg_release,
 	.sendmsg	=	hash_sendmsg_nokey,
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 150c2b6480ed..22df3799a17b 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -106,7 +106,6 @@ static struct proto_ops algif_rng_ops = {
 	.bind		=	sock_no_bind,
 	.accept		=	sock_no_accept,
 	.setsockopt	=	sock_no_setsockopt,
-	.poll		=	sock_no_poll,
 	.sendmsg	=	sock_no_sendmsg,
 	.sendpage	=	sock_no_sendpage,
 
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index c5603d1a07d6..c84270e16bdd 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -746,7 +746,6 @@ static const struct proto_ops base_sock_ops = {
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 6dde9a0cfe76..87f892f1d0fe 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -627,7 +627,6 @@ static const struct proto_ops pptp_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept     = sock_no_accept,
 	.getname    = pptp_getname,
-	.poll       = sock_no_poll,
 	.listen     = sock_no_listen,
 	.shutdown   = sock_no_shutdown,
 	.setsockopt = sock_no_setsockopt,
diff --git a/include/net/sock.h b/include/net/sock.h
index 169c92afcafa..d9249fe65859 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1585,8 +1585,6 @@ int sock_no_connect(struct socket *, struct sockaddr *, int, int);
 int sock_no_socketpair(struct socket *, struct socket *);
 int sock_no_accept(struct socket *, struct socket *, int, bool);
 int sock_no_getname(struct socket *, struct sockaddr *, int *, int);
-__poll_t sock_no_poll(struct file *, struct socket *,
-			  struct poll_table_struct *);
 int sock_no_ioctl(struct socket *, unsigned int, unsigned long);
 int sock_no_listen(struct socket *, int);
 int sock_no_shutdown(struct socket *, int);
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index b5116fa9835e..00deacdcb51c 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -175,7 +175,6 @@ static const struct proto_ops bnep_sock_ops = {
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
index ce86a7bae844..e08f28fadd65 100644
--- a/net/bluetooth/cmtp/sock.c
+++ b/net/bluetooth/cmtp/sock.c
@@ -178,7 +178,6 @@ static const struct proto_ops cmtp_sock_ops = {
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 008ba439bd62..1eaac01f85de 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -208,7 +208,6 @@ static const struct proto_ops hidp_sock_ops = {
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff --git a/net/core/sock.c b/net/core/sock.c
index c501499a04fe..b72b6ad050e4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2503,12 +2503,6 @@ int sock_no_getname(struct socket *sock, struct sockaddr *saddr,
 }
 EXPORT_SYMBOL(sock_no_getname);
 
-__poll_t sock_no_poll(struct file *file, struct socket *sock, poll_table *pt)
-{
-	return 0;
-}
-EXPORT_SYMBOL(sock_no_poll);
-
 int sock_no_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	return -EOPNOTSUPP;
-- 
2.14.2

