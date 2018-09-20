Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00CCECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9D21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IgvH6nDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE9D21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbeITNJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:09:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbeITNJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O4x+rSgg+IuoAaOQeRi4pvfXOM/DOGCWDW6lkAApAxs=; b=IgvH6nDW0Xkbu8fjmbPgmgngS
        RacF/XqlHThhiu6lCHm6+OJk7ca+DcvsDXqV7/3xsY8AAHINRdLIubbRzIdunE05shJLQGsNQDwJH
        Qv2U+122bzKMILEt05YmgD4SXvG9XeoPYZq32iUX3EnR/crIhQgo+QUonx9VwX78nsNMcFgOC/QjK
        0BofpjQnmrXujnZWnmNcYjPDt0us54CpswsSqOnYFbYFyEgN7GWG0bZy/umP7KjfvYLnKRQEMaFz+
        t1iBWJH4MXgAah2Mi+tmLQYd2PE44nohc4fHzBf9EXuI/X/nir0UnDwHLRxIf14yb/jVPpwC+2s2j
        alIPPK6Bg==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tMy-0002iY-ML; Thu, 20 Sep 2018 07:27:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] ia64: remove the unused iommu_dma_init function
Date:   Thu, 20 Sep 2018 09:26:57 +0200
Message-Id: <20180920072700.22396-7-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920072700.22396-1-hch@lst.de>
References: <20180920072700.22396-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/iommu.h | 1 -
 arch/ia64/kernel/pci-dma.c    | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/ia64/include/asm/iommu.h b/arch/ia64/include/asm/iommu.h
index 5397e5aa3704..7429a72f3f92 100644
--- a/arch/ia64/include/asm/iommu.h
+++ b/arch/ia64/include/asm/iommu.h
@@ -15,7 +15,6 @@ extern int iommu_detected;
 #define no_iommu		(1)
 #define iommu_detected		(0)
 #endif
-extern void iommu_dma_init(void);
 extern void machvec_init(const char *name);
 
 #endif
diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 936af0ec7f8f..afb43677f9ca 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -37,12 +37,6 @@ static int __init pci_iommu_init(void)
 /* Must execute after PCI subsystem */
 fs_initcall(pci_iommu_init);
 
-void __init
-iommu_dma_init(void)
-{
-	return;
-}
-
 void __init pci_iommu_alloc(void)
 {
 	dma_ops = &intel_dma_ops;
-- 
2.18.0

