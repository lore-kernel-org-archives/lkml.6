Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BC6ADC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6363D208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CceKRdm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6363D208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755744AbeFOHDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:03:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46380 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbeFOHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:03:46 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so4435044pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yQlaqM5XGttjt680bJd3u67BVy+6fjXx4Z5qhtLnlOw=;
        b=CceKRdm6I1wLY6D1klaJHsKaKzk+6IS+wkqEYKSxOW0hciAnwai+rD72BWFZKENVka
         bzVawnOsJnuUqA/Pk7FblIjIluFT4gERAVkma3gfP2tL8E0E9K2eehe18VqvZZ0rVfGR
         I1KoGUCJv3V1DLKX6JHWFkSd8wSusREL8Xiuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yQlaqM5XGttjt680bJd3u67BVy+6fjXx4Z5qhtLnlOw=;
        b=I7w4Luc1aWJJXs3zG0mj9xBJXCPNtknDzfGWqZ+cCP+wsGVuboy9CMnFnJZLD+bIIv
         NL8v6GNQH97dP+auApESbrXl6zo+cxvz/ShcRMHFsFfmZ8jBZfOxQ/PJLLjRket4TQOU
         DmJuCodzAu5gdd1NXOabrPoNifirD6XeX3fW01jkKewsYUvUjItP1dLSJX1jrdEGnwHs
         DAyISWznDV3e/CJmqdRbV8Wg7BHmxutCjxnhWybpcriDRVtIbEIHEfWSV1WzbMbqZplL
         sCNTQbESzbdE/2jY+gdbU6bV9HblzCnqLzk94B2VXcyZZDYsmy5DtyjD44gbzjHhIzqs
         PoOw==
X-Gm-Message-State: APt69E3nDnFXOhCWcZ2zWIIo/dcQLGdf/XogzG5L86jL0LbI/xX8d32F
        hzSFwvMbJngzDOfdh0u4mKmQjw==
X-Google-Smtp-Source: ADUXVKKCr0NqDwWxpk8OxdWEnK12ckm3fQRzdVKUoH4f35+o/Rzu3BD44/r39FttkjvGas+nKWll3w==
X-Received: by 2002:a63:87c8:: with SMTP id i191-v6mr469919pge.124.1529046225605;
        Fri, 15 Jun 2018 00:03:45 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h78-v6sm15139330pfh.141.2018.06.15.00.03.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 00:03:45 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, freeman.liu@spreadtrum.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: Add Spreadtrum SC27XX PMICs ADC controller documentation
Date:   Fri, 15 Jun 2018 15:03:35 +0800
Message-Id: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27XX series
PMICs ADC controller device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
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

