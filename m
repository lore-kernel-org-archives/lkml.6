Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A6C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20CC208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPdtJY/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20CC208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754363AbeFUDOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:14:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46389 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754159AbeFUDOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:14:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so842356pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Nk7zKxhi16MQcphw1c9ypcmwMqZAMdYmp9p5N1ea/lY=;
        b=FPdtJY/9Ioeq2KBOeYmGAfVZn8Tl6qCz1hXzVkOZfHWdBZ0FAlx2CODwpkqWCIfKBr
         dMRLIyII24HYoD7vGzhJBTlWJ4O7sY5J4UCzI8MWFRbGKwy96c8R+kPsYgCPRvmsxFGd
         pEQdJkJ3Y4omAsynhbAsgm3yP9AC8hlU5oV5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nk7zKxhi16MQcphw1c9ypcmwMqZAMdYmp9p5N1ea/lY=;
        b=DZRF4ufuTVMF9TKu4Jjhg+GX7ftgWPBR4aJxGedtPyVjj4bsiFsDt2K7XfjhmnPQnb
         7xPEPh/6XQMckPw6goBo1/cv5/TWC8mQBb72XA2WpfNvFx0rO1O6X3Ct+JxNewPikCVg
         vG0Au3sXanBW8Z/HIWrBVsly9Rh2J0ApSuQIY5kYICtqppLQ0q9OfsYlBaRCNvfkVz1l
         Wbas6yf9g0uhEJkG2zEADf3RBZUvYSvSlC9b7ikQrEklt114k0OQmUQyl0pJRV2J5OfM
         RF5dafvf055pHKm+NDgQv+clI3ivPirUNd4hylVZnhaZgCSPte2U3mRtccfRo6uBBbE8
         THpA==
X-Gm-Message-State: APt69E3CZ7C4SRwHslRFmEWuyHzZUCVQeNG0FtFN9tEI3ECkAsFeXp6i
        MEl7ULf5kU6TY1tIRsAWSDbS4Q==
X-Google-Smtp-Source: ADUXVKLjaenr0Cej4DtBn1irCFYKM2kfW+Hhji4QOix1DWBnLgA4USk/bcfjPIQCXP/H73ioIgVf3Q==
X-Received: by 2002:a17:902:2927:: with SMTP id g36-v6mr26199010plb.303.1529550889904;
        Wed, 20 Jun 2018 20:14:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m5-v6sm11443448pfa.93.2018.06.20.20.14.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 20:14:49 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, freeman.liu@spreadtrum.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: Add Spreadtrum SC27XX PMICs ADC controller documentation
Date:   Thu, 21 Jun 2018 11:14:04 +0800
Message-Id: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27XX series
PMICs ADC controller device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v2:
 - Add reviewed tag from Rob.

Changes since v1:
 - No updates.
---
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |   36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
new file mode 100644
index 0000000..8aad960
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
@@ -0,0 +1,36 @@
+Spreadtrum SC27XX series PMICs ADC binding
+
+Required properties:
+- compatible: Should be one of the following.
+	"sprd,sc2720-adc"
+	"sprd,sc2721-adc"
+	"sprd,sc2723-adc"
+	"sprd,sc2730-adc"
+	"sprd,sc2731-adc"
+- reg: The address offset of ADC controller.
+- interrupt-parent: The interrupt controller.
+- interrupts: The interrupt number for the ADC device.
+- #io-channel-cells: Number of cells in an IIO specifier.
+- hwlocks: Reference to a phandle of a hwlock provider node.
+
+Example:
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmic_adc: adc@480 {
+			compatible = "sprd,sc2731-adc";
+			reg = <0x480>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			hwlocks = <&hwlock 4>;
+		};
+	};
-- 
1.7.9.5

