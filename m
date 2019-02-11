Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D63C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E4620873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eK2gA8oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfBKXrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:47:12 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17569 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfBKXrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:47:12 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c62095d0000>; Mon, 11 Feb 2019 15:46:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 15:47:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 15:47:11 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 23:47:11 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 23:47:10 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Feb 2019 23:47:10 +0000
Received: from byan-linux.NVIDIA.COM (Not Verified[172.17.136.14]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c62097e0001>; Mon, 11 Feb 2019 15:47:10 -0800
From:   Bo Yan <byan@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Yan <byan@nvidia.com>
Subject: [PATCH V2] arm64: tegra: add topology data for Tegra194 cpu
Date:   Mon, 11 Feb 2019 15:47:07 -0800
Message-ID: <1549928827-14006-1-git-send-email-byan@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190131222517.GB13156@mithrandir>
References: <20190131222517.GB13156@mithrandir>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549928797; bh=rE8UhgxhLPvaoVnBJszXbodl0b5Ikea1ro1IYgb4oc4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=eK2gA8oekZjzoNtijmz6G5f/3ik32ciR0Vf31GA3vMSYVmgJI/Zrj7pfeIRipiU46
         cbgd4miN3XT+4JXxH1VpoeoTQ2bNVsxFfZwz7E8gDCqrH2awrRFT9ffKLj4Upk8hh8
         0Bvr7LQ9AOa3SNSu0XEgYhni5jhrTRaG9Y/IaLkSgCuM62//Q0l/1mP7kPGw7bMiKS
         XrIaGKBCghP+3JM5sa3jhb7PLBGiSSEXThi4LMx9BB6WrlW5Wu4ye7ra7d49QsoBHo
         HOS9TPg1f3FKS0WAyq3AxtnY8DE1Ly+wvLk9qlYTLHeRsvTPWOC4bHb83K4MB0eZLG
         KmO89QIh1h12w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xavier CPU architecture includes 8 CPU cores organized in
4 clusters. Add cpu-map data for topology initialization, this
fixes the topology information in
/sys/devices/system/cpu/cpu[n]/topology

Signed-off-by: Bo Yan <byan@nvidia.com>
---
V2: remove cache nodes, add topology data only

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 58 +++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6dfa1ca..35e6e76 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -870,56 +870,98 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cl0_0>;
+				};
+
+				core1 {
+					cpu = <&cl0_1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cl1_0>;
+				};
+
+				core1 {
+					cpu = <&cl1_1>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cl2_0>;
+				};
+
+				core1 {
+					cpu = <&cl2_1>;
+				};
+			};
+
+			cluster3 {
+				core0 {
+					cpu = <&cl3_0>;
+				};
+
+				core1 {
+					cpu = <&cl3_1>;
+				};
+			};
+		};
+
+		cl0_0: cpu@0 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x10000>;
 			enable-method = "psci";
 		};
 
-		cpu@1 {
+		cl0_1: cpu@1 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x10001>;
 			enable-method = "psci";
 		};
 
-		cpu@2 {
+		cl1_0: cpu@2 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x100>;
 			enable-method = "psci";
 		};
 
-		cpu@3 {
+		cl1_1: cpu@3 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x101>;
 			enable-method = "psci";
 		};
 
-		cpu@4 {
+		cl2_0: cpu@4 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x200>;
 			enable-method = "psci";
 		};
 
-		cpu@5 {
+		cl2_1: cpu@5 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x201>;
 			enable-method = "psci";
 		};
 
-		cpu@6 {
+		cl3_0: cpu@6 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x10300>;
 			enable-method = "psci";
 		};
 
-		cpu@7 {
+		cl3_1: cpu@7 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x10301>;
-- 
2.7.4

