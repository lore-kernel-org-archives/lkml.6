Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7894C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DC92086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFAkdXtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfA1LpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:45:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47070 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfA1LpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:45:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so17608593wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2gNvmDs3vCdOhRLOPNjOrr4p1fKxmGZTEdGsMe8hCo4=;
        b=QFAkdXtWd050TwoTegdEMbPl5/cb7Ej2bG9FxckLttf25SeT1yiZiIAAqPSeadyF/c
         8crg1BiOvFHr0tHdZ6fq1EPi8wIGAL536DP2a05uUx0Kj8WWbuFqYbmZwpdwr4gU6G3k
         cYu9/da5qQov7rxgj9S8OF6En08rYNaOkO064=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2gNvmDs3vCdOhRLOPNjOrr4p1fKxmGZTEdGsMe8hCo4=;
        b=k3wtTSqM1cvPV6uFgyGC8reIXLiqKBPfHujqvssTtDRN5N+CGowthQM3O6OLac9+jD
         8o/6JHg/RbjW7ot938h0r2oZTTi8HA0DvboA8iGFw1yhxS6pvAjNUosPfId62ggxAQCO
         ZP8NvUeaVs9rUXuD+7GDEb8L+9nMwDvKM0M75b3PIlOV0LIfgnpw7CAPXMXm3t4TyDKr
         JYGx8w5iQesrR58NTQhziRud4L3zHxzglCKEjQoPXU/kE9+ibFJsIYxCn7m6mu7KXujC
         vZtDwCr9z5gbezKFdfbUcjnyL9eRCwTCdt4tWnFEJCdKh5vZ9pTZRAUYbShzGUZPSanb
         7knA==
X-Gm-Message-State: AJcUukfiiCfCYqOHIRGB6/6ClyEEB68ED9DlQOPvFFj8iiB4Wn5NpnCm
        Q3d38Fues04zuLKGkmTRqlkm4w==
X-Google-Smtp-Source: ALg8bN6BGZsCuwASfqXlpxEOCs2Vy2ZlU2twy93qHgQNQJQAkcnMzXRuKazQyjafvS1+QJ4qCNEWzQ==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr22181171wrs.117.1548675917529;
        Mon, 28 Jan 2019 03:45:17 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id z9sm122968775wrs.63.2019.01.28.03.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 03:45:17 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: pms405: add spmi regulators
Date:   Mon, 28 Jan 2019 12:45:04 +0100
Message-Id: <1548675904-18324-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMS405 sports 5 SMPS and 13 LDO regulators.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index ad2b62d..6fbdb1e 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -52,4 +52,24 @@
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
 		};
 	};
+
+	pms405_1: pms405@1 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		regulators {
+			compatible = "qcom,pms405-regulators";
+			vdd_s3-supply = <&pms405_s3>;
+
+			pms405_s3: s3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vdd_cpu";
+				regulator-min-microvolt = <1048000>;
+				regulator-max-microvolt = <1352000>;
+			};
+		};
+	};
 };
-- 
2.7.4

