Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2624115-1520285318-3-7251408962360570370
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520285318; b=jdSFl+bNJ2BepBXzoSMSrzgS8NsJj76Fa0fdVZ/4H2LIi3+
    JsVHgH9QTC2pOde/44jRRSHZ6d+X48U+Swnd3KqLBlfNFfYXgd1dO/D41AVLcMzE
    0YNGNMPouN9p8wxWkSMmkLvfPoFbF3r+Zndr3CSlw5stYnIPnFiylvIGwvMBAa6M
    WpBH2CMVwbnD2o9X22ZLDR0Buxm/Tt3MtY4xcWt8H86i/G0jjpiLKlQd6G+kir3T
    UZOFCwgUIK9r64F938DTODCf5a4rMZMeaYlL7uR/1KB0QcXyimvnQ8u4ZK8/VOZG
    ZaqhNuIlsJ6H44a99SQY4bhZwFU8yISQ26GB3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520285318;
    bh=bSPGcsV9xHYATKBliDJcmY5rY/+K1a1F+DHpC/3SdIA=; b=j5Iyl/QX4aam
    Q5CiqWPFSIyjIUGRqJRLzEc53h8dayUPbTzNj2Epp59p0ZRyyMuFeYmPCmzfGEda
    4vPKHMdFGSXp7SgPkM5jXKzY5eQq8rBPjpDo19x3ZXIt6aqtAdQCVBUfKHEwq4sy
    NxlrE3l4sv1wTnBZxR5Gdw4+caQRN4+uzHFhMOrTn4ZktAsbEmN69L2kev/7pjpy
    F+4Jj79mkZMKTbF4PeLz1laY0vH3mJlYAahnSrAabsyqvXN07JqluF9DsbVvogwy
    5+nEw44VxskdHQaW/GWpCCpzKJvRWvD1ybFjPuvhP2K4ey1u4eKYO5DtQQ1DiApC
    ax0spLucVg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Cgsd0rQs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Cgsd0rQs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeCEV2Q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:28:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeCEV2C (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:28:02 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 36/36] random: convert to ->poll_mask
Date: Mon,  5 Mar 2018 13:27:43 -0800
Message-Id: <20180305212743.16664-37-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The big change is that random_read_wait and random_write_wait are merged
into a single waitqueue that uses keyed wakeups.  Because wait_event_*
doesn't know about that this will lead to occassional spurious wakeups
in _random_read and add_hwgenerator_randomness, but wait_event_* is
designed to handle these and were are not in a a hot path there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/char/random.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e5b3d3ba4660..840d80b64431 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -401,8 +401,7 @@ static struct poolinfo {
 /*
  * Static global variables
  */
-static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
-static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
+static DECLARE_WAIT_QUEUE_HEAD(random_wait);
 static struct fasync_struct *fasync;
 
 static DEFINE_SPINLOCK(random_ready_list_lock);
@@ -710,7 +709,7 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 
 		/* should we wake readers? */
 		if (entropy_bits >= random_read_wakeup_bits) {
-			wake_up_interruptible(&random_read_wait);
+			wake_up_interruptible_poll(&random_wait, POLLIN);
 			kill_fasync(&fasync, SIGIO, POLL_IN);
 		}
 		/* If the input pool is getting full, send some
@@ -1293,7 +1292,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 	trace_debit_entropy(r->name, 8 * ibytes);
 	if (ibytes &&
 	    (r->entropy_count >> ENTROPY_SHIFT) < random_write_wakeup_bits) {
-		wake_up_interruptible(&random_write_wait);
+		wake_up_interruptible_poll(&random_wait, POLLOUT);
 		kill_fasync(&fasync, SIGIO, POLL_OUT);
 	}
 
@@ -1748,7 +1747,7 @@ _random_read(int nonblock, char __user *buf, size_t nbytes)
 		if (nonblock)
 			return -EAGAIN;
 
-		wait_event_interruptible(random_read_wait,
+		wait_event_interruptible(random_wait,
 			ENTROPY_BITS(&input_pool) >=
 			random_read_wakeup_bits);
 		if (signal_pending(current))
@@ -1784,14 +1783,17 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	return ret;
 }
 
+static struct wait_queue_head *
+random_get_poll_head(struct file *file, __poll_t events)
+{
+	return &random_wait;
+}
+
 static __poll_t
-random_poll(struct file *file, poll_table * wait)
+random_poll_mask(struct file *file, __poll_t events)
 {
-	__poll_t mask;
+	__poll_t mask = 0;
 
-	poll_wait(file, &random_read_wait, wait);
-	poll_wait(file, &random_write_wait, wait);
-	mask = 0;
 	if (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (ENTROPY_BITS(&input_pool) < random_write_wakeup_bits)
@@ -1890,7 +1892,8 @@ static int random_fasync(int fd, struct file *filp, int on)
 const struct file_operations random_fops = {
 	.read  = random_read,
 	.write = random_write,
-	.poll  = random_poll,
+	.get_poll_head  = random_get_poll_head,
+	.poll_mask  = random_poll_mask,
 	.unlocked_ioctl = random_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
@@ -2223,7 +2226,7 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	 * We'll be woken up again once below random_write_wakeup_thresh,
 	 * or when the calling thread is about to terminate.
 	 */
-	wait_event_interruptible(random_write_wait, kthread_should_stop() ||
+	wait_event_interruptible(random_wait, kthread_should_stop() ||
 			ENTROPY_BITS(&input_pool) <= random_write_wakeup_bits);
 	mix_pool_bytes(poolp, buffer, count);
 	credit_entropy_bits(poolp, entropy);
-- 
2.14.2

