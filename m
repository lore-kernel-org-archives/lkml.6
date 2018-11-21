Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEF6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21FC214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O49yIe5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21FC214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbeKVFHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35984 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733244AbeKVFHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so6744011wrr.3;
        Wed, 21 Nov 2018 10:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=smESXBOtl9KKus4Hogn7U/MQwM4aLtjcLcrRBWMVoQA=;
        b=O49yIe5SxEuZEH6o5B4qoPGnbZZWHoDqiU/rdAZczLUd7zDJS8oBl3uTCW2LDxInTF
         iyBx8qOT4uj0yds+CLP4yOWg/aPNVbao2iC9Sae2NgO34JJReFQo4oNiXo6EliJFvtR6
         Ntkcu+SU/0Jgw0So9ssl0fK+rPf9ACtx55y7La306WpEiWHsDyvgCKcObhhkk6tuQqLo
         /7H8jUTF21s9QUFZyaLNsSMkJ9sSpF5t58zGKIdlu1fqht2sHELSgOkLv//3j/ASYNyf
         8alewAusqFOtDnGzu1ibgIFK+HnIhvCKyYWFAXQdDnpJcKwotBVDIMwsBW3Z8NxELycO
         BJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=smESXBOtl9KKus4Hogn7U/MQwM4aLtjcLcrRBWMVoQA=;
        b=T86dJjpSg91mEJ8JFWnPoyIEItMFbP5QarRRTRLOMYKKuY7vT71FUaFIOxJJuCKogd
         cp1TVNldAUvQEMjm2yyOVCM4FmT2ibhCUWRUud3HIlpe/xbzl+86cTD/w6VzwLdBM1dB
         geQUC59qOhOdPW3vZEzg6mkpOQgGClK3ZFSOCiQgACBooabvmaw48rPZU+eYx/1YlvXo
         vKxq8uoWEf1OM7WCIlBvn29e7xUTKRvhjCSSPVgL49KIm+DKnQk5yMaChHsNxkxZu/1w
         Ypobjv+kOU/24FkoX/GveStiI94DdhRUOuX6GwE4gFWW6DBPaWS8RnYDeMeTHtU5dZ3R
         Cupg==
X-Gm-Message-State: AA+aEWZrMr+giO5Y6zg1SQ22yGbasrllibL14I5ql1r2PQDJHdPGvf7l
        KxAK2LuX18EpQDJAZToXKOOBmw/Co/A=
X-Google-Smtp-Source: AFSGD/XPFtu+MclU6P+SmKfPU0BI/fTNWYdZS2MG8CP5sdpqfHSILyE0ZDZzfawyluNjx1RaOFX/6Q==
X-Received: by 2002:adf:b745:: with SMTP id n5-v6mr7221735wre.274.1542825121113;
        Wed, 21 Nov 2018 10:32:01 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:32:00 -0800 (PST)
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
Subject: [RFC PATCH v3 10/17] dt-bindings: clock: Add Allwinner suniv F1C100s CCU
Date:   Wed, 21 Nov 2018 21:30:43 +0300
Message-Id: <88a177299386b610d429d4c1eb2566727aef7b17.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
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

