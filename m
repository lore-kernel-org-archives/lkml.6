Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FBAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4C8218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CGJZoTEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfAaSgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:36:32 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18314 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfAaSgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:36:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c53402f0002>; Thu, 31 Jan 2019 10:36:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 10:36:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 10:36:29 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 18:36:29 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 18:36:28 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 18:36:28 +0000
Received: from byan-linux.NVIDIA.COM (Not Verified[172.17.136.14]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c53402c0005>; Thu, 31 Jan 2019 10:36:28 -0800
From:   Bo Yan <byan@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, Bo Yan <byan@nvidia.com>
Subject: [PATCH] arm64: tegra: add topology data for Tegra194 cpu
Date:   Thu, 31 Jan 2019 10:35:54 -0800
Message-ID: <1548959754-3941-1-git-send-email-byan@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548959791; bh=VScH3OFgtB7ecWCvWawJ3p1afFHfmelNMZa9uP4vm44=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=CGJZoTEwAGfpc46+VyUo9H+TpK7le7XrMJGpZ7GoUFa2gjdR+of6FoLM2Tf/VDzRv
         THhZ1bkGi/cDLJ0ZrC+IpJnTnhoWzVTY2HNkZEGxd7euy1LwJlc6/Rfxj20nhnafqC
         E3rcNhBijg78smhiBcqavwd1KxnM/kaNqiPgd1etvhjwsWjKMi1XceP9fjq5Lfg8RM
         qECjvli48pDEsbFhQevz+DQ8NjGhkvx6SlcGxCZJupV/cYWNUxtg4iKa/beRD/BxL4
         uQKgbhL703kSRzSxdv70ud24d4KvTftah4eZ7U/fW8XzGjvj8xhmN11zCRdpyq6MvD
         UKzsiesRQch8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xavier CPU architecture includes 8 CPU cores organized in
4 clusters. Add cpu-map data for topology initialization, add
cache data for cache node creation in sysfs.

Signed-off-by: Bo Yan <byan@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 148 +++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6dfa1ca..7c2a1fb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -870,63 +870,195 @@
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
+			i-cache-size = <131072>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <512>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache_sets = <256>;
+			l2-cache = <&l2_0>;
 		};
 
-		cpu@1 {
+		cl0_1: cpu@1 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x10001>;
 			enable-method = "psci";
+			i-cache-size = <131072>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <512>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache_sets = <256>;
+			l2-cache = <&l2_0>;
 		};
 
-		cpu@2 {
+		cl1_0: cpu@2 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x100>;
 			enable-method = "psci";
+			i-cache-size = <131072>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <512>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache_sets = <256>;
+			l2-cache = <&l2_1>;
 		};
 
-		cpu@3 {
+		cl1_1: cpu@3 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x101>;
 			enable-method = "psci";
+			i-cache-size = <131072>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <512>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache_sets = <256>;
+			l2-cache = <&l2_1>;
 		};
 
-		cpu@4 {
+		cl2_0: cpu@4 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x200>;
 			enable-method = "psci";
+			i-cache-size = <131072>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <512>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache_sets = <256>;
+			l2-cache = <&l2_2>;
 		};
 
-		cpu@5 {
+		cl2_1: cpu@5 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x201>;
 			enable-method = "psci";
+			i-cache-size = <131072>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <512>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache_sets = <256>;
+			l2-cache = <&l2_2>;
 		};
 
-		cpu@6 {
+		cl3_0: cpu@6 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x10300>;
 			enable-method = "psci";
+			i-cache-size = <131072>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <512>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache_sets = <256>;
+			l2-cache = <&l2_3>;
 		};
 
-		cpu@7 {
+		cl3_1: cpu@7 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x10301>;
 			enable-method = "psci";
+			i-cache-size = <131072>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <512>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache_sets = <256>;
+			l2-cache = <&l2_3>;
 		};
 	};
 
+	l2_0: l2-cache0 {
+		cache-size = <2097152>;
+		cache-line-size = <64>;
+		cache-sets = <2048>;
+		next-level-cache = <&l3>;
+	};
+
+	l2_1: l2-cache1 {
+		cache-size = <2097152>;
+		cache-line-size = <64>;
+		cache-sets = <2048>;
+		next-level-cache = <&l3>;
+	};
+
+	l2_2: l2-cache2 {
+		cache-size = <2097152>;
+		cache-line-size = <64>;
+		cache-sets = <2048>;
+		next-level-cache = <&l3>;
+	};
+
+	l2_3: l2-cache3 {
+		cache-size = <2097152>;
+		cache-line-size = <64>;
+		cache-sets = <2048>;
+		next-level-cache = <&l3>;
+	};
+
+	l3: l3-cache {
+		cache-size = <4194304>;
+		cache-line-size = <64>;
+		cache-sets = <4096>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		status = "okay";
-- 
2.7.4

