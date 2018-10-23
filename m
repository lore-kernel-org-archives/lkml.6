Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888ACC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DF0207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mWHIFQyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DF0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeJXHE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:04:27 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7825 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXHE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:04:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bcfa2fd0000>; Tue, 23 Oct 2018 15:38:53 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Oct 2018 15:39:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Oct 2018 15:39:02 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 23 Oct
 2018 22:39:02 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 23 Oct
 2018 22:39:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 23 Oct 2018 22:39:02 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bcfa3060002>; Tue, 23 Oct 2018 15:39:02 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH 0/3] Add Tegra194 Dual ARM SMMU driver
Date:   Tue, 23 Oct 2018 15:39:04 -0700
Message-ID: <1540334347-7178-1-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540334333; bh=dXkqI3kipmqmY/E4Vk6BKX5LPVnWoHTIBDi0dsrwJBo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=mWHIFQyi+0Ug65CaPVd0pzCtMPgBPm+Wkm4PCkXvusZEESzj92cZGFXdrSfCpXZkG
         bS6bZU2KValPNoxpAqkU1lWDequidUGTJxxdb1N5yf1WQxmSdcl6igWYScceDSDAS2
         gzA+Rd7b7A/+3eLNz2fYofAe+Qf7P+GxLHuyEaFFVg4aSVcEh/9buW7FYhtVnRiW80
         mBbG5o3ARSh7FYPWNC5oe5Dib+snU+tNerBbr6Uykro4+3jkt0RS7T3sO1T/hutpe+
         V+/oSX7MFkorAgBwoZzp1IMkO6lwSczIhSEHPmDgU7au+FvWltVMCqHCDBFAtBN1jb
         uEkfnl1vBLcyQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA's Xavier (Tegra194) SOC has three ARM SMMU(MMU-500) instances.
Two of the SMMU instances are used to interleave IOVA accesses across them.
The IOVA accesses from HW devices are interleaved across these two SMMU instances
and they need to be programmed identical.

The existing ARM SMMU driver can't be used in its current form for programming the
two SMMU instances identically. But, most of the code can be shared between ARM SMMU
driver and Tegra194 SMMU driver.
Page fault handling and TLB sync operations need to know about specific instance
of SMMU for correct fault handling and optimal TLB sync wait. Rest of the code doesn't
need to know about number of SMMU instances. Based on this fact, The patch series here
rearranges the arm-smmu.c code to allow sharing most of the ARM SMMU programming/iommu_ops
code between ARM SMMU driver and Tegra194 SMMU driver and transparently
handles programming of two SMMU instances.

The third SMMU instance would use the existing ARM SMMU driver.

Krishna Reddy (3):
  iommu/arm-smmu: rearrange arm-smmu.c code
  iommu/arm-smmu: Prepare fault, probe, sync functions for sharing code
  iommu/tegra194_smmu: Add Tegra194 SMMU driver

 drivers/iommu/Makefile          |    1 +
 drivers/iommu/arm-smmu-common.c | 1971 +++++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu-common.h |  256 +++++
 drivers/iommu/arm-smmu.c        | 2167 +--------------------------------------
 drivers/iommu/tegra194-smmu.c   |  201 ++++
 5 files changed, 2436 insertions(+), 2160 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-common.c
 create mode 100644 drivers/iommu/arm-smmu-common.h
 create mode 100644 drivers/iommu/tegra194-smmu.c

-- 
2.1.4

