Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2689340-1527001776-2-2534560834274923802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527001775; b=Wfsa9w2I6T4TjNpIoqx/g6IrQjznOAkW4BeHGoaNlZxI7+yEhQ
    D7D+yu95sNrr1XGXE0egoVrLavfCZLCkPaJ4COfhmxLY5A4sukMLmU8H0aLRbDDe
    J+0bd8px3c2nYZkGWkJXH/hSsSZxQMzSFRUjbvNKDuyRjHQmOd54RkDGVL3A7F2z
    hwqhRSk7ymWBZ4eS9hAscLPWZ1zt19dVBGyuFCtevrY8tIdF0VWY07NnmtiCIXiZ
    ijyHypFdnqtqgpDLUpedFXAEL83uSqgA+Erx8t0sM7OA0v6Pwx50lMoWKid62c62
    TkYbrmNRO+/dh+1yQ8jhAdAkoRBOhCaC5L9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527001775; bh=
    u63zu6+30qt2WYNh/uO7jFBrpUw0lMmMHP5KHn4D28I=; b=AFFPpZLRpx4rZeLn
    E/ZuzczegprzEPeB1WfYIBChigip43urxH2C4cUkuDAXDvdetPwJFvTgF05LIGFX
    9PT1eiLbtK7jD1mmPOzI49ZsBuxGPtg2Eny7YiReNzQYrV00i6JAvUlu1MdCM/in
    gPr0/dMj5jrqVNVmVCg/NMRjkZXKDV1+E3UJBtZpzwkHiRNyIDJCK0S31srwZbMw
    amE6h8EQe6ZMTBDmFbj47nbgk2M4wUk+P2ChgPG26usBU1YMHlGSvwKM/oHu0x+f
    f0GeZyGgxzho1uZ1DF0liCoO73LaN/MbkxVsOI/svTTUFVRcCwoAT2vlbskHSd7P
    s7pg7A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=PUYK32aL x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=PUYK32aL x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKg2ans1PQ8MPeDAbPHhD953Qcfu51xhc5zYOx6Dc+SYTdh2rULEu3E0wIy6es/kdpnjP5G+BmPjq9rLZj3EXfrOSSGXZ8sdI7/0I9aNOzUNsuBFTOsn
    7m7d/o6kaWVI+qNltxyVW14rXokXAMZXhoZwZYuN2mXJNOAaliT2F5AWSUd/G0My7+I5NoTFVIqwqSW/8wyNMzSCHBIf8Il8RMch4j/8Dz7pC7VRYq3yPkIh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=VwQbUJbxAAAA:8 a=7YVJ-hDRUNwIsF-CY9wA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbeEVPJU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:09:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14393 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeEVPH4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 11:07:56 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="79548771"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: tglx@linutronix.de, mingo@kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, jack@suse.cz, darrick.wong@oracle.com,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v6 4/5] fs: blkdev set bio prio from kiocb prio
Date: Tue, 22 May 2018 08:07:36 -0700
Message-Id: <20180522150737.9893-5-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180522150737.9893-1-adam.manzanares@wdc.com>
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

Now that kiocb has an ioprio field copy this over to the bio when it is
created from the kiocb.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 fs/block_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e27065..11ba99e79d2a 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -216,6 +216,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio.bi_write_hint = iocb->ki_hint;
 	bio.bi_private = current;
 	bio.bi_end_io = blkdev_bio_end_io_simple;
+	bio.bi_ioprio = iocb->ki_ioprio;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -355,6 +356,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_write_hint = iocb->ki_hint;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
+		bio->bi_ioprio = iocb->ki_ioprio;
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
-- 
2.15.1

