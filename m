Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324190-2-7901061988283752520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324189; b=W2g4HJqHuRexFzgeWz1evh/i+SWv3GMQQSBDADfP2k2BcaF
    uob722+QFWZrI1RHRt3B90EBlaaZLj+CCSkRvayCd5oS+e9YRPt+5C9VmLBOFVLI
    O9FNHD8vbKHsnuxuu84I0FWgpj3OVZwZ1mokHbWnJVQBjU/7mKWEdbL5QMPgBrD3
    qrR7JZO30NQZmkR8CjFsZtnlEzq8Vvzp40/lFOxYISe7iMBJ7RaV65CAfafY0qf5
    Cbv8L4jR6T6n6u1ZdB/GHCqHaE9/+G3JBO+mjbXBLbKAP+N6Zm/AGc6wLvuz9r81
    RttN7HbDK84GMxFQkmVqTTQGPpsqXMDwTY8bOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324189; bh=tP9NnphHyCRfj4n76pK
    QU05CsAMVQR/j111BICp4pUQ=; b=UcASVdnHcwa8fhXjlOOx5pUNKxjI6uTY2UC
    29K/bSs3pj01QDDXao1MZXxUGf47Q74K3VgsGw2T7B/L6XcvQUUPLyVihEm1CIuK
    ayW4kCbl/F3ktIE9wGIlLaJAcGF/+jK9bBA4pZ2hf1kqxc/JjHZlKOg8PCh3ropw
    ZaRaVSFDqoqX+ipEiVQKbYCNPVrf4/dakDRKMssQJWqg8A1Gp1KVYnt2BTyezYzT
    ufBOLA8xSDuDT33iZm658cQdvYVdpDb4gN0/2iz26PnQeX/bkrROM9hL9VOHzpd0
    iZ6LHeWG/dJUbpal/tLATGiTfEn46sNz3B6jDnH8cpByD357HWQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeBKEnF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:43:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41896 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752875AbeBKEd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Dmitry Vyukov" <dvyukov@google.com>,
        "Jens Axboe" <axboe@kernel.dk>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.147037335@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 076/136] blktrace: fix unlocked access to
 init/start-stop/teardown
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 1f2cac107c591c24b60b115d6050adc213d10fc0 upstream.

sg.c calls into the blktrace functions without holding the proper queue
mutex for doing setup, start/stop, or teardown.

Add internal unlocked variants, and export the ones that do the proper
locking.

Fixes: 6da127ad0918 ("blktrace: Add blktrace ioctls to SCSI generic devices")
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/blktrace.c | 58 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 10 deletions(-)

--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -307,7 +307,7 @@ static void blk_trace_cleanup(struct blk
 		blk_unregister_tracepoints();
 }
 
-int blk_trace_remove(struct request_queue *q)
+static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
@@ -320,6 +320,17 @@ int blk_trace_remove(struct request_queu
 
 	return 0;
 }
+
+int blk_trace_remove(struct request_queue *q)
+{
+	int ret;
+
+	mutex_lock(&q->blk_trace_mutex);
+	ret = __blk_trace_remove(q);
+	mutex_unlock(&q->blk_trace_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_trace_remove);
 
 static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
@@ -536,9 +547,8 @@ err:
 	return ret;
 }
 
-int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-		    struct block_device *bdev,
-		    char __user *arg)
+static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
+			     struct block_device *bdev, char __user *arg)
 {
 	struct blk_user_trace_setup buts;
 	int ret;
@@ -557,6 +567,19 @@ int blk_trace_setup(struct request_queue
 	}
 	return 0;
 }
+
+int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
+		    struct block_device *bdev,
+		    char __user *arg)
+{
+	int ret;
+
+	mutex_lock(&q->blk_trace_mutex);
+	ret = __blk_trace_setup(q, name, dev, bdev, arg);
+	mutex_unlock(&q->blk_trace_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_trace_setup);
 
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
@@ -593,7 +616,7 @@ static int compat_blk_trace_setup(struct
 }
 #endif
 
-int blk_trace_startstop(struct request_queue *q, int start)
+static int __blk_trace_startstop(struct request_queue *q, int start)
 {
 	int ret;
 	struct blk_trace *bt = q->blk_trace;
@@ -632,6 +655,17 @@ int blk_trace_startstop(struct request_q
 
 	return ret;
 }
+
+int blk_trace_startstop(struct request_queue *q, int start)
+{
+	int ret;
+
+	mutex_lock(&q->blk_trace_mutex);
+	ret = __blk_trace_startstop(q, start);
+	mutex_unlock(&q->blk_trace_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_trace_startstop);
 
 /*
@@ -662,7 +696,7 @@ int blk_trace_ioctl(struct block_device
 	switch (cmd) {
 	case BLKTRACESETUP:
 		bdevname(bdev, b);
-		ret = blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
+		ret = __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
@@ -673,10 +707,10 @@ int blk_trace_ioctl(struct block_device
 	case BLKTRACESTART:
 		start = 1;
 	case BLKTRACESTOP:
-		ret = blk_trace_startstop(q, start);
+		ret = __blk_trace_startstop(q, start);
 		break;
 	case BLKTRACETEARDOWN:
-		ret = blk_trace_remove(q);
+		ret = __blk_trace_remove(q);
 		break;
 	default:
 		ret = -ENOTTY;
@@ -694,10 +728,14 @@ int blk_trace_ioctl(struct block_device
  **/
 void blk_trace_shutdown(struct request_queue *q)
 {
+	mutex_lock(&q->blk_trace_mutex);
+
 	if (q->blk_trace) {
-		blk_trace_startstop(q, 0);
-		blk_trace_remove(q);
+		__blk_trace_startstop(q, 0);
+		__blk_trace_remove(q);
 	}
+
+	mutex_unlock(&q->blk_trace_mutex);
 }
 
 /*
