Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955C6C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0E820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gymUdo/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0E820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLDBgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:36:55 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14280 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeLDBgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:36:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c05d9fa0000>; Mon, 03 Dec 2018 17:35:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Dec 2018 17:36:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Dec 2018 17:36:54 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 01:36:54 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 01:36:53 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Dec 2018 01:36:53 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c05da350004>; Mon, 03 Dec 2018 17:36:53 -0800
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <thomasz@nvidia.com>,
        <olof@lixom.net>, <jtukkinen@nvidia.com>, <mperttunen@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v3 0/5] Add Tegra194 Dual ARM SMMU driver
Date:   Mon, 3 Dec 2018 17:36:48 -0800
Message-ID: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543887354; bh=GFFSVMThQMDSxoe7Z5jLRH73/5ZQ0+ad0JneajN89sY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=gymUdo/yMdiRK5n1CAZNnDR/kUBgTFsPFxuHZz1n1hsWlcoqZA4dKc4gCtdXR8xgD
         8uLKNRZwtqTHSWpL8QJn27XMm25vkp5+QcvmuWlL7NIPT/f06lxnSq41jDcQ8mJNQM
         ISbEoaXL9GoWE0248b9MJgJ30D8k4qABykwJrjUPDNa42/LwV1Mdg2dYOYbrAHxKkE
         bDBcpMNFI8YgREU0fFyUg0ES+cmmSLvWpx9YtzuRl7iUF/EXOvxpBoZSIQZxOC6hD6
         V79brsd/wmU+75p9ex7W5foUPXkTx/g1GemUHNoSyQAlzgxQ8yU9SIw2CTOZ7jgOTA
         VDmFoiUIQdMOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA's Xavier (Tegra194) SOC has two ARM SMMU(MMU-500) instances, which
are used as one SMMU device in HW. The IOVA accesses from HW devices are
interleaved across these two SMMU instances and need to be programmed identical.

The existing ARM SMMU driver can't be used in its current form for programming
the two SMMU instances identically. But, Most of the code can be shared between
ARM SMMU driver and Tegra194 SMMU driver. To allow sharing the code, Created
a libray based on the current ARM SMMU driver and added suppport to program
multiple ARM SMMU Instances identically. Upated Current ARM SMMU driver and
Tegra194 SMMU driver to use the library functions.

Please review the patches and provide feedback.

Changes in v2:
* Added CONFIG_ARM_SMMU_TEGRA to protect Tegra194 SMMU driver compilation
* Enabled CONFIG_ARM_SMMU_TEGRA in defconfig
* Added SMMU nodes in Tegra194 device tree

Changes in v3:
* Created library for ARM SMMU based on arm-smmu.c
* Added support to program multiple ARM SMMU instances identically
* Updated arm-smmu.c/tegra194-smmu.c to use ARM SMMU library functions

Krishna Reddy (6):
  iommu/arm-smmu: create library for ARM SMMU
  iommu/arm-smmu: Add support to program multiple ARM SMMU's identically
  iommu/arm-smmu: update arm-smmu.c to use ARM SMMU library
  iommu/tegra194_smmu: Add Tegra194 SMMU driver
  arm64: defconfig: Enable ARM_SMMU_TEGRA
  arm64: tegra: Add SMMU nodes to Tegra194 device tree

 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  148 +++
 arch/arm64/configs/defconfig             |    1 +
 drivers/iommu/Kconfig                    |   11 +
 drivers/iommu/Makefile                   |    2 +
 drivers/iommu/arm-smmu.c                 | 1709 +----------------------------
 drivers/iommu/lib-arm-smmu.c             | 1768 ++++++++++++++++++++++++++++++
 drivers/iommu/lib-arm-smmu.h             |  161 +++
 drivers/iommu/tegra194-smmu.c            |  394 +++++++
 8 files changed, 2496 insertions(+), 1698 deletions(-)
 create mode 100644 drivers/iommu/lib-arm-smmu.c
 create mode 100644 drivers/iommu/lib-arm-smmu.h
 create mode 100644 drivers/iommu/tegra194-smmu.c

-- 
2.1.4

