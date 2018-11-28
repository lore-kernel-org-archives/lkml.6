Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BD92133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NObnfZiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BD92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeK2Jhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46709 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeK2Jho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so27905917wrt.13;
        Wed, 28 Nov 2018 14:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ubjsUuWpwhE6KgMgOCfNMi0c/FMrOf6xRBFiQvdF1Vc=;
        b=NObnfZiYv7Uc1u7CRsjEv1brpNB+TW+y63FzZqAcuF3jFPbwvirdA9hURJJ4angpoB
         KwpsuPFncOFcZQa/OPLzBdzNOpaSKMsoOH6TXhLr1VT8IhG07k1ubkGZ4a+j4u7yhtdk
         KXphBNm2am9nBCIRpX2MLvVJKDH3afL7XrmH4q/PnNOBsszceMJ19zv6TH6df/d4zCIv
         O0fWGzZZlNhvquYW0bjOwfco56pWmwYEeCk6/Uc6NIPxzxXUxfqNhQHwD7MgVZ1HVgJ3
         w/K1enS8dOrgbIp5/NB48YMwv5VDI5GQRbh1H6Z1m8GEADWLCoV2C7/cQfe7ppl4dyFa
         6RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ubjsUuWpwhE6KgMgOCfNMi0c/FMrOf6xRBFiQvdF1Vc=;
        b=DfMl5RPrQu0Je4q+8FYs9L/gGfKO/zopwQc276HKqkISTY8fEHHsPDzyVPIhGHrg6p
         DfWkKiauZolcAl1PD+tFvJInOn5M3bCIlQ6Go4KAkmf4ABtA48eqndMSolZ7reHK13Dh
         s1iHzuy3Ubm7mrYRtdg3cR/ADY/UPGHZXhPcl35H0X6D9LnJWtq9qWDgDWRC+qr9vruZ
         Y6Ve3XcBnSYC1IASBWpaUfzq+/ar7uy1lns1gkAYBjdtuxRccedhg5/jicOlGpY48tmL
         HAmg9+Cx4HAQ3l6Y7moFYCTLPWUacb21v6Ey3vTWrFIwq4/8dwHEpaaguZZtl8xvazqr
         H0Nw==
X-Gm-Message-State: AA+aEWZsysNK2vdK+NviswMxWwjTDbeHoSNbvbuEZA5pbb75+tTTPKwv
        1z1bKWIjaJpC2L3JV8Rt3v/Y/OdfMMo=
X-Google-Smtp-Source: AFSGD/Vpf1xamS/ywryj93m2Q0L3Ki/z5A17t6Dy5jHAgZzkpghk+xF3aCwKYz1iNvkATs5PGTYTGA==
X-Received: by 2002:adf:fd50:: with SMTP id h16mr28741551wrs.228.1543444471963;
        Wed, 28 Nov 2018 14:34:31 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:31 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [PATCH v5 12/17] dt-bindings: clock: Add Allwinner suniv F1C100s CCU
Date:   Thu, 29 Nov 2018 01:33:22 +0300
Message-Id: <47d0f466155e3d678d3383655856c1e15e975870.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatiple string for Allwinner suniv F1C100s CCU.
Add clock and reset definitions.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../devicetree/bindings/clock/sunxi-ccu.txt        |  1 +
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      | 70 ++++++++++++++++++++++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      | 38 ++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 47d2e90..e3bd88a 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -22,6 +22,7 @@ Required properties :
 		- "allwinner,sun50i-h5-ccu"
 		- "allwinner,sun50i-h6-ccu"
 		- "allwinner,sun50i-h6-r-ccu"
+		- "allwinner,suniv-f1c100s-ccu"
 		- "nextthing,gr8-ccu"
 
 - reg: Must contain the registers base address and length
