Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3729524-1523494275-2-7286924867765911099
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
    1523494275; b=BvTLFkI2YZZLTh+CDFgK5P4nSc67UMPjd6B3kQpMe8TfICKBUX
    fVGuR6wIMw6YHrD2tfknWKtkdZ4++xP94jfv+vncnQ62kNDJ4OBQSrLxlFIjl12R
    7fHV1gjcjmZ9lYMNzJikaLDRGZYPKVVeNp/R1OeLKR3E1lMNlJ/mY4lvYzaTP3Gi
    vxnOcUglgl1fxyfPcUFSyApKa8rCjnVY/iNijCubSWmByXwE/5hdCOyKgNIg0hgS
    sHS/0r0jTwjzwZbv4cmQ3kfNE04BixFqR5EAPORWoXSD6U6vky8UIWNjJuYrZ7KR
    OLzzD9H+r6XTc0ovM83g+LoTzx6Xe7834WnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494275; bh=uFGAK
    KEGS+8pZaD20G572VZEZDlvzxl4Jm87PzZ+BvM=; b=c/uzqpQv1kgCgsoJq8Dwg
    nNVUbIAGEIEK9sqzUrQoc7b6QFVlohwjbk8yzUcnI5kpsMq0CfVZtR3Ub9QzrCsA
    7paAhFHNeB4ECSALmg9vsBuA/kTjn6PngK9QufX5muwnDREPftNcuOW+CG713faD
    P+ztRybuj6aIydgUNnFt3xe7JR/sTtcgKpMkPONLrCRX/rK6bEbKhXdtkHdSqq9g
    facO2v9kguPfi4WKWoKk5m7sUycGYA9+wJkPz2iEj/W4LxxAJ8ChfpDRT+OY4Oul
    mjSU/6WnEBUAuow6vDjyWNttMdkk++dbd6aaeuSM3HxkD8HDb9SmFT7/YH7vCiIZ
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
X-CM-Envelope: MS4wfNerbZsGdWF7jUYeYinpmWIB7quS6D35AKhU112HnHqHsb04N0kf942J3KMpv0U+rJII9gakuCXoTmWJvA5DubHuNIj/P7qYjkvOo4kdVr+RIL0aSvQx
    eClVPnV9Tp/BsJWy83cCKFNlDMr7IJXNysoygcpyTp9zpxWCNIC/e52nJvRwVsL9Ni2no4ZhVrui7StiGuHN8/uMSv6HdxBY0mDPc+xIkmbrf8+MhFo2frsF
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=wMNdZWldAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8
    a=8981fWPbAAAA:8 a=jC3aBCMyrth2RviaqswA:9 a=FUarYpL4UH3yWsho8X8J:22
    a=IC2XNlieTeVoXbcui8wp:22 a=AjGcO6oz07-iQ99wixmX:22 a=o72u2rHnfW5qNJ_4I8LD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeDLAuY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:50:24 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39856 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeDLAuT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:19 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <8087d933d49bbf280ae3d39dc7c46905956ae204.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 07/10] block/swim: Rename macros to avoid inconsistent
 inverted logic
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Sony drive status bits use active-low logic. The swim_readbit()
function converts that to 'C' logic for readability. Hence, the
sense of the names of the status bit macros should not be inverted.

Mostly they are correct. However, the TWOMEG_DRIVE, MFM_MODE and
TWOMEG_MEDIA macros have inverted sense (like MkLinux). Fix this
inconsistency and make the following patches less confusing.

The same problem affects swim3.c so fix that too.

No functional change.

The FDHD drive status bits are documented in sonydriv.cpp from MAME
and in swimiii.h from MkLinux.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/block/swim.c  | 8 ++++----
 drivers/block/swim3.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 7b847170cf71..d1ee4670666a 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -110,7 +110,7 @@ struct iwm {
 /* Select values for swim_select and swim_readbit */
 
 #define READ_DATA_0	0x074
-#define TWOMEG_DRIVE	0x075
+#define ONEMEG_DRIVE	0x075
 #define SINGLE_SIDED	0x076
 #define DRIVE_PRESENT	0x077
 #define DISK_IN		0x170
@@ -118,9 +118,9 @@ struct iwm {
 #define TRACK_ZERO	0x172
 #define TACHO		0x173
 #define READ_DATA_1	0x174
-#define MFM_MODE	0x175
+#define GCR_MODE	0x175
 #define SEEK_COMPLETE	0x176
-#define ONEMEG_MEDIA	0x177
+#define TWOMEG_MEDIA	0x177
 
 /* Bits in handshake register */
 
@@ -612,7 +612,7 @@ static void setup_medium(struct floppy_state *fs)
 		struct floppy_struct *g;
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
-		fs->type = swim_readbit(base, ONEMEG_MEDIA);
+		fs->type = swim_readbit(base, TWOMEG_MEDIA);
 
 		if (swim_track00(base))
 			printk(KERN_ERR
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index af51015d056e..469541c1e51e 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -148,7 +148,7 @@ struct swim3 {
 #define MOTOR_ON	2
 #define RELAX		3	/* also eject in progress */
 #define READ_DATA_0	4
-#define TWOMEG_DRIVE	5
+#define ONEMEG_DRIVE	5
 #define SINGLE_SIDED	6	/* drive or diskette is 4MB type? */
 #define DRIVE_PRESENT	7
 #define DISK_IN		8
@@ -156,9 +156,9 @@ struct swim3 {
 #define TRACK_ZERO	10
 #define TACHO		11
 #define READ_DATA_1	12
-#define MFM_MODE	13
+#define GCR_MODE	13
 #define SEEK_COMPLETE	14
-#define ONEMEG_MEDIA	15
+#define TWOMEG_MEDIA	15
 
 /* Definitions of values used in writing and formatting */
 #define DATA_ESCAPE	0x99
-- 
2.16.1
