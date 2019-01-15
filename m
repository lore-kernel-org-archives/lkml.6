Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E911FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ADB20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OyklhS21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfAOTD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:03:56 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12268 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730300AbfAOTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:03:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3e2e8b0001>; Tue, 15 Jan 2019 11:03:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Jan 2019 11:03:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Jan 2019 11:03:54 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 19:03:54 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 19:03:54 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 19:03:54 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c3e2e9a0000>; Tue, 15 Jan 2019 11:03:54 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <chunyan.zhang@unisoc.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V9 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Date:   Tue, 15 Jan 2019 11:03:50 -0800
Message-ID: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547579020; bh=7LmrZ9OsZ3o9SobpreCnQv4ByFBfGKe0Dav4/9uMQ1U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=OyklhS21WW7hnKq/GapYowodKpduRuDAYGTNWNWyI3/2wLRAFmS9KyVI1eYFQ37M/
         qwaCZ/AUqbEa3MR4fwlw2qkXWUddJbmovtuCP9pLmSg6P0Ei7L3mu8MFrSDpXXbZJ0
         WAANkQo/GbR+WDzFLMXTry49rcHU8cSdno49MAOXRdrZ8VVydhQLS9p8A3+10DgnWO
         AORd4XkVN8k6m/8ivIcRNdUPVuNHB/7aceCs1S0f1t/Kr6U2kmzmn73/mVbkTaeRMh
         avvJETBj8YyZGWVUJyGlWdQhDa0RUs22znHoipzNQTHxfPf1jMggYAUnufqyCCcS/K
         YRZJjcHa0i8rw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supports-cqe optional property for Tegra SDMMC.

Tegra186 and Tegra194 supports HW Command queue only
on SDMMC4 controller. This property is used to identify
command queue support controller in the tegra sdhci driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 32b4b4e41923..fb14c2c8d7ee 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -72,6 +72,10 @@ Optional properties for Tegra210 and Tegra186:
 - nvidia,default-trim : Specify the default outbound clock trimmer
   value.
 - nvidia,dqs-trim : Specify DQS trim value for HS400 timing
+- supports-cqe : The presence of this property indicates that the
+  corresponding controller supports HW command queue feature.
+  Tegra186 and Tegra194 has 4 SDMMC Controllers and only SDMMC4
+  controller supports HW Command Queue with eMMC device.
 
   Notes on the pad calibration pull up and pulldown offset values:
     - The property values are drive codes which are programmed into the
-- 
2.7.4

