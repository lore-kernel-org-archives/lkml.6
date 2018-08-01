Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ECCC46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C4020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LzjJ7q13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C4020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390105AbeHARt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:49:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbeHARt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/1Uk2WKQ8OJpu1bF6ml22seKePBIqYxxNL+NiNfNGyc=; b=LzjJ7q13KpHmMogodFPGwda50
        UKjNw7Kw5i2UKJsNMfMFE01XNWf4jTc8kB8FxQFR5a0m7/5pomEeKCKppNE/pphS6upWDxHXEA04f
        /miBe7v6ZfYo0q4rxJdkxZICIr9dg9Wz6Bqo8w8gn7XwCO6ogKaejjc9ZtjjeXoMpD+ENI9cbBQvt
        I1SyhUA+C6CQNxKD3/UEPrYbUyLZN4b3JUXhuqqIM1Ue1YwWI2X5Qjt13yuFCaJ4M+438UXmotGz6
        ud4HmffZhgF93OWJD2UiU6QlW23OoPQzFCF/wGYNUx9ev8S5TULGc810xBjEncpC2FMxF4gHDGx9W
        yDevt93Lg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fktab-0007dp-8U; Wed, 01 Aug 2018 16:03:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 4/9] ia64: remove the unused bad_dma_address symbol
Date:   Wed,  1 Aug 2018 18:02:47 +0200
Message-Id: <20180801160252.25629-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801160252.25629-1-hch@lst.de>
References: <20180801160252.25629-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 3c2884bef3d4..924966e5aa25 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -15,9 +15,6 @@
 #include <linux/kernel.h>
 #include <asm/page.h>
 
-dma_addr_t bad_dma_address __read_mostly;
-EXPORT_SYMBOL(bad_dma_address);
-
 int no_iommu __read_mostly;
 #ifdef CONFIG_IOMMU_DEBUG
 int force_iommu __read_mostly = 1;
-- 
2.18.0

