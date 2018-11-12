Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E57C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7012241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7012241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbeKMChW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:37:22 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55140 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728199AbeKMChV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:37:21 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wACGCjCS030401;
        Mon, 12 Nov 2018 18:12:45 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 749FF630C7; Mon, 12 Nov 2018 18:42:43 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] dt-binding: spi: add NPCM PSPI controller documentation
Date:   Mon, 12 Nov 2018 18:42:31 +0200
Message-Id: <20181112164232.435629-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181112164232.435629-1-tmaimon77@gmail.com>
References: <20181112164232.435629-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM Peripheral SPI controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt  | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
new file mode 100644
index 000000000000..99606b22e5c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
@@ -0,0 +1,35 @@
+Nuvoton NPCM Peripheral Serial Peripheral Interface(PSPI) controller driver
+
+Nuvoton NPCM7xx SOC support two PSPI channels.
+
+Required properties:
+ - compatible : "nuvoton,npcm750-pspi" for NPCM7XX BMC
+ - #address-cells : should be 1. see spi-bus.txt
+ - #size-cells : should be 0. see spi-bus.txt
+ - specifies physical base address and size of the register.
+ - interrupts : contain PSPI interrupt.
+ - clocks : phandle of PSPI reference clock.
+ - clock-names: Should be "clk_apb5".
+ - pinctrl-names : a pinctrl state named "default" must be defined.
+ - pinctrl-0 : phandle referencing pin configuration of the device.
+ - cs-gpios: Specifies the gpio pins to be used for chipselects.
+            See: Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+- clock-frequency : Input clock frequency to the PSPI block in Hz.
+		    Default is 25000000 Hz.
+
+Example:
+
+spi0: spi@f0200000 {
+	compatible = "nuvoton,npcm750-pspi";
+	reg = <0xf0200000 0x1000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pspi1_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clk NPCM7XX_CLK_APB5>;
+	clock-names = "clk_apb5";
+	cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+};
-- 
2.14.1

