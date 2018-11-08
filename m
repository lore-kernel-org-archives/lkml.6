Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38BC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3B32081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3B32081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeKHWuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:50:52 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:27678 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHWuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:50:51 -0500
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 8 Nov 2018
 21:15:23 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
Date:   Thu, 8 Nov 2018 21:15:10 +0800
Message-ID: <1541682912-120480-2-git-send-email-jian.hu@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
References: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new clock controller compatible and dt-bingdings headers
for the Everything-Else domain of the g12a SoC

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
 .../bindings/clock/amlogic,gxbb-clkc.txt           |  1 +
 include/dt-bindings/clock/g12a-clkc.h              | 93 ++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index e950599..0833006 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -9,6 +9,7 @@ Required Properties:
 		"amlogic,gxbb-clkc" for GXBB SoC,
 		"amlogic,gxl-clkc" for GXL and GXM SoC,
 		"amlogic,axg-clkc" for AXG SoC.
+		"amlogic,g12a-clkc" for G12A SoC.
 
 - #clock-cells: should be 1.
 
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
new file mode 100644
index 0000000..b55e6e1
--- /dev/null
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Meson-G12A clock tree IDs
+ *
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __G12A_CLKC_H
+#define __G12A_CLKC_H
+
+#define CLKID_SYS_PLL				0
+#define CLKID_FIXED_PLL				1
+#define CLKID_FCLK_DIV2				2
+#define CLKID_FCLK_DIV3				3
+#define CLKID_FCLK_DIV4				4
+#define CLKID_FCLK_DIV5				5
+#define CLKID_FCLK_DIV7				6
+#define CLKID_GP0_PLL				7
+#define CLKID_CLK81				10
+#define CLKID_MPLL0				11
+#define CLKID_MPLL1				12
+#define CLKID_MPLL2				13
+#define CLKID_MPLL3				14
+#define CLKID_DDR				15
+#define CLKID_DOS				16
+#define CLKID_AUDIO_LOCKER			17
+#define CLKID_MIPI_DSI_HOST			18
+#define CLKID_ETH_PHY				19
+#define CLKID_ISA				20
+#define CLKID_PL301				21
+#define CLKID_PERIPHS				22
+#define CLKID_SPICC0				23
+#define CLKID_I2C				24
+#define CLKID_SANA				25
+#define CLKID_SD				26
+#define CLKID_RNG0				27
+#define CLKID_UART0				28
+#define CLKID_SPICC1				29
+#define CLKID_HIU_IFACE				30
+#define CLKID_MIPI_DSI_PHY			31
+#define CLKID_ASSIST_MISC			32
+#define CLKID_SD_EMMC_A				33
+#define CLKID_SD_EMMC_B				34
+#define CLKID_SD_EMMC_C				35
+#define CLKID_AUDIO_CODEC			36
+#define CLKID_AUDIO				37
+#define CLKID_ETH				38
+#define CLKID_DEMUX				39
+#define CLKID_AUDIO_IFIFO			40
+#define CLKID_ADC				41
+#define CLKID_UART1				42
+#define CLKID_G2D				43
+#define CLKID_RESET				44
+#define CLKID_PCIE_COMB				45
+#define CLKID_PARSER				46
+#define CLKID_USB				47
+#define CLKID_PCIE_PHY				48
+#define CLKID_AHB_ARB0				49
+#define CLKID_AHB_DATA_BUS			50
+#define CLKID_AHB_CTRL_BUS			51
+#define CLKID_HTX_HDCP22			52
+#define CLKID_HTX_PCLK				53
+#define CLKID_BT656				54
+#define CLKID_USB1_DDR_BRIDGE			55
+#define CLKID_MMC_PCLK				56
+#define CLKID_UART2				57
+#define CLKID_VPU_INTR				58
+#define CLKID_GIC				59
+#define CLKID_SD_EMMC_B_CLK0			60
+#define CLKID_SD_EMMC_C_CLK0			61
+#define CLKID_HIFI_PLL				71
+#define CLKID_VCLK2_VENCI0			77
+#define CLKID_VCLK2_VENCI1			78
+#define CLKID_VCLK2_VENCP0			79
+#define CLKID_VCLK2_VENCP1			80
+#define CLKID_VCLK2_VENCT0			81
+#define CLKID_VCLK2_VENCT1			82
+#define CLKID_VCLK2_OTHER			83
+#define CLKID_VCLK2_ENCI			84
+#define CLKID_VCLK2_ENCP			85
+#define CLKID_DAC_CLK				86
+#define CLKID_AOCLK				87
+#define CLKID_IEC958				88
+#define CLKID_ENC480P				89
+#define CLKID_RNG1				90
+#define CLKID_VCLK2_ENCT			91
+#define CLKID_VCLK2_ENCL			92
+#define CLKID_VCLK2_VENCLMMC			93
+#define CLKID_VCLK2_VENCL			94
+#define CLKID_VCLK2_OTHER1			95
+#define CLKID_FCLK_DIV2P5			96
+
+#endif /* __G12A_CLKC_H */
-- 
1.9.1

