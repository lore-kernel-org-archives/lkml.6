Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB57C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198F621523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RnGXMpsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198F621523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbeITNJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:09:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbeITNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y1FI2wNeTrVfe5NpVOIyP50fQCXefARFxQWqlJBGm3Q=; b=RnGXMpsW1L2OogjF71jJ8pCmd
        6IClNYlI0K65m3OK+lp58Ix11my0TOcEwgZSbx+WD9YsURPf0xyq0M1MYVH+n17GvNgtE57R3tSKr
        or+nmqhiXJmjLkWyMDTjeC6RRnZozt2X8pj9OuBU+5GzLktglmZnOAvgHsxP7nBV4bYqrnruWnFN+
        ilvHINfnhkaDLccsHZG1/J2p8R5krJQTJGpaPdRgyRmNlzqUVPsA0+GeaGg/YlwVUlCtuj4jwcNxB
        6E2KipJ9YjiqdiGSAGj4biyhnsgWRQYYIuKECOYJC2aW1OC/XoL0kuapsBScIoMp1eSZdw8qjxsmR
        X0/5qsWig==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tMv-0002hF-A5; Thu, 20 Sep 2018 07:27:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] ia64: remove the unused pci_iommu_shutdown function
Date:   Thu, 20 Sep 2018 09:26:56 +0200
Message-Id: <20180920072700.22396-6-hch@lst.de>
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
 arch/ia64/kernel/pci-dma.c    | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/ia64/include/asm/iommu.h b/arch/ia64/include/asm/iommu.h
index 156b9d8e1932..5397e5aa3704 100644
--- a/arch/ia64/include/asm/iommu.h
+++ b/arch/ia64/include/asm/iommu.h
@@ -5,7 +5,6 @@
 /* 10 seconds */
 #define DMAR_OPERATION_TIMEOUT (((cycles_t) local_cpu_data->itc_freq)*10)
 
-extern void pci_iommu_shutdown(void);
 extern void no_iommu_init(void);
 #ifdef	CONFIG_INTEL_IOMMU
 extern int force_iommu, no_iommu;
diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 924966e5aa25..936af0ec7f8f 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -37,11 +37,6 @@ static int __init pci_iommu_init(void)
 /* Must execute after PCI subsystem */
 fs_initcall(pci_iommu_init);
 
-void pci_iommu_shutdown(void)
-{
-	return;
-}
-
 void __init
 iommu_dma_init(void)
 {
-- 
2.18.0

