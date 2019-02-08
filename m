Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3BDC282C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB382080D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzsXKtZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBHAaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:30:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35283 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBHAaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:30:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so825461plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m09kF0Fi0NLeeymHfmgKYOPmCDh2G2+L0dXTvpyHyHg=;
        b=dzsXKtZ0Fim3cjwQhLLvhVsXktoKxQsMktcmqYni3Eb5hs57LWi+P24srKZ+7jBAM2
         zwEtFscYjWQnrr6X2pPTJC+0JL+RYcZjDLX/pxS0V/zBCvtEb7Xm9hDlPd08bHlz9iRI
         ul3XmlBi5obDnYGvuDRyl4Lh+z8GVe2/WAn5nSSAvFRN1g15OnXlbfIWmJxtvyNTahxe
         tMW3gtDB7i1bu9fXoXawzDMJmAZNlaWb4upuEgL8kxt957iEFyo7KhacePFngmwcdxtd
         utT+c5sLIqDD3I0jzDKrChOrDl4InwdbDi1zhXVoF97VGI0L3jqhCFo+ulS6qRbZQLlW
         584A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m09kF0Fi0NLeeymHfmgKYOPmCDh2G2+L0dXTvpyHyHg=;
        b=FI0UHD+DqJ74V/3VJDRiREmapooUe7mfTCcB/qYddL2Bdf64XOdUyIG3tiAWCtQA/y
         pkTpE51mZYnOIwFp6I5V23DM/6OdWyvHG0VVd6YjaLfoQYClSPB/dbzwQJlIKnUqYuPf
         IaRcYeegr1zfIHwdq8F5isAJOfjKPIhXah2CWFVkIvmHoYDC5+Vhokg2MTx+yDYcY81O
         JVHSCtK3zC7+z2f1dqvMGuK15xCqPNtnqSVpUuATD4nMbs5xY0UBs/dkxPQ3hZt0PlGx
         X/Czj4F7xCPCDdY+q/cFp6lQSONNhnF25Ne5tTU+CTI619NxgqZHM37cTwpOcb+6sRSU
         T1OA==
X-Gm-Message-State: AHQUAuaeJLReiXpCGc8IEKw+lwavE1ABQ13GFLu+OaTH0O/e3Chef58x
        WgVzx/US1iOZUR3G9tbYyNo=
X-Google-Smtp-Source: AHgI3IZ+9Sw0ETvVXWytwkQXKXlNz+9/mdNFtZqJqmldb5O+2m4JOpwydj4sd2mXjv9ZIB01qn7seg==
X-Received: by 2002:a17:902:1d4a:: with SMTP id u10mr18697449plu.122.1549585801790;
        Thu, 07 Feb 2019 16:30:01 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:30:00 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 4/5] arm64: dts: imx8mq: Add nodes for PCIe IP blocks
Date:   Thu,  7 Feb 2019 16:29:40 -0800
Message-Id: <20190208002941.30343-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for two PCIe controllers found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 89babc531380..8ceab748ed04 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/imx8mq-clock.h>
 #include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx8mq-pinfunc.h"
@@ -539,6 +540,63 @@
 			};
 		};
 
+		pcie0: pcie@33800000 {
+			compatible = "fsl,imx8mq-pcie";
+			reg = <0x33800000 0x400000>,
+			      <0x1ff00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
+			          0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY>,
+			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
+			         <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			status = "disabled";
+		};
+
+		pcie1: pcie@0x33c00000 {
+			compatible = "fsl,imx8mq-pcie";
+			reg = <0x33c00000 0x400000>,
+			      <0x27f00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000 /* downstream I/O 64KB */
+				   0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY2>,
+			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_EN>,
+			         <&src IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,	/* GIC Dist */
-- 
2.20.1

