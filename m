Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBivzBmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D80E56074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFFTht (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:37:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35814 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeFFThi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:37:38 -0400
X-Google-Smtp-Source: ADUXVKKVbkLjVmzr2Sm6YmpvW2x0vGH9qfhYXAI97WqEb50UQVivpRBmcT/r7DxRGhCkQYh26btEmw==
From: Mathieu Malaterre <malat@debian.org>
To: James Hogan <jhogan@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: jz4780: DTS: Probe the spi-gpio driver from devicetree
Date: Wed,  6 Jun 2018 21:37:30 +0200
Message-Id: <20180606193730.15087-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180606193730.15087-1-malat@debian.org>
References: <20180606193730.15087-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-gpio driver supports jz4780.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 809f01a62955..308079ee8dd3 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -167,6 +167,25 @@
 		};
 	};
 
+	spi_gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		num-chipselects = <2>;
+
+		gpio-miso = <&gpe 14 0>;
+		gpio-sck = <&gpe 15 0>;
+		gpio-mosi = <&gpe 17 0>;
+		cs-gpios = <&gpe 16 0
+			    &gpe 18 0>;
+
+		spidev@0 {
+			compatible = "spidev";
+			reg = <0>;
+			spi-max-frequency = <1000000>;
+		};
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4780-uart";
 		reg = <0x10030000 0x100>;
-- 
2.11.0
