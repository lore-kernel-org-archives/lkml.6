Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FFDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0BE2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2LTN/z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfBZLuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:50:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40966 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfBZLun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:50:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id y5so6133372plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 03:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BsfNKWEJ3ROKzrbnju2laN7hNuk0psHdh/467dEUXhg=;
        b=m2LTN/z+Y8P/b7k/tzaH2Fb2S6ZLbwIQa6E/jV+c6QEzqT7shkF9+4ad6YOwcUY1Cc
         87ACyxPTjwUFzjkcEBjHsxQvmRXiM1aVFwHifDc1wGQ32/qdOpMXRlBL/MFHQrrkQ0Y6
         xs1aCYZpSYAAHBOup58iqqdqgUl9UwmXF0252FETY3QFiren60GC3xrrMz8IoxJQzx/i
         3q1k3TsAfJBtu7CScsmMkCNSqV9jHL3rye59pJK7pWQ/cyFVRVLH1YxLPpmgBGp9DcYu
         IfPeB1gIIbFWCfnfXyJeDpl8a97N9F2Lhr00LuMoHCpsHoMZHv88nm4haHn+e6BsNMSO
         2X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BsfNKWEJ3ROKzrbnju2laN7hNuk0psHdh/467dEUXhg=;
        b=sFBWmPblpOksJhjnaV45mdQKY7N4rrA9sqOS7Oby8Na/0kKkUOI7x1t8T/sVqmT1W7
         mUdw5tKFi/Yw2/BUMwOV66ppPMapzT42jerkNP3tMfTXfY5rMqG22tI6vEaemwgR4c12
         IZ//N8SWDo1lmixakgfa+kGrQb7CwUpzyZnpAs6z/5yGrXXoRhyikF49nxJ0/p1g8Z+o
         SwKL2XRy+6GpVMkxEaPt2IoGoAEJ5xQS9f00uqTZORwotcxRPDUFApPQpRLf0eyy/oHJ
         KJuAE28vZRs44HlUy9hXPrKZsjIGYSdp/kSzjYVRSulsrlFv0wP6pUuC9ulHUTR632lJ
         zatg==
X-Gm-Message-State: AHQUAuZUl3BpaMdAIWAqurqdD+jqGbKezthpoBC1gItZVA3Y8vBzIL+q
        d+G6pbExoTBgOXAiJcUqOh/2
X-Google-Smtp-Source: AHgI3IbYtzO47PzqP/GcwC77ytxzSt9Q3QS6j+WcIewtyOwCwjSjrirAYwRqkHnWa7cZrUp7bySXTQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr24836963plb.226.1551181842548;
        Tue, 26 Feb 2019 03:50:42 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7288:2b3b:d5bf:2058:5f56:d25e])
        by smtp.gmail.com with ESMTPSA id t10sm31639245pfa.151.2019.02.26.03.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 03:50:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org, linux-gpio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] arm64: dts: bitmain: Add GPIO Line names for Sophon Edge board
Date:   Tue, 26 Feb 2019 17:20:22 +0530
Message-Id: <20190226115022.19022-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org>
References: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO line names for Sophon Edge board based on BM1880 SoC from
Bitmain. Line names are based on the board schematics as well as the
96Boards Consumer Edition specification v1.0.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
index 6a3255597138..6bdf4c101c61 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
+++ b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
@@ -8,6 +8,28 @@
 
 #include "bm1880.dtsi"
 
+/*
+ * GPIO name legend: proper name = the GPIO line is used as GPIO
+ *         NC = not connected (pin out but not routed from the chip to
+ *              anything the board)
+ *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
+ *         LSEC = Low Speed External Connector
+ *         HSEC = High Speed External Connector
+ *
+ * Line names are taken from the schematic "sophon-edge-schematics"
+ * version, 1.0210.
+ *
+ * For the lines routed to the external connectors the
+ * lines are named after the 96Boards CE Specification 1.0,
+ * Appendix "Expansion Connector Signal Description".
+ *
+ * When the 96Board naming of a line and the schematic name of
+ * the same line are in conflict, the 96Board specification
+ * takes precedence. This is only for the informational
+ * lines i.e. "[FOO]", the GPIO named lines "GPIO-A" thru "GPIO-L"
+ * are the only ones actually used for GPIO.
+ */
+
 / {
 	compatible = "bitmain,sophon-edge", "bitmain,bm1880";
 	model = "Sophon Edge";
@@ -32,6 +54,98 @@
 		clock-frequency = <500000000>;
 		#clock-cells = <0>;
 	};
