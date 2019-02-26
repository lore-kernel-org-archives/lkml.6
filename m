Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D909CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAF92173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPXgBDzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfBZHEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:04:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44040 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfBZHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:04:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id c4so5752457pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 23:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=53MU+PrJEz/r+Dn9mTJrPuyEaFLQINLwi+DDlahI7lM=;
        b=OPXgBDzRp7QyoZv9Qyl/SKZFnjIiejB64kQd5JcYgOFdk2ij76aN4Ia+RkA3R2/t7n
         eflixowpiXrU0CTXcioWGD1lnbZWnGboP5rDWJQIZek08aGlKhHxoZ0iaQ5rQsMfEGCi
         kfLz9t8+JG//QvFKm+KTg2eVwTygVzi/FxlDP0+9iWqXo++Ml3XAsTBiWdUlkWdjwVhq
         TzX4eWx0TbGHb8nQlYmijxdwUKn+xtarKZ/BIEBZ+3RkRAwD6LEiU1iwkLids6hMMKco
         UHe7V5NTxONmVKdosPgr6zsAo9JZV44OzVELVkLMKLLk5rSy2siS5eMvN8NpXta465Lr
         fFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=53MU+PrJEz/r+Dn9mTJrPuyEaFLQINLwi+DDlahI7lM=;
        b=dGmiVdntpk0x8WI/mqJ3orSaW9BQHWBwUmRwS5PGwPPtx7BLJfEE25J7VP6immxG0k
         GXkwikLOs3ZBbSUcqEOM68hl/E42aRKA3UyRIbPfNDJAdbBxL1GU3JBgUpeMvsWf3JHO
         bIFhC9Nxmq9japdHhDSZ1oHqI0HjTsl9UZdlRk2396Bxqrk8Yk78GocZq9PJn1qdQ083
         dG4e4AS+3+690W8D70WHRrc6CUxNqljhPTn/1tIZl1hs0oXNDGM4jYrYkLGR7FNfvA/u
         /8mCNIZQBgWz/MWr/k1PM1IE8+aB9cx/6BJTrvRlI3OHCRzmvQRYSre+8okY+QTBJKiy
         w/1A==
X-Gm-Message-State: AHQUAuZCDfrDNMam/zS9z9jXcFn+KSFR7R8Moac65dl1rqOLq2boNS+4
        e3TLKzPab3MhAMzuc+8m1xax8w==
X-Google-Smtp-Source: AHgI3IZ6qU8SlDsh3Sm6sSqiGUWfej6bmLHNNGuXTTsLyW0SPQYEPrxisV9K/ID34hm/P2K7cxuFTQ==
X-Received: by 2002:a17:902:8217:: with SMTP id x23mr5549463pln.332.1551164694064;
        Mon, 25 Feb 2019 23:04:54 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c127sm24074059pfg.133.2019.02.25.23.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 23:04:53 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: Add GEN2 PCIe controller and PHY
Date:   Mon, 25 Feb 2019 23:05:25 -0800
Message-Id: <20190226070525.22453-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 sports two PCIe controller/phy pairs; one GEN2 and one GEN3. Add
the nodes for the GEN2 pair.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 103 +++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5308f1671824..43848653babd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1024,6 +1024,109 @@
 			};
 		};
 
+		pcie0: pci@1c00000 {
+			compatible = "qcom,pcie-sdm845", "snps,dw-pcie";
+			ret = <0 0x01c00000 0 0x2000>,
+			      <0 0x60000000 0 0xf1d>,
+			      <0 0x60000f20 0 0xa8>,
+			      <0 0x60100000 0 0x100000>;
+			reg-names = "parf", "dbi", "elbi", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0xd00000>;
+
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+			clock-names = "pipe",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "tbu";
+
+			iommu-map = <0x0 &apps_smmu 0x1c10 0x1>,
+				    <0x100 &apps_smmu 0x1c11 0x1>,
+				    <0x200 &apps_smmu 0x1c12 0x1>,
+				    <0x300 &apps_smmu 0x1c13 0x1>,
+				    <0x400 &apps_smmu 0x1c14 0x1>,
+				    <0x500 &apps_smmu 0x1c15 0x1>,
+				    <0x600 &apps_smmu 0x1c16 0x1>,
+				    <0x700 &apps_smmu 0x1c17 0x1>,
+				    <0x800 &apps_smmu 0x1c18 0x1>,
+				    <0x900 &apps_smmu 0x1c19 0x1>,
+				    <0xa00 &apps_smmu 0x1c1a 0x1>,
+				    <0xb00 &apps_smmu 0x1c1b 0x1>,
+				    <0xc00 &apps_smmu 0x1c1c 0x1>,
+				    <0xd00 &apps_smmu 0x1c1d 0x1>,
+				    <0xe00 &apps_smmu 0x1c1e 0x1>,
+				    <0xf00 &apps_smmu 0x1c1f 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc PCIE_0_GDSC>;
+
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sdm845-qmp-pcie-phy";
+			reg = <0 0x01c06000 0 0x18c>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
+				 <&gcc GCC_PCIE_PHY_REFGEN_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_PHY_REFGEN_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			status = "disabled";
+
+			pcie0_lane: lanes@1c06200 {
+				reg = <0 0x01c06200 0 0x128>,
+				      <0 0x01c06400 0 0x1fc>,
+				      <0 0x01c06800 0 0x218>,
+				      <0 0x01c06600 0 0x70>;
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#phy-cells = <0>;
+				clock-output-names = "pcie_0_pipe_clk";
+			};
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-- 
2.18.0

