Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FCAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793E021852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFFe5goN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeLRPDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:03:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37564 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeLRPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:03:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so7952214plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HM6vGHLEYTQ34K9d+Cku5qQedHbZ76UdlqZjiEC2yYI=;
        b=DFFe5goNJ8sL3mG1QL4BIapBIANcH2+8O3WOryVR7vnKWC/Ldpfg6UnIfIa7MBhDrL
         KNASmNqDLUPuxi/0dVrx4rvAqJ+ZLhtTQIcbpy8ekVH7jfP/YzbyhRibR4iAOwAh+kAY
         3MMucGr6nYYJzyr19GhReRznyqp4qrU6vM988=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HM6vGHLEYTQ34K9d+Cku5qQedHbZ76UdlqZjiEC2yYI=;
        b=UWh9l2VR1vaLJVpHI/IaJ6HhwoTLgzhsQ+TF+zgZt0UxPJHLyRPPNJAxeiaUimaPKV
         sIZ4U2KvQZQArpoT/mRmWTrV/jiJPsJ7hbvtxDr1m1wzVC52KiRSQl95qv1SPeIrHpA4
         OlIoN0ejax9VlJNFYreE36HjFdw6sl8QHtFLHdN3fbrMhTp5kbet9IHZ2sgWzSo+b3wl
         XT6K/t8TvpY7HBFb/hkwY8iKuETv4iWZAw8EnnNovKLxsYx6a9J3dl16zGv3vE5gh75W
         CDUfB9oeegEz4QBoLnTKYv/jZtordUZDjQ3gFlawc+siPVuJV6Pkic+xHT4YAIrrtnga
         qLcQ==
X-Gm-Message-State: AA+aEWaovMZU4iFhJZmVkNosJNa+ULDtVUClNTQbtkmtlKNaKImBAM1j
        wTPN+hRuRa/9ncJ9GDA34qHI
X-Google-Smtp-Source: AFSGD/W3FUXjOO3QZhHB/6lIBHHQPo9D7ENM/Sq4ljq3u2v/P6Oh1BEhCBqtGVfbZn6QaRpO9utmDw==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr16783365plj.116.1545145425629;
        Tue, 18 Dec 2018 07:03:45 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:03:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 06/11] ARM: dts: Add devicetree for OrangePi i96 board
Date:   Tue, 18 Dec 2018 20:32:33 +0530
Message-Id: <20181218150238.23010-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial devicetree for Orange Pi i96 board from Xunlong. It
is one of the 96Boards IoT Edition board.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/Makefile                   |  3 +-
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts | 50 ++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a0fdad8f10dd..cfb08ea33872 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -807,7 +807,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974-sony-xperia-honami.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb
 dtb-$(CONFIG_ARCH_RDA) += \
-	rda8810pl-orangepi-2g-iot.dtb
+	rda8810pl-orangepi-2g-iot.dtb \
+	rda8810pl-orangepi-i96.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
diff --git a/arch/arm/boot/dts/rda8810pl-orangepi-i96.dts b/arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
new file mode 100644
index 000000000000..728f76931b99
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ */
+
+/dts-v1/;
+
+#include "rda8810pl.dtsi"
+
+/ {
+	compatible = "xunlong,orangepi-i96", "rda,8810pl";
+	model = "Orange Pi i96";
+
+	aliases {
+		serial0 = &uart2;
+		serial1 = &uart1;
+		serial2 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial2:921600n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+
+	uart_clk: uart-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <921600>;
+		#clock-cells = <0>;
+	};
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
+
+&uart3 {
+	status = "okay";
+	clocks = <&uart_clk>;
+};
-- 
2.17.1

