Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839842-2-17548173896880348734
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
    1524839841; b=TrLq3ieCW44QLyxIVmdxAIg+FvYSJ9pgJI54e4j6wZrdm3T9T5
    tFFaC98A/ihyDQG/1LVrFeGqCh/0g8vgxXFvrEOV5hwe+utC5RqEGLB0uyAYGMVj
    rY3GHh7xhgqzui6mkTTK+DmDkXioXIaDJJgj25jDgRBVEoObUqIEsGrl8aAtiyq9
    KaOLlNI1cfMPvswlq+obaTWABXgSz1Jqg789I4D+SfH6fjf5yZXGVOOu0+QLqdP1
    vth4Wx+Hq4BY5UAGQ4lc+uJewcJW0NqWXnuE538Pv/XQhEYv4dDgIInlvm30RfoR
    myxxIQZNeFStgzuaVXyYpxKhhU/1v1W4Galg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839841; bh=YbktUZ0HnzMEZt4p8H8knHlKM5WYBg
    r0r1yAv4O9/eM=; b=h/oJsBLwodJY68h+mEIMek9C5qMKw76dEfPBc33MbOBNtM
    7d+vjPObV6djg5fo62Sm1HmuqmgJ59AIGqkqOdeACwl0/Fi/EdsOFJRbW9dKCSmM
    mhHdEYE6ZikhL8af3VsCskrNRUC3m9te7tgC3mIWGmGiKHUJB0SuXrLmEAG+n0sz
    HNs18QP04L594lwam6+WesdK+35H/NkayiLx0oqUa0/I/Mo5L+ENhNQTynrTDVsJ
    hUOJnQhja3kuZK7djz0HLf0NiHGECS7T+Z1RaHTiZQkvI3nkJEZ5yv1F2ObhHdsU
    gOKUPjgM746mANOHWM9kT1VqhhBkzaY7GnBRuNjQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCr6qW3WRQI4q2XSKF7uXzMAVf7gnP/2oVjqqFHTRJa8crLml3sW2HkeErrhfd23T/1uGr2lNKsVUEMfcFnuWDDczOPCsdN5VVTS8idGrKCRPjOJI9Kw
    XnqzHLmFGz6P2D014Y3+unK71wTtt+TCXMloveMBYjh55KY5PISe+CsXvEKN23TOVgwZkbZx6OCkeXtVy/dRue/PiLXUuJX+0egln+wUmU/kvUuK5KshfHuC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8981fWPbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8
    a=tBb2bbeoAAAA:8 a=ag1SF4gXAAAA:8 a=N7W8jSqto3vh_Oun77EA:9 a=QEXdDO2ut3YA:10
    a=o72u2rHnfW5qNJ_4I8LD:22 a=AjGcO6oz07-iQ99wixmX:22 a=Oj-tNtZlA1e06AYgeCfH:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934683AbeD0OJc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934654AbeD0OJa (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0750821864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4.14 71/80] block/swim: Remove extra put_disk() call from error path
Date: Fri, 27 Apr 2018 15:59:04 +0200
Message-Id: <20180427135736.573014307@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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
