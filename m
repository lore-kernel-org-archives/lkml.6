Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A817C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AE020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hl3yO3b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AE020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbeHARtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:49:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbeHARtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SDjbaJj+OA0ck2PMxH23qgRxJ+qBrLug90K7cIj7CDA=; b=Hl3yO3b5tcmDfvs0WjF/wtk4Q
        g1XqBXtxLBa1gt+MqRRLyZhECJr22uupBGqMsLTzy5tKc90xDDhJZzBa3CMR5wMZFLKul7dvJvxtb
        2mI6OGLI+/bMSZTIrLMb+mhUEJettlX+y3lWt/zVL9D+JKRHyo7CEnWENZzml2ljbNqyVtrHisURt
        fGfPGwfHEQpPPKXp2W7TKNfLdm3tqowVqOEdTiVCF3Z+IHO4qqNQwISMk566zBljmq/QZMDMmFXnN
        JGe5+ZMYykQXz2/z+hexBNsnuW7HyuiXxaAGnVwUqhCVons0jhfkDzYEbqPqaNP9SPFBs098/92JE
        8GHSbkFDg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fktaT-0007cK-Oo; Wed, 01 Aug 2018 16:02:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 1/9] ia64: remove the kern_mem_attribute export
Date:   Wed,  1 Aug 2018 18:02:44 +0200
Message-Id: <20180801160252.25629-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801160252.25629-1-hch@lst.de>
References: <20180801160252.25629-1-hch@lst.de>
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

