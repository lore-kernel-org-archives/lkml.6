Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B766AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8434020874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C74OyDly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeLRDmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:42:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45405 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeLRDmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:42:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so7116418pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBeXaJXIkgLTVAea7CD+4QY6FweZRNu6qTHTVAB8x/Y=;
        b=C74OyDly/NiDSVigsP5oCcyhH/+431l8v+3wMLcDmTTt4/7sWUZudzf3bJVdGVJE+S
         oZEnZdjdZUhN9/ortEfDl6NF7rWEYgAP2n0hhJ0TK354X4xeKA0SIafrrrB5iyV1PK/3
         j+WYI7zOtJBaLAeUsumyexl9kNs0EAVKboO1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBeXaJXIkgLTVAea7CD+4QY6FweZRNu6qTHTVAB8x/Y=;
        b=eOk14RlqQRtqx8ctGKPD7T6Ja8UF/cV4u0XOE6XWw8naovdHxH+h514GKpt+oAtkqQ
         GAOsf+34zrVzS/2VTMsptKNkRxoLYue6Rn2vDd2GUXrUmtplOp3bV1sxJn3z+OnrW6da
         ofqutQuH/ffqS+FKVbmV4V4RP4c+XxtGg13ikh5vrwNp48tjRC1PMZJv5XdcHcSgSiL6
         zvzQ2toqgm8/lqnS5uSYnb4s9VzcplBY+jeb0wS5PNuwnZtayIYUC/zq/4nvRjeRt44M
         l2wW5g1wQYX+Sw9E38zdD8FUm1pRHDpEITHrMN9novHY5SmCSox2L+VHpncDXgD7rF3Z
         Juuw==
X-Gm-Message-State: AA+aEWZiLCAQhuq+kD0oX30QHgdUi4GKfiEqUPpEM+ES62GuQfUmK49W
        WF4PvK5F1w4WvhTITdVfWn0f
X-Google-Smtp-Source: AFSGD/Ur6QlqoYVhX6ulGeNUDPBX3qrFkGoScofDTgtC7XPVabrAqXv5AtErBkEJattpaN4PjDPuAA==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr15084079pfh.151.1545104559121;
        Mon, 17 Dec 2018 19:42:39 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:42:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 05/11] ARM: dts: Add devicetree for OrangePi 2G IoT board
Date:   Tue, 18 Dec 2018 09:11:26 +0530
Message-Id: <20181218034132.5070-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial devicetree support for OrangePi 2G IoT board from Xunlong.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/Makefile                    |  2 +
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    | 50 +++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d625b9..a0fdad8f10dd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -806,6 +806,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974-sony-xperia-castor.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb
+dtb-$(CONFIG_ARCH_RDA) += \
+	rda8810pl-orangepi-2g-iot.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
diff --git a/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts b/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
new file mode 100644
index 000000000000..98e34248ae80
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
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
+	compatible = "xunlong,orangepi-2g-iot", "rda,8810pl";
+	model = "Orange Pi 2G-IoT";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
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

