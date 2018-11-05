Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54B9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A02F20854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A02F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeKESC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:02:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49882 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726173AbeKESC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:02:29 -0500
X-UUID: aeafd18796504cfdbbdd13c6999b0381-20181105
X-UUID: aeafd18796504cfdbbdd13c6999b0381-20181105
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1768005654; Mon, 05 Nov 2018 16:43:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 5 Nov 2018 16:43:43 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 5 Nov 2018 16:43:43 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-gpio@vger.kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>
Subject: [PATCH 2/2] dt-bindings: pinctrl: update bindings for MT7629 SoC
Date:   Mon, 5 Nov 2018 16:43:41 +0800
Message-ID: <85278445c65854dca6d4f9993a0ca2d048b9e5d8.1541143226.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <6fe4c5fbed14391b6b7fb7d44e42e133e718d6f9.1541143226.git.ryder.lee@mediatek.com>
References: <6fe4c5fbed14391b6b7fb7d44e42e133e718d6f9.1541143226.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates bindings for MT7629 pinctrl driver.

Cc: Sean Wang <sean.wang@kernel.org>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
index 3b69513..4dedce4 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
@@ -3,6 +3,7 @@
 Required properties for the root node:
  - compatible: Should be one of the following
 	       "mediatek,mt7622-pinctrl" for MT7622 SoC
+	       "mediatek,mt7629-pinctrl" for MT7629 SoC
  - reg: offset and length of the pinctrl space
 
  - gpio-controller: Marks the device node as a GPIO controller.
@@ -324,6 +325,133 @@ group.
 	"uart4_2_rts_cts"		"uart"		95, 96
 	"watchdog"			"watchdog"	78
 
