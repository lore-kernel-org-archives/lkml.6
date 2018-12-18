Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5153C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BCD217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7JRSrAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeLRIGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:06:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36445 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeLRIGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:06:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so7452696pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
        b=e7JRSrAf8tYftofR6Nt0Jup6rjHQzM9AyxzsMscFwCvLYirD1lf1YYNM3yt6OXWUYP
         2L8Mmx6wclRDrJqB/L6e6+abWX5i7G4zk/uLByVujvH3pP0lO14bxPbOTtZETGtPL1c6
         3TnmYjFWwD4TBHDOrkQReoeWrgIxjRAzagXiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
        b=CF8gQ+UeJ0eo3pqBquRM/ygn5rNhrCefs3qOLF8E1mks05R5/WliWpW6EYUwgENvGG
         3t8PgefWbuFpdWj//PLGQz2G7P1pr9aw3XFxOxNKqDiuAkV73GvXGHTvHULi1gJqOgBp
         Iv7F460OT131f+ieJqB2TJFseA3QuHInxHB19Uq+RQcWMcCIRUtNlQLGhOUmnaopY254
         hWsn/4XKxUxIkmP9AG0/9Kgm+Ldmxtv9gDdXvVJP7AYjNGYnmfpIImNXdmwUumam0wMq
         hpmI2N9o3DhnxJdXY6hlegcb2ymLWjayzDJnGisDMLx4asaObn3GNXyWL404PASx7r6q
         Smrw==
X-Gm-Message-State: AA+aEWY0GjQp1C5t47ZaYphaVBThGR6DndySSrujS9kgsNeRmjbe5jM4
        qSy2lrDlWPQjnDDAEligAC3q
X-Google-Smtp-Source: AFSGD/VHxIUaNuTsemyGsqeUllriiWDzULrfb3dRwnRpaC9JgO22Hzumx9WUEeFugh6imstyLoNAtQ==
X-Received: by 2002:a63:1a4b:: with SMTP id a11mr14959790pgm.254.1545120374584;
        Tue, 18 Dec 2018 00:06:14 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:06:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 04/11] ARM: dts: Add devicetree for RDA8810PL SoC
Date:   Tue, 18 Dec 2018 13:35:20 +0530
Message-Id: <20181218080527.10801-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree for RDA8810PL SoC from RDA Microelectronics.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
new file mode 100644
index 000000000000..15547b138977
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * RDA8810PL SoC
+ *
+ * Copyright (c) 2017 Andreas Färber
+ * Copyright (c) 2018 Manivannan Sadhasivam
+ */
+
+/ {
+	compatible = "rda,8810pl";
+	interrupt-parent = <&intc>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <0x0>;
+		};
+	};
+
+	sram@100000 {
+		compatible = "mmio-sram";
+		reg = <0x100000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+	};
+
+	apb@20800000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x20800000 0x100000>;
+
+		intc: interrupt-controller@0 {
+			compatible = "rda,8810pl-intc";
+			reg = <0x0 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	apb@20900000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x20900000 0x100000>;
+	};
+
+	apb@20a00000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x20a00000 0x100000>;
+
+		uart1: serial@0 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x0 0x1000>;
+			status = "disabled";
+		};
+
+		uart2: serial@10000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x10000 0x1000>;
+			status = "disabled";
+		};
+
+		uart3: serial@90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x90000 0x1000>;
+			status = "disabled";
+		};
+	};
+
+	l2: cache-controller@21100000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x21100000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+};
-- 
2.17.1

