Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4502C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689A725A83
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689A725A83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeGBHwD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:52:03 -0400
Received: from 107-173-13-209-host.colocrossing.com ([107.173.13.209]:38827
        "EHLO ozlabs.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S933469AbeGBHwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:52:02 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 03:52:02 EDT
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 70158AE8059E;
        Mon,  2 Jul 2018 03:40:55 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Russell Currey <ruscur@russell.cc>,
        linux-kernel@vger.kernel.org
Subject: [PATCH kernel] powerpc/powernv/ioda2: Add 256M IOMMU page size to the default POWER8 case
Date:   Mon,  2 Jul 2018 17:42:05 +1000
Message-Id: <20180702074205.12837-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sketchy bypass uses 256M pages so add this page size as well.

This should cause no behavioral change but will be used later.

Fixes: 477afd6ea6 "powerpc/ioda: Use ibm,supported-tce-sizes for IOMMU page size mask"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5bd0eb6..557c11d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2925,7 +2925,7 @@ static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
 		/* Add 16M for POWER8 by default */
 		if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
 				!cpu_has_feature(CPU_FTR_ARCH_300))
-			mask |= SZ_16M;
+			mask |= SZ_16M | SZ_256M;
 		return mask;
 	}
 
-- 
2.11.0

