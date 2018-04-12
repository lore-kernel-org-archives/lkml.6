Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3778089-1523494276-2-14149088420674745606
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, URIBL_SBL 1.623, URIBL_SBL_A 0.1,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523494276; b=EIxHxoWV6Lrt7RZ+z8sGbclsrx5jUWf4ZICJb3gc8JOFesAjIs
    B7kAhAohPnK9D9bQxuN+Bm/enS+E3xq0xX3LpMZd+3MbwqitEZzRQCajfLLvhLin
    F7+Q5ebLYw32bh/dvecSdjqR7yhwmrLh/v1CWQf7EdTpzKuLrEjZLQgwVeqTDwlX
    prbEu9T3i9NC+Rzjp0QtSsJ7w+2Ku1tpvIdHAr3M6ShCBmYW9SfVpN6sDs1HPZSB
    0tKsS9ETKoMKF8UmgLxV+sszFej5dCSSi78S9h4Ff8ntzHyJ4ZxycdPxRiuaouhm
    HdB0Anj4ED8CUn3bL0YRRofS7lymzx+OSH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494276; bh=7COMI
    Cr9oazGnJJI21dcV1tnMkfytBa4TaZh7mBbpRU=; b=Mk7XiCI3mGFicS2V6+bPv
    gsYyhJSshAmOtXi9wGau5x90zHlQuMktQVG2O2kPNwnwFZ2RDhqPNTB2XV8BIs0r
    Lj48jt81S41OpbAtiG8Xd17cXCeKc1YXpjC/8ikXP81SP4RqqAlv3ygVa4TnrQAY
    E+8pQeH/tYs/TBuiXcz2Ui8ApknX2CWOcUKvohuuqhLE7NiWIK20zmpgK4bzu0X2
    Vr12G3TX/SpclLdAYMX7tvp4PzvFii1BcXg7SExaDIdicn7bf0SRwO2g8o5LDabS
    wnKBg9LR+3kM6Ie0DefRmnpNvi6cPdDXShcsD7Y8L5oULXViYOlbAUBc5DvSb/HF
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfJkICcGesHgkaBw7HNdRrkCW6Mw4T934/oSXPx98fcFTglJ49y+i3FgwJ6MkbETRHs5Y8oVnMqzKFN6yAD770vAobsJeFRgZZ5sYM+cSA/VxZDwBgMCr
    JVXTcq6vpF5HgkUflG5eAdzEBjEjQk41lzlodToUNNKCdVHvTNZgwaxQYvfpQQBIWTSq7QXoshM0TsekxUm0HjafotTMMR85IRs7yan2evSvTlEfLANc6lD1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=8981fWPbAAAA:8 a=G66KQTBotQQGbdJUCVcA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=o72u2rHnfW5qNJ_4I8LD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeDLAuY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:50:24 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39860 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeDLAuU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:20 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <7f3cf4519b38aeadb3c2211629689dce920fe610.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 10/10] block/swim: Select appropriate drive on device open
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver supports internal and external FDD units so the floppy_open
function must not hard-code the drive location.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/block/swim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 2c75761b61e8..0e31884a9519 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -648,7 +648,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 
 	swim_write(base, setup, S_IBM_DRIVE  | S_FCLK_DIV2);
 	udelay(10);
-	swim_drive(base, INTERNAL_DRIVE);
+	swim_drive(base, fs->location);
 	swim_motor(base, ON);
 	swim_action(base, SETMFM);
 	if (fs->ejected)
-- 
2.16.1
