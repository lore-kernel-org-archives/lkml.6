Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727090-1517912139-2-9969184741026521270
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517912138; b=b7sTPy/qlIx1pDOSBNmskDlqeMytaj6OAptDByV5ZTbN+Xi
    KHs2z4zFQ+r2Sn1jtxjwO+FvsbkkkuheA7MLTlST4z3aMV0kUjhJOE/7uC43YwTI
    2y1YK3pQp7UwVkwQV7ElG1+eZMdA0Jb0SVHnat0oimS4bxgARvzXa3J9UVaCb0Pm
    pmxaR5zzrlDyKf7r4yatt+nLuGMqWgXNn3FqJKkwebRWsHGiUUpiV3wpKD59pAaZ
    L+Ky69tRFRlaPEkz0+z9qR/OvE4f4gVFkRKY+F47H7333TqLpHpETmDuM7fR8fvR
    Jxjm7rRJbKsf8SwrMV138J2Yk4ok9OUJAaQ+1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1517912138;
    bh=jpTp1H+WnyRJxM9RZpwNkOPaKfHBKw1EaGtSygzK0/Q=; b=FWHrAO9qXEsf
    uaN6Iw7k28XYIdBVL+aHQ89wEHWE9CuBN/faBc0YKE5Q5FZ5uZDfmCZqVWkqEJ5P
    vRX1/sH62wsNnbfVjE6rEexpBGktvLHNoMmdIhyWI7WRU/LQlgA0obojHS8AUMRt
    t1nQiykTj6zVxXj8y19LJBzQRHKjZ366uHxBc3vO6R/QcNZhjDLVhfqmrulGvKLi
    dSptVkSeaE0UwMa1+GZQjJStM+hW7MMNWCydH1/u4TyDDuIraY7Moi84ioPVY2jV
    OZjiv/aw0Yxrn3cFy2Xprn5LJy/bw9Ft/+qrhPK69uCXDFFPTqqn93jv9J952cjY
    dAGRh9tz6A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeBFKPG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:15:06 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:47300 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBFKPD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 05:15:03 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC 4/6] mm: Add NO_DMA dummies for DMA pool API
Date: Tue,  6 Feb 2018 11:14:50 +0100
Message-Id: <1517912092-15470-5-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add dummies for dma{,m}_pool_{create,destroy,alloc,free}(), to allow
compile-testing if NO_DMA=y.

This prevents the following from showing up later:

    ERROR: "dma_pool_destroy" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "dma_pool_free" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "dma_pool_create" [drivers/usb/mtu3/mtu3.ko] undefined!
    ERROR: "dma_pool_destroy" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
    ERROR: "dma_pool_free" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
    ERROR: "dma_pool_create" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!
    ERROR: "dma_pool_alloc" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
    ERROR: "dma_pool_free" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
    ERROR: "dma_pool_create" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!
    ERROR: "dma_pool_destroy" [drivers/mailbox/bcm-pdc-mailbox.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/dmapool.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/dmapool.h b/include/linux/dmapool.h
index 53ba737505df31c7..adeb5e56c3ad73a8 100644
--- a/include/linux/dmapool.h
+++ b/include/linux/dmapool.h
@@ -16,6 +16,7 @@
 
 struct device;
 
+#ifdef CONFIG_HAS_DMA
 struct dma_pool *dma_pool_create(const char *name, struct device *dev, 
 			size_t size, size_t align, size_t allocation);
 
@@ -23,6 +24,17 @@ void dma_pool_destroy(struct dma_pool *pool);
 
 void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 		     dma_addr_t *handle);
+void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
+#else /* !CONFIG_HAS_DMA */
+static inline struct dma_pool *dma_pool_create(const char *name,
+	struct device *dev, size_t size, size_t align, size_t allocation)
+{ return NULL; }
+static inline void dma_pool_destroy(struct dma_pool *pool) { }
+static inline void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
+				   dma_addr_t *handle) { return NULL; }
+static inline void dma_pool_free(struct dma_pool *pool, void *vaddr,
+				 dma_addr_t addr) { }
+#endif /* !CONFIG_HAS_DMA */
 
 static inline void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
 				    dma_addr_t *handle)
@@ -30,14 +42,19 @@ static inline void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
 	return dma_pool_alloc(pool, mem_flags | __GFP_ZERO, handle);
 }
 
-void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
-
 /*
  * Managed DMA pool
  */
+#ifdef CONFIG_HAS_DMA
 struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
 				  size_t size, size_t align, size_t allocation);
 void dmam_pool_destroy(struct dma_pool *pool);
+#else /* !CONFIG_HAS_DMA */
+static inline struct dma_pool *dmam_pool_create(const char *name,
+	struct device *dev, size_t size, size_t align, size_t allocation)
+{ return NULL; }
+static inline void dmam_pool_destroy(struct dma_pool *pool) { }
+#endif /* !CONFIG_HAS_DMA */
 
 #endif
 
-- 
2.7.4

