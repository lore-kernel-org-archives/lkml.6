Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E85813F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22F420893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22F420893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeG3NPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:15:24 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:14734 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeG3NPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:15:23 -0400
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="16959140"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jul 2018 04:40:49 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Mon, 30 Jul 2018 04:40:48 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Cristian.Birsan@microchip.com>
Subject: [PATCH v6 1/3] ARM: dts: at91: sama5d2: add I2S clock muxing nodes
Date:   Mon, 30 Jul 2018 14:40:06 +0300
Message-ID: <20180730114008.30464-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730114008.30464-1-codrin.ciubotariu@microchip.com>
References: <20180730114008.30464-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two clock muxes for the two I2S
buses present on sama5d2 platforms.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v6:
	- none

 arch/arm/boot/dts/sama5d2.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5c48e9..eeb6afa1cda7 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -992,6 +992,24 @@
 						atmel,clk-output-range = <0 100000000>;
 					};
 				};
+
+				i2s_clkmux {
+					compatible = "atmel,sama5d2-clk-i2s-mux";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					i2s0muxck: i2s0_muxclk {
+						clocks = <&i2s0_clk>, <&i2s0_gclk>;
+						#clock-cells = <0>;
+						reg = <0>;
+					};
+
+					i2s1muxck: i2s1_muxclk {
+						clocks = <&i2s1_clk>, <&i2s1_gclk>;
+						#clock-cells = <0>;
+						reg = <1>;
+					};
+				};
 			};
 
 			qspi0: spi@f0020000 {
-- 
2.17.1

