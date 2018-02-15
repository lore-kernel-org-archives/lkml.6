Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710458-2-13918435966334577665
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710457; b=JDarxCKGSZLm1A+UmIuQ6GYk28PIuqydFjHaXDqvMxFUL+f
    y0kic8cwgKedngCrer2TQCl9cdcf5coJQrDITJ4GIzaup9B8lPWlkvOgG8GHgcJ7
    UkXdrC7fZis6ILYxopti6dWG+X4hzHbLVT9JZtw9YjRTBzbFrxc/aAzvteL4A1cS
    k+vbIHJjLGgCB+uQ+lbrrvGoN1kOicwcd6CbluzE+GCC61XhbUxFdI1K4tT8zmwx
    4kWSV6hhfikr7gzIUjid0GNp6s/D88o9Lv6ZeGP0cbI6aanUsgjiu4YgMQ2u3yM0
    5WyPhA/PDvpDuH1ib4yzZPzTSGjUcsZ2+P9LXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710457; bh=1YP4+y/Wb4vE3XCX1BI/FDmMxm
    IpjaWNr0jpEYBmufk=; b=CjvrA9Z6l89MbW4/fs5dfma0m6/OQDbqofHkSc7fFY
    bve5Mfg6obpaEmBCv7bTHgY25QrdLmgKyhPLVZGGrOhwnLC37saI2/bhNPt5t8Xw
    U6KznKDcfRyAfCehHezkNkFjz8DqYRnALJMbuxZ2Hc4R0s2hlbbFN8lJL6GNDxIo
    au8JqkhCg67DVQ5qK77NHjyFLXLq7Zc4nJ7E3R9L/Bd6xPh8DW3/91au7uCe4kad
    nplOM078x9tXZhSYgTvwa1HlC9dpA2q/4RYhgnknS3lJNGmYGjR5PGC71X9zdU0E
    h4PN8brWRmuFr3A9WzUBDEzXX2UW8B2SGzoB/1H8Yq/A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424785AbeBOPq5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424749AbeBOPq4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 182/202] pktcdvd: Fix a recently introduced NULL pointer dereference
Date: Thu, 15 Feb 2018 16:18:02 +0100
Message-Id: <20180215151722.375063493@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 882d4171a8950646413b1a3cbe0e4a6a612fe82e upstream.

Call bdev_get_queue(bdev) after bdev->bd_disk has been initialized
instead of just before that pointer has been initialized. This patch
avoids that the following command

pktsetup 1 /dev/sr0

triggers the following kernel crash:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000548
IP: pkt_setup_dev+0x2db/0x670 [pktcdvd]
CPU: 2 PID: 724 Comm: pktsetup Not tainted 4.15.0-rc4-dbg+ #1
Call Trace:
 pkt_ctl_ioctl+0xce/0x1c0 [pktcdvd]
 do_vfs_ioctl+0x8e/0x670
 SyS_ioctl+0x3c/0x70
 entry_SYSCALL_64_fastpath+0x23/0x9a

Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: commit ca18d6f769d2 ("block: Make most scsi_req_init() calls implicit")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/pktcdvd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2579,14 +2579,14 @@ static int pkt_new_dev(struct pktcdvd_de
 	bdev = bdget(dev);
 	if (!bdev)
 		return -ENOMEM;
+	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
+	if (ret)
+		return ret;
 	if (!blk_queue_scsi_passthrough(bdev_get_queue(bdev))) {
 		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
-		bdput(bdev);
+		blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
 		return -EINVAL;
 	}
-	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
-	if (ret)
-		return ret;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
