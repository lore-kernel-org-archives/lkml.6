Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF1FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BB821873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxFWH4zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeLRPDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:03:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44407 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeLRPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:03:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so8252188pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4xtujsTt51xjeBlCqtpiwVFI+MMIJI2gQm9S+Vb5IU=;
        b=HxFWH4zm9VyHcUeDTZblNdLNCFIFYBvQP8phho0YEoV5uUBZEwyn5+5UpHrA4BGx3v
         HIJ7xsbJfRAJCjM3EBpkpVyiAe9jvDGR93r709LHS3Vz94eC8Gcyd7HDu4dpiaUFHlc6
         C50+uBYf8TfYjB+jOhBR45/RZmhBtTF17wpqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4xtujsTt51xjeBlCqtpiwVFI+MMIJI2gQm9S+Vb5IU=;
        b=bJCo6UYwukON8ZAyBo3WoBoBPcZpssF0GUEXAJrZhLHxzpdp+A5CM+VpP609qDZu4U
         tFvWJV6eJ3wUBh9STHyib2pshixSCBtxoqFetQ3rwpt4IM6EuPqcFnxgmozbnsuWUOK/
         3KJZ7f4/i75QED9AOCbUy0caxg0BLfuLibhAxH8YSX7/XBhQdJoRLPi3eDxRCruo0TrX
         SLsfi4tK6QKDvPrc3DWA4vbhjulJZbcmc+ftF0ZcHQzb6eg2gUGBkyIy6QxnSwqwi/3/
         Jvi/NLK+zCQZkufe3wIrSdSoGp8EoVjAfYVKMn8DylmyO5/5V2nudoHBZH/yWGCdbvvi
         yQrg==
X-Gm-Message-State: AA+aEWbtFtIG9OB+1StcTHAgp5CfCQ0qz55Pe2hUBxIt031CDR34b4+V
        pGFT/1HISMs/IKRXGh4JMosd
X-Google-Smtp-Source: AFSGD/UAt/kBd75XrEij9wrxXhvukgdaTY0LbjlzDw7TVjbsxIgsotbZ65cNJ7Q/G55S+0PxajBOzQ==
X-Received: by 2002:a63:7c41:: with SMTP id l1mr15797012pgn.45.1545145407166;
        Tue, 18 Dec 2018 07:03:27 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:03:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 04/11] ARM: dts: Add devicetree for RDA8810PL SoC
Date:   Tue, 18 Dec 2018 20:32:31 +0530
Message-Id: <20181218150238.23010-5-manivannan.sadhasivam@linaro.org>
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

Add initial device tree for RDA8810PL SoC from RDA Microelectronics.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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