+
+	soc {
+		gpio0: gpio@50027000 {
+			porta: gpio-controller@0 {
+				gpio-line-names =
+					"GPIO-A", /* GPIO0, LSEC pin 23 */
+					"GPIO-C", /* GPIO1, LSEC pin 25 */
+					"[GPIO2_PHY0_RST]", /* GPIO2 */
+					"GPIO-E", /* GPIO3, LSEC pin 27 */
+					"[USB_DET]", /* GPIO4 */
+					"[EN_P5V]", /* GPIO5 */
+					"[VDDIO_MS1_SEL]", /* GPIO6 */
+					"GPIO-G", /* GPIO7, LSEC pin 29 */
+					"[BM_TUSB_RST_L]", /* GPIO8 */
+					"[EN_P5V_USBHUB]", /* GPIO9 */
+					"NC",
+					"LED_WIFI", /* GPIO11 */
+					"LED_BT", /* GPIO12 */
+					"[BM_BLM8221_EN_L]", /* GPIO13 */
+					"NC", /* GPIO14 */
+					"NC", /* GPIO15 */
+					"NC", /* GPIO16 */
+					"NC", /* GPIO17 */
+					"NC", /* GPIO18 */
+					"NC", /* GPIO19 */
+					"NC", /* GPIO20 */
+					"NC", /* GPIO21 */
+					"NC", /* GPIO22 */
+					"NC", /* GPIO23 */
+					"NC", /* GPIO24 */
+					"NC", /* GPIO25 */
+					"NC", /* GPIO26 */
+					"NC", /* GPIO27 */
+					"NC", /* GPIO28 */
+					"NC", /* GPIO29 */
+					"NC", /* GPIO30 */
+					"NC"; /* GPIO31 */
+			};
+		};
+
+		gpio1: gpio@50027400 {
+			portb: gpio-controller@0 {
+				gpio-line-names =
+					"NC", /* GPIO32 */
+					"NC", /* GPIO33 */
+					"[I2C0_SDA]", /* GPIO34, LSEC pin 17 */
+					"[I2C0_SCL]", /* GPIO35, LSEC pin 15 */
+					"[JTAG0_TDO]", /* GPIO36 */
+					"[JTAG0_TCK]", /* GPIO37 */
+					"[JTAG0_TDI]", /* GPIO38 */
+					"[JTAG0_TMS]", /* GPIO39 */
+					"[JTAG0_TRST_X]", /* GPIO40 */
+					"[JTAG1_TDO]", /* GPIO41 */
+					"[JTAG1_TCK]", /* GPIO42 */
+					"[JTAG1_TDI]", /* GPIO43 */
+					"[CPU_TX]", /* GPIO44 */
+					"[CPU_RX]", /* GPIO45 */
+					"[UART1_TXD]", /* GPIO46 */
+					"[UART1_RXD]", /* GPIO47 */
+					"[UART0_TXD]", /* GPIO48 */
+					"[UART0_RXD]", /* GPIO49 */
+					"GPIO-I", /* GPIO50, LSEC pin 31 */
+					"GPIO-K", /* GPIO51, LSEC pin 33 */
+					"USER_LED2", /* GPIO52 */
+					"USER_LED1", /* GPIO53 */
+					"[UART0_RTS]", /* GPIO54 */
+					"[UART0_CTS]", /* GPIO55 */
+					"USER_LED4", /* GPIO56, JTAG1_TRST_X */
+					"USER_LED3", /* GPIO57, JTAG1_TMS */
+					"[I2S0_SCLK]", /* GPIO58 */
+					"[I2S0_FS]", /* GPIO59 */
+					"[I2S0_SDI]", /* GPIO60 */
+					"[I2S0_SDO]", /* GPIO61 */
+					"GPIO-B", /* GPIO62, LSEC pin 24 */
+					"GPIO-F"; /* GPIO63, I2S1_SCLK, LSEC pin 28 */
+			};
+		};
+
+		gpio2: gpio@50027800 {
+			portc: gpio-controller@0 {
+				gpio-line-names =
+					"GPIO-D", /* GPIO64, I2S1_FS, LSEC pin 26 */
+					"GPIO-J", /* GPIO65, I2S1_SDI, LSEC pin 32 */
+					"GPIO-H", /* GPIO66, I2S1_SDO, LSEC pin 30 */
+					"GPIO-L", /* GPIO67, LSEC pin 34 */
+					"[SPI0_CS]", /* GPIO68, SPI1_CS, LSEC pin 12 */
+					"[SPI0_DIN]", /* GPIO69, SPI1_SDI, LSEC pin 10 */
+					"[SPI0_DOUT]", /* GPIO70, SPI1_SDO, LSEC pin 14 */
+					"[SPI0_SCLK]"; /* GPIO71, SPI1_SCK, LSEC pin 8 */
+			};
+		};
+	};
 };
 
 &uart0 {
-- 
2.17.1

