Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C0C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD60620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2mYM3oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfAaAAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:00:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45858 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfAaAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:00:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so572980plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OaFD0M5dIEtSst8G4T5l3VJFNcduRZuMCC/2FAz5l/o=;
        b=d2mYM3ocy/vz4UJO504AzF338dNMr5sjZ4pl9Pq96Palfh13lixX21yR94Cfl2NaYN
         oAB8q8UBSBGwpEE/mlT8d64tW/4f9JZ+Uc41sheWHSU+Csl/QGK2CVT9ESMZAQ2BLtQ5
         WWKYnhynQ42mry1GqnPZ+WRDKO+2wFncmFbyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OaFD0M5dIEtSst8G4T5l3VJFNcduRZuMCC/2FAz5l/o=;
        b=OlXH7Nvpk2E4O4NoaXuMVsa5BOGoTy/dg+fexSMxchnMWtrzlp767e3OaelhSF7Su1
         z56Sg0b7Cq6hZQ6HTpJTE1WVIlkRI/L9dIgsz8K1H+uLOaVrj603t1P/iBx5UwemMRdO
         SDE528MWFou/R/QjFWLAFxvzwTjvGvVGI9h/fUWJek27apqxktyRlUgc6vWUxNJCbvxk
         MHPqIlZe3g1jfbZ1qB42xaghUiUrweP9R2Pev27M5R1BTVWkLX5UEfSDJMtq93EFm43h
         9VS1er8X/Mq/e30TykAQO4xx95K2gpXC/gY0zzAZY1AAeq7eY9s4y0OS+0ccjYOETQYn
         pbdw==
X-Gm-Message-State: AJcUukcpQWz0NFV1mXvQ2xWTUUpqV5Ix67B96EBzicmfi49IQJb7fAXI
        beEAShr5cx381huXwFUlDyUkAw==
X-Google-Smtp-Source: ALg8bN7khfj/o6pSi5Jesuf9ND8sCVrzEa/YreGlj8wluN63xZJ+RwsalYJTwQjtlvXyXbytS4b/Hw==
X-Received: by 2002:a17:902:e08b:: with SMTP id cb11mr32825776plb.263.1548892822814;
        Wed, 30 Jan 2019 16:00:22 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 15sm1007622pfs.113.2019.01.30.16.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:00:21 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: qcom: qcs404: Define APPS IOMMU
Date:   Wed, 30 Jan 2019 16:00:06 -0800
Message-Id: <20190131000006.11145-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APPS IOMMU provides contexts for FastRPC, MDP and WLAN, among other
things. Define these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 85 ++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d90decd00f5c..c574e48c61d2 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -395,6 +395,91 @@
 			reg = <0x01905000 0x20000>;
 		};
 
+		apps_iommu: iommu@1e20000 {
+			compatible = "qcom,qcs404-iommu", "qcom,msm-iommu-v1";
+			clocks = <&gcc GCC_SMMU_CFG_CLK>,
+				 <&gcc GCC_APSS_TCU_CLK>;
+			clock-names = "iface", "bus";
+			qcom,iommu-secure-id = <17>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#iommu-cells = <1>;
+
+			/* Define ranges such that the first bank is at 0x1000 */
+			ranges = <0 0x01e20000 0x40000>;
+
+			/* Bank 5: CDSP compute bank 1 */
+			iommu-ctx@5000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x5000 0x1000>;
+				interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* Bank 6: CDSP compute bank 2 */
+			iommu-ctx@6000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x6000 0x1000>;
+				interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* Bank 7: CDSP compute bank 3 */
+			iommu-ctx@7000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x7000 0x1000>;
+				interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* Bank 8: CDSP compute bank 4 */
+			iommu-ctx@8000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x8000 0x1000>;
+				interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* Bank 9: CDSP compute bank 5 */
+			iommu-ctx@9000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x9000 0x1000>;
+				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* Bank 10: MDP */
+			iommu-ctx@a000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0xa000 0x1000>;
+				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* Bank 21: WLAN 0 */
+			iommu-ctx@15000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x15000 0x1000>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* Bank 23: ADSP compute bank 2 */
+			iommu-ctx@17000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x17000 0x1000>;
+				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* Bank 24: ADSP compute bank 3 */
+			iommu-ctx@18000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x18000 0x1000>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			/* Bank 25: ADSP compute bank 4 */
+			iommu-ctx@19000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x19000 0x1000>;
+				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		spmi_bus: spmi@200f000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0200f000 0x001000>,
-- 
2.18.0

