Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3778089-1523494272-2-11430820876456118821
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
    1523494271; b=IiMqvLNvKfG9V04iTcKlOdJzssyLHMYTmzu6IRe4gTUrogfOxe
    XP87Yo3To1e1jwGYoXLN8uSze6cU9SC+0PFMFY5M79MpEBpYw29kejSpKEnmdzxe
    q7hjaMQdLI6dU+tm7SnHkeqfMBoA4mpOnVv7IZxEXpMiY9UyDjmd4CofXCVI73CK
    XrBXsGnJAbcFFuKNw5At6gRoRiviV7LNFVlr0U6nb2YihuFxr7r7/sxRzgFohv6T
    1sU2rvUCNi2cTMddgl+j7p237UKKF6k3mXHX3B7kOfJqEXienU4twWAJcxmdMqPq
    SFh9fsZk3kxM/SFpcZz5Ezm4ujPA/1OHLlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494271; bh=Veetp
    WNqclzoqmhMrQ1kpydRJ6ZN5r8QLPVYLoJyiRc=; b=KAiKAiflOSZMlrp4lgSQd
    wQGaoV0fuVzHz7GRFZwhkDla0gcV5dU0WbA1NaCgklQsgklZQ/XI1IavFtcz2Uyr
    ay7aGBxBBwa6svCVh6te76uxifQaeQlZKNPC92hTc/AsEIr1IOwaKIMF4KMJYDJB
    w0/BQg8ZooKMYKl21P05X0HGwsSrHhwPkTOasVjQlLMNoMOMTO9D1WIFqJoatsq9
    qu5VfiITk6+W/wzCKDognsCn7uDPC1zGFIXciwWpjMxJCtkLhoWoU7CMNCKn0trX
    9yo052E0kpN0p3YfuLK35yl6QEkG294cJaoqb93bMYUfkwxWEW1R1sgt9FXOYHXB
    g==
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
X-CM-Envelope: MS4wfCsgGf4Smh9nn3sCFbPWeYwGjEygs2s2J17BQcEZjWIdoac+vdVXCw1FZ0nt9P7s9ON23mU0qdHW52IA6EmnC3HQTxs81RbTSqlozIm5lgZaR2ubBl38
    mxzYS+TgQp99LpeWZWFQ9TdDeS3U8ZNJsKD/13Ki2zGXVHaqv6HeIQztU007zZJ2A6mR+dVBCgmN+05MFsSjdYW2Zt+2UPYBJhiQE+bsbSMTmHn6HBsJz4xk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=8981fWPbAAAA:8 a=Swts24iuYcdqNhvro5IA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=o72u2rHnfW5qNJ_4I8LD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeDLAuZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:50:25 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39854 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeDLAuT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:19 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <bd4e42a4e661ced92849d33bdc3ebf8d4f283dc8.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 08/10] block/swim: Check drive type
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The SWIM chip is compatible with GCR-mode Sony 400K/800K drives but
this driver only supports MFM mode. Therefore only Sony FDHD drives
are supported. Skip incompatible drives.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/block/swim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index d1ee4670666a..c8c8b9da3edd 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -829,10 +829,12 @@ static int swim_floppy_init(struct swim_priv *swd)
 	/* scan floppy drives */
 
 	swim_drive(base, INTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT))
+	if (swim_readbit(base, DRIVE_PRESENT) &&
+	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, INTERNAL_DRIVE);
 	swim_drive(base, EXTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT))
+	if (swim_readbit(base, DRIVE_PRESENT) &&
+	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, EXTERNAL_DRIVE);
 
 	/* register floppy drives */
-- 
2.16.1
