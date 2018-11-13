Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38236C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2142245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2142245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbeKMP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:57:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34940 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732401AbeKMP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:57:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAD60T7D002303;
        Tue, 13 Nov 2018 00:00:29 -0600
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAD60SFp124158
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 00:00:28 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 13
 Nov 2018 00:00:28 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 13 Nov 2018 00:00:28 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAD60Lu8017811;
        Tue, 13 Nov 2018 00:00:25 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux definitions
Date:   Tue, 13 Nov 2018 11:31:08 +0530
Message-ID: <20181113060111.16374-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113060111.16374-1-vigneshr@ti.com>
References: <20181113060111.16374-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
defining pinmux configs in human readable form, instead of raw-coded
hex values.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 MAINTAINERS                      |  1 +
 include/dt-bindings/pinctrl/k3.h | 35 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/k3.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fa45ff36fde9..1574ad6d7ead 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2204,6 +2204,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/arm/ti/k3.txt
 F:	arch/arm64/boot/dts/ti/Makefile
 F:	arch/arm64/boot/dts/ti/k3-*
+F:	include/dt-bindings/pinctrl/k3.h
 
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
new file mode 100644
index 000000000000..463d845a9b36
--- /dev/null
+++ b/include/dt-bindings/pinctrl/k3.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for pinctrl bindings for TI's K3 SoC
+ * family.
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+#ifndef _DT_BINDINGS_PINCTRL_TI_K3_H
+#define _DT_BINDINGS_PINCTRL_TI_K3_H
+
+#define PULLUDEN_SHIFT		(16)
+#define PULLTYPESEL_SHIFT	(17)
+#define RXACTIVE_SHIFT		(18)
+
+#define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
+#define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
+
+#define PULL_UP			(1 << PULLTYPESEL_SHIFT | PULL_ENABLE)
+#define PULL_DOWN		(0 << PULLTYPESEL_SHIFT | PULL_ENABLE)
+
+#define INPUT_EN		(1 << RXACTIVE_SHIFT)
+#define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
+
+/* Only these macros are expected be used directly in device tree files */
+#define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
+#define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
+#define PIN_OUTPUT_PULLDOWN	(INPUT_DISABLE | PULL_DOWN)
+#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
+#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
+#define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
+
+#define AM65X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
+#define AM65X_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
+
+#endif
-- 
2.19.1

