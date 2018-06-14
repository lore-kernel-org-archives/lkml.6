Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0D543C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50AE208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50AE208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964832AbeFNLCS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:02:18 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:54299 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964779AbeFNLCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:02:16 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 14 Jun 2018 20:02:14 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 9AA707A706;
        Thu, 14 Jun 2018 20:02:14 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,222,1526310000"; 
   d="scan'208";a="282525594"
Received: from unknown (HELO be1yocto.ree.adwin.renesas.com) ([172.29.43.62])
  by relmlii1.idc.renesas.com with ESMTP; 14 Jun 2018 20:02:11 +0900
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/5] dt-bindings: Add the r9a06g032-sysctrl.h file
Date:   Thu, 14 Jun 2018 11:56:30 +0100
Message-Id: <1528973829-25493-2-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the constants necessary to use the renesas,r9a06g032-sysctrl node.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/r9a06g032-sysctrl.h | 148 ++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 include/dt-bindings/clock/r9a06g032-sysctrl.h

diff --git a/include/dt-bindings/clock/r9a06g032-sysctrl.h b/include/dt-bindings/clock/r9a06g032-sysctrl.h
new file mode 100644
index 0000000..90c0f3d
--- /dev/null
+++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * R9A06G032 sysctrl IDs
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_R9A06G032_SYSCTRL_H__
+#define __DT_BINDINGS_R9A06G032_SYSCTRL_H__
+
+#define R9A06G032_CLK_PLL_USB		1
+#define R9A06G032_CLK_48		1	/* AKA CLK_PLL_USB */
+#define R9A06G032_MSEBIS_CLK		3	/* AKA CLKOUT_D16 */
+#define R9A06G032_MSEBIM_CLK		3	/* AKA CLKOUT_D16 */
+#define R9A06G032_CLK_DDRPHY_PLLCLK	5	/* AKA CLKOUT_D1OR2 */
+#define R9A06G032_CLK50			6	/* AKA CLKOUT_D20 */
+#define R9A06G032_CLK25			7	/* AKA CLKOUT_D40 */
+#define R9A06G032_CLK125		9	/* AKA CLKOUT_D8 */
+#define R9A06G032_CLK_P5_PG1		17	/* AKA DIV_P5_PG */
+#define R9A06G032_CLK_REF_SYNC		21	/* AKA DIV_REF_SYNC */
+#define R9A06G032_CLK_25_PG4		26
+#define R9A06G032_CLK_25_PG5		27
+#define R9A06G032_CLK_25_PG6		28
+#define R9A06G032_CLK_25_PG7		29
+#define R9A06G032_CLK_25_PG8		30
+#define R9A06G032_CLK_ADC		31
+#define R9A06G032_CLK_ECAT100		32
+#define R9A06G032_CLK_HSR100		33
+#define R9A06G032_CLK_I2C0		34
+#define R9A06G032_CLK_I2C1		35
+#define R9A06G032_CLK_MII_REF		36
+#define R9A06G032_CLK_NAND		37
+#define R9A06G032_CLK_NOUSBP2_PG6	38
+#define R9A06G032_CLK_P1_PG2		39
+#define R9A06G032_CLK_P1_PG3		40
+#define R9A06G032_CLK_P1_PG4		41
+#define R9A06G032_CLK_P4_PG3		42
+#define R9A06G032_CLK_P4_PG4		43
+#define R9A06G032_CLK_P6_PG1		44
+#define R9A06G032_CLK_P6_PG2		45
+#define R9A06G032_CLK_P6_PG3		46
+#define R9A06G032_CLK_P6_PG4		47
+#define R9A06G032_CLK_PCI_USB		48
+#define R9A06G032_CLK_QSPI0		49
+#define R9A06G032_CLK_QSPI1		50
+#define R9A06G032_CLK_RGMII_REF		51
+#define R9A06G032_CLK_RMII_REF		52
+#define R9A06G032_CLK_SDIO0		53
+#define R9A06G032_CLK_SDIO1		54
+#define R9A06G032_CLK_SERCOS100		55
+#define R9A06G032_CLK_SLCD		56
+#define R9A06G032_CLK_SPI0		57
+#define R9A06G032_CLK_SPI1		58
+#define R9A06G032_CLK_SPI2		59
+#define R9A06G032_CLK_SPI3		60
+#define R9A06G032_CLK_SPI4		61
+#define R9A06G032_CLK_SPI5		62
+#define R9A06G032_CLK_SWITCH		63
+#define R9A06G032_HCLK_ECAT125		65
+#define R9A06G032_HCLK_PINCONFIG	66
+#define R9A06G032_HCLK_SERCOS		67
+#define R9A06G032_HCLK_SGPIO2		68
+#define R9A06G032_HCLK_SGPIO3		69
+#define R9A06G032_HCLK_SGPIO4		70
+#define R9A06G032_HCLK_TIMER0		71
+#define R9A06G032_HCLK_TIMER1		72
+#define R9A06G032_HCLK_USBF		73
+#define R9A06G032_HCLK_USBH		74
+#define R9A06G032_HCLK_USBPM		75
+#define R9A06G032_CLK_48_PG_F		76
+#define R9A06G032_CLK_48_PG4		77
+#define R9A06G032_CLK_DDRPHY_PCLK	81	/* AKA CLK_REF_SYNC_D4 */
+#define R9A06G032_CLK_FW		81	/* AKA CLK_REF_SYNC_D4 */
+#define R9A06G032_CLK_CRYPTO		81	/* AKA CLK_REF_SYNC_D4 */
+#define R9A06G032_CLK_A7MP		84	/* AKA DIV_CA7 */
+#define R9A06G032_HCLK_CAN0		85
+#define R9A06G032_HCLK_CAN1		86
+#define R9A06G032_HCLK_DELTASIGMA	87
+#define R9A06G032_HCLK_PWMPTO		88
+#define R9A06G032_HCLK_RSV		89
+#define R9A06G032_HCLK_SGPIO0		90
+#define R9A06G032_HCLK_SGPIO1		91
+#define R9A06G032_RTOS_MDC		92
+#define R9A06G032_CLK_CM3		93
+#define R9A06G032_CLK_DDRC		94
+#define R9A06G032_CLK_ECAT25		95
+#define R9A06G032_CLK_HSR50		96
+#define R9A06G032_CLK_HW_RTOS		97
+#define R9A06G032_CLK_SERCOS50		98
+#define R9A06G032_HCLK_ADC		99
+#define R9A06G032_HCLK_CM3		100
+#define R9A06G032_HCLK_CRYPTO_EIP150	101
+#define R9A06G032_HCLK_CRYPTO_EIP93	102
+#define R9A06G032_HCLK_DDRC		103
+#define R9A06G032_HCLK_DMA0		104
+#define R9A06G032_HCLK_DMA1		105
+#define R9A06G032_HCLK_GMAC0		106
+#define R9A06G032_HCLK_GMAC1		107
+#define R9A06G032_HCLK_GPIO0		108
+#define R9A06G032_HCLK_GPIO1		109
+#define R9A06G032_HCLK_GPIO2		110
+#define R9A06G032_HCLK_HSR		111
+#define R9A06G032_HCLK_I2C0		112
+#define R9A06G032_HCLK_I2C1		113
+#define R9A06G032_HCLK_LCD		114
+#define R9A06G032_HCLK_MSEBI_M		115
+#define R9A06G032_HCLK_MSEBI_S		116
+#define R9A06G032_HCLK_NAND		117
+#define R9A06G032_HCLK_PG_I		118
+#define R9A06G032_HCLK_PG19		119
+#define R9A06G032_HCLK_PG20		120
+#define R9A06G032_HCLK_PG3		121
+#define R9A06G032_HCLK_PG4		122
+#define R9A06G032_HCLK_QSPI0		123
+#define R9A06G032_HCLK_QSPI1		124
+#define R9A06G032_HCLK_ROM		125
+#define R9A06G032_HCLK_RTC		126
+#define R9A06G032_HCLK_SDIO0		127
+#define R9A06G032_HCLK_SDIO1		128
+#define R9A06G032_HCLK_SEMAP		129
+#define R9A06G032_HCLK_SPI0		130
+#define R9A06G032_HCLK_SPI1		131
+#define R9A06G032_HCLK_SPI2		132
+#define R9A06G032_HCLK_SPI3		133
+#define R9A06G032_HCLK_SPI4		134
+#define R9A06G032_HCLK_SPI5		135
+#define R9A06G032_HCLK_SWITCH		136
+#define R9A06G032_HCLK_SWITCH_RG	137
+#define R9A06G032_HCLK_UART0		138
+#define R9A06G032_HCLK_UART1		139
+#define R9A06G032_HCLK_UART2		140
+#define R9A06G032_HCLK_UART3		141
+#define R9A06G032_HCLK_UART4		142
+#define R9A06G032_HCLK_UART5		143
+#define R9A06G032_HCLK_UART6		144
+#define R9A06G032_HCLK_UART7		145
+#define R9A06G032_CLK_UART0		146
+#define R9A06G032_CLK_UART1		147
+#define R9A06G032_CLK_UART2		148
+#define R9A06G032_CLK_UART3		149
+#define R9A06G032_CLK_UART4		150
+#define R9A06G032_CLK_UART5		151
+#define R9A06G032_CLK_UART6		152
+#define R9A06G032_CLK_UART7		153
+
+#endif /* __DT_BINDINGS_R9A06G032_SYSCTRL_H__ */
-- 
2.7.4

