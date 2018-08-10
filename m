Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B349C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71EC22444
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJQ2v4gO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71EC22444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeHJUZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:25:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42878 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeHJUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:25:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so4858067pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=itUr3AAkHAduxXXhlrEFU6xz8Tobq25hv6Z136WoREo=;
        b=GJQ2v4gOujr4SfXx5JlgkQFCafctR9P4OBGnGgGYICe5kOVSi4bojMGE9mRlNssXPM
         vZrxp2rEap96XTrxD3dokilXfBBIq0szPUu+bXTr5vq3mIzEF48zfalIFKy6iKaUJcaA
         KcCPiwqIxpQdhPJXTq7OJVfrTHSwkz5twLEYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=itUr3AAkHAduxXXhlrEFU6xz8Tobq25hv6Z136WoREo=;
        b=oKIhChSNY+5B+aj0F4ofqOUt/m5ma/2YJkluRl0rDqGh3R9fjU7QHC/0fWox2lzR2a
         KhZPAPfgfsE62SxjqHVjxFg1cWDhtOsX+2KRt+4e4FGr8qHjeq1vo5ufvqk+m+28OZBx
         gV0v7nWAMJX1N6cxwzjHGoLJA91ePx+NWnPxihmYU6Om/n7DCJP97VXzZ/Ek1F25O7i6
         JudNBzdE1fmlFu2EtJUmbdAY9VezjvCANNtHb7CBd9NbwSuUblFquYJJ8YN0Y5fx/I4W
         Wzup4ezvOX75njegctapAKu6kGnPfEp078DTgZHdOiAzpJdfOybryLK1XyNziwHsVvCA
         ksEg==
X-Gm-Message-State: AOUpUlFvech+o+MjIaXV9F69EqfLy2uDdhqQGJSze7oQKf2Acd3lzFhi
        OflrcRt4rcISJauU+hGTED4X
X-Google-Smtp-Source: AA+uWPzbWAUYOR6VwyWMGt7lsSDfhZd9yfHnhTGkSx5IgJ9tUGCK7XwaT05TDYm9soptWqkW9MnGbw==
X-Received: by 2002:a62:1089:: with SMTP id 9-v6mr7872849pfq.30.1533923656999;
        Fri, 10 Aug 2018 10:54:16 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id l127-v6sm16981262pfc.55.2018.08.10.10.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 10:54:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] arm64: dts: Add devicetree support for HiKey970 board
Date:   Fri, 10 Aug 2018 23:23:39 +0530
Message-Id: <20180810175339.25421-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
References: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for HiKey970 development board which
based on Hi3670 SoC and is also one of the 96Boards Consumer
Edition and AI platform.

Only UART6 is enabled which is the default console required
by the 96Boards Consumer Edition Specification.

This patch has been tested on HiKey970 Board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/Makefile        |  1 +
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts

diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
index 03d93f8ef8a9..f4d68caeba83 100644
--- a/arch/arm64/boot/dts/hisilicon/Makefile
+++ b/arch/arm64/boot/dts/hisilicon/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_HISI) += hi3660-hikey960.dtb
+dtb-$(CONFIG_ARCH_HISI) += hi3670-hikey970.dtb
 dtb-$(CONFIG_ARCH_HISI) += hi3798cv200-poplar.dtb
 dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
new file mode 100644
index 000000000000..4f5118642024
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Hisilicon HiKey970 Development Board
+ *
+ * Copyright (C) 2016, Hisilicon Ltd.
+ * Copyright (C) 2018, Linaro Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "hi3670.dtsi"
+
+/ {
+	model = "HiKey970";
+	compatible = "hisilicon,hi3670-hikey970", "hisilicon,hi3670";
+
+	aliases {
+		serial6 = &uart6;       /* console UART */
+	};
+
+	chosen {
+		stdout-path = "serial6:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* expect bootloader to fill in this region */
+		reg = <0x0 0x0 0x0 0x0>;
+	};
+};
+
+&uart6 {
+	status = "okay";
+};
-- 
2.17.1

