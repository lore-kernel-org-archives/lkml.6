Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524838433-2-16506966775710541539
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524838432; b=LBqASt9wWZ0PgEGNPN0RtZrsmJFBnfEM6xkderxSYRsX46fvsa
    KjmInVNP6HmrC0n2jalb/v3PycDSRKemsAT1dDYN+AwiRRxMH8dNq6u9ZD+fTvKQ
    RjJC53Fy4xYP+VMk6NmWe9OFB1bZ2hZ6uLZKwY5LNHlIoDfpXVgM03UYqeOuKSaC
    uzJM1Q4ghvckHhaykoeqGijIUX02eWn6wBHHURRJh5wecm7N6j1KVt9vKktkcC/8
    /lIQ4FkAFyDb0aThLWzAVuDWi9B+gnBMm+IDGIxvxaldNmLboz22a/MPV4N0ewOK
    zr2+XnOYXZLKTKbCGyBhms6u9BWlsttqn0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838432; bh=3D+rGn5oa3+IyXFqdU7U5JhodoN/Jc
    Wv9DoipmTZGMA=; b=DYnCpafN/4FqvZcRLUxmgax4aT1Myc3IReTqN4Er6C1p4P
    9WGmVbIRS787uTxGaPph0IZmuhJ3F6zPBq/0E5E7AFO7IjCKh3HBsfnikDqURtHr
    i1Mrb2q225p/Q2J7s5H0p+fPtEP/odjYmF3k8KgfrgxkURaC9lNyh+DU/Y2xEJhI
    NXaLvjf9jm7jZt+B2cC6DnVblX/jkwX7llmA+AXzRvJD+d/Bzz/rrMwseBQG7nGl
    EFPUNWmMY/mVgpL4WD6OWhUoXk9FIO4LErRBqGN9tNuzsfLlEc0ckAL3boJvTIeB
    PAYIuIfdw3GDV9zgumGIYzo+byIQfaQTJYxW+Dqw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfF3RNzcHtwcuHZA0R0PPodBEgUPdo2bYi86c+naIq4db7Oj2gpRSpKSZxWXe73giRGt8V0F0EshLHnzQyTdVGtRdPUJxbzLW0Y9TQ2hsgO48ivs6VxmR
    FNLOYH741k+BgA1FnV7AizzHTT6Szv1dGDIK6lZE7hjddA4ph3KtZdKHz4VKMrSDDzs+BZb/o1MhhK90B2Jg64+bdndsKvtMrTQ4TWZyI429tRf1JN1hSwR7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8981fWPbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8
    a=tBb2bbeoAAAA:8 a=ag1SF4gXAAAA:8 a=N7W8jSqto3vh_Oun77EA:9 a=QEXdDO2ut3YA:10
    a=o72u2rHnfW5qNJ_4I8LD:22 a=AjGcO6oz07-iQ99wixmX:22 a=Oj-tNtZlA1e06AYgeCfH:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935320AbeD0ONV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935277AbeD0ONU (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:13:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF83218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4.16 68/81] block/swim: Remove extra put_disk() call from error path
Date: Fri, 27 Apr 2018 15:59:10 +0200
Message-Id: <20180427135747.247793906@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit c1d6207cc0eef2a7f8551f9c7420d8776268f6e1 upstream.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Fixes: 103db8b2dfa5 ("[PATCH] swim: stop sharing request queue across multiple gendisks")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -858,7 +858,6 @@ static int swim_floppy_init(struct swim_
 							      &swd->lock);
 		if (!swd->unit[drive].disk->queue) {
 			err = -ENOMEM;
-			put_disk(swd->unit[drive].disk);
 			goto exit_put_disks;
 		}
 		blk_queue_bounce_limit(swd->unit[drive].disk->queue,
