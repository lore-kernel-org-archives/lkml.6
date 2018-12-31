Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF75C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E882073F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3Rh21ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeLaS4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:56:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43717 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeLaS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:56:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so13456528pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UwW0EYSDEEweABTfqJHVBQZKjbgkRBM0Ptj+o96JZ5g=;
        b=G3Rh21ts1PuS/b2BnKkkiRGJYC76O8Fkl6j0wvYKPCKw+R662nTXYCpw+tPKEr2JEc
         239+4tx7TRmsXnIEk/67z6x6rDLCU8v4V/QGIoccGIv/eP5Cm1HeR3xRtPzydBfmP+J9
         Ncc/Tr75girZ4w9Fy9t+Jyvj1nEvoAgfRLG9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UwW0EYSDEEweABTfqJHVBQZKjbgkRBM0Ptj+o96JZ5g=;
        b=oIImTYcFcH4KTQdxhbmY5KdlKUGFarmbmtKDPXVE55LdPYbGQIGSq+8PnMx4PDS2Qo
         vMPYuD0bqjQ8fW4EzOigLXOrgRu5iqROYqxTzh18IAZT478klRxwMbJQ7nYam35+bdN4
         XMp/Ptk+dRcgrcIuAEDZxi9qWkfkKDKeelYUwmEAtg9yjVvgISZbt0syaWEko2eOYpZU
         Djpn71zgQjiDshn/x0ecn+SsMBix6iRlKNpdCvkFEuZkSW/whE7DlGWeGynTIqhJ+E1+
         9TRHdOo0KDZNanl17ChpGsibHPSZdoJ9O58VzwR94PYq+5a7gFmARS7qyk1twZeWOtLr
         /+Dw==
X-Gm-Message-State: AA+aEWZ/YKuSHEx9UtNgjDUyCVrAgnxZSM2oUxETGg5h+kl4wBghDNLN
        Nbfj07EBMIjla/RCOyg4uwnN
X-Google-Smtp-Source: AFSGD/Uy/7kgxogbyRI+yKooPnj0bgaHzL3uBAoqyXQIaPucp+Asc6IfsF6nbqSiJkGiKeWbVUeKaw==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr39774647pfe.148.1546282571328;
        Mon, 31 Dec 2018 10:56:11 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
        by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 10:56:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Subject: [PATCH 5/6] clk: actions: Add clock driver for S500 SoC
Date:   Tue,  1 Jan 2019 00:25:16 +0530
Message-Id: <20181231185517.18517-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common clock driver for Actions Semi S500 SoC.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
[Mani: cleaned up the driver]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Kconfig    |   5 +
 drivers/clk/actions/Makefile   |   1 +
 drivers/clk/actions/owl-s500.c | 524 +++++++++++++++++++++++++++++++++
 3 files changed, 530 insertions(+)
 create mode 100644 drivers/clk/actions/owl-s500.c

diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
index 04f0a6355726..5b45ca35757e 100644
--- a/drivers/clk/actions/Kconfig
+++ b/drivers/clk/actions/Kconfig
@@ -9,6 +9,11 @@ if CLK_ACTIONS
 
 # SoC Drivers
 
+config CLK_OWL_S500
+	bool "Support for the Actions Semi OWL S500 clocks"
+	depends on ARCH_ACTIONS || COMPILE_TEST
+	default ARCH_ACTIONS
+
 config CLK_OWL_S700
 	bool "Support for the Actions Semi OWL S700 clocks"
 	depends on (ARM64 && ARCH_ACTIONS) || COMPILE_TEST
diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index ccfdf9781cef..a2588e55c790 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -10,5 +10,6 @@ clk-owl-y			+= owl-pll.o
 clk-owl-y			+= owl-reset.o
 
 # SoC support
+obj-$(CONFIG_CLK_OWL_S500)	+= owl-s500.o
 obj-$(CONFIG_CLK_OWL_S700)	+= owl-s700.o
 obj-$(CONFIG_CLK_OWL_S900)	+= owl-s900.o
diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
new file mode 100644
index 000000000000..93feea8d71e2
--- /dev/null
+++ b/drivers/clk/actions/owl-s500.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Actions Semi Owl S500 SoC clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+//
+// Copyright (c) 2018 LSI-TEC - Caninos Loucos
+// Author: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "owl-common.h"
+#include "owl-composite.h"
+#include "owl-divider.h"
+#include "owl-factor.h"
+#include "owl-fixed-factor.h"
+#include "owl-gate.h"
+#include "owl-mux.h"
+#include "owl-pll.h"
+
+#include <dt-bindings/clock/actions,s500-cmu.h>
+
+#define CMU_COREPLL			(0x0000)
+#define CMU_DEVPLL			(0x0004)
+#define CMU_DDRPLL			(0x0008)
+#define CMU_NANDPLL			(0x000C)
+#define CMU_DISPLAYPLL			(0x0010)
+#define CMU_AUDIOPLL			(0x0014)
+#define CMU_TVOUTPLL			(0x0018)
+#define CMU_BUSCLK			(0x001C)
+#define CMU_SENSORCLK			(0x0020)
+#define CMU_LCDCLK			(0x0024)
+#define CMU_DSICLK			(0x0028)
+#define CMU_CSICLK			(0x002C)
+#define CMU_DECLK			(0x0030)
+#define CMU_BISPCLK			(0x0034)
+#define CMU_BUSCLK1			(0x0038)
+#define CMU_VDECLK			(0x0040)
+#define CMU_VCECLK			(0x0044)
+#define CMU_NANDCCLK			(0x004C)
+#define CMU_SD0CLK			(0x0050)
+#define CMU_SD1CLK			(0x0054)
+#define CMU_SD2CLK			(0x0058)
+#define CMU_UART0CLK			(0x005C)
+#define CMU_UART1CLK			(0x0060)
+#define CMU_UART2CLK			(0x0064)
+#define CMU_PWM4CLK			(0x0068)
+#define CMU_PWM5CLK			(0x006C)
+#define CMU_PWM0CLK			(0x0070)
+#define CMU_PWM1CLK			(0x0074)
+#define CMU_PWM2CLK			(0x0078)
+#define CMU_PWM3CLK			(0x007C)
+#define CMU_USBPLL			(0x0080)
+#define CMU_ETHERNETPLL			(0x0084)
+#define CMU_CVBSPLL			(0x0088)
+#define CMU_LENSCLK			(0x008C)
+#define CMU_GPU3DCLK			(0x0090)
+#define CMU_CORECTL			(0x009C)
+#define CMU_DEVCLKEN0			(0x00A0)
+#define CMU_DEVCLKEN1			(0x00A4)
+#define CMU_DEVRST0			(0x00A8)
+#define CMU_DEVRST1			(0x00AC)
+#define CMU_UART3CLK			(0x00B0)
+#define CMU_UART4CLK			(0x00B4)
+#define CMU_UART5CLK			(0x00B8)
+#define CMU_UART6CLK			(0x00BC)
+#define CMU_SSCLK			(0x00C0)
+#define CMU_DIGITALDEBUG		(0x00D0)
+#define CMU_ANALOGDEBUG			(0x00D4)
+#define CMU_COREPLLDEBUG		(0x00D8)
+#define CMU_DEVPLLDEBUG			(0x00DC)
+#define CMU_DDRPLLDEBUG			(0x00E0)
+#define CMU_NANDPLLDEBUG		(0x00E4)
+#define CMU_DISPLAYPLLDEBUG		(0x00E8)
+#define CMU_TVOUTPLLDEBUG		(0x00EC)
+#define CMU_DEEPCOLORPLLDEBUG		(0x00F4)
+#define CMU_AUDIOPLL_ETHPLLDEBUG	(0x00F8)
+#define CMU_CVBSPLLDEBUG		(0x00FC)
+
+#define OWL_S500_COREPLL_DELAY		(150)
+#define OWL_S500_DDRPLL_DELAY		(63)
+#define OWL_S500_DEVPLL_DELAY		(28)
+#define OWL_S500_NANDPLL_DELAY		(44)
+#define OWL_S500_DISPLAYPLL_DELAY	(57)
+#define OWL_S500_ETHERNETPLL_DELAY	(25)
+#define OWL_S500_AUDIOPLL_DELAY		(100)
+
+static const struct clk_pll_table clk_audio_pll_table[] = {
+	{ 0, 45158400 }, { 1, 49152000 },
+	{ 0, 0 },
+};
+
+/* pll clocks */
+static OWL_PLL_NO_PARENT_DELAY(ethernet_pll_clk, "ethernet_pll_clk", CMU_ETHERNETPLL, 500000000, 0, 0, 0, 0, 0, OWL_S500_ETHERNETPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
+static OWL_PLL_NO_PARENT_DELAY(core_pll_clk, "core_pll_clk", CMU_COREPLL, 12000000, 9, 0, 8, 4, 134, OWL_S500_COREPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
+static OWL_PLL_NO_PARENT_DELAY(ddr_pll_clk, "ddr_pll_clk", CMU_DDRPLL, 12000000, 8, 0, 8, 1, 67, OWL_S500_DDRPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
+static OWL_PLL_NO_PARENT_DELAY(nand_pll_clk, "nand_pll_clk", CMU_NANDPLL, 6000000, 8, 0, 7, 2, 86, OWL_S500_NANDPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
+static OWL_PLL_NO_PARENT_DELAY(display_pll_clk, "display_pll_clk", CMU_DISPLAYPLL, 6000000, 8, 0, 8, 2, 126, OWL_S500_DISPLAYPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
+static OWL_PLL_NO_PARENT_DELAY(dev_pll_clk, "dev_pll_clk", CMU_DEVPLL, 6000000, 8, 0, 7, 8, 126, OWL_S500_DEVPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
+static OWL_PLL_NO_PARENT_DELAY(audio_pll_clk, "audio_pll_clk", CMU_AUDIOPLL, 0, 4, 0, 1, 0, 0, OWL_S500_AUDIOPLL_DELAY, clk_audio_pll_table, CLK_IGNORE_UNUSED);
+
+static const char *dev_clk_mux_p[] = { "hosc", "dev_pll_clk" };
+static const char *bisp_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
+static const char *sensor_clk_mux_p[] = { "hosc", "bisp_clk" };
+static const char *sd_clk_mux_p[] = { "dev_clk", "nand_pll_clk" };
+static const char *pwm_clk_mux_p[] = { "losc", "hosc" };
+static const char *ahbprediv_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
+static const char *uart_clk_mux_p[] = { "hosc", "dev_pll_clk" };
+static const char *de_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
+static const char *i2s_clk_mux_p[] = { "audio_pll_clk" };
+static const char *hde_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
+static const char *nand_clk_mux_p[] = { "nand_pll_clk", "display_pll_clk", "dev_clk", "ddr_pll_clk" };
+
+static struct clk_factor_table sd_factor_table[] = {
+	/* bit0 ~ 4 */
+	{ 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
+	{ 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
+	{ 8, 1, 9 }, { 9, 1, 10 }, { 10, 1, 11 }, { 11, 1, 12 },
+	{ 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
+	{ 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
+	{ 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
+	{ 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
+	{ 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },
+
+	/* bit8: /128 */
+	{ 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, { 259, 1, 4 * 128 },
+	{ 260, 1, 5 * 128 }, { 261, 1, 6 * 128 }, { 262, 1, 7 * 128 }, { 263, 1, 8 * 128 },
+	{ 264, 1, 9 * 128 }, { 265, 1, 10 * 128 }, { 266, 1, 11 * 128 }, { 267, 1, 12 * 128 },
+	{ 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 }, { 271, 1, 16 * 128 },
+	{ 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 }, { 275, 1, 20 * 128 },
+	{ 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 }, { 279, 1, 24 * 128 },
+	{ 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 }, { 283, 1, 28 * 128 },
+	{ 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 }, { 287, 1, 32 * 128 },
+	{ 0, 0, 0 },
+};
+
+static struct clk_factor_table bisp_factor_table[] = {
+	{ 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
+	{ 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
+	{ 0, 0, 0 },
+};
+
+static struct clk_factor_table ahb_factor_table[] = {
+	{ 1, 1, 2 }, { 2, 1, 3 },
+	{ 0, 0, 0 },
+};
+
+static struct clk_div_table rmii_ref_div_table[] = {
+	{ 0, 4 }, { 1, 10 },
+	{ 0, 0 },
+};
+
+static struct clk_div_table i2s_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
+	{ 4, 6 }, { 5, 8 }, { 6, 12 }, { 7, 16 },
+	{ 8, 24 },
+	{ 0, 0 },
+};
+
+static struct clk_div_table nand_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 6 },
+	{ 4, 8 }, { 5, 10 }, { 6, 12 }, { 7, 14 },
+	{ 8, 16 }, { 9, 18 }, { 10, 20 }, { 11, 22 },
+	{ 0, 0 },
+};
+
+/* mux clock */
+static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK_SET_RATE_PARENT);
+static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
+
+/* gate clocks */
+static OWL_GATE(spi0_clk, "spi0_clk", "ahb_clk", CMU_DEVCLKEN1, 10, 0, CLK_IGNORE_UNUSED);
+static OWL_GATE(spi1_clk, "spi1_clk", "ahb_clk", CMU_DEVCLKEN1, 11, 0, CLK_IGNORE_UNUSED);
+static OWL_GATE(spi2_clk, "spi2_clk", "ahb_clk", CMU_DEVCLKEN1, 12, 0, CLK_IGNORE_UNUSED);
+static OWL_GATE(spi3_clk, "spi3_clk", "ahb_clk", CMU_DEVCLKEN1, 13, 0, CLK_IGNORE_UNUSED);
+static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
+static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
+
+/* divider clocks */
+static OWL_DIVIDER(h_clk, "h_clk", "ahbprevdiv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
+static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
+
+/* factor clocks */
+static OWL_FACTOR(ahb_clk, "ahb_clk", "h_clk", CMU_BUSCLK1, 2, 2, ahb_factor_table, 0, 0);
+static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 3, bisp_factor_table, 0, 0);
+static OWL_FACTOR(de2_clk, "de_clk2", "de_clk", CMU_DECLK, 4, 3, bisp_factor_table, 0, 0);
+
+/* composite clocks */
+static OWL_COMP_FACTOR(vce_clk, "vce_clk", hde_clk_mux_p,
+			OWL_MUX_HW(CMU_VCECLK, 4, 2),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 26, 0),
+			OWL_FACTOR_HW(CMU_VCECLK, 0, 3, 0, bisp_factor_table),
+			0);
+
+static OWL_COMP_FACTOR(vde_clk, "vde_clk", hde_clk_mux_p,
+			OWL_MUX_HW(CMU_VDECLK, 4, 2),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 25, 0),
+			OWL_FACTOR_HW(CMU_VDECLK, 0, 3, 0, bisp_factor_table),
+			0);
+
+static OWL_COMP_FACTOR(bisp_clk, "bisp_clk", bisp_clk_mux_p,
+			OWL_MUX_HW(CMU_BISPCLK, 4, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
+			OWL_FACTOR_HW(CMU_BISPCLK, 0, 3, 0, bisp_factor_table),
+			0);
+
+static OWL_COMP_FACTOR(sensor0_clk, "sensor0_clk", sensor_clk_mux_p,
+			OWL_MUX_HW(CMU_SENSORCLK, 4, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
+			OWL_FACTOR_HW(CMU_SENSORCLK, 0, 3, 0, bisp_factor_table),
+			CLK_IGNORE_UNUSED);
+
+static OWL_COMP_FACTOR(sensor1_clk, "sensor1_clk", sensor_clk_mux_p,
+			OWL_MUX_HW(CMU_SENSORCLK, 4, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
+			OWL_FACTOR_HW(CMU_SENSORCLK, 8, 3, 0, bisp_factor_table),
+			CLK_IGNORE_UNUSED);
+
+static OWL_COMP_FACTOR(sd0_clk, "sd0_clk", sd_clk_mux_p,
+			OWL_MUX_HW(CMU_SD0CLK, 9, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 5, 0),
+			OWL_FACTOR_HW(CMU_SD0CLK, 0, 9, 0, sd_factor_table),
+			0);
+
+static OWL_COMP_FACTOR(sd1_clk, "sd1_clk", sd_clk_mux_p,
+			OWL_MUX_HW(CMU_SD1CLK, 9, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 6, 0),
+			OWL_FACTOR_HW(CMU_SD1CLK, 0, 9, 0, sd_factor_table),
+			0);
+
+static OWL_COMP_FACTOR(sd2_clk, "sd2_clk", sd_clk_mux_p,
+			OWL_MUX_HW(CMU_SD2CLK, 9, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 7, 0),
+			OWL_FACTOR_HW(CMU_SD2CLK, 0, 9, 0, sd_factor_table),
+			0);
+
+static OWL_COMP_DIV(pwm0_clk, "pwm0_clk", pwm_clk_mux_p,
+			OWL_MUX_HW(CMU_PWM0CLK, 12, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 23, 0),
+			OWL_DIVIDER_HW(CMU_PWM0CLK, 0, 10, 0, NULL),
+			0);
+
+static OWL_COMP_DIV(pwm1_clk, "pwm1_clk", pwm_clk_mux_p,
+			OWL_MUX_HW(CMU_PWM1CLK, 12, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 24, 0),
+			OWL_DIVIDER_HW(CMU_PWM1CLK, 0, 10, 0, NULL),
+			0);
+
+static OWL_COMP_DIV(pwm2_clk, "pwm2_clk", pwm_clk_mux_p,
+			OWL_MUX_HW(CMU_PWM2CLK, 12, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 25, 0),
+			OWL_DIVIDER_HW(CMU_PWM2CLK, 0, 10, 0, NULL),
+			0);
+
+static OWL_COMP_DIV(pwm3_clk, "pwm3_clk", pwm_clk_mux_p,
+			OWL_MUX_HW(CMU_PWM3CLK, 12, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 26, 0),
+			OWL_DIVIDER_HW(CMU_PWM3CLK, 0, 10, 0, NULL),
+			0);
+
+static OWL_COMP_DIV(pwm4_clk, "pwm4_clk", pwm_clk_mux_p,
+			OWL_MUX_HW(CMU_PWM4CLK, 12, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 11, 0),
+			OWL_DIVIDER_HW(CMU_PWM4CLK, 0, 10, 0, NULL),
+			0);
+
+static OWL_COMP_DIV(pwm5_clk, "pwm5_clk", pwm_clk_mux_p,
+			OWL_MUX_HW(CMU_PWM5CLK, 12, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 0, 0),
+			OWL_DIVIDER_HW(CMU_PWM5CLK, 0, 10, 0, NULL),
+			0);
+
+static OWL_COMP_PASS(de_clk, "de_clk", de_clk_mux_p,
+			OWL_MUX_HW(CMU_DECLK, 12, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 8, 0),
+			0);
+
+static OWL_COMP_FIXED_FACTOR(i2c0_clk, "i2c0_clk", "ethernet_pll_clk",
+			OWL_GATE_HW(CMU_DEVCLKEN1, 14, 0),
+			1, 5, 0);
+
+static OWL_COMP_FIXED_FACTOR(i2c1_clk, "i2c1_clk", "ethernet_pll_clk",
+			OWL_GATE_HW(CMU_DEVCLKEN1, 15, 0),
+			1, 5, 0);
+
+static OWL_COMP_FIXED_FACTOR(i2c2_clk, "i2c2_clk", "ethernet_pll_clk",
+			OWL_GATE_HW(CMU_DEVCLKEN1, 30, 0),
+			1, 5, 0);
+
+static OWL_COMP_FIXED_FACTOR(i2c3_clk, "i2c3_clk", "ethernet_pll_clk",
+			OWL_GATE_HW(CMU_DEVCLKEN1, 31, 0),
+			1, 5, 0);
+
+static OWL_COMP_DIV(uart0_clk, "uart0_clk", uart_clk_mux_p,
+			OWL_MUX_HW(CMU_UART0CLK, 16, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 6, 0),
+			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			CLK_IGNORE_UNUSED);
+
+static OWL_COMP_DIV(uart1_clk, "uart1_clk", uart_clk_mux_p,
+			OWL_MUX_HW(CMU_UART1CLK, 16, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 7, 0),
+			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			CLK_IGNORE_UNUSED);
+
+static OWL_COMP_DIV(uart2_clk, "uart2_clk", uart_clk_mux_p,
+			OWL_MUX_HW(CMU_UART2CLK, 16, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 8, 0),
+			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			CLK_IGNORE_UNUSED);
+
+static OWL_COMP_DIV(uart3_clk, "uart3_clk", uart_clk_mux_p,
+			OWL_MUX_HW(CMU_UART3CLK, 16, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 19, 0),
+			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			CLK_IGNORE_UNUSED);
+
+static OWL_COMP_DIV(uart4_clk, "uart4_clk", uart_clk_mux_p,
+			OWL_MUX_HW(CMU_UART4CLK, 16, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 20, 0),
+			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			CLK_IGNORE_UNUSED);
+
+static OWL_COMP_DIV(uart5_clk, "uart5_clk", uart_clk_mux_p,
+			OWL_MUX_HW(CMU_UART5CLK, 16, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 21, 0),
+			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			CLK_IGNORE_UNUSED);
+
+static OWL_COMP_DIV(uart6_clk, "uart6_clk", uart_clk_mux_p,
+			OWL_MUX_HW(CMU_UART6CLK, 16, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN1, 18, 0),
+			OWL_DIVIDER_HW(CMU_UART1CLK, 0, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL),
+			CLK_IGNORE_UNUSED);
+
+static OWL_COMP_DIV(i2srx_clk, "i2srx_clk", i2s_clk_mux_p,
+			OWL_MUX_HW(CMU_AUDIOPLL, 24, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 21, 0),
+			OWL_DIVIDER_HW(CMU_AUDIOPLL, 20, 4, 0, i2s_div_table),
+			0);
+
+static OWL_COMP_DIV(i2stx_clk, "i2stx_clk", i2s_clk_mux_p,
+			OWL_MUX_HW(CMU_AUDIOPLL, 24, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 20, 0),
+			OWL_DIVIDER_HW(CMU_AUDIOPLL, 16, 4, 0, i2s_div_table),
+			0);
+
+static OWL_COMP_DIV(hdmia_clk, "hdmia_clk", i2s_clk_mux_p,
+			OWL_MUX_HW(CMU_AUDIOPLL, 24, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 22, 0),
+			OWL_DIVIDER_HW(CMU_AUDIOPLL, 24, 4, 0, i2s_div_table),
+			0);
+
+static OWL_COMP_DIV(spdif_clk, "spdif_clk", i2s_clk_mux_p,
+			OWL_MUX_HW(CMU_AUDIOPLL, 24, 1),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 23, 0),
+			OWL_DIVIDER_HW(CMU_AUDIOPLL, 28, 4, 0, i2s_div_table),
+			0);
+
+static OWL_COMP_DIV(nand_clk, "nand_clk", nand_clk_mux_p,
+			OWL_MUX_HW(CMU_NANDCCLK, 8, 2),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 4, 0),
+			OWL_DIVIDER_HW(CMU_NANDCCLK, 0, 3, 0, nand_div_table),
+			CLK_SET_RATE_PARENT);
+
+static OWL_COMP_DIV(ecc_clk, "ecc_clk", nand_clk_mux_p,
+			OWL_MUX_HW(CMU_NANDCCLK, 8, 2),
+			OWL_GATE_HW(CMU_DEVCLKEN0, 4, 0),
+			OWL_DIVIDER_HW(CMU_NANDCCLK, 4, 3, 0, nand_div_table),
+			CLK_SET_RATE_PARENT);
+
+static struct owl_clk_common *s500_clks[] = {
+	&ethernet_pll_clk.common,
+	&core_pll_clk.common,
+	&ddr_pll_clk.common,
+	&dev_pll_clk.common,
+	&nand_pll_clk.common,
+	&audio_pll_clk.common,
+	&display_pll_clk.common,
+	&dev_clk.common,
+	&timer_clk.common,
+	&i2c0_clk.common,
+	&i2c1_clk.common,
+	&i2c2_clk.common,
+	&i2c3_clk.common,
+	&uart0_clk.common,
+	&uart1_clk.common,
+	&uart2_clk.common,
+	&uart3_clk.common,
+	&uart4_clk.common,
+	&uart5_clk.common,
+	&uart6_clk.common,
+	&pwm0_clk.common,
+	&pwm1_clk.common,
+	&pwm2_clk.common,
+	&pwm3_clk.common,
+	&pwm4_clk.common,
+	&pwm5_clk.common,
+	&sensor0_clk.common,
+	&sensor1_clk.common,
+	&sd0_clk.common,
+	&sd1_clk.common,
+	&sd2_clk.common,
+	&bisp_clk.common,
+	&ahb_clk.common,
+	&ahbprediv_clk.common,
+	&h_clk.common,
+	&spi0_clk.common,
+	&spi1_clk.common,
+	&spi2_clk.common,
+	&spi3_clk.common,
+	&rmii_ref_clk.common,
+	&de_clk.common,
+	&de1_clk.common,
+	&de2_clk.common,
+	&i2srx_clk.common,
+	&i2stx_clk.common,
+	&hdmia_clk.common,
+	&hdmi_clk.common,
+	&vce_clk.common,
+	&vde_clk.common,
+	&spdif_clk.common,
+	&nand_clk.common,
+	&ecc_clk.common,
+};
+
+static struct clk_hw_onecell_data s500_hw_clks = {
+	.hws = {
+		[CLK_ETHERNET_PLL]	= &ethernet_pll_clk.common.hw,
+		[CLK_CORE_PLL]		= &core_pll_clk.common.hw,
+		[CLK_DDR_PLL]		= &ddr_pll_clk.common.hw,
+		[CLK_NAND_PLL]		= &nand_pll_clk.common.hw,
+		[CLK_DISPLAY_PLL]	= &display_pll_clk.common.hw,
+		[CLK_DEV_PLL]		= &dev_pll_clk.common.hw,
+		[CLK_AUDIO_PLL]		= &audio_pll_clk.common.hw,
+		[CLK_TIMER]		= &timer_clk.common.hw,
+		[CLK_DEV]		= &dev_clk.common.hw,
+		[CLK_DE]		= &de_clk.common.hw,
+		[CLK_DE1]		= &de1_clk.common.hw,
+		[CLK_DE2]		= &de2_clk.common.hw,
+		[CLK_I2C0]		= &i2c0_clk.common.hw,
+		[CLK_I2C1]		= &i2c1_clk.common.hw,
+		[CLK_I2C2]		= &i2c2_clk.common.hw,
+		[CLK_I2C3]		= &i2c3_clk.common.hw,
+		[CLK_I2SRX]		= &i2srx_clk.common.hw,
+		[CLK_I2STX]		= &i2stx_clk.common.hw,
+		[CLK_UART0]		= &uart0_clk.common.hw,
+		[CLK_UART1]		= &uart1_clk.common.hw,
+		[CLK_UART2]		= &uart2_clk.common.hw,
+		[CLK_UART3]		= &uart3_clk.common.hw,
+		[CLK_UART4]		= &uart4_clk.common.hw,
+		[CLK_UART5]		= &uart5_clk.common.hw,
+		[CLK_UART6]		= &uart6_clk.common.hw,
+		[CLK_PWM0]		= &pwm0_clk.common.hw,
+		[CLK_PWM1]		= &pwm1_clk.common.hw,
+		[CLK_PWM2]		= &pwm2_clk.common.hw,
+		[CLK_PWM3]		= &pwm3_clk.common.hw,
+		[CLK_PWM4]		= &pwm4_clk.common.hw,
+		[CLK_PWM5]		= &pwm5_clk.common.hw,
+		[CLK_SENSOR0]		= &sensor0_clk.common.hw,
+		[CLK_SENSOR1]		= &sensor1_clk.common.hw,
+		[CLK_SD0]		= &sd0_clk.common.hw,
+		[CLK_SD1]		= &sd1_clk.common.hw,
+		[CLK_SD2]		= &sd2_clk.common.hw,
+		[CLK_BISP]		= &bisp_clk.common.hw,
+		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_SPI1]		= &spi1_clk.common.hw,
+		[CLK_SPI2]		= &spi2_clk.common.hw,
+		[CLK_SPI3]		= &spi3_clk.common.hw,
+		[CLK_AHB]		= &ahb_clk.common.hw,
+		[CLK_H]			= &h_clk.common.hw,
+		[CLK_AHBPREDIV]		= &ahbprediv_clk.common.hw,
+		[CLK_RMII_REF]		= &rmii_ref_clk.common.hw,
+		[CLK_HDMI_AUDIO]	= &hdmia_clk.common.hw,
+		[CLK_HDMI]		= &hdmi_clk.common.hw,
+		[CLK_VDE]		= &vde_clk.common.hw,
+		[CLK_VCE]		= &vce_clk.common.hw,
+		[CLK_SPDIF]		= &spdif_clk.common.hw,
+		[CLK_NAND]		= &nand_clk.common.hw,
+		[CLK_ECC]		= &ecc_clk.common.hw,
+	},
+	.num = CLK_NR_CLKS,
+};
+
+static struct owl_clk_desc s500_clk_desc = {
+	.clks	    = s500_clks,
+	.num_clks   = ARRAY_SIZE(s500_clks),
+
+	.hw_clks    = &s500_hw_clks,
+};
+
+static int s500_clk_probe(struct platform_device *pdev)
+{
+	struct owl_clk_desc *desc;
+
+	desc = &s500_clk_desc;
+	owl_clk_regmap_init(pdev, desc);
+
+	return owl_clk_probe(&pdev->dev, desc->hw_clks);
+}
+
+static const struct of_device_id s500_clk_of_match[] = {
+	{ .compatible = "actions,s500-cmu", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver s500_clk_driver = {
+	.probe = s500_clk_probe,
+	.driver = {
+		.name = "s500-cmu",
+		.of_match_table = s500_clk_of_match,
+	},
+};
+
+static int __init s500_clk_init(void)
+{
+	return platform_driver_register(&s500_clk_driver);
+}
+core_initcall(s500_clk_init);
-- 
2.17.1

