Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF5BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1536A20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hQBIZVbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1536A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeGIQr2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:47:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45072 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933207AbeGIQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:47:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w69Gl0gQ092162;
        Mon, 9 Jul 2018 11:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531154820;
        bh=TrtCegeIR0JjCkmA+xteXb30NyR5h9Sc/YNtffGEHBY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hQBIZVbHT4/gmMdGXMrUZHw11+1pN5O4P3nc1fn7wtK8Mp4w/I1eL1lwPJClFYKG7
         DknhxY0V2Bp7mar7ilOEVVeH6appxPflsFIrWLx6uHtybij3zliBGaaK/+VH9R7SM2
         26sM/xlJM5UJ2S6PyKQzTa0uC15lp5xb3UmgubEw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w69Gl0oI017315;
        Mon, 9 Jul 2018 11:47:00 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 9 Jul
 2018 11:47:00 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 9 Jul 2018 11:46:59 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w69GkpWB001873;
        Mon, 9 Jul 2018 11:46:56 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <mark.rutland@arm.com>,
        <faiz_abbas@ti.com>, <sboyd@kernel.org>
Subject: [PATCH v5 1/6] ARM: dts: dra762: Add MCAN clock support
Date:   Mon, 9 Jul 2018 22:18:36 +0530
Message-ID: <20180709164841.14182-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180709164841.14182-1-faiz_abbas@ti.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
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

