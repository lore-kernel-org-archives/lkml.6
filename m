Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A2BC04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA0C20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS0Rr0W+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA0C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeKSAjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:39:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41213 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKSAjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:39:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so645885wrs.8;
        Sun, 18 Nov 2018 06:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+3/Jfkz3Nmnk0j0SXb3AchXufio2viB0S4jlUlisOK8=;
        b=NS0Rr0W+ZXwyhOPXqRf11YL2t5Qtc6hKriuJAOIdC7xn3JwT1+oebA/TewRb9+0Lqr
         8kWEBxvJB2Zg63YmGFDgIivgnceUMTsTxjK6z35nlr2FGV/UdE9Rb3QDfvCrwNdF7G6T
         jW1d8/RTBh9L+9uw+I3g3mwUr2VDB0iZ0WztvxGMHSN+hu2j7EEjjVYX5jmncCM8cHPF
         8H3+bIGmsIo8/pOi0vt/BYBlXmSs+iXa8EjI5PTxqXBO/tQHIQ+QTHSP2VIMo6JeCtAj
         n2FfX9atGylgWlgGp3iZjRYIvIUHyJgN6bWGcGUt1h2UxWLh/y19NgMICE0N9Kr7NUCd
         L4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+3/Jfkz3Nmnk0j0SXb3AchXufio2viB0S4jlUlisOK8=;
        b=hXZXrATj3iixoDfrcn1lvwX75VQYRXQ6Cni+FV2FYdKuJDTyoSK6w033YooVFzuMFD
         kTfiu5RS+9Gv/n/9RNlp7jJDyVpynALR8ocNlJikfkWOzoHHO9Iys39uETc90zAwcSSU
         D9B9xhbH/A0KBoYiRuXlRTycNzHq2iHbDpfdmgjOICXACW6SoElDN1M5ZOc8AWTQHwlB
         /BQdHvX/Yd9/DOMX1V4kpoNn0EU0jpbwgpeO9w9QeBDkMBSV3+ha/Oh1jYh5CXGPHiVS
         Af+yRVGbVEv2zyXHpepwqrtGg/PYBRzD0h7yAk/XTrfViRl+C6pl51hH+PiPbGAqtjWM
         fNUg==
X-Gm-Message-State: AA+aEWYM9kUNUHmfYm9fIvy/D2CMO8CJ9TuSzlMTXI6TjPV9GV4Zo23S
        pG5iwSkCK/vL4qz1fUE6RcTJEry4phM=
X-Google-Smtp-Source: AFSGD/WC8Ze3lU4VK+e5rT0eYsaXE3poeZb1WtaGABm1/2Q9/g4ZRz8QWn/ibosZ5Trke58F6Dz6PQ==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr12731174wrr.329.1542550718043;
        Sun, 18 Nov 2018 06:18:38 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:37 -0800 (PST)
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
Subject: [RFC PATCH v2 11/14] dt-bindings: clock: Add Allwinner suniv F1C100s CCU
Date:   Sun, 18 Nov 2018 17:17:10 +0300
Message-Id: <5f0322d5e37726f0c597b919f59e121f0b2855c3.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatiple string for Allwinner suniv F1C100s CCU.
Add clock and reset definitions.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 .../devicetree/bindings/clock/sunxi-ccu.txt        |  1 +
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      | 69 ++++++++++++++++++++++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      | 37 ++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 47d2e90..92c16eb 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -3,6 +3,7 @@ Allwinner Clock Control Unit Binding
 
 Required properties :
 - compatible: must contain one of the following compatibles:
+		- "allwinner,suniv-f1c100s-ccu"
 		- "allwinner,sun4i-a10-ccu"
 		- "allwinner,sun5i-a10s-ccu"
 		- "allwinner,sun5i-a13-ccu"
