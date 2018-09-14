Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025FFECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B927820861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B927820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeINVDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:03:21 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:35602 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINVDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:03:20 -0400
X-IronPort-AV: E=Sophos;i="5.53,373,1531810800"; 
   d="scan'208";a="19979059"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2018 08:48:15 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Fri, 14 Sep 2018 08:48:15 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: dts: at91: add new compatibility string for macb on sama5d3
Date:   Fri, 14 Sep 2018 17:48:11 +0200
Message-ID: <20180914154811.12090-2-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180914154811.12090-1-nicolas.ferre@microchip.com>
References: <20180914154811.12090-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need this new compatibility string as we experienced different behavior
for this 10/100Mbits/s macb interface on this particular SoC.
Backward compatibility is preserved as we keep the alternative strings.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/devicetree/bindings/net/macb.txt | 1 +
 arch/arm/boot/dts/sama5d3_emac.dtsi            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index 457d5ae16f23..3e17ac1d5d58 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -10,6 +10,7 @@ Required properties:
   Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
   the Cadence GEM, or the generic form: "cdns,gem".
   Use "atmel,sama5d2-gem" for the GEM IP (10/100) available on Atmel sama5d2 SoCs.
+  Use "atmel,sama5d3-macb" for the 10/100Mbit IP available on Atmel sama5d3 SoCs.
   Use "atmel,sama5d3-gem" for the Gigabit IP available on Atmel sama5d3 SoCs.
   Use "atmel,sama5d4-gem" for the GEM IP (10/100) available on Atmel sama5d4 SoCs.
   Use "cdns,zynq-gem" Xilinx Zynq-7xxx SoC.
diff --git a/arch/arm/boot/dts/sama5d3_emac.dtsi b/arch/arm/boot/dts/sama5d3_emac.dtsi
index 7cb235ef0fb6..6e9e1c2f9def 100644
--- a/arch/arm/boot/dts/sama5d3_emac.dtsi
+++ b/arch/arm/boot/dts/sama5d3_emac.dtsi
@@ -41,7 +41,7 @@
 			};
 
 			macb1: ethernet@f802c000 {
-				compatible = "cdns,at91sam9260-macb", "cdns,macb";
+				compatible = "atmel,sama5d3-macb", "cdns,at91sam9260-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
-- 
2.15.1

