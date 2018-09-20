Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD31421523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cVUvWyYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD31421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbeITNJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:09:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeITNJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SDjbaJj+OA0ck2PMxH23qgRxJ+qBrLug90K7cIj7CDA=; b=cVUvWyYB1ZxYK+cxKEwjPvHK0
        GRexoZV6Fkfe80VbrsvGc8IjO1wviyky+s5LAlINqt2DeOyFLGY1T4QY5IngQizIRmgIkQ2LF7S8i
        dQgXG0yeYwaEbBivFE9C8WqZJKWoLkYp3SKGbwgUm1TVJOof2013njSA7DOMgmmG1zjgJzmeSF/OT
        IMkuVWeAWmTx/WZtiBmGK0bXbHrkN0EGYKyReKUNt1z2Zk2hIDbR5k5W/b6NlWn9/IVHd5lXwsUxJ
        7Ocy4sjX7KdRUVaMjmvUxEnVoygvV/bGqnykl/Jj4FnrrD9Qip1Z7I97TgDYTyN+iLF/D/2q3c5eL
        jmJ/qNaOg==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tMh-0002bw-98; Thu, 20 Sep 2018 07:27:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] ia64: remove the kern_mem_attribute export
Date:   Thu, 20 Sep 2018 09:26:52 +0200
Message-Id: <20180920072700.22396-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920072700.22396-1-hch@lst.de>
References: <20180920072700.22396-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No actually used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/efi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 9c09bf390cce..f77d80edddfe 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -842,7 +842,6 @@ kern_mem_attribute (unsigned long phys_addr, unsigned long size)
 	} while (md);
 	return 0;	/* never reached */
 }
-EXPORT_SYMBOL(kern_mem_attribute);
 
 int
 valid_phys_addr_range (phys_addr_t phys_addr, unsigned long size)
-- 
2.18.0

