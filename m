Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D65240BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NTe+ZqPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D65240BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbeGEOV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:21:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41742 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeGEOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:21:57 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w65ELXjb122137;
        Thu, 5 Jul 2018 09:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530800493;
        bh=TrtCegeIR0JjCkmA+xteXb30NyR5h9Sc/YNtffGEHBY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NTe+ZqPUSRrYAGjKWPLEH6E5PLlogRCAnXuSz8M3N0ggovcamVWRKv7iOx2wFAspS
         k7RPsvPDECF7nk2PmCQu8XanGyJ8B/EKL5L0nINx9h7m0YRTe+pSgyYxD3OUGb7wnV
         llQRnywR/X/1eqvIwX9liGhIWluKWfdfvXCXb0IA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w65ELXcR019504;
        Thu, 5 Jul 2018 09:21:33 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 5 Jul
 2018 09:21:32 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 5 Jul 2018 09:21:32 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w65ELPxg020259;
        Thu, 5 Jul 2018 09:21:29 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <mark.rutland@arm.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v4 1/6] ARM: dts: dra762: Add MCAN clock support
Date:   Thu, 5 Jul 2018 19:53:14 +0530
Message-ID: <20180705142319.19583-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180705142319.19583-1-faiz_abbas@ti.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

MCAN is clocked by H14 divider of DPLL_GMAC. Unlike other
DPLL dividers this DPLL_GMAC H14 divider is controlled by
control module. Adding support for these clocks.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76x.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index 1c88c581ff18..bfc82636999c 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -17,3 +17,36 @@
 &crossbar_mpu {
 	ti,irqs-skip = <10 67 68 133 139 140>;
 };
+
+&scm_conf_clocks {
+	dpll_gmac_h14x2_ctrl_ck: dpll_gmac_h14x2_ctrl_ck@3fc {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_gmac_x2_ck>;
+		ti,max-div = <63>;
+		reg = <0x03fc>;
+		ti,bit-shift=<20>;
+		ti,latch-bit=<26>;
+		assigned-clocks = <&dpll_gmac_h14x2_ctrl_ck>;
+		assigned-clock-rates = <80000000>;
+	};
+
+	dpll_gmac_h14x2_ctrl_mux_ck: dpll_gmac_h14x2_ctrl_mux_ck@3fc {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&dpll_gmac_ck>, <&dpll_gmac_h14x2_ctrl_ck>;
+		reg = <0x3fc>;
+		ti,bit-shift = <29>;
+		ti,latch-bit=<26>;
+		assigned-clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
+		assigned-clock-parents = <&dpll_gmac_h14x2_ctrl_ck>;
+	};
+
+	mcan_clk: mcan_clk@3fc {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
+		ti,bit-shift = <27>;
+		reg = <0x3fc>;
+	};
+};
-- 
2.17.0

