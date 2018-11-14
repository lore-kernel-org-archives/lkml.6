Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D72C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B060F2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cmVqT7Tw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B060F2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbeKNS0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:26:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeKNS0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oSrle2FH9A0wa4Fv0z1ytORBIOuBSBwJhWG7qdJQBtw=; b=cmVqT7Twps0mDQ49Ca2498i8r8
        KbMC7P/cn8Gvrwg71YjF+bNk3QfxQKnBhDd1c5K9WEby+PmHz0v1iCqLMi0ydfdun7BZ6BW+xqjOj
        P7ljLozUob9+RqtzFq5Y8gSoQBXtBYrRkidMRSi3vMRiVikHoXnvaiZh2BG+HG5Pgf58eIbYSQz+n
        mztj6NQ4B9mpxt5IZxvNsxCURohdr01+M+qDQ4D1JXufckGLb9E6rFYtqHvJCbRGR0+M8+3pvBuVd
        QWZ6mco3mAh7yCEoU5vfFaImxjeOat8lhkzkDVx/LTwtHXnies5B3YGlubE8Xhoc8JjEzZAI/KkWV
        yKfA2udg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqSx-0004xG-5Q; Wed, 14 Nov 2018 08:24:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/34] powerpc/powernv: remove pnv_npu_dma_set_mask
Date:   Wed, 14 Nov 2018 09:22:57 +0100
Message-Id: <20181114082314.8965-18-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These devices are not PCIe devices and do not have associated dma map
ops, so this is just dead code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index afbb73cd3c5b..1d9f446f3eff 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3688,14 +3688,6 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
-static int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
-{
-	dev_err_once(&npdev->dev,
-			"%s operation unsupported for NVLink devices\n",
-			__func__);
-	return -EPERM;
-}
-
 static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 #ifdef CONFIG_PCI_MSI
@@ -3705,7 +3697,6 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.enable_device_hook	= pnv_pci_enable_device_hook,
 	.window_alignment	= pnv_pci_window_alignment,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
-	.dma_set_mask		= pnv_npu_dma_set_mask,
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
-- 
2.19.1

