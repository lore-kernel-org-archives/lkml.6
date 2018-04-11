Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523480267-2-4580783955923285660
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523480266; b=OShMtJlIZAJDRsvAT2hBA7Uemh99e7mq9IpIc7YPm05XgG3H2y
    qRsMiDGmHQG14tfrnq24CJe8XSEBtboQC4k2AowfPLwsVpCpkHcnfs+quwDiHgqr
    pXdOtri7hvKNttHdqtchYBxfFU6y9Rh6F9TUMlVavW57kfj3LYPlhYDyuu6dIs+c
    wFmQHyO9wS+w5pPu2fpEv7kncIsp0t6mDodxd276BMSq1n6ajLfcMQd5YOQJ9aWj
    ra6e/DoqK6ggoNjJ8x8TDAUVuXtPU5pm+bivHUJ3Ule/WqsIlFokT2hL1Pxqkn5x
    DeSZdspZYprdGE4HdSQCGq+1388KV2BddLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480266; bh=92pfwNIIjAHjHbSAwPc3QeQG5XQNyx
    yvv9WjZMfjGjo=; b=rEkPZFdNy8EyxOv+u0VhtPuppYML7u8zstNgrSEBahUe70
    o/wlf0MyVCfi3vBASZEpDlQPYVrTG8zc6lSIORz2f/kg8BcEpQQyH+XHu+OSbHgJ
    CFt5dBQmc7C94J+MquP45XQXaOGse7dv3eNDKV/nWGLV9FtRr4AFlzRWTNfskCZe
    fOQpxTpdc9TNXWrteZnAmN5swLl8SjATHIbYDaoD7ZirLGvKIWiobvvOWxIhGpRJ
    b0HaqEfGycayhJ3mz1SfRwDmjjuD0TNCDMUUVsC3opnos4GzyW7syd0jJ1wohe3l
    zToiA9oCQ4p3q3HiCNE2ovI58dsC7qwPU4tYB5vw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIvBziIJwPMhHBGND3JxK2wihr6SVJMgJr+HxURgV6BzTd9XouwTqaNt2ahxhy9HQ81+Ek29x+UCnGbEe6SS7Q9HhrjmHONzjViHsNlDD//O8cQA3gPD
    7W4f27lWwC2pAyixQnqz2YUjWpK0fASyMW6mxfcVrtEsvD+GxZXkAyntfYPvk1aGQhfVqn/kjstzv5zT3ROMxV8ny8yzPWeN/2WxuuKf92rEIQG9hXuIkqkx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=FOH2dFAWAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=OX198wCGgoSroHnkHdYA:9 a=RSdVLRHgSUcvHvJ1:21 a=mnnycdplF6YCDCJn:21
    a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755372AbeDKSoV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755383AbeDKSoS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 021/190] blk-mq: NVMe 512B/4K+T10 DIF/DIX format returns I/O error on dd with split op
Date: Wed, 11 Apr 2018 20:34:27 +0200
Message-Id: <20180411183551.344306580@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>


[ Upstream commit f36ea50ca0043e7b1204feaf1d2ba6bd68c08d36 ]

When formatting NVMe to 512B/4K + T10 DIf/DIX, dd with split op returns
"Input/output error". Looks block layer split the bio after calling
bio_integrity_prep(bio). This patch fixes the issue.

Below is how we debug this issue:
(1)format nvme to 4K block # size with type 2 DIF
(2)dd with block size bigger than 1024k.
oflag=direct
dd: error writing '/dev/nvme0n1': Input/output error

We added some debug code in nvme device driver. It showed us the first
op and the second op have the same bi and pi address. This is not
correct.

1st op: nvme0n1 Op:Wr slba 0x505 length 0x100, PI ctrl=0x1400,
	dsmgmt=0x0, AT=0x0 & RT=0x505
	Guard 0x00b1, AT 0x0000, RT physical 0x00000505 RT virtual 0x00002828

2nd op: nvme0n1 Op:Wr slba 0x605 length 0x1, PI ctrl=0x1400, dsmgmt=0x0,
	AT=0x0 & RT=0x605  ==> This op fails and subsequent 5 retires..
	Guard 0x00b1, AT 0x0000, RT physical 0x00000605 RT virtual 0x00002828

With the fix, It showed us both of the first op and the second op have
correct bi and pi address.

1st op: nvme2n1 Op:Wr slba 0x505 length 0x100, PI ctrl=0x1400,
	dsmgmt=0x0, AT=0x0 & RT=0x505
	Guard 0x5ccb, AT 0x0000, RT physical 0x00000505 RT virtual
	0x00002828
2nd op: nvme2n1 Op:Wr slba 0x605 length 0x1, PI ctrl=0x1400, dsmgmt=0x0,
	AT=0x0 & RT=0x605
	Guard 0xab4c, AT 0x0000, RT physical 0x00000605 RT virtual
	0x00003028

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1252,13 +1252,13 @@ static blk_qc_t blk_mq_make_request(stru
 
 	blk_queue_bounce(q, &bio);
 
+	blk_queue_split(q, &bio, q->bio_split);
+
 	if (bio_integrity_enabled(bio) && bio_integrity_prep(bio)) {
 		bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
 
-	blk_queue_split(q, &bio, q->bio_split);
-
 	if (!is_flush_fua && !blk_queue_nomerges(q) &&
 	    blk_attempt_plug_merge(q, bio, &request_count, &same_queue_rq))
 		return BLK_QC_T_NONE;
