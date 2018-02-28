Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519831947-2-1584436859942076486
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
    t=1519831946; b=UtYlc/oRMKJgCH6lGYF7VGaxVnIjZotiMqI+KfOH5ljfgEq
    PdpqU1k6X/6CCXNeHEIXvpRLBK8o6Tr5EL224ieKbiFQaSPo1Nxd8kU8n0hRQR47
    aR5FYKwn+1Xl5TVwLjAKuOcxPmHxReA5dYdT1drxo4qFWYt7F7AUYvV2lsrMag0x
    xaa4AS7e1HJCIbUVGWd02tOJt+VpPDmYDexIX3MsQfT0WgFBZAZdLvwUf2QerxZ4
    7RyR0OOyilSz0o3MyO+5GOJIdt+8n1Uh/gIepibflbRcK05aAHH8wAfKFkM13VW4
    Xd2folKQq7AUB+YSlG6Gt7ExYBZzNNNORCwdUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831946; bh=AypA8cZcQtnsQY9USEA
    zR7TYdTfwTadKm9SVPgbO9TU=; b=KpP2QQtGCvm7Ww/7VTLh8eeVqCzc2boOnuJ
    uGWz8yCmC80mFtLWVQYFfTD8ANiyfsBy7LDVgjO1ZOICtTw2LiItOeQ/nj/GpIBk
    37fdwfZ7RO5gA1XlZFD2FcJYPZJjCNK1rRK3QTpDgdNIJyOe6L+AVGophrWZi605
    V3UQVm0p8fQKMeRKRRyKcP+VbhthOBX8Jvp4OTOypGiE56tey/yJt3WbirUFeMo+
    uhEz7l9ckjeklWChkkULQGCdHN5SCjjw5G1zeoSCTsSPQ/ERjkPDP6uw2cHCZoPa
    RTS+Zi7dp7ajKewsGxLMGEN0lhkGxluKZokwZLS5uOxQLH9IRDQ==
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
        id S932305AbeB1PcW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:32:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33314 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752869AbeB1PWi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:38 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Christoph Hellwig" <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.515118045@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 008/254] scsi: dma-mapping: always provide
 dma_get_cache_alignment
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 860dd4424f344400b491b212ee4acb3a358ba9d9 upstream.

Provide the dummy version of dma_get_cache_alignment that always returns
1 even if CONFIG_HAS_DMA is not set, so that drivers and subsystems can
use it without ifdefs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.16: Also delete the conflicting declaration in
 <asm-generic/dma-mapping-broken.h>]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -181,7 +181,6 @@ static inline void *dma_zalloc_coherent(
 	return ret;
 }
 
-#ifdef CONFIG_HAS_DMA
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
@@ -189,7 +188,6 @@ static inline int dma_get_cache_alignmen
 #endif
 	return 1;
 }
-#endif
 
 /* flags for the coherent memory api */
 #define	DMA_MEMORY_MAP			0x01
--- a/include/asm-generic/dma-mapping-broken.h
+++ b/include/asm-generic/dma-mapping-broken.h
@@ -85,9 +85,6 @@ dma_supported(struct device *dev, u64 ma
 extern int
 dma_set_mask(struct device *dev, u64 mask);
 
-extern int
-dma_get_cache_alignment(void);
-
 extern void
 dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
