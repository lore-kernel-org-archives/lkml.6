Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87529C282C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDE4218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R18l4W5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfAZEL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 23:11:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34465 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbfAZEL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 23:11:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so5021271pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 20:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Dlsm30B9KuTOu0GLcpGbceT3Bf9eF5q8ffkTHhPK10=;
        b=R18l4W5OI7MT0OK4nLJAsmi8khYt/36YKWTv5ckk2NTnitUlKl72fIqBCfmvsQN3as
         qBR872ibrOcIUJkPaiTAlt4BjlDOY+cc0IPemlJn5jr5bNKFoFI2i3DEvowPRV6Qsw34
         e8SNnZ7+l3wPAp8E9Q3H1rDVkLzcNZCCB7cSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Dlsm30B9KuTOu0GLcpGbceT3Bf9eF5q8ffkTHhPK10=;
        b=MEcefgHMYPx4zlU+bYwBmcoVmZfZLEi5Kj46xJhx8/8raJI8PrhdM4cgS0IYic+lAJ
         kLw2pfcTk9H/Wxmq7DFGjhbIemFpONi9xaCsMQ1BlPIy1sXuvm3pFOUCBV9qO/v9PQTh
         aRgbfhvCMwu6PlHfAw3pk0u4sz0GLB7PDmPKPa0N9HJWVwrsUvyFH/BYxUNqWGR29x5v
         IfdvDuyFOtmBfTRKCBWKHwNgHLU3LFYbG5iA6htFDRhasg/PDa9a9Nlhbh64oQxlMucg
         X9TiJV53Xx23z5z3lB3SFgZloHUDv+Q4QErrEZUv5fI3bqCP1JTt8oDJXCC1YYn1Frvi
         MuUw==
X-Gm-Message-State: AJcUukeTk78KsZDppsmPFGX30QsInLGyTiRJ0i2Vh6jE4P9x4Fjtg71T
        ylUdrzIqmL2rDO/B0TUNbmLn
X-Google-Smtp-Source: ALg8bN4JSzb6u5ERSDZfaPGotK5jNqyeieNtXwX7Y4wLRt4M8ZupFvHXqLZoqM/vdUeYYooFMWBe0w==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr12318387pgl.186.1548475885231;
        Fri, 25 Jan 2019 20:11:25 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
        by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 20:11:24 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] arm64: dts: bitmain: Add Sophon Egde board support
Date:   Sat, 26 Jan 2019 09:40:40 +0530
Message-Id: <20190126041041.13173-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for Sophon Edge board from Bitmain based on
BM1880 SoC. This board is one of the 96Boards Consumer and AI platform.
More information about this board can be found in 96Boards product page:

https://www.96boards.org/documentation/consumer/sophon-edge/

Only UART peripheral support is enabled for now.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/Makefile          |  3 ++
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   | 50 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/arm64/boot/dts/bitmain/Makefile
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts

diff --git a/arch/arm64/boot/dts/bitmain/Makefile b/arch/arm64/boot/dts/bitmain/Makefile
new file mode 100644
index 000000000000..be90a6071be0
--- /dev/null
+++ b/arch/arm64/boot/dts/bitmain/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+dtb-$(CONFIG_ARCH_BITMAIN) += bm1880-sophon-edge.dtb
diff --git a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
new file mode 100644
index 000000000000..6a3255597138
--- /dev/null
+++ b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+/dts-v1/;
+
+#include "bm1880.dtsi"
+
+/ {
+	compatible = "bitmain,sophon-edge", "bitmain,bm1880";
+	model = "Sophon Edge";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart2;
+		serial2 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x1 0x00000000 0x0 0x40000000>; // 1GB
+	};
+
+	uart_clk: uart-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <500000000>;
+		#clock-cells = <0>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
+
+&uart1 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
+
+&uart2 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
-- 
2.17.1

