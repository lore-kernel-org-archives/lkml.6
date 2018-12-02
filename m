Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0F5C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C9620851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNUqTPbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C9620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLBUZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:25:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35014 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeLBUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so3670222wmh.0;
        Sun, 02 Dec 2018 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b3VT8ipXM4GVCZfalW4x+w8+g6CzhWh2u23wr46Xid4=;
        b=aNUqTPbso6m71CsDPncXaS+OD9GjWDC8sdZNTC5QUXKn5NR3XXevF+2rH7Kos/bZgq
         +HVpsXGjnXO2I61hUE4benHItT6tIgyGNYqMeOrS7HdRZDYkxBLH0YmGqR89wOjYPiYg
         lfcZW2ruOVm9y+auWUQAr2VxlodOPgEwepwWk9qtvg2QDO9jmtNi28noUbpf2ErVxw1h
         LTrD1SKoxVMDkwsfKbjMAIw1KrP7fX/A2Hl6v2VORzADCh8qMCUOCo93k48Tm2mwp7Iw
         ZgGnMqXIq+wMz3Qk9Yeb0iKaFTxrrksbYq/f09V/EuRZ+k2zyvheFhCgKrOkV31prfTK
         6dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b3VT8ipXM4GVCZfalW4x+w8+g6CzhWh2u23wr46Xid4=;
        b=MN/7sK1VoJFzNe9BBf2NHLz2yRgGzTD8wudygClarSH6Th7/tl7vxJLyJC4o2G0kei
         1KmlUSNWyD8R7mFNfp7sXH6CXXJHeRpM+99/AtmB/eAyLadap+hrTvclmyB7ZeGqNTPr
         /oK8C/9bYnFGrM8MgaOUDbaP4z2H4O+Y0ODFvBoq3g9J6ppteoKjfh8x++WBTm9SWoVO
         qrCm11b5uegseS95q67mrm1NZTaVdoUm6A3O+D0sECIJoahVG2yCuT7T2dF0X1wKTw88
         gCc5CbMAL+uzCyUcTN+l9gkqTEWTNjV3rB+k8RiKpqN2DhN/QmhTQNC0+DAvmRjPwBD7
         GL+w==
X-Gm-Message-State: AA+aEWYh7jeUMp7c2aQuQiFtzhVYQl2xJvgkXFhbSpp8SN0OF+/k4ZnH
        6XXc7lgY+9Ifpx4CNejDyOcRlEmS1Q8=
X-Google-Smtp-Source: AFSGD/VH0g5NGCrKj4K3ZKMdWMNXZ10pqp0zr3BBq6RdMbSLXd+fpFXumiuxq4rbqS8pJkeiQZPd7A==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr5699286wmo.138.1543782271634;
        Sun, 02 Dec 2018 12:24:31 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:31 -0800 (PST)
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
Subject: [PATCH v6 12/17] dt-bindings: clock: Add Allwinner suniv F1C100s CCU
Date:   Sun,  2 Dec 2018 23:23:46 +0300
Message-Id: <963e6608b509ae7a83966c76b9d0fc7d8bf1c07b.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatiple string for Allwinner suniv F1C100s CCU.
Add clock and reset definitions.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
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

