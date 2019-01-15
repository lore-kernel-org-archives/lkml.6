Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D77C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8184620656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHQTYI+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfAODeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:34:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35471 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfAODeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:34:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so636346pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 19:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7d6Ogf6N7tz/DtneEdqXk8KBTvb//DmYHP2fab33+vI=;
        b=aHQTYI+MRzBz5YPrG/LcAGSPcHfPmmk8JgMahVC7qUtRr3SLHlSoPsOL1/9/l0o22v
         Wdg1SpJU9kfluxaN/PUDS0UBQm3TSjboUAJJ/uxjdI45PIaemXEP28ED46uaqXA3GZ1M
         2HhefJkl01rthv2vuTQMOTlvsOLtq5JRyDI2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7d6Ogf6N7tz/DtneEdqXk8KBTvb//DmYHP2fab33+vI=;
        b=k1CIRF+NHGRWHloBn7FrMcfW8O7h6ab6POaRAiXwTQSVeWXqhESGfTs2ODMPLL6/7h
         a0H4YKsqpjk76jJcYjGZihy6si2SCa0+eYgUU6l/F+CYvTX1NlReZTTB64ljr/XeVSjU
         qiQU42JTTDV4QYKzuf+9WjXJtxBMHoZeqhL8UgNzE4nOpbV1h8SHxfVDc5f/Mf1X/9tY
         tnMuvNPEPpcQphzZxwiQEKtd/AbrwfPpVpXDZXJXXj9VCeXkryaOSTuOFo1DZC4qUQhk
         gsP28KWrNuoigVBqEpvsnU/WPj7LToNMJ+ll+gAnXbIIMd7o1jt+h01mWpUpZR6hX+s4
         uTpw==
X-Gm-Message-State: AJcUukerik1FdosMXNhbsPRmHKp2wdxCEWCautjDLpTJ0qpJYFULBJ3J
        y2ZMkt4zxF30U9JY6UzVohnV
X-Google-Smtp-Source: ALg8bN7ao6X1kcEHeVSPExFQ0KBWu2DSRlw4r5xoQr3MN0o9y/5MIrjkwL+KYhv2XZp3Glc4SIgVTQ==
X-Received: by 2002:a65:6094:: with SMTP id t20mr1795150pgu.285.1547523248748;
        Mon, 14 Jan 2019 19:34:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
        by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 19:34:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/6] dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
Date:   Tue, 15 Jan 2019 09:03:36 +0530
Message-Id: <20190115033340.25016-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

Add devicetree bindings for Actions Semi S500 Clock Management Unit.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
[Mani: Documented S500 CMU compatible]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/actions,owl-cmu.txt        |  7 +-
 include/dt-bindings/clock/actions,s500-cmu.h  | 78 +++++++++++++++++++
 2 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h

diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
index 2ef86ae96df8..d19885b7c73f 100644
--- a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
+++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
@@ -2,13 +2,14 @@
 
 The Actions Semi Owl Clock Management Unit generates and supplies clock
 to various controllers within the SoC. The clock binding described here is
-applicable to S900 and S700 SoC's.
+applicable to S900, S700 and S500 SoC's.
 
 Required Properties:
 
 - compatible: should be one of the following,
 	"actions,s900-cmu"
 	"actions,s700-cmu"
+	"actions,s500-cmu"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - clocks: Reference to the parent clocks ("hosc", "losc")
@@ -19,8 +20,8 @@ Each clock is assigned an identifier, and client nodes can use this identifier
 to specify the clock which they consume.
 
 All available clocks are defined as preprocessor macros in corresponding
-dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h header and can be
-used in device tree sources.
+dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h or
+actions,s500-cmu.h header and can be used in device tree sources.
 
 External clocks:
 
diff --git a/include/dt-bindings/clock/actions,s500-cmu.h b/include/dt-bindings/clock/actions,s500-cmu.h
new file mode 100644
index 000000000000..dc3fd2b0299d
--- /dev/null
+++ b/include/dt-bindings/clock/actions,s500-cmu.h
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree binding constants for Actions Semi S500 Clock Management Unit
+ *
+ * Copyright (c) 2014 Actions Semi Inc.
+ * Copyright (c) 2018 LSI-TEC - Caninos Loucos
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_S500_CMU_H
+#define __DT_BINDINGS_CLOCK_S500_CMU_H
+
+#define CLK_NONE		0
+
+/* fixed rate clocks */
+#define CLK_LOSC		1
+#define CLK_HOSC		2
+
+/* pll clocks */
+#define CLK_CORE_PLL		3
+#define CLK_DEV_PLL		4
+#define CLK_DDR_PLL		5
+#define CLK_NAND_PLL		6
+#define CLK_DISPLAY_PLL		7
+#define CLK_ETHERNET_PLL	8
+#define CLK_AUDIO_PLL		9
+
+/* system clock */
+#define CLK_DEV			10
+#define CLK_H			11
+#define CLK_AHBPREDIV		12
+#define CLK_AHB			13
+#define CLK_DE			14
+#define CLK_BISP		15
+#define CLK_VCE			16
+#define CLK_VDE			17
+
+/* peripheral device clock */
+#define CLK_TIMER		18
+#define CLK_I2C0		19
+#define CLK_I2C1		20
+#define CLK_I2C2		21
+#define CLK_I2C3		22
+#define CLK_PWM0		23
+#define CLK_PWM1		24
+#define CLK_PWM2		25
+#define CLK_PWM3		26
+#define CLK_PWM4		27
+#define CLK_PWM5		28
+#define CLK_SD0			29
+#define CLK_SD1			30
+#define CLK_SD2			31
+#define CLK_SENSOR0		32
+#define CLK_SENSOR1		33
+#define CLK_SPI0		34
+#define CLK_SPI1		35
+#define CLK_SPI2		36
+#define CLK_SPI3		37
+#define CLK_UART0		38
+#define CLK_UART1		39
+#define CLK_UART2		40
+#define CLK_UART3		41
+#define CLK_UART4		42
+#define CLK_UART5		43
+#define CLK_UART6		44
+#define CLK_DE1			45
+#define CLK_DE2			46
+#define CLK_I2SRX		47
+#define CLK_I2STX		48
+#define CLK_HDMI_AUDIO		49
+#define CLK_HDMI		50
+#define CLK_SPDIF		51
+#define CLK_NAND		52
+#define CLK_ECC			53
+#define CLK_RMII_REF		54
+
+#define CLK_NR_CLKS	       (CLK_RMII_REF + 1)
+
+#endif /* __DT_BINDINGS_CLOCK_S500_CMU_H */
-- 
2.17.1

