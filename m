Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACE82084D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACE82084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933117AbeGCO5g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:57:36 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:39664 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeGCO5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:57:10 -0400
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="16634824"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jul 2018 07:56:51 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 3 Jul 2018 07:56:50 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <alexandre.belloni@bootlin.com>,
        <nicolas.ferre@microchip.com>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quentin.schulz@bootlin.com>
CC:     <Cristian.Birsan@microchip.com>
Subject: [PATCH 2/2] ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to aclk
Date:   Tue, 3 Jul 2018 17:56:31 +0300
Message-ID: <20180703145631.15246-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703145631.15246-1-codrin.ciubotariu@microchip.com>
References: <20180703145631.15246-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The optional clock phandle to aclk (Audio PLL clock) is no longer needed
by the driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 Documentation/devicetree/bindings/sound/atmel-i2s.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel-i2s.txt b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
index 735368b8a73f..40549f496a81 100644
--- a/Documentation/devicetree/bindings/sound/atmel-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
@@ -15,7 +15,6 @@ Required properties:
 - clock-names:    Should be one of each entry matching the clocks phandles list:
                   - "pclk" (peripheral clock) Required.
                   - "gclk" (generated clock) Optional (1).
-                  - "aclk" (Audio PLL clock) Optional (1).
                   - "muxclk" (I2S mux clock) Optional (1).
 
 Optional properties:
@@ -23,9 +22,9 @@ Optional properties:
 - princtrl-names: Should contain only one value - "default".
 
 
-(1) : Only the peripheral clock is required. The generated clock, the Audio
-      PLL clock adn the I2S mux clock are optional and should only be set
-      together, when Master Mode is required.
+(1) : Only the peripheral clock is required. The generated clock and the I2S
+      mux clock are optional and should only be set together, when Master Mode
+      is required.
 
 Example:
 
@@ -40,8 +39,8 @@ Example:
 			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 			 AT91_XDMAC_DT_PERID(32))>;
 		dma-names = "tx", "rx";
-		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
-		clock-names = "pclk", "gclk", "aclk", "muxclk";
+		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&i2s0muxck>;
+		clock-names = "pclk", "gclk", "muxclk";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2s0_default>;
 	};
-- 
2.17.1

