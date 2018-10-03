Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD9C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161282098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ik53fxLa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jPJD71MX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161282098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJCUdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:33:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:33:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 84BB560C7B; Wed,  3 Oct 2018 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538574306;
        bh=kzWuYFfTiyoeClrY0eK/QW8Y7mt86vDlMXD2H3en6qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ik53fxLaOeiADXJU+k45FrqiSP4aRJKWdu6cXGCI74BtxFRM/5Rj3m0hlVayMOyeE
         ukWwlqBVnVSvXZX2VNMKSmfA2ja+4ZnJtlluECjB32Q+p6h6ITQVgR1vIqftwo66kM
         L/0LBx1n2MtUQ0TyPhxhwTyj+amU/057wzkSuDB0=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5052760C80;
        Wed,  3 Oct 2018 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538574304;
        bh=kzWuYFfTiyoeClrY0eK/QW8Y7mt86vDlMXD2H3en6qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPJD71MXowLF3ySBrXr5vKhMPDUJiluGKInheTa1K4eQ833cIl4BgI9JM4GFbxkUK
         DoL6WU/++JL3QyVGn2LpifriqKRE0lsrwRyMRvFowjZdOHpuXP3HjSpKjd3RzkAmXV
         MBx5jAldXEubQPF/6sUEpwQeJkQXfW93oo5Q1JZM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5052760C80
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH V5 2/3] dt-bindings: soc: qcom: GENI SE SPI controller device tree binding
Date:   Wed,  3 Oct 2018 19:14:24 +0530
Message-Id: <1538574265-30235-3-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dilip Kota <dkota@codeaurora.org>

Move GENI SE SPI controller device-tree bindings
from devicetree/bindings/soc/qcom/qcom,geni-se.txt
to devicetree/bindings/spi/qcom,spi-geni-qcom.txt.

Signed-off-by: Dilip Kota <dkota@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 27 ++-------------
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt | 39 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index b9d0c21..dab7ca9 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -53,19 +53,8 @@ Required properties:
 - clocks:		Serial engine core clock needed by the device.
 
 Qualcomm Technologies Inc. GENI Serial Engine based SPI Controller
-
-Required properties:
-- compatible:		Must contain "qcom,geni-spi".
-- reg:			Must contain SPI register location and length.
-- interrupts:		Must contain SPI controller interrupts.
-- clock-names:		Must contain "se".
-- clocks:		Serial engine core clock needed by the device.
-- #address-cells:	Must be <1> to define a chip select address on
-			the SPI bus.
-- #size-cells:		Must be <0>.
-
-SPI slave nodes must be children of the SPI master node and conform to SPI bus
-binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
+node binding is described in
+Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt.
 
 Example:
 	geniqup@8c0000 {
@@ -102,16 +91,4 @@ Example:
 			pinctrl-1 = <&qup_1_uart_3_sleep>;
 		};
 
-		spi0: spi@a84000 {
-			compatible = "qcom,geni-spi";
-			reg = <0xa84000 0x4000>;
-			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-			clock-names = "se";
-			clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&qup_1_spi_2_active>;
-			pinctrl-1 = <&qup_1_spi_2_sleep>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
 	}
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
new file mode 100644
index 0000000..790311a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
@@ -0,0 +1,39 @@
+GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
+
+The QUP v3 core is a GENI based AHB slave that provides a common data path
+(an output FIFO and an input FIFO) for serial peripheral interface (SPI)
+mini-core.
+
+SPI in master mode supports up to 50MHz, up to four chip selects, programmable
+data path from 4 bits to 32 bits and numerous protocol variants.
+
+Required properties:
+- compatible:		Must contain "qcom,geni-spi".
+- reg:			Must contain SPI register location and length.
+- interrupts:		Must contain SPI controller interrupts.
+- clock-names:		Must contain "se".
+- clocks:		Serial engine core clock needed by the device.
+- #address-cells:	Must be <1> to define a chip select address on
+			the SPI bus.
+- #size-cells:		Must be <0>.
+
+SPI Controller nodes must be child of GENI based Qualcomm Universal
+Peripharal. Please refer GENI based QUP wrapper controller node bindings
+described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt.
+
+SPI slave nodes must be children of the SPI master node and conform to SPI bus
+binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
+
+Example:
+	spi0: spi@a84000 {
+		compatible = "qcom,geni-spi";
+		reg = <0xa84000 0x4000>;
+		interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "se";
+		clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&qup_1_spi_2_active>;
+		pinctrl-1 = <&qup_1_spi_2_sleep>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

