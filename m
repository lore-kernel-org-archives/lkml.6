Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E41C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C1B20811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OrP+MLp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeLSXmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:42:22 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18992 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeLSXmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:42:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1ad7530000>; Wed, 19 Dec 2018 15:42:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Dec 2018 15:42:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Dec 2018 15:42:20 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 23:42:20 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 23:42:20 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1ad75b0001>; Wed, 19 Dec 2018 15:42:20 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 0/4] HW Command Queue support for Tegra SDMMC
Date:   Wed, 19 Dec 2018 15:42:14 -0800
Message-ID: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545262931; bh=VHGHUFBU5Wz4+5pvQ1/zYN4X3BlSNsbEuuur0JguKSs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=OrP+MLp/hC1rygRkFjJ2KAYem3GYLJXReB1134mVbIrxXc6i8SlfcETu4fc80Wrbp
         7SnkP8c7azJolgqaQ9Narw1+z9kIJZok9m8xJM0y2aDwEFXZ9FhwGsthR4kzOJkKlx
         nd3Zuhfn6fbdrUEopiOKaBqiibD3UsP91KNwCRgVNnf0PW8zImcFAVEcRCRlqyZCWq
         pupw6DcA2oSvG3Hemzd+qMzO87Lj3ou+dnv+wVw9Z8qW0O+pVqLNLVi6Ln3n9tN7Fx
         HlMm+L6W767Kj9sq6tiiksof8nQWifyWrqe10ixDbhVIOYc6yWebNpQc4O1E9V7Pos
         DM2WmWQu1ZmvA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is for HW Command Queue support for Tegra SDMMC.

Patch[4] adds HW Command Queue support for Tegra SDMMC and has
dependencies on other patches in this series as explained below.

Patch[3] SDMMC address range:
This patch defines exact register space for all the SDMMC
Controllers. Controllers supporting command queue are having
CQHCI register space from offset 0xF000.
Patch[4] uses address range of sdmmc controllers to identify command
queue supported controllers

Patch[2] DMA Configuration prior to CQE:
As per eMMC5.1 Spec Section 6.6.39.1, Block size should be set to 512 B
before enabling command queue.
Tegra SDHCI Host design strictly follows this and prevents write access
to SDHCI_BLOCK_SIZE when CQE is set in CQHCI_CFG and results in access
failure and crashes for any write access to SDHCI_BLOCK_SIZE while CQE
is set.

Patch[1] Fix V4 Mode enable:
V4 Mode need to be enabled to select Host Version 4.0 mode for HW Command
queue support with Tegra SDHCI.

Sowjanya Komatineni (4):
  mmc: sdhci: Fix sdhci_do_enable_v4_mode
  mmc: cqhci: DMA Configuration prior to CQE
  arm64: dtsi: Fix SDMMC address range
  mmc: tegra: HW Command Queue Support for Tegra SDMMC

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |  6 +--
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  4 +-
 drivers/mmc/host/Kconfig                 |  1 +
 drivers/mmc/host/cqhci.c                 | 18 +++++--
 drivers/mmc/host/sdhci-tegra.c           | 89 +++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                 |  7 +--
 6 files changed, 113 insertions(+), 12 deletions(-)

-- 
2.7.4

