Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160641-2-13798981797361416960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160640; b=XbZVP7ZIe6r+dNxstdd4+2WTEl2zRH5nUh3fPfk7HLzH2c8Qov
    bJAWk/uW1N6Z1PhxHiPNlqP+6PO9DVbYp4CDX+YL4N3v0+pAWcl7cJ8JONNmFIf9
    lFM8YoY4EU7k01cVh1nrmhlpi0rDfUyrsS82Xrohc2mgEBUa9JdUpv6mqDFDg5BH
    vqiiER7aa/IkBptvj1ShA1Fa6bYU6X1wyzWa45KDGYyUbGVdfL3566IU+TziUb6t
    mJv8jbGum+7Aw0N2IX/JtBr26lW7wIiDizYMz5Ije37NsJTSaLSrSl8V3P0u1IGw
    ig6/6YfzqunmPfkkAX7Ryi9B9pRP2trXU75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160640; bh=R1FIvRD1FS0ZpMPZdEAW7s16gZ7rDM
    pNw+vVZGX/Z28=; b=DKCGeQ01+IMLFCboOWCMfNJWCPYGcf13TlhyfDJmTsFqd5
    RjXYLPpMRiZUjOqnPtqNt4ZApjilqniGWGbhrO6eAAVq+RR4oqvL3l2FrUlBPErg
    OtJuD4WZgqUOOgvlA/ubgBxsB001sVp5VeyaaaCylV9aJjKvJCbrVUA2ynR+sfoS
    gmaEudwuhaef2f7Fbjy4EcCqz5fWmQohW4VWOyN6EZsFGAGNFh9PsJ2OAgQS25+n
    mW5QySIPM6y6eP0L01u4ITzONjT9Tu/Q50GTo+E4dK+UckI90a3yE0LmOIc+WOY1
    6WiR6pA1cBRuzqO7d7MKDqwckWJ7L215sq7ztMzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tMCOdYvq x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=tMCOdYvq x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFL4ekFGD/LQqpPPFOt+7d56fXoB+7ZKiyJTKCFsHbaKUeLokLPN3wlEGAATkJPZ9pQo6j1+dQ5BNvpx/3eSc8C47mtATREqvyGFtrdxgyfp2kem7kzM
    VGuRoF89YhZx559tadXQQUM0CaAQrNZNXe3eg9JDLa6MQxC2UY/BGjxxoDzjSOiQwz0lK+vWboADKUOEqisk/giH2tUmM4siM9+6cy1saLc5rnka44vRDrWa
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=FOH2dFAWAAAA:8 a=ag1SF4gXAAAA:8 a=cQAtWQUi6B-pYIo_kuwA:9
    a=Ibcj2-IOhSrz7vQS:21 a=gaE_HL3gUnJGpc3D:21 a=QEXdDO2ut3YA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968033AbeEXLRR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968026AbeEXJxV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 049/165] loop: dont call into filesystem while holding lo_ctl_mutex
Date: Thu, 24 May 2018 11:37:35 +0200
Message-Id: <20180524093624.010834016@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit 2d1d4c1e591fd40bd7dafd868a249d7d00e215d5 upstream.

We hit an issue where a loop device on NFS was stuck in
loop_get_status() doing vfs_getattr() after the NFS server died, which
caused a pile-up of uninterruptible processes waiting on lo_ctl_mutex.
There's no reason to hold this lock while we wait on the filesystem;
let's drop it so that other processes can do their thing. We need to
grab a reference on lo_backing_file while we use it, and we can get rid
of the check on lo_device, which has been unnecessary since commit
a34c0ae9ebd6 ("[PATCH] loop: remove the bio remapping capability") in
the linux-history tree.

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1166,21 +1166,17 @@ loop_set_status(struct loop_device *lo,
 static int
 loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 {
-	struct file *file = lo->lo_backing_file;
+	struct file *file;
 	struct kstat stat;
-	int error;
+	int ret;
 
-	if (lo->lo_state != Lo_bound)
+	if (lo->lo_state != Lo_bound) {
+		mutex_unlock(&lo->lo_ctl_mutex);
 		return -ENXIO;
-	error = vfs_getattr(&file->f_path, &stat,
-			    STATX_INO, AT_STATX_SYNC_AS_STAT);
-	if (error)
-		return error;
+	}
+
 	memset(info, 0, sizeof(*info));
 	info->lo_number = lo->lo_number;
-	info->lo_device = huge_encode_dev(stat.dev);
-	info->lo_inode = stat.ino;
-	info->lo_rdevice = huge_encode_dev(lo->lo_device ? stat.rdev : stat.dev);
 	info->lo_offset = lo->lo_offset;
 	info->lo_sizelimit = lo->lo_sizelimit;
 	info->lo_flags = lo->lo_flags;
@@ -1193,7 +1189,19 @@ loop_get_status(struct loop_device *lo,
 		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
 		       lo->lo_encrypt_key_size);
 	}
-	return 0;
+
+	/* Drop lo_ctl_mutex while we call into the filesystem. */
+	file = get_file(lo->lo_backing_file);
+	mutex_unlock(&lo->lo_ctl_mutex);
+	ret = vfs_getattr(&file->f_path, &stat, STATX_INO,
+			  AT_STATX_SYNC_AS_STAT);
+	if (!ret) {
+		info->lo_device = huge_encode_dev(stat.dev);
+		info->lo_inode = stat.ino;
+		info->lo_rdevice = huge_encode_dev(stat.rdev);
+	}
+	fput(file);
+	return ret;
 }
 
 static void
@@ -1373,7 +1381,8 @@ static int lo_ioctl(struct block_device
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
-		break;
+		/* loop_get_status() unlocks lo_ctl_mutex */
+		goto out_unlocked;
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1382,7 +1391,8 @@ static int lo_ioctl(struct block_device
 		break;
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
-		break;
+		/* loop_get_status() unlocks lo_ctl_mutex */
+		goto out_unlocked;
 	case LOOP_SET_CAPACITY:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1543,7 +1553,7 @@ static int lo_compat_ioctl(struct block_
 		mutex_lock(&lo->lo_ctl_mutex);
 		err = loop_get_status_compat(
 			lo, (struct compat_loop_info __user *) arg);
-		mutex_unlock(&lo->lo_ctl_mutex);
+		/* loop_get_status() unlocks lo_ctl_mutex */
 		break;
 	case LOOP_SET_CAPACITY:
 	case LOOP_CLR_FD:
