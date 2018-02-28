Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839310-2-16859231224353466862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839309; b=p9bfPY8oswfXfeZb0OM2Pbk6LQRnP3rWhNYCXeT3c/bOMOi
    lJeh50yhl8TdKhVQsmQAcC8xLetHf3pMqHBO8reHg4d+8oXYVtxCzv43o4K1+tUT
    REgSVvgy0BsXX9g6UXXHHjy93NEUBPc4vBTvNx7SJ1qaxyyedDRgXagH0ycgJ1dW
    b9xGKaxaUqJzD9IH1r4muoFci0wth7+LUH1Xvci6KuuMlwuM2EhV15u9+2bGvEbV
    VU04UsRGt0/k6EpBufatplvunrWOLmEp1Pav7wXjN24+S7sY0VKoohC7jWHLjc2r
    8umNROhtLf5IV+F0QOOkOyzypske7dcgbO/Ye2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839309; bh=/QtbrEKGK1jTDjbtEsE
    zXXw0YRfJQU4D/5V9kUWQmLQ=; b=n3sbVapBBH61UuOFjB9ZnF9GpwlRVLTM8+G
    COSoOeuLAW4bLRLi3BE4Nvfzj41Q58vPXmFcR/3MZLj4gFL34ak8Jn5beooRLDnW
    CVopt415xkMwOm9p32Y9AtVAhVjhn5+mw1lzvKbyn2z3Ldej3SN43SpZAdKeoLkl
    1UWSiAjmwyp+40/ML9NGo6R4wkqEx2UPShzJzvhL0d45RoQ8vURMnIwKP6VAKwex
    1KYqDVuau4XgLItcFWB/6gDh+RmxKAS3me7PWXivNT8dF91QOtwKtuEQaiPaRtqy
    tI2MEiJGZ8/ZXu3ZK1p3WkFvziF+ao5X9g0oUlOyZTkdN0Z0bog==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932647AbeB1PWP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:22:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33075 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeB1PWL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Christoph Hellwig" <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.324235571@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 006/140] scsi: dma-mapping: always provide
 dma_get_cache_alignment
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 860dd4424f344400b491b212ee4acb3a358ba9d9 upstream.

Provide the dummy version of dma_get_cache_alignment that always returns
1 even if CONFIG_HAS_DMA is not set, so that drivers and subsystems can
use it without ifdefs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.2: Also delete the conflicting declaration in
 <asm-generic/dma-mapping-broken.h>]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -130,7 +130,6 @@ static inline void *dma_zalloc_coherent(
 	return ret;
 }
 
-#ifdef CONFIG_HAS_DMA
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
@@ -138,7 +137,6 @@ static inline int dma_get_cache_alignmen
 #endif
 	return 1;
 }
-#endif
 
 /* flags for the coherent memory api */
 #define	DMA_MEMORY_MAP			0x01
--- a/include/asm-generic/dma-mapping-broken.h
+++ b/include/asm-generic/dma-mapping-broken.h
@@ -69,9 +69,6 @@ dma_supported(struct device *dev, u64 ma
 extern int
 dma_set_mask(struct device *dev, u64 mask);
 
-extern int
-dma_get_cache_alignment(void);
-
 extern void
 dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
