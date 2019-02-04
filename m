Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F91C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A9A217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iqC87PC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfBDIOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:14:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfBDIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pj/gGyzWDbQ1LrtzEjX8pE/7qwnWQICqgRh5Uy8QyL0=; b=iqC87PC6yQA8LQWjSZ1o5HRzD0
        iPh3Q4x+rL5/mwYpFdUTCJKqPrQrAsN2C9uOR2RTg0L3lno+RJR1ySaqjIYTtE6E7cCq34pIOzOcF
        QkJV6oPB4I1g9/ZsX0pGG6H9I+gWYtggNa4mOi9bL7RQHpmRRcGIZjUwGU370PEedzOoI3OggI8WF
        3x9/o+eEyipOzzmroQ5ISd3ONiTA/+ctZzlEo8EkUV7sJdYPy85sGZlPUlykz0AQmKI6nVc7zEeUQ
        GiGJSDX7MtrAhM5lO+gzbPa8qPmzZ3UYcD9OsKsTsX8YBn8Y9J9LtzUHZxtsiE7Kt01J7f/4Gub+Q
        Fk3Z+adA==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqZOf-0008R5-GZ; Mon, 04 Feb 2019 08:14:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>
Cc:     linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dma-mapping: add a kconfig symbol for arch_teardown_dma_ops availability
Date:   Mon,  4 Feb 2019 09:14:20 +0100
Message-Id: <20190204081420.15083-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204081420.15083-1-hch@lst.de>
References: <20190204081420.15083-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig                     |  1 +
 arch/arm/include/asm/dma-mapping.h   |  5 -----
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/dma-mapping.h |  5 -----
 include/linux/dma-mapping.h          | 10 +++++++---
 kernel/dma/Kconfig                   |  3 +++
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1cf44f00870..4bb36ae71b14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -16,6 +16,7 @@ config ARM
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
+	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index a224b6e39e58..03ba90ffc0f8 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -96,11 +96,6 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
-#ifdef CONFIG_MMU
-#define arch_teardown_dma_ops arch_teardown_dma_ops
-extern void arch_teardown_dma_ops(struct device *dev);
-#endif
-
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 63909f318d56..87ec7be25e97 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -29,6 +29,7 @@ config ARM64
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK if !PREEMPT
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index de96507ee2c1..de98191e4c7d 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -29,11 +29,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-#ifdef CONFIG_IOMMU_DMA
-void arch_teardown_dma_ops(struct device *dev);
-#define arch_teardown_dma_ops	arch_teardown_dma_ops
-#endif
-
 /*
  * Do not use this function in a driver, it is only provided for
  * arch/arm/mm/xen.c, which is used by arm64 as well.
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2b20d60e6158..4210c5c1dd21 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -681,9 +681,13 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 }
 #endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
 
-#ifndef arch_teardown_dma_ops
-static inline void arch_teardown_dma_ops(struct device *dev) { }
-#endif
+#ifdef CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS
+void arch_teardown_dma_ops(struct device *dev);
+#else
+static inline void arch_teardown_dma_ops(struct device *dev)
+{
+}
+#endif /* CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS */
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
 {
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c44599d128e8..77a352259796 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -22,6 +22,9 @@ config HAVE_GENERIC_DMA_COHERENT
 config ARCH_HAS_SETUP_DMA_OPS
 	bool
 
+config ARCH_HAS_TEARDOWN_DMA_OPS
+	bool
+
 config ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	bool
 
-- 
2.20.1

