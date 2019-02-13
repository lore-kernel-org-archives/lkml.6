Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F610C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A6D222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rDEj2z8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404365AbfBMQdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:33:47 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3600 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404309AbfBMQdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:33:46 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6446ed0000>; Wed, 13 Feb 2019 08:33:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Feb 2019 08:33:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Feb 2019 08:33:46 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Feb
 2019 16:33:45 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Feb 2019 16:33:45 +0000
Received: from byan-linux.NVIDIA.COM (Not Verified[172.17.136.14]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6446e90000>; Wed, 13 Feb 2019 08:33:45 -0800
From:   Bo Yan <byan@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Yan <byan@nvidia.com>
Subject: [PATCH V3] arm64: tegra: add topology data for Tegra194 cpu
Date:   Wed, 13 Feb 2019 08:33:42 -0800
Message-ID: <1550075622-1072-1-git-send-email-byan@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190213081252.GA647@ulmo>
References: <20190213081252.GA647@ulmo>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550075629; bh=Hk1GzH1q13DWR88RQq0ZOwpS7kHyY3R/0frlX19/ReA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=rDEj2z8iddLo/+zvkTgsCUTLSkrwbv24KIQsPfoPqGIs7wc7GmxKtHV/01PP2bhv5
         5YadqfCaTN72Tcl0ce24tiZ7siVGJoAbxOcHyorbiA90VGs9usgpZ21JOcinI00B+y
         D0fTMZuFBBim++eeRMAuXWfF/zPrhKb5SGUElUHOfaWkUGcT8F5N56rT1YIp/9Cbiu
         cxEA5cAAp+lArX8wsa0tH20zNEwJJiF4StmznMFf9Q+eT6mrIKY/XXSB1LX6035X6v
         sar1NYXJSvemG4Qkh5L8Axtt8wdMOma4iwxI1RRDkEO+dyWqeMfu5alx5hJEybQuAk
         Uh1HCNvj7ip5A==
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
V3: Replaced phandles with full path to CPU node
V2: remove cache nodes, add topology data only

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6dfa1ca..708d20c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -870,6 +870,48 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&{/cpus/cpu@0}>;
+				};
+
+				core1 {
+					cpu = <&{/cpus/cpu@1}>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&{/cpus/cpu@2}>;
+				};
+
+				core1 {
+					cpu = <&{/cpus/cpu@3}>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&{/cpus/cpu@4}>;
+				};
+
+				core1 {
+					cpu = <&{/cpus/cpu@5}>;
+				};
+			};
+
+			cluster3 {
+				core0 {
+					cpu = <&{/cpus/cpu@6}>;
+				};
+
+				core1 {
+					cpu = <&{/cpus/cpu@7}>;
+				};
+			};
+		};
+
 		cpu@0 {
 			compatible = "nvidia,tegra194-carmel", "arm,armv8";
 			device_type = "cpu";
-- 
2.7.4

