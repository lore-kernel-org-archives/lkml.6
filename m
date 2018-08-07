Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD3821A6D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD3821A6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeHGETT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:19:19 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:35522 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbeHGETS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:19:18 -0400
Received: from ofmlt.linux-actions.org (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 7 Aug 2018
 10:07:27 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] documentation: pinctrl: Add compatibles for Amlogic Meson G12A pin controllers
Date:   Tue, 7 Aug 2018 10:06:33 +0800
Message-ID: <20180807020634.18182-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807020634.18182-1-yixun.lan@amlogic.com>
References: <20180807020634.18182-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible name for Amlogic's Meson-G12A pin controllers,
add a dt-binding header file which document the detail pin names.

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../bindings/pinctrl/meson,pinctrl.txt        |   2 +
 include/dt-bindings/gpio/meson-g12a-gpio.h    | 114 ++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index 54ecb8ab7788..82ead40311f6 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -13,6 +13,8 @@ Required properties for the root node:
 		      "amlogic,meson-gxl-aobus-pinctrl"
 		      "amlogic,meson-axg-periphs-pinctrl"
 		      "amlogic,meson-axg-aobus-pinctrl"
+		      "amlogic,meson-g12a-periphs-pinctrl"
+		      "amlogic,meson-g12a-aobus-pinctrl"
  - reg: address and size of registers controlling irq functionality
 
 === GPIO sub-nodes ===
diff --git a/include/dt-bindings/gpio/meson-g12a-gpio.h b/include/dt-bindings/gpio/meson-g12a-gpio.h
new file mode 100644
index 000000000000..f7bd69350d18
--- /dev/null
+++ b/include/dt-bindings/gpio/meson-g12a-gpio.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ * Author: Xingyu Chen <xingyu.chen@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_G12A_GPIO_H
+#define _DT_BINDINGS_MESON_G12A_GPIO_H
+
+/* First GPIO chip */
+#define GPIOAO_0	0
+#define GPIOAO_1	1
+#define GPIOAO_2	2
+#define GPIOAO_3	3
+#define GPIOAO_4	4
+#define GPIOAO_5	5
+#define GPIOAO_6	6
+#define GPIOAO_7	7
+#define GPIOAO_8	8
+#define GPIOAO_9	9
+#define GPIOAO_10	10
+#define GPIOAO_11	11
+#define GPIOE_0		12
+#define GPIOE_1		13
+#define GPIOE_2		14
+
+/* Second GPIO chip */
+#define GPIOZ_0		0
+#define GPIOZ_1		1
+#define GPIOZ_2		2
+#define GPIOZ_3		3
+#define GPIOZ_4		4
+#define GPIOZ_5		5
+#define GPIOZ_6		6
+#define GPIOZ_7		7
+#define GPIOZ_8		8
+#define GPIOZ_9		9
+#define GPIOZ_10	10
+#define GPIOZ_11	11
+#define GPIOZ_12	12
+#define GPIOZ_13	13
+#define GPIOZ_14	14
+#define GPIOZ_15	15
+#define GPIOH_0		16
+#define GPIOH_1		17
+#define GPIOH_2		18
+#define GPIOH_3		19
+#define GPIOH_4		20
+#define GPIOH_5		21
+#define GPIOH_6		22
+#define GPIOH_7		23
+#define GPIOH_8		24
+#define BOOT_0		25
+#define BOOT_1		26
+#define BOOT_2		27
+#define BOOT_3		28
+#define BOOT_4		29
+#define BOOT_5		30
+#define BOOT_6		31
+#define BOOT_7		32
+#define BOOT_8		33
+#define BOOT_9		34
+#define BOOT_10		35
+#define BOOT_11		36
+#define BOOT_12		37
+#define BOOT_13		38
+#define BOOT_14		39
+#define BOOT_15		40
+#define GPIOC_0		41
+#define GPIOC_1		42
+#define GPIOC_2		43
+#define GPIOC_3		44
+#define GPIOC_4		45
+#define GPIOC_5		46
+#define GPIOC_6		47
+#define GPIOC_7		48
+#define GPIOA_0		49
+#define GPIOA_1		50
+#define GPIOA_2		51
+#define GPIOA_3		52
+#define GPIOA_4		53
+#define GPIOA_5		54
+#define GPIOA_6		55
+#define GPIOA_7		56
+#define GPIOA_8		57
+#define GPIOA_9		58
+#define GPIOA_10	59
+#define GPIOA_11	60
+#define GPIOA_12	61
+#define GPIOA_13	62
+#define GPIOA_14	63
+#define GPIOA_15	64
+#define GPIOX_0		65
+#define GPIOX_1		66
+#define GPIOX_2		67
+#define GPIOX_3		68
+#define GPIOX_4		69
+#define GPIOX_5		70
+#define GPIOX_6		71
+#define GPIOX_7		72
+#define GPIOX_8		73
+#define GPIOX_9		74
+#define GPIOX_10	75
+#define GPIOX_11	76
+#define GPIOX_12	77
+#define GPIOX_13	78
+#define GPIOX_14	79
+#define GPIOX_15	80
+#define GPIOX_16	81
+#define GPIOX_17	82
+#define GPIOX_18	83
+#define GPIOX_19	84
+
+#endif /* _DT_BINDINGS_MESON_G12A_GPIO_H */
-- 
2.18.0

