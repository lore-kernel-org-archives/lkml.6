Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95667C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6429220811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="amiOozUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbfBMHCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbfBMHC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UNth3gGEzfO2YRqAVos53dQJ1BpypqC0w85Hh2Fn61I=; b=amiOozUExFEIpuqDhhtsAGdiim
        ou0eSfheWtT4EVYv6da6GZokZErXFtvAqFnCAcT1pCI+w5kXA4tmNzIHphM5Kuf/PVU8v7zWVfuaE
        AJuwKNlWDSbFMVeYs/OPKfgbYRUFdsmSJ/pjWvQ/THondkgx+2NfEzs5NUEBr3Kls5iiSDfz6yWt7
        oA9ztsk7ybULUiKFtVHBoTy2YRJyGQYH8j0m1ImgQTNvR16Tb5/4+6Q49GxCcbheOf5ywziMJEkcB
        rY3OZ8KWdthkMbqgpK/I+KbG3b0mPrNNvHyVz8TlGsRpbGfHaQRWqfCwklOJ1Qhqj90F01o+R0w/G
        JREiWDFA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoYc-0000KA-8p; Wed, 13 Feb 2019 07:02:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/32] powerpc/pci: remove the dma_set_mask pci_controller ops methods
Date:   Wed, 13 Feb 2019 08:01:16 +0100
Message-Id: <20190213070133.11259-16-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 --
 arch/powerpc/kernel/dma.c             | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 236a7460b6ec..98e8b46aff97 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -45,8 +45,6 @@ struct pci_controller_ops {
 	void		(*teardown_msi_irqs)(struct pci_dev *pdev);
 #endif
 
-	int             (*dma_set_mask)(struct pci_dev *pdev, u64 dma_mask);
-
 	void		(*shutdown)(struct pci_controller *hose);
 };
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 0d52107b90f0..5eca02315b2e 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -304,13 +304,6 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 	if (ppc_md.dma_set_mask)
 		return ppc_md.dma_set_mask(dev, dma_mask);
 
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-		struct pci_controller *phb = pci_bus_to_host(pdev->bus);
-		if (phb->controller_ops.dma_set_mask)
-			return phb->controller_ops.dma_set_mask(pdev, dma_mask);
-	}
-
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 	*dev->dma_mask = dma_mask;
-- 
2.20.1

