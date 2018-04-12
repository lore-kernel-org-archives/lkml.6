Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3729524-1523494228-2-6548472277245410380
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
    1523494227; b=omusrkqJUpAwAzqKbBs+9zsO9STmQadC/Z3COExiitZ8nN2mtN
    ixsCY7rVx30eGG6n6gaYNzACrgCpsQT1Dbd8aBJ28x4m79ydseZlXze2z9GbjZeU
    oXlHlHu4pQebanAnGnV+mmeOygCZSLC71yb4C1oZQraLvGleI2TA9roI6HKnzIzN
    TGVKPae18By46YMNfxdgf+rwJujpjtUarnRfpFXdtmzcEXhc+h3xOdGLPVWir0fx
    /cP+cLT/gnzz5KtZiIo+VYohVnffWFvwjvIjUf8bOpybeeavx3F4vk32mcLue33H
    oIdKrPMipDlmDx7M0VmW8il9MLeHeYLRbD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494227; bh=9LsZK
    uINOyqe4dov1IiV+iodoll1Okf+DaKTafK9zvw=; b=Vmalp7eNmRp82QRK0PPIU
    xtjtWojsujwe37I0IcpjSIM0unbzXZMYUT+qEBUn/Se5StsMhvw9CwESnicGQGny
    ZdMazZEHi1JsZ9vfKxSqodx+n/tnEluqC7LYcBVUXvQnZFOoxtSUTNX7ox8EJ+Sp
    dPC1jXJzBgYpaPtGgoaACtZvPiwyY0vjbn2e9NRTIz1NQztwZLkQzW457kzH9eeQ
    iA75h0v2vNajmHlypzB0FK5lTdSLMRs9RPTOZ/Da5ibr/aiDNi4qxD2nuq8UcDBo
    7XGtlPwS8xBEs+ZVNoPRxfuKaWaf4asQKrROyXhHI+sO/flFZrI0eqwrnwcS6Bzh
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
X-CM-Envelope: MS4wfAh6LsmSaS5wxL7ORMXiFeHlbquF5kdj6Qm+BIsA50gSLqqoXYFiyN08eBSqq8RbYBmvKPi3IzQcOAkY/FQDSXan2TOvfytUH8y0BDawXNesxfcpMCmm
    jBnV2VUMuRdptcSwh1siuZUTdHz8VOcbqeYthyykQwNVMJsbu/4/4pcxnBy+T1iCpv48/c3lmGTeN8E6lsZbq7Dv9wK8NYFgfGsrxoD2KNN+KnFQLNILSk+c
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=8981fWPbAAAA:8 a=t3Etx5NInMrR6of4Y5sA:9
    a=vWOiH96eAx4A8ttF:21 a=3-5iWNZX-k_-Qyi7:21 a=AjGcO6oz07-iQ99wixmX:22
    a=o72u2rHnfW5qNJ_4I8LD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDLAuX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:50:23 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39862 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeDLAuU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:20 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <8f7474079aab3a47a4534bec7463ed52d0e5a652.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 09/10] block/swim: Fix IO error at end of medium
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reading to the end of a 720K disk results in an IO error instead of EOF
because the block layer thinks the disk has 2880 sectors. (Partly this
is a result of inverted logic of the ONEMEG_MEDIA bit that's now fixed.)

Initialize the density and head count in swim_add_floppy() to agree
with the device size passed to set_capacity() during drive probe.

Call set_capacity() again upon device open, after refreshing the density
and head count values.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/block/swim.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index c8c8b9da3edd..2c75761b61e8 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -612,7 +612,6 @@ static void setup_medium(struct floppy_state *fs)
 		struct floppy_struct *g;
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
-		fs->type = swim_readbit(base, TWOMEG_MEDIA);
 
 		if (swim_track00(base))
 			printk(KERN_ERR
@@ -620,6 +619,9 @@ static void setup_medium(struct floppy_state *fs)
 
 		swim_track00(base);
 
+		fs->type = swim_readbit(base, TWOMEG_MEDIA) ?
+			HD_MEDIA : DD_MEDIA;
+		fs->head_number = swim_readbit(base, SINGLE_SIDED) ? 1 : 2;
 		get_floppy_geometry(fs, 0, &g);
 		fs->total_secs = g->size;
 		fs->secpercyl = g->head * g->sect;
@@ -656,6 +658,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		goto out;
 	}
 
+	set_capacity(fs->disk, fs->total_secs);
+
 	if (mode & FMODE_NDELAY)
 		return 0;
 
@@ -808,10 +812,9 @@ static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 
 	swim_motor(base, OFF);
 
-	if (swim_readbit(base, SINGLE_SIDED))
-		fs->head_number = 1;
-	else
-		fs->head_number = 2;
+	fs->type = HD_MEDIA;
+	fs->head_number = 2;
+
 	fs->ref_count = 0;
 	fs->ejected = 1;
 
-- 
2.16.1
