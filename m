Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9700ECDFB2
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639B720870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqu0MC+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639B720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeGOMyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:54:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37233 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeGOMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:54:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so13213387wmh.2;
        Sun, 15 Jul 2018 05:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y2/51KuHZg6HhqjfutbiEN4mWf0R8/0/50MCNRjwg8E=;
        b=jqu0MC+vCUnx4yhRkSBhhOiO5+5JOAGezss1/ofLTTk+Dh5aEjIeQcMO3bvLslOfFC
         7nzXbCP18GcYiX6IGu+uJr6X8lRBLJMVsTTC7K5XC7o6LenU8hBcOFyBxi483bYcRXOS
         ENraWoEIyFY1Lx9oaQ/0nf9WsEu8TFgvgZ1OL4bM+i6R2rykHqQxoohJTutG4RueljJ3
         DY8yp2BcTLpYaOpF/Nf1bCp4SpjdIZdwrkMDktJEohM3h5obBLaVDHNESV0n0OSWWstU
         CYt5+1DifKEM81IGmP5LKx3+vJhhwbIQt6ho0wgIcN6PT+f3XV7B6KYlcH5dRJBwkXSa
         ZS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y2/51KuHZg6HhqjfutbiEN4mWf0R8/0/50MCNRjwg8E=;
        b=SGl0+8dCS2slVo1ZX+zoVvF1T0phiCsUbhrkQPsYlRo668Hy6jEY4COVFR1YkXXO2Y
         yGEgmUh3GgzildVqHtD5yROVVAOrBONTOX0rZzqwB73pZWrdupoB8kPsAxPjWlWQ+mnT
         xZxGtGB6eWZfcmpas4ri8oEV3JBTTFyqAgAi7ridTt9xzIRIhIjo0lj4nBNqzRQUODqd
         8G7S+I6uDlm59ILfdaB63MD4fq6okxM196n33F2pf+/LlNh4a6LNEYfer0a81sFPzrsj
         4tRVJ57KG7HnqAoEJq38ScZeeuJ8LaPb/XTY48zkuJ8VgmKptclantygiEOCI7FWhR7d
         nsgA==
X-Gm-Message-State: AOUpUlETgRCO2DGdiVudgzaZuZl1ZHmaPUkIW9lXYh3+pN/wLqa7wGlH
        gl8tnkPlFFWSk6L3/Ckpepo=
X-Google-Smtp-Source: AAOMgped6sS4slP+2y5S6XogiuknObyhGgril8UnYpy/IYeOeW6DU+TCuhapASnErHWBrYftl1Fi5Q==
X-Received: by 2002:a1c:e5cd:: with SMTP id c196-v6mr7543599wmh.101.1531657912041;
        Sun, 15 Jul 2018 05:31:52 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id s10-v6sm16358688wmb.12.2018.07.15.05.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 05:31:51 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v4 2/5] dt-bindings: clock: Add S700 support for Actions Semi Soc's
Date:   Sun, 15 Jul 2018 14:31:42 +0200
Message-Id: <20180715123145.16975-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715123145.16975-1-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock bindings constants for action S700
Maintain common clock dt-bindings for Actions Semi SoC's
S700 and S900.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +--
 include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++++++++++++++++
 2 files changed, 129 insertions(+), 9 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (67%)
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
similarity index 67%
rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
rename to Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
index 93e4fb827cd6..d737ea74a450 100644
--- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
@@ -1,12 +1,14 @@
-* Actions S900 Clock Management Unit (CMU)
+* Actions Semi Owl Clock Management Unit (CMU)
 
-The Actions S900 clock management unit generates and supplies clock to various
-controllers within the SoC. The clock binding described here is applicable to
-S900 SoC.
+The Actions Semi S900/S700 clock management unit generates and supplies clock
+to various controllers within the SoC. The clock binding described here is
+applicable to S900 and S700 SoC's.
 
 Required Properties:
 
-- compatible: should be "actions,s900-cmu"
+- compatible: should be one of the following,
+	"actions,s900-cmu"
+	"actions,s700-cmu"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - clocks: Reference to the parent clocks ("hosc", "losc")
@@ -15,16 +17,16 @@ Required Properties:
 Each clock is assigned an identifier, and client nodes can use this identifier
 to specify the clock which they consume.
 
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/actions,s900-cmu.h header and can be used in device
-tree sources.
+All available clocks are defined as preprocessor macros in corresponding
+dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h header and can be
+used in device tree sources.
 
 External clocks:
 
 The hosc clock used as input for the plls is generated outside the SoC. It is
 expected that it is defined using standard clock bindings as "hosc".
 
