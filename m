Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FCEC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5D20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA5D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeJWBqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:46:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:24674 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbeJWBqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:46:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 10:26:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,412,1534834800"; 
   d="scan'208";a="274601773"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga006.fm.intel.com with ESMTP; 22 Oct 2018 10:26:53 -0700
From:   thor.thayer@linux.intel.com
To:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 1/2] arm64: dts: stratix10: Support for Ethernet Jumbo frame
Date:   Mon, 22 Oct 2018 12:29:11 -0500
Message-Id: <1540229352-26010-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Properly specify the RX and TX FIFO size which is important
for Jumbo frames.
Update the max-frame-size to support Jumbo frames.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi      | 6 ++++++
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index d033da401c26..8a2641c742ae 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -137,6 +137,8 @@
 			reset-names = "stmmaceth", "stmmaceth-ocp";
 			clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
 			clock-names = "stmmaceth";
+			tx-fifo-depth = <16384>;
+			rx-fifo-depth = <16384>;
 			status = "disabled";
 		};
 
@@ -150,6 +152,8 @@
 			reset-names = "stmmaceth", "stmmaceth-ocp";
 			clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
 			clock-names = "stmmaceth";
+			tx-fifo-depth = <16384>;
+			rx-fifo-depth = <16384>;
 			status = "disabled";
 		};
 
@@ -163,6 +167,8 @@
 			reset-names = "stmmaceth", "stmmaceth-ocp";
 			clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
 			clock-names = "stmmaceth";
+			tx-fifo-depth = <16384>;
+			rx-fifo-depth = <16384>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 6edc4fa9fd42..7c661753bfaf 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -76,7 +76,7 @@
 	phy-mode = "rgmii";
 	phy-handle = <&phy0>;
 
-	max-frame-size = <3800>;
+	max-frame-size = <9000>;
 
 	mdio0 {
 		#address-cells = <1>;
-- 
2.7.4