diff --git a/include/dt-bindings/clock/suniv-ccu-f1c100s.h b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
new file mode 100644
index 0000000..56f6d0d
--- /dev/null
+++ b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (c) 2018 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
+#define _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
+
+#define CLK_CPU			11
+
+#define CLK_BUS_MMC0		14
+#define CLK_BUS_MMC1		15
+#define CLK_BUS_DRAM		16
+#define CLK_BUS_SPI0		17
+#define CLK_BUS_SPI1		18
+#define CLK_BUS_OTG		19
+#define CLK_BUS_VE		20
+#define CLK_BUS_LCD		21
+#define CLK_BUS_DEINTERLACE	22
+#define CLK_BUS_CSI		23
+#define CLK_BUS_TVD		24
+#define CLK_BUS_TVE		25
+#define CLK_BUS_DE_BE		26
+#define CLK_BUS_DE_FE		27
+#define CLK_BUS_CODEC		28
+#define CLK_BUS_SPDIF		29
+#define CLK_BUS_IR		30
+#define CLK_BUS_RSB		31
+#define CLK_BUS_I2S0		32
+#define CLK_BUS_I2C0		33
+#define CLK_BUS_I2C1		34
+#define CLK_BUS_I2C2		35
+#define CLK_BUS_PIO		36
+#define CLK_BUS_UART0		37
+#define CLK_BUS_UART1		38
+#define CLK_BUS_UART2		39
+
+#define CLK_MMC0		40
+#define CLK_MMC0_SAMPLE		41
+#define CLK_MMC0_OUTPUT		42
+#define CLK_MMC1		43
+#define CLK_MMC1_SAMPLE		44
+#define CLK_MMC1_OUTPUT		45
+#define CLK_I2S			46
+#define CLK_SPDIF		47
+
+#define CLK_USB_PHY0		48
+
+#define CLK_DRAM_VE		49
+#define CLK_DRAM_CSI		50
+#define CLK_DRAM_DEINTERLACE	51
+#define CLK_DRAM_TVD		52
+#define CLK_DRAM_DE_FE		53
+#define CLK_DRAM_DE_BE		54
+
+#define CLK_DE_BE		55
+#define CLK_DE_FE		56
+#define CLK_TCON		57
+#define CLK_DEINTERLACE		58
+#define CLK_TVE2_CLK		59
+#define CLK_TVE1_CLK		60
+#define CLK_TVD			61
+#define CLK_CSI			62
+#define CLK_VE			63
+#define CLK_CODEC		64
+#define CLK_AVS			65
+
+#endif
diff --git a/include/dt-bindings/reset/suniv-ccu-f1c100s.h b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
new file mode 100644
index 0000000..95f1ed0
--- /dev/null
+++ b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2018 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#ifndef _DT_BINDINGS_RST_SUNIV_F1C100S_H_
+#define _DT_BINDINGS_RST_SUNIV_F1C100S_H_
+
+#define RST_USB_PHY0		0
+#define RST_BUS_MMC0		1
+#define RST_BUS_MMC1		2
+#define RST_BUS_DRAM		3
+#define RST_BUS_SPI0		4
+#define RST_BUS_SPI1		5
+#define RST_BUS_OTG		6
+#define RST_BUS_VE		7
+#define RST_BUS_LCD		8
+#define RST_BUS_DEINTERLACE		9
+#define RST_BUS_CSI		10
+#define RST_BUS_TVD		11
+#define RST_BUS_TVE		12
+#define RST_BUS_DE_BE		13
+#define RST_BUS_DE_FE		14
+#define RST_BUS_CODEC		15
+#define RST_BUS_SPDIF		16
+#define RST_BUS_IR		17
+#define RST_BUS_RSB		18
+#define RST_BUS_I2S0		19
+#define RST_BUS_I2C0		20
+#define RST_BUS_I2C1		21
+#define RST_BUS_I2C2		22
+#define RST_BUS_UART0		23
+#define RST_BUS_UART1		24
+#define RST_BUS_UART2		25
+
+#endif /* _DT_BINDINGS_RST_SUNIV_F1C100S_H_ */
-- 
2.7.4

