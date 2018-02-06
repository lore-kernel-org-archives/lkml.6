Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-874968-1517912263-2-10662641298627579718
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
    t=1517912262; b=Cv+a42d/agcnAheG5LkdgW1IArEyI7lI68BP00tWNYEGxmk
    YHNB6VRHy1CF5C8KfgBmTeKFqHYZDXi0Ynajz3sDeEVISA1Z2SYbaAn1LcSEZh/G
    ji7IAUEJoBvcrwk5FFFSpe/N5aCQCdfQoEdJTrmEvF+RifSeDXAAWVvlwi8+BhkR
    4WYcb8GAgn2ogsvvu92FM77WDtN0wfDmvnGY+sRzkquxNcCS5mOFoaV22sF6ggYy
    KjQazI+LhM57KY2QpY3hBkcUzVeluJbvhaQ16Sev3XZwtCaWci3VvWt43W1wJ1as
    tcM7pnrrV1M6f7g3jNRyLDHsZ/WD7riItbKlqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1517912262;
    bh=9sAbPFhQbKKLrMPHJSOCCIW1BGfYNubJzn5jz3GSiUM=; b=G4h+gTsDN0dP
    HwOQoJeEsV+IVmvEOR6yi92p98NfxRM3LQ7u4SG8EHxignbZLSS98YOMOzM1sLCf
    j9iqeLbc6Ibr7ndBcozww+q1Lp0HvvIRcBjhdKgfswcn8jtuj0kKBV2DeHWgzSBk
    PkCNz7z+Uoax3QvSaBZqqNoWOeVBKcOm9vuLLRANTEKi1xiNLL5KHsaCXKd0YJ8l
    Loud9zJVNhvkoySM+cdYCj3ROUV0NtYgSu4MQugODu23xETXvMrfDx39syPC9ctd
    se39Sy45oUXfqHlZfpBgo/X51gotVDROAR+y4/dqRwlRrjF/0mMbWu+VickIQJs1
    +r+UX1Dp2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeBFKQO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:16:14 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:37472 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbeBFKPE (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Feb 2018 05:15:04 -0500
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
Subject: [PATCH/RFC 2/6] dma-coherent: Add NO_DMA dummies for managed DMA API
Date: Tue,  6 Feb 2018 11:14:48 +0100
Message-Id: <1517912092-15470-3-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add dummies for dmam_{alloc,free}_coherent(), to allow compile-testing
if NO_DMA=y.

This prevents the following from showing up later:

    ERROR: "dmam_alloc_coherent" [drivers/net/ethernet/arc/arc_emac.ko] undefined!
    ERROR: "dmam_free_coherent" [drivers/net/ethernet/apm/xgene/xgene-enet.ko] undefined!
    ERROR: "dmam_alloc_coherent" [drivers/net/ethernet/apm/xgene/xgene-enet.ko] undefined!
    ERROR: "dmam_alloc_coherent" [drivers/mtd/nand/hisi504_nand.ko] undefined!
    ERROR: "dmam_alloc_coherent" [drivers/mmc/host/dw_mmc.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/dma-mapping.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index d78d7541f784875b..4d92956a4ddb8a5c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -776,10 +776,19 @@ static inline void dma_deconfigure(struct device *dev) {}
 /*
  * Managed DMA API
  */
+#ifdef CONFIG_HAS_DMA
 extern void *dmam_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp);
 extern void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
 			       dma_addr_t dma_handle);
+#else /* !CONFIG_HAS_DMA */
+static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
+					dma_addr_t *dma_handle, gfp_t gfp)
+{ return NULL; }
+static inline void dmam_free_coherent(struct device *dev, size_t size,
+				      void *vaddr, dma_addr_t dma_handle) { }
+#endif /* !CONFIG_HAS_DMA */
+
 extern void *dmam_alloc_attrs(struct device *dev, size_t size,
 			      dma_addr_t *dma_handle, gfp_t gfp,
 			      unsigned long attrs);
-- 
2.7.4

