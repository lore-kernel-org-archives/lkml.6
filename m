Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeCQX3b (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:29:31 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:34888 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeCQX3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:29:24 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Cc: James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 1/8] mfd: syscon: Add ingenic-tcu.h header
Date: Sun, 18 Mar 2018 00:28:54 +0100
Message-Id: <20180317232901.14129-2-paul@crapouillou.net>
In-Reply-To: <20180317232901.14129-1-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header contains macros for the registers that are present in the
regmap shared by all the drivers related to the TCU (Timer Counter Unit)
of the Ingenic JZ47xx SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/syscon/ingenic-tcu.h | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 include/linux/mfd/syscon/ingenic-tcu.h

 v2: Use SPDX identifier for the license
 v3: - Use macros instead of enum
     - Add 'TCU_' at the beginning of each macro
	 - Remove useless include <linux/regmap.h>
 v4: No change

diff --git a/include/linux/mfd/syscon/ingenic-tcu.h b/include/linux/mfd/syscon/ingenic-tcu.h
new file mode 100644
index 000000000000..96dd59f7c3b2
--- /dev/null
+++ b/include/linux/mfd/syscon/ingenic-tcu.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for the Ingenic JZ47xx TCU driver
+ */
+#ifndef __LINUX_CLK_INGENIC_TCU_H_
+#define __LINUX_CLK_INGENIC_TCU_H_
+
+#include <linux/bitops.h>
+
+#define TCU_REG_WDT_TDR		0x00
+#define TCU_REG_WDT_TCER	0x04
+#define TCU_REG_WDT_TCNT	0x08
+#define TCU_REG_WDT_TCSR	0x0c
+#define TCU_REG_TER		0x10
+#define TCU_REG_TESR		0x14
+#define TCU_REG_TECR		0x18
+#define TCU_REG_TSR		0x1c
+#define TCU_REG_TFR		0x20
+#define TCU_REG_TFSR		0x24
+#define TCU_REG_TFCR		0x28
+#define TCU_REG_TSSR		0x2c
+#define TCU_REG_TMR		0x30
+#define TCU_REG_TMSR		0x34
+#define TCU_REG_TMCR		0x38
+#define TCU_REG_TSCR		0x3c
+#define TCU_REG_TDFR0		0x40
+#define TCU_REG_TDHR0		0x44
+#define TCU_REG_TCNT0		0x48
+#define TCU_REG_TCSR0		0x4c
+#define TCU_REG_OST_DR		0xe0
+#define TCU_REG_OST_CNTL	0xe4
+#define TCU_REG_OST_CNTH	0xe8
+#define TCU_REG_OST_TCSR	0xec
+#define TCU_REG_TSTR		0xf0
+#define TCU_REG_TSTSR		0xf4
+#define TCU_REG_TSTCR		0xf8
+#define TCU_REG_OST_CNTHBUF	0xfc
+
+#define TCU_TCSR_RESERVED_BITS		0x3f
+#define TCU_TCSR_PARENT_CLOCK_MASK	0x07
+#define TCU_TCSR_PRESCALE_LSB		3
+#define TCU_TCSR_PRESCALE_MASK		0x38
+
+#define TCU_TCSR_PWM_SD		BIT(9)	/* 0: Shutdown abruptly 1: gracefully */
+#define TCU_TCSR_PWM_INITL_HIGH	BIT(8)	/* Sets the initial output level */
+#define TCU_TCSR_PWM_EN		BIT(7)	/* PWM pin output enable */
+
+#define TCU_CHANNEL_STRIDE	0x10
+#define TCU_REG_TDFRc(c)	(TCU_REG_TDFR0 + ((c) * TCU_CHANNEL_STRIDE))
+#define TCU_REG_TDHRc(c)	(TCU_REG_TDHR0 + ((c) * TCU_CHANNEL_STRIDE))
+#define TCU_REG_TCNTc(c)	(TCU_REG_TCNT0 + ((c) * TCU_CHANNEL_STRIDE))
+#define TCU_REG_TCSRc(c)	(TCU_REG_TCSR0 + ((c) * TCU_CHANNEL_STRIDE))
+
+#endif /* __LINUX_CLK_INGENIC_TCU_H_ */
-- 
2.11.0
