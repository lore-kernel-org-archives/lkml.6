Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E34EC5ACCD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E80214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Xdev66Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E80214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeJQKBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:01:05 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11509 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeJQKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:01:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc6996e0001>; Tue, 16 Oct 2018 19:07:42 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 16 Oct 2018 19:07:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 16 Oct 2018 19:07:45 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 02:07:39 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 02:07:37 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Oct 2018 02:07:37 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bc699690000>; Tue, 16 Oct 2018 19:07:37 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>, <avienamo@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH 1/2] arm64: dts: tegra186: Add dma-ranges to avoid using bounce buffers
Date:   Tue, 16 Oct 2018 19:06:47 -0700
Message-ID: <1539742008-16595-1-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539742062; bh=4PmdvguNvl8e0LMDbyabLgO7DKggboZnYh6/C+J96Ng=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Xdev66YxGMxA4v36rWD47BoqN8eXY7mYgzX9S2UlpkKTeY98rBUEXGjYiCXKlqiQ5
         8WB2cC7oG1rPyR9PDZuyEeS/M3W5SwaFhmIBX3uP6JQHi7VTx90FpfCTf4ED/WAVFE
         mHSttKKAzLPi3N9XvJkJNxyPd/32pKoT7/3DMhTCN+UqBxpu0wEjvyTYaAByiutD8Q
         8xlbdULjNobGK9410J42YBBqJNSidyl44xdVlIvQ1LYEnLB8aWDqwcuaOrThhRzFy2
         qHjznnoSE2q5nzY86/bmHECjIP8aq21uxdQ1jwM+0XTmh+MVoRNXgecVoVosWkvNZJ
         1+PasKrBEUpDw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma-ranges to avoid using DMA bounce buffers unnecessarily for
the devices that can address the physcial memory and don't
have SMMU enabled.

This also resolves the failures in attaching devices to IOMMU.
The following error is caused by the check in io-pgtable-arm.c, where
the dma address is expected to match the physical address for the IOMMU
devices that don't support coherent page table walking. Bounce buffer
usage is causing the mismatch and device add failure.

[    7.000461] arm-smmu 12000000.iommu: Cannot accommodate DMA
translation for IOMMU page tables
[    7.010513] iommu: Failed to add device 15200000.display to group 0:
-12

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 2f3c8e2..230c0c8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -14,6 +14,7 @@
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
+	dma-ranges = <0x0 0x0 0x0 0x0 0x4 0x0>;
 
 	misc@100000 {
 		compatible = "nvidia,tegra186-misc";
-- 
2.1.4

