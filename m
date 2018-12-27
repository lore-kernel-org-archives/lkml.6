Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BCFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1719521741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SrLggIT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbeL0V6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:58:06 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12154 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbeL0V6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:58:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c254ae50000>; Thu, 27 Dec 2018 13:57:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Dec 2018 13:58:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Dec 2018 13:58:05 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Dec
 2018 21:58:05 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 21:58:05 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c254aed0000>; Thu, 27 Dec 2018 13:58:05 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <mperttunen@nvidia.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V6 0/2] HW Command Queue support for Tegra SDMMC
Date:   Thu, 27 Dec 2018 13:58:00 -0800
Message-ID: <1545947882-18875-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545947877; bh=PO4tnPArrGBMDSApMJU/nzcJOPiM9huOCdFM4cCW8bQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=SrLggIT5W1WZkXBlMeWTQ+sOujcpkAs0ebxfSRT1vE1UonuaI9maU0pGIZIPt5cSi
         GJVrwstaWV2sF8GU7t3+REruNs+weR4LCEMbBahDBQfWsqVjwGIWt+mrMaoB6+RRGf
         EzymgJpKS0MomwQTYRhOJqC9R6QOqZ+4aW9Nx3kbm6uX8R5tLHNQSpoAMNwTthZpli
         C7MY/3fbtNeeI8O1pok/e3bOAOewSvglrYrgbGRl5ZAvymsBgYHz/QZk3TeXfkxdpb
         lvfV5/Rwtn308aEEO2a/aJlQQxuE5WWk9BkUNktt84R4xdIB4aP64QoqOsqgwJaiPJ
         a/rLBdtK2XVTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is for HW Command Queue support for Tegra SDMMC.

Patch[2] adds HW Command Queue support for Tegra SDMMC and has
dependencies on other patches in this series as explained below.

Patch[1] SDMMC address range:
This patch defines exact register space for all the SDMMC
Controllers. Controllers supporting command queue are having
CQHCI register space from offset 0xF000.
Patch[2] uses address range of sdmmc controllers to identify command
queue supported controllers

Sowjanya Komatineni (2):
  arm64: dtsi: Fix SDMMC address range
  mmc: tegra: HW Command Queue Support for Tegra SDMMC

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |   6 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |   4 +-
 drivers/mmc/host/Kconfig                 |   1 +
 drivers/mmc/host/sdhci-tegra.c           | 107 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                 |   6 +-
 5 files changed, 117 insertions(+), 7 deletions(-)

-- 
2.7.4