diff --git a/include/dt-bindings/clock/suniv-ccu-f1c100s.h b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
new file mode 100644
index 0000000..f5ac155
--- /dev/null
+++ b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ *
+ * Copyright (c) 2018 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
+#define _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
+
+#define CLK_CPU			11
+
+#define CLK_BUS_DMA		14
+#define CLK_BUS_MMC0		15
+#define CLK_BUS_MMC1		16
+#define CLK_BUS_DRAM		17
+#define CLK_BUS_SPI0		18
+#define CLK_BUS_SPI1		19
+#define CLK_BUS_OTG		20
+#define CLK_BUS_VE		21
+#define CLK_BUS_LCD		22
+#define CLK_BUS_DEINTERLACE	23
+#define CLK_BUS_CSI		24
+#define CLK_BUS_TVD		25
+#define CLK_BUS_TVE		26
+#define CLK_BUS_DE_BE		27
+#define CLK_BUS_DE_FE		28
+#define CLK_BUS_CODEC		29
+#define CLK_BUS_SPDIF		30
+#define CLK_BUS_IR		31
+#define CLK_BUS_RSB		32
+#define CLK_BUS_I2S0		33
+#define CLK_BUS_I2C0		34
+#define CLK_BUS_I2C1		35
+#define CLK_BUS_I2C2		36
+#define CLK_BUS_PIO		37
+#define CLK_BUS_UART0		38
+#define CLK_BUS_UART1		39
+#define CLK_BUS_UART2		40
+
+#define CLK_MMC0		41
+#define CLK_MMC0_SAMPLE		42
+#define CLK_MMC0_OUTPUT		43
+#define CLK_MMC1		44
+#define CLK_MMC1_SAMPLE		45
+#define CLK_MMC1_OUTPUT		46
+#define CLK_I2S			47
+#define CLK_SPDIF		48
+
+#define CLK_USB_PHY0		49
+
+#define CLK_DRAM_VE		50
+#define CLK_DRAM_CSI		51
+#define CLK_DRAM_DEINTERLACE	52
+#define CLK_DRAM_TVD		53
+#define CLK_DRAM_DE_FE		54
+#define CLK_DRAM_DE_BE		55
+
+#define CLK_DE_BE		56
+#define CLK_DE_FE		57
+#define CLK_TCON		58
+#define CLK_DEINTERLACE		59
+#define CLK_TVE2_CLK		60
+#define CLK_TVE1_CLK		61
+#define CLK_TVD			62
+#define CLK_CSI			63
+#define CLK_VE			64
+#define CLK_CODEC		65
+#define CLK_AVS			66
+
+#endif
diff --git a/include/dt-bindings/reset/suniv-ccu-f1c100s.h b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
new file mode 100644
index 0000000..6a4b438
--- /dev/null
+++ b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ *
+ * Copyright (C) 2018 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ */
+
+#ifndef _DT_BINDINGS_RST_SUNIV_F1C100S_H_
+#define _DT_BINDINGS_RST_SUNIV_F1C100S_H_
+
+#define RST_USB_PHY0		0
+#define RST_BUS_DMA		1
+#define RST_BUS_MMC0		2
+#define RST_BUS_MMC1		3
+#define RST_BUS_DRAM		4
+#define RST_BUS_SPI0		5
+#define RST_BUS_SPI1		6
+#define RST_BUS_OTG		7
+#define RST_BUS_VE		8
+#define RST_BUS_LCD		9
+#define RST_BUS_DEINTERLACE	10
+#define RST_BUS_CSI		11
+#define RST_BUS_TVD		12
+#define RST_BUS_TVE		13
+#define RST_BUS_DE_BE		14
+#define RST_BUS_DE_FE		15
+#define RST_BUS_CODEC		16
+#define RST_BUS_SPDIF		17
+#define RST_BUS_IR		18
+#define RST_BUS_RSB		19
+#define RST_BUS_I2S0		20
+#define RST_BUS_I2C0		21
+#define RST_BUS_I2C1		22
+#define RST_BUS_I2C2		23
+#define RST_BUS_UART0		24
+#define RST_BUS_UART1		25
+#define RST_BUS_UART2		26
+
+#endif /* _DT_BINDINGS_RST_SUNIV_F1C100S_H_ */
-- 
2.7.4

