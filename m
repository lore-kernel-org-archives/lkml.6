Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3454413-1521618080-2-17290711566825261956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521618080; b=G1rJIcXr6FdRukxKgK7O/WqdR17yUY0W4Kt02NlY01tIYK/
    kOG1I9Crt4bmxbWBk2bS5jy9tnO3iiAFAAKvEBYnPD+Iu5jFVLy7HxiHhTJsDoST
    J8ESis8SeeoZerCR3kHN10pJicB6NFANMcY+Jmbj5PtNds0YYP/jtOGmhBRvp0Qv
    wg29WwssLus43TTPq6F6F/EQ7YQufWeoAliEGFK17VBPonjAvnGKya6NH0AVzpFE
    DN/L7epMZ22YsVjnvnelQMw1y+zprIMgJ+kK+QjP8uWsATu3kLbBB1ryQ2Ct84zH
    nYtRJt029Un8wHdX99eofNPR/ueKyLPvdmAyVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618080;
    bh=Bs2nuDITYvKxgF4k131QgwDUoPHOUkpwoTo70bP5DqU=; b=GKX7Z+fI+IEC
    QJdI6PFyaGnhOf1vTo4xYX94hSvAvT+L//oEpSLLllcTL4Pv7z9BUmGs46phmJRU
    lxymT832mCgzdVQRmQB9BD+AqlQla3R0h/Q+BXo57pfkxl/+Zw5qO0XxurlAfktl
    ki3FEKao1EHVfSyxYNihgCeriMfO0WrkKdAsjc0JeBNZ8UBDw7ADnpZ57S+b3qUL
    llt0MyGYtEwCBOUHhOq7U2PWdGFCEwyJgcvqo/Hr1EbfHgRCeFvF3Q2Fqv2xjtwd
    GdkbaJQKM7KbGa0/2acObCyty8dfEsb+v7IO6E1oiYawTTuTSWVh4/jDxFrwkY7R
    jXzJfvHD5g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=OVdjVNtN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=OVdjVNtN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeCUHlQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:41:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCUHlM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:41:12 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/28] net: add support for ->poll_mask in proto_ops
Date: Wed, 21 Mar 2018 08:40:12 +0100
Message-Id: <20180321074032.14211-9-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321074032.14211-1-hch@lst.de>
References: <20180321074032.14211-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The socket file operations still implement ->poll until all protocols are
switched over.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/net.h |  3 +++
 net/socket.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 91216b16feb7..ce3d4dacb51e 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -147,6 +147,9 @@ struct proto_ops {
 	int		(*getname)   (struct socket *sock,
 				      struct sockaddr *addr,
 				      int *sockaddr_len, int peer);
+	struct wait_queue_head *(*get_poll_head)(struct socket *sock,
+				      __poll_t events);
+	__poll_t	(*poll_mask) (struct socket *sock, __poll_t events);
 	__poll_t	(*poll)	     (struct file *file, struct socket *sock,
 				      struct poll_table_struct *wait);
 	int		(*ioctl)     (struct socket *sock, unsigned int cmd,
diff --git a/net/socket.c b/net/socket.c
index 3f859a07641a..ceb69ddcd7bd 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -118,8 +118,10 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from);
 static int sock_mmap(struct file *file, struct vm_area_struct *vma);
 
 static int sock_close(struct inode *inode, struct file *file);
-static __poll_t sock_poll(struct file *file,
-			      struct poll_table_struct *wait);
+static struct wait_queue_head *sock_get_poll_head(struct file *file,
+		__poll_t events);
+static __poll_t sock_poll_mask(struct file *file, __poll_t);
+static __poll_t sock_poll(struct file *file, struct poll_table_struct *wait);
 static long sock_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 #ifdef CONFIG_COMPAT
 static long compat_sock_ioctl(struct file *file,
@@ -142,6 +144,8 @@ static const struct file_operations socket_file_ops = {
 	.llseek =	no_llseek,
 	.read_iter =	sock_read_iter,
 	.write_iter =	sock_write_iter,
+	.get_poll_head = sock_get_poll_head,
+	.poll_mask =	sock_poll_mask,
 	.poll =		sock_poll,
 	.unlocked_ioctl = sock_ioctl,
 #ifdef CONFIG_COMPAT
@@ -1114,14 +1118,51 @@ int sock_create_lite(int family, int type, int protocol, struct socket **res)
 }
 EXPORT_SYMBOL(sock_create_lite);
 
+static struct wait_queue_head *sock_get_poll_head(struct file *file,
+		__poll_t events)
+{
+	struct socket *sock = file->private_data;
+
+	if (!sock->ops->poll_mask)
+		return NULL;
+	if (sock->ops->get_poll_head)
+		return sock->ops->get_poll_head(sock, events);
+
+	sock_poll_busy_loop(sock, events);
+	return sk_sleep(sock->sk);
+}
+
+static __poll_t sock_poll_mask(struct file *file, __poll_t events)
+{
+	struct socket *sock = file->private_data;
+
+	/*
+	 * We need to be sure we are in sync with the socket flags modification.
+	 *
+	 * This memory barrier is paired in the wq_has_sleeper.
+	 */
+	smp_mb();
+
+	/* this socket can poll_ll so tell the system call */
+	return sock->ops->poll_mask(sock, events) |
+		(sk_can_busy_loop(sock->sk) ? POLL_BUSY_LOOP : 0);
+}
+
 /* No kernel lock held - perfect */
 static __poll_t sock_poll(struct file *file, poll_table *wait)
 {
 	struct socket *sock = file->private_data;
-	__poll_t events = poll_requested_events(wait);
+	__poll_t events = poll_requested_events(wait), mask = 0;
 
-	sock_poll_busy_loop(sock, events);
-	return sock->ops->poll(file, sock, wait) | sock_poll_busy_flag(sock);
+	if (sock->ops->poll) {
+		sock_poll_busy_loop(sock, events);
+		mask = sock->ops->poll(file, sock, wait);
+	} else if (sock->ops->poll_mask) {
+		sock_poll_wait(file, sock_get_poll_head(file, events), wait);
+		mask = sock->ops->poll_mask(sock, events);
+	}
+
+	return mask | sock_poll_busy_flag(sock);
 }
 
 static int sock_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.14.2