+
+== Valid values for pins, function and groups on MT7629 ==
+
+	Pin #:  Valid values for pins
+	-----------------------------
+	PIN 0: "TOP_5G_CLK"
+	PIN 1: "TOP_5G_DATA"
+	PIN 2: "WF0_5G_HB0"
+	PIN 3: "WF0_5G_HB1"
+	PIN 4: "WF0_5G_HB2"
+	PIN 5: "WF0_5G_HB3"
+	PIN 6: "WF0_5G_HB4"
+	PIN 7: "WF0_5G_HB5"
+	PIN 8: "WF0_5G_HB6"
+	PIN 9: "XO_REQ"
+	PIN 10: "TOP_RST_N"
+	PIN 11: "SYS_WATCHDOG"
+	PIN 12: "EPHY_LED0_N_JTDO"
+	PIN 13: "EPHY_LED1_N_JTDI"
+	PIN 14: "EPHY_LED2_N_JTMS"
+	PIN 15: "EPHY_LED3_N_JTCLK"
+	PIN 16: "EPHY_LED4_N_JTRST_N"
+	PIN 17: "WF2G_LED_N"
+	PIN 18: "WF5G_LED_N"
+	PIN 19: "I2C_SDA"
+	PIN 20: "I2C_SCL"
+	PIN 21: "GPIO_9"
+	PIN 22: "GPIO_10"
+	PIN 23: "GPIO_11"
+	PIN 24: "GPIO_12"
+	PIN 25: "UART1_TXD"
+	PIN 26: "UART1_RXD"
+	PIN 27: "UART1_CTS"
+	PIN 28: "UART1_RTS"
+	PIN 29: "UART2_TXD"
+	PIN 30: "UART2_RXD"
+	PIN 31: "UART2_CTS"
+	PIN 32: "UART2_RTS"
+	PIN 33: "MDI_TP_P1"
+	PIN 34: "MDI_TN_P1"
+	PIN 35: "MDI_RP_P1"
+	PIN 36: "MDI_RN_P1"
+	PIN 37: "MDI_RP_P2"
+	PIN 38: "MDI_RN_P2"
+	PIN 39: "MDI_TP_P2"
+	PIN 40: "MDI_TN_P2"
+	PIN 41: "MDI_TP_P3"
+	PIN 42: "MDI_TN_P3"
+	PIN 43: "MDI_RP_P3"
+	PIN 44: "MDI_RN_P3"
+	PIN 45: "MDI_RP_P4"
+	PIN 46: "MDI_RN_P4"
+	PIN 47: "MDI_TP_P4"
+	PIN 48: "MDI_TN_P4"
+	PIN 49: "SMI_MDC"
+	PIN 50: "SMI_MDIO"
+	PIN 51: "PCIE_PERESET_N"
+	PIN 52: "PWM_0"
+	PIN 53: "GPIO_0"
+	PIN 54: "GPIO_1"
+	PIN 55: "GPIO_2"
+	PIN 56: "GPIO_3"
+	PIN 57: "GPIO_4"
+	PIN 58: "GPIO_5"
+	PIN 59: "GPIO_6"
+	PIN 60: "GPIO_7"
+	PIN 61: "GPIO_8"
+	PIN 62: "SPI_CLK"
+	PIN 63: "SPI_CS"
+	PIN 64: "SPI_MOSI"
+	PIN 65: "SPI_MISO"
+	PIN 66: "SPI_WP"
+	PIN 67: "SPI_HOLD"
+	PIN 68: "UART0_TXD"
+	PIN 69: "UART0_RXD"
+	PIN 70: "TOP_2G_CLK"
+	PIN 71: "TOP_2G_DATA"
+	PIN 72: "WF0_2G_HB0"
+	PIN 73: "WF0_2G_HB1"
+	PIN 74: "WF0_2G_HB2"
+	PIN 75: "WF0_2G_HB3"
+	PIN 76: "WF0_2G_HB4"
+	PIN 77: "WF0_2G_HB5"
+	PIN 78: "WF0_2G_HB6"
+
+Valid values for function are:
+	"eth", "i2c", "led", "flash", "pcie", "pwm", "spi", "uart", "watchdog"
+
+	Valid value			function	pins (in pin#)
+	-------------------------------------------------------------------------
+	"wf0_2g"			"eth"		70, 71, 72, 73, 74, 75,
+							76, 77, 78
+	"wf0_5g"			"eth"		0, 1, 2, 3, 4, 5, 6, 7
+							8, 9, 10
+	"mdc_mdio"			"eth"		23, 24
+	"i2c_0"				"i2c"		19, 20
+	"i2c_1"				"i2c"		53, 54
+	"ephy_leds"			"led"		12, 13, 14, 15, 16, 17, 18
+	"ephy0_led"			"led"		12
+	"ephy1_led"			"led"		13
+	"ephy2_led"			"led"		14
+	"ephy3_led"			"led"		15
+	"ephy4_led"			"led"		16
+	"wf2g_led"			"led"		17
+	"wf5g_led"			"led"		18
+	"snfi"				"flash"		62, 63, 64, 65, 66, 67
+	"spi_nor"			"flash"		62, 63, 64, 65, 66, 67
+	"pcie_pereset"			"pcie"		51
+	"pcie_wake"			"pcie"		55
+	"pcie_clkreq"			"pcie"		56
+	"pwm_0"				"pwm"		52
+	"pwm_1"				"pwm"		61
+	"spi_0"				"spi"		21, 22, 23, 24
+	"spi_1"				"spi"		62, 63, 64, 65
+	"spi_wp"			"spi"		66
+	"spi_hold"			"spi"		67
+	"uart0_txd_rxd"			"uart"		68, 69
+	"uart1_0_txd_rxd"		"uart"		25, 26
+	"uart1_0_cts_rts"		"uart"		27, 28
+	"uart1_1_txd_rxd"		"uart"		53, 54
+	"uart1_1_cts_rts"		"uart"		55, 56
+	"uart2_0_txd_rxd"		"uart"		29, 30
+	"uart2_0_cts_rts"		"uart"		31, 32
+	"uart2_1_txd_rxd"		"uart"		57, 58
+	"uart2_1_cts_rts"		"uart"		59, 60
+	"watchdog"			"watchdog"	11
+
 Example:
 
 	pio: pinctrl@10211000 {
-- 
1.9.1

