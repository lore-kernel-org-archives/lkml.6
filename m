Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A34C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F1521874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfuYX16w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfA2SNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:13:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfA2SNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xBAJp7P+SRrVIpBj+imQoJVibRelvsQITaxQpmd4yu8=; b=IfuYX16wx0s162p8oT3vThP9q7
        7zp+isgn2cWSRvCn82BM2DokrI2pL+tKqiFH4ISqOTWomr1uPwMsX2+hQaW/SC+xAGd6NRt93/Qme
        fcTkdsCECQ7JUkQGj5FYTio/CAsaGwbWOGQRG/9UGhpZ3n+LCxEKuk+HEs5440KYO2HEKmKRfFxWG
        +HRhmDsJvzqpqSGJwVdBNyImQLK4yWKbuem+RceJsMlThOvhKx5ba2mlzBxzSTTjg0BrOn18r7aZx
        LiNsouhPkdSyYqt56Zx7EqoRuTFrOq65WTIMlcEVdTCMhxfrjbjGjd1AlbFfxtztuOeGNZS76w8o7
        5r8QcHrw==;
Received: from 213-225-35-141.nat.highway.a1.net ([213.225.35.141] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goXtB-00084Z-58; Tue, 29 Jan 2019 18:13:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] parisc: remove the HBA_DATA macro
Date:   Tue, 29 Jan 2019 19:13:10 +0100
Message-Id: <20190129181310.5557-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129181310.5557-1-hch@lst.de>
References: <20190129181310.5557-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to hide a cast in a macro, especially as all users have
cleaner ways to archive the result than blind casting.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/include/asm/pci.h | 2 --
 drivers/parisc/ccio-dma.c     | 9 ++++++---
 drivers/parisc/lba_pci.c      | 6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index 00f763688401..f14465b84de4 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -66,8 +66,6 @@ struct pci_hba_data {
 	char gmmio_name[HBA_NAME_SIZE];
 };
 
-#define HBA_DATA(d)		((struct pci_hba_data *) (d))
-
 /* 
 ** We support 2^16 I/O ports per HBA.  These are set up in the form
 ** 0xbbxxxx, where bb is the bus number and xxxx is the I/O port
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index b17e81cf77d5..097b0d43d13c 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -1519,6 +1519,7 @@ static int __init ccio_probe(struct parisc_device *dev)
 {
 	int i;
 	struct ioc *ioc, **ioc_p = &ioc_list;
+	struct pci_hba_data *hba;
 
 	ioc = kzalloc(sizeof(struct ioc), GFP_KERNEL);
 	if (ioc == NULL) {
@@ -1545,11 +1546,13 @@ static int __init ccio_probe(struct parisc_device *dev)
 	ccio_ioc_init(ioc);
 	ccio_init_resources(ioc);
 	hppa_dma_ops = &ccio_ops;
-	dev->dev.platform_data = kzalloc(sizeof(struct pci_hba_data), GFP_KERNEL);
 
+	hba = kzalloc(sizeof(*hba), GFP_KERNEL);
 	/* if this fails, no I/O cards will work, so may as well bug */
-	BUG_ON(dev->dev.platform_data == NULL);
-	HBA_DATA(dev->dev.platform_data)->iommu = ioc;
+	BUG_ON(hba == NULL);
+
+	hba->iommu = ioc;
+	dev->dev.platform_data = hba;
 
 #ifdef CONFIG_PROC_FS
 	if (ioc_count == 0) {
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 065d88868402..9047cc22c155 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1275,7 +1275,7 @@ lba_legacy_resources(struct parisc_device *pa_dev, struct lba_device *lba_dev)
 		r->flags = IORESOURCE_MEM;
 		/* mmio_mask also clears Enable bit */
 		r->start &= mmio_mask;
-		r->start = PCI_HOST_ADDR(HBA_DATA(lba_dev), r->start);
+		r->start = PCI_HOST_ADDR(&lba_dev->hba, r->start);
 		rsize = ~ READ_REG32(lba_dev->hba.base_addr + LBA_LMMIO_MASK);
 
 		/*
@@ -1321,7 +1321,7 @@ lba_legacy_resources(struct parisc_device *pa_dev, struct lba_device *lba_dev)
 		r->flags = IORESOURCE_MEM;
 		/* mmio_mask also clears Enable bit */
 		r->start &= mmio_mask;
-		r->start = PCI_HOST_ADDR(HBA_DATA(lba_dev), r->start);
+		r->start = PCI_HOST_ADDR(&lba_dev->hba, r->start);
 		rsize = READ_REG32(lba_dev->hba.base_addr + LBA_ELMMIO_MASK);
 		r->end = r->start + ~rsize;
 	}
@@ -1562,7 +1562,7 @@ lba_driver_probe(struct parisc_device *dev)
 
 	/* ------------ Second : initialize common stuff ---------- */
 	pci_bios = &lba_bios_ops;
-	pcibios_register_hba(HBA_DATA(lba_dev));
+	pcibios_register_hba(&lba_dev->hba);
 	spin_lock_init(&lba_dev->lba_lock);
 
 	if (lba_hw_init(lba_dev))
-- 
2.20.1

