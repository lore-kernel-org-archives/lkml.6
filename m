Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808A2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DE82086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ghNluO1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbeLSXml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:42:41 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16944 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeLSXmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:42:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1ad7580000>; Wed, 19 Dec 2018 15:42:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Dec 2018 15:42:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Dec 2018 15:42:22 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 23:42:22 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 23:42:22 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1ad75d0000>; Wed, 19 Dec 2018 15:42:21 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 2/4] mmc: cqhci: DMA Configuration prior to CQE
Date:   Wed, 19 Dec 2018 15:42:16 -0800
Message-ID: <1545262938-20636-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
References: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545262936; bh=9zaY3vxqoyf2Tw0ejvlYvRV5wvvAejx8ZD3gU7mm8AQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ghNluO1Omgt6ApSoklk02IDG9Ht+OMUBV6D2VRI1SlONEBPaRbRZ6PMXTBWbfDebC
         a6OrEmRVZKqRE0cxuhk29Rym29kZF5xLGyXRP4R9g2cS/umznEJUX0sXdEpW5j/dGt
         XnwZ1fUN9kXlVDva3C/w50pDvh9gMMIEMw6NxpdJqApISMjmbj4GuL02soYnWrLF90
         VjuBa1pANaSyzUOB1RDsGkL8uJBjbT1/hjbhpJS0+9FqHGF82/UrB6OGV8Gv1mI07W
         Gs1dE70lSeK9RBxRkJ5i5fk5uJ8XFRu7Po1+UyZvABiTYNavr5HnjksOtcMBwaNW2e
         7Zf9h+hTj8gFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eMMC-5.1 JESD84-B51 Spec (Section 6.6.39.1), mentions "Prior to
enabling command queuing, the block size shall be set to 512 B.
Device may respond with an error to CMD46/CMD47 if block size
is not 512 B".

This patch fixes the sequence to follow exact as per the spec.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 159270e947cf..f701342e7212 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -248,6 +248,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
 	}
 
+	if (cq_host->ops->enable)
+		cq_host->ops->enable(mmc);
+
 	cqcfg &= ~(CQHCI_DCMD | CQHCI_TASK_DESC_SZ);
 
 	if (mmc->caps2 & MMC_CAP2_CQE_DCMD)
@@ -273,9 +276,6 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	mmc->cqe_on = true;
 
-	if (cq_host->ops->enable)
-		cq_host->ops->enable(mmc);
-
 	/* Ensure all writes are done before interrupts are enabled */
 	wmb();
 
@@ -561,6 +561,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	int tag = cqhci_tag(mrq);
 	struct cqhci_host *cq_host = mmc->cqe_private;
 	unsigned long flags;
+	u32 cqcfg = 0;
 
 	if (!cq_host->enabled) {
 		pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc));
@@ -579,8 +580,19 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
+		/* Configuration must not be changed while enabled */
+		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+		if (cqcfg & CQHCI_ENABLE) {
+			cqcfg &= ~CQHCI_ENABLE;
+			cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+		}
+
 		if (cq_host->ops->enable)
 			cq_host->ops->enable(mmc);
+
+		cqcfg |= CQHCI_ENABLE;
+		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
 	}
 
 	if (mrq->data) {
-- 
2.7.4

