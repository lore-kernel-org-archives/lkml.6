Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3729524-1523494318-2-14840588008924990321
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, URIBL_SBL 1.623, URIBL_SBL_A 0.1,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523494318; b=eJZIm5Dar7qGfz/si9lXpA+kXj3PyWKKj+7MYczg6n+FRumTFH
    L5IzKixL8N/f44kMlm5U88uLonHHdA+xECMcKpI/RwGQsALIMGGlpIEi/Vwu6dPA
    mGmt+BcDWyKMd6EWgQspC1dPUv9JsTGIWma32dYbLIxwwQk3LE3OKM/IY8V2SJnl
    Wsy/JxI81pnsWrxgnQd66GC1K3Vuf6E9uIy6TlcKfJIp3OuL6dnBTwilO/wdzI3g
    /dyLjPd7cncxGRqvmf+p+aqZ5aLD4o6PAyxZ+0IBT1do70icJhcYWxDfN8TYFIPu
    MDbpqoahrk2QNLeNUQ4hmHcyF90UgzQLLgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494318; bh=UtlEh
    h2Ew2nkQlGgXwZ70GgGB6RaWEiTH5qBm4QYyCA=; b=J8NCXamaoMyPqMxe8ok8c
    /Au8x3t6B2fRa/scydiH3SbSVxuuILVuv1FsQJM8ACUFr0f5MO3RsAnI/Zk8ly5x
    6/8wBpX3PFLOiJ/8Frm2NXb9cbGKdDYgKTJh1KbQ9/aoSnpPnHA6iFJr8BvWtuMX
    6VjM8EMljFzeD1aduFc9Xr6XOo38Q1y3FpK2jgLB4/CXW1rUacECdLmAuRw1rbPi
    rcGchuRHsICiLRM5WXTSz1fuO/71yD2mqCi+bvWNagZl2QdHFInYwpAb1PgqSMVY
    Kjk8cfhVeqmjhfFbGbT7ejC5HEaa75SxCrFk7cPA+NlSExjLd4GoEIBbnyYM99J+
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHURDdyyJVac0m0Q0v5iMJmqCI5BVITr7AYI7qNh9g3ozDF2RK9DQXu+5RjO96J1qQzIqFfKbY/1obDTsl4nYmyAOM0DL5l8d/0fu5c2WOqZr4bcdPSN
    QpS3ongiPs/X8JLSf5/IXaMhYRCtZWSgaZOR4ZEWJgrFnVaAED8tgvDdfM/G2AnEJUo2+aQ3hPBiVIdOGYCvHXXWYPXIskC+qPVhPACaZ82s6I6iE0xLb2Nx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=8981fWPbAAAA:8 a=tBb2bbeoAAAA:8
    a=W19_s1xktO1MWphDU8cA:9 a=AjGcO6oz07-iQ99wixmX:22 a=o72u2rHnfW5qNJ_4I8LD:22
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeDLAvc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:51:32 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39810 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbeDLAuQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:16 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <71b97421bda9d3772d6238297b3c93ecd881309b.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 05/10] block/swim: Remove extra put_disk() call from error
 path
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Fixes: 103db8b2dfa5 ("[PATCH] swim: stop sharing request queue across multiple gendisks")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/block/swim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 2cdfc0db5966..0258a96e0c46 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -861,7 +861,6 @@ static int swim_floppy_init(struct swim_priv *swd)
 							      &swd->lock);
 		if (!swd->unit[drive].disk->queue) {
 			err = -ENOMEM;
-			put_disk(swd->unit[drive].disk);
 			goto exit_put_disks;
 		}
 		blk_queue_bounce_limit(swd->unit[drive].disk->queue,
-- 
2.16.1
