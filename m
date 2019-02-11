Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F29C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA314222A2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bR/Gh26p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfBKNgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:36:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfBKNgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gjgpSl2TQMa1GedWEfa9eVH33/BunMol673tS60BBbw=; b=bR/Gh26p09ViQl9+h3Z+loectJ
        bu0grvW0QQqeaJbUbwTdDoLvvppxu4hJys8Xlkv1R0jxIiAxcVOHqpeLdyj1AZe9zEo7duxIKX3OE
        Y2Ess8x+IGx56kUjv3KB/Qws/lYaroPsuBSWNigpryt6x4POrxiMBO4ITYKslHNaW2DBbiH/glpUv
        x4H/HE83LPREg3Hst7gpyE4aKMdighV8y012vQHfUsuzuMTGg8qTcgFtWxZbd90mn1bXAwHBWSEzn
        rmw4WDeaOLGhLhX1Co4ZXYkJcCa0iyxx6uRjuJQ+mzEfEPA1RBJyjD4MkxHpUAybKByJjhDaRg+Ee
        fC+IPXIQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBkl-0008Qj-An; Mon, 11 Feb 2019 13:36:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] of: mark early_init_dt_alloc_reserved_memory_arch static
Date:   Mon, 11 Feb 2019 14:35:45 +0100
Message-Id: <20190211133554.30055-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is only used in of_reserved_mem.c, and never overridden
despite the __weak marker.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/of/of_reserved_mem.c    | 2 +-
 include/linux/of_reserved_mem.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0adcb1..9f165fc1d1a2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -26,7 +26,7 @@
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
-int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
+static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	phys_addr_t align, phys_addr_t start, phys_addr_t end, bool nomap,
 	phys_addr_t *res_base)
 {
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 67ab8d271df3..60f541912ccf 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -35,13 +35,6 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
 void of_reserved_mem_device_release(struct device *dev);
 
-int early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
-					     phys_addr_t align,
-					     phys_addr_t start,
-					     phys_addr_t end,
-					     bool nomap,
-					     phys_addr_t *res_base);
-
 void fdt_init_reserved_mem(void);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
-- 
2.20.1

