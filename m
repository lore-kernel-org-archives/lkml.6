Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0BC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8783D20892
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SxZ0ewUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8783D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeJOTxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:53:22 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43412 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbeJOTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:53:21 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9FC4wsJ015463;
        Mon, 15 Oct 2018 05:05:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=+nwO/4QFTWXLl7XD6vk6gQQ4qXOSizwRgvMrEpCa4w8=;
 b=SxZ0ewUKUXS/nJF1mCS2tqntQTghTQl9uQ2uZRvz7aBXVWiLDHE3P9aSPjBiy/mZ2XX2
 c7gbCjTClsB3VcEYrrn/aGjlWEpWE+yocPENgWfZMlVzEAxIhF8dJ4HA10HmjotqMbMa
 GKanFA25uSVYBV4wu//qs7Mz3g8zC/dl5hkpfAmm5wbRjDa3zRV4WcJs8qZXQkcigT8T
 LVcJK7DStniFLWuxERyib/QjLKinlWSzB5oZoPDe83QYEWdkgcl5/ErD9dfB62KlDIYS
 roIfRtABcUU8JhJX6+7poDlAr0eRKKdOZTEhIG7q7fpuqaWq2mFN2ywFy9ExFtFLRce9 jg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2n4pmqgrf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Oct 2018 05:05:45 -0700
Received: from IL-EXCH03.marvell.com (10.5.102.220) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 15 Oct
 2018 05:05:43 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by IL-EXCH03.marvell.com
 (10.5.102.220) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 15 Oct
 2018 15:05:26 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 15 Oct 2018 05:05:25 -0700
Received: from hannah.il.marvell.com (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id 94B293F703F;
        Mon, 15 Oct 2018 05:05:21 -0700 (PDT)
From:   <hannah@marvell.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>, <corbet@lwn.net>,
        <joro@8bytes.org>, <robh+dt@kernel.org>,
        <gregory.clement@bootlin.com>, <mark.rutland@arm.com>,
        <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <sebastian.hesselbarth@gmail.com>, <robin.murphy@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <nadavh@marvell.com>,
        <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>
Subject: [PATCH 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743
Date:   Mon, 15 Oct 2018 15:00:44 +0300
Message-ID: <1539604846-21151-3-git-send-email-hannah@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539604846-21151-1-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit
to ARM SMMUv2 registers.
This patch split the writeq/readq to two accesses of writel/readl.

Note that separate writes/reads to 2 is not problem regards to atomicity,
because the driver use the readq/writeq while initialize the SMMU, report
for SMMU fault, and use spinlock in one case (iova_to_phys).

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 Documentation/arm64/silicon-errata.txt |  2 ++
 drivers/iommu/arm-smmu.c               | 33 +++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 3b2f2dd..fc3f2a0 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -67,6 +67,8 @@ stable kernels.
 | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
 | Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
 |                |                 |                 |                             |
+| Marvell        | ARM-MMU-500     | #582743         | N/A                         |
+|                |                 |                 |                             |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 |                |                 |                 |                             |
 | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fccb1d4..d64f892 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -119,6 +119,7 @@ enum arm_smmu_arch_version {
 enum arm_smmu_implementation {
 	GENERIC_SMMU,
 	ARM_MMU500,
+	MRVL_MMU500,
 	CAVIUM_SMMUV2,
 };
 
@@ -276,13 +277,35 @@ static inline void smmu_writeq_relaxed(struct arm_smmu_device *smmu,
 				       u64 val,
 				       void __iomem *addr)
 {
-	writeq_relaxed(val, addr);
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the writeq to double writel
+	 */
+	if (smmu->model != MRVL_MMU500) {
+		writeq_relaxed(val, addr);
+		return;
+	}
+
+	writel_relaxed(upper_32_bits(val), addr + 4);
+	writel_relaxed(lower_32_bits(val), addr);
 }
 
 static inline u64 smmu_readq_relaxed(struct arm_smmu_device *smmu,
 				     void __iomem *addr)
 {
-	return readq_relaxed(addr);
+	u64 val;
+
+	/*
+	 * Marvell Armada-AP806 erratum #582743.
+	 * Split all the readq to double readl
+	 */
+	if (smmu->model != MRVL_MMU500)
+		return readq_relaxed(addr);
+
+	val = (u64)readl_relaxed(addr + 4) << 32;
+	val |= readl_relaxed(addr);
+
+	return val;
 }
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -1611,7 +1634,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	for (i = 0; i < smmu->num_mapping_groups; ++i)
 		arm_smmu_write_sme(smmu, i);
 
-	if (smmu->model == ARM_MMU500) {
+	if (smmu->model == ARM_MMU500 || smmu->model == MRVL_MMU500) {
 		/*
 		 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
 		 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
@@ -1640,7 +1663,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		 * Disable MMU-500's not-particularly-beneficial next-page
 		 * prefetcher for the sake of errata #841119 and #826419.
 		 */
-		if (smmu->model == ARM_MMU500) {
+		if (smmu->model == ARM_MMU500 || smmu->model == MRVL_MMU500) {
 			reg = readl_relaxed(cb_base + ARM_SMMU_CB_ACTLR);
 			reg &= ~ARM_MMU500_ACTLR_CPRE;
 			writel_relaxed(reg, cb_base + ARM_SMMU_CB_ACTLR);
@@ -1923,6 +1946,7 @@ struct arm_smmu_match_data {
 ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
+ARM_SMMU_MATCH_DATA(mrvl_mmu500, ARM_SMMU_V2, MRVL_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
 
 static const struct of_device_id arm_smmu_of_match[] = {
@@ -1931,6 +1955,7 @@ struct arm_smmu_match_data {
 	{ .compatible = "arm,mmu-400", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
+	{ .compatible = "marvell,mmu-500", .data = &mrvl_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ },
 };
-- 
1.9.1