-Actions S900 CMU also requires one more clock:
+Actions Semi S900 CMU also requires one more clock:
  - "losc" - internal low frequency oscillator
 
 Example: Clock Management Unit node:
diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bindings/clock/actions,s700-cmu.h
new file mode 100644
index 000000000000..905808bf335b
--- /dev/null
+++ b/include/dt-bindings/clock/actions,s700-cmu.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Actions S700 clock driver
+ *
+ * Copyright (c) 2014 Actions Semi Inc.
+ * Author: David Liu <liuwei@actions-semi.com>
+ *
+ * Author: Pathiban Nallathambi <pn@denx.de>
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_S700_H
+#define __DT_BINDINGS_CLOCK_S700_H
+
+#define CLK_NONE			0
+
+/* pll clocks */
+#define CLK_CORE_PLL			1
+#define CLK_DEV_PLL			2
+#define CLK_DDR_PLL			3
+#define CLK_NAND_PLL			4
+#define CLK_DISPLAY_PLL			5
+#define CLK_TVOUT_PLL			6
+#define CLK_CVBS_PLL			7
+#define CLK_AUDIO_PLL			8
+#define CLK_ETHERNET_PLL		9
+
+/* system clock */
+#define CLK_CPU				10
+#define CLK_DEV				11
+#define CLK_AHB				12
+#define CLK_APB				13
+#define CLK_DMAC			14
+#define CLK_NOC0_CLK_MUX		15
+#define CLK_NOC1_CLK_MUX		16
+#define CLK_HP_CLK_MUX			17
+#define CLK_HP_CLK_DIV			18
+#define CLK_NOC1_CLK_DIV		19
+#define CLK_NOC0			20
+#define CLK_NOC1			21
+#define CLK_SENOR_SRC			22
+
+/* peripheral device clock */
+#define CLK_GPIO			23
+#define CLK_TIMER			24
+#define CLK_DSI				25
+#define CLK_CSI				26
+#define CLK_SI				27
+#define CLK_DE				28
+#define CLK_HDE				29
+#define CLK_VDE				30
+#define CLK_VCE				31
+#define CLK_NAND			32
+#define CLK_SD0				33
+#define CLK_SD1				34
+#define CLK_SD2				35
+
+#define CLK_UART0			36
+#define CLK_UART1			37
+#define CLK_UART2			38
+#define CLK_UART3			39
+#define CLK_UART4			40
+#define CLK_UART5			41
+#define CLK_UART6			42
+
+#define CLK_PWM0			43
+#define CLK_PWM1			44
+#define CLK_PWM2			45
+#define CLK_PWM3			46
+#define CLK_PWM4			47
+#define CLK_PWM5			48
+#define CLK_GPU3D			49
+
+#define CLK_I2C0			50
+#define CLK_I2C1			51
+#define CLK_I2C2			52
+#define CLK_I2C3			53
+
+#define CLK_SPI0			54
+#define CLK_SPI1			55
+#define CLK_SPI2			56
+#define CLK_SPI3			57
+
+#define CLK_USB3_480MPLL0		58
+#define CLK_USB3_480MPHY0		59
+#define CLK_USB3_5GPHY			60
+#define CLK_USB3_CCE			61
+#define CLK_USB3_MAC			62
+
+#define CLK_LCD				63
+#define CLK_HDMI_AUDIO			64
+#define CLK_I2SRX			65
+#define CLK_I2STX			66
+
+#define CLK_SENSOR0			67
+#define CLK_SENSOR1			68
+
+#define CLK_HDMI_DEV			69
+
+#define CLK_ETHERNET			70
+#define CLK_RMII_REF			71
+
+#define CLK_USB2H0_PLLEN		72
+#define CLK_USB2H0_PHY			73
+#define CLK_USB2H0_CCE			74
+#define CLK_USB2H1_PLLEN		75
+#define CLK_USB2H1_PHY			76
+#define CLK_USB2H1_CCE			77
+
+#define CLK_TVOUT			78
+
+#define CLK_THERMAL_SENSOR		79
+
+#define CLK_IRC_SWITCH			80
+#define CLK_PCM1			81
+#define CLK_NR_CLKS			(CLK_PCM1 + 1)
+
+#endif /* __DT_BINDINGS_CLOCK_S700_H */
-- 
2.18.0

