Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0CEB2C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9F0208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LT1IVnCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9F0208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755138AbeFNKoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:44:16 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35015 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935786AbeFNKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:44:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so8667991lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nsLRHqDsn6jIlUl3h1shSA3jg98RwxjrWsSKcLlExq4=;
        b=LT1IVnCorpgGAWEoUOq6VNXRB3aEXO6y7JwmORhLa4nBLkjMCKzQuN899bORmb22Zh
         VhvtR+v/nugVoHnb5hIdg4cFjT1DZLc5Iv6eVvEUJxJMbEm+fj5WH/jJgs09IeBHRemb
         rz4pnwl1DE1rhAWi5hMMoCv5u5Lvc435Pu4H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nsLRHqDsn6jIlUl3h1shSA3jg98RwxjrWsSKcLlExq4=;
        b=EUKYKQS2LJJLBEF6Hh7p0TwFdDg9X6DNXac77grGrW2SfJ/cinEQkKCPanqPpkVIcQ
         DT++WeIwH2csIeNzLkGaoUVZxzTRqeItXfF3bxI2iTu5DpEyL5yiE9WynUzL0Pk69E9x
         Fk8+SEtykISYm4OTrYz0mnrJ5O0ucdC0LpK3KLeKfUvI59AKRUPaajrgqAgciVOz6ybq
         gdWtRJAwqJEA+2yTPFKneOUIwVobIqm8nO7KPzU9SWP0zd+0KlgrlvFRqmi02J9FP5Xb
         QpW58pFK/5M9bFnqsFJ2jqEVAFoKCRpFYHn7EqXaFNo+ElCcxfI6ALLc7rc/6sR0RZl1
         0Slw==
X-Gm-Message-State: APt69E1Ugv+XavpVmYiCYXKbI/pnnL1G1w5NYzo0fwupGrihhD56NFBa
        +Zd76isv5+UCyjJR9aue+FvEYbLlfgo=
X-Google-Smtp-Source: ADUXVKLQ8S6RFe5VU59a/OIS0eSY1JSpk9YPxmV7P3vQdpSEqTuym9MJTzmNvjLDNCPozMW60C51Bw==
X-Received: by 2002:a2e:5358:: with SMTP id t24-v6mr1448532ljd.129.1528973051032;
        Thu, 14 Jun 2018 03:44:11 -0700 (PDT)
Received: from localhost (85-76-96-172-nat.elisa-mobile.fi. [85.76.96.172])
        by smtp.gmail.com with ESMTPSA id a19-v6sm1013055lff.84.2018.06.14.03.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 03:44:09 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brown <david.brown@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE))
Subject: [PATCH v3 4/6] thermal: tsens: Add support for SDM845
Date:   Thu, 14 Jun 2018 13:43:14 +0300
Message-Id: <0cdd0957cf80c2f9921928755722a427c7309964.1528972165.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 uses the TSENS v2 IP block

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi                    | 2 +-
 drivers/thermal/qcom/tsens-v2.c                          | 9 ++++++++-
 drivers/thermal/qcom/tsens.c                             | 3 +++
 drivers/thermal/qcom/tsens.h                             | 5 ++++-
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 06195e8..84da3db 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -5,6 +5,7 @@ Required properties:
  - "qcom,msm8916-tsens" : For 8916 Family of SoCs
  - "qcom,msm8974-tsens" : For 8974 Family of SoCs
  - "qcom,msm8996-tsens" : For 8996 Family of SoCs
+ - "qcom,tsens-v2"      : For any SoC with v2 version of the tsens IP
 
 - reg: Address range of the thermal registers
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6c8a857..28d4c08 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -460,7 +460,7 @@
 		};
 
 		tsens0: thermal-sensor@4a8000 {
-			compatible = "qcom,msm8996-tsens";
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index c981a40..abc8f13 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -69,8 +69,15 @@ static const struct tsens_ops ops_v2 = {
 	.get_temp	= get_temp_tsens_v2,
 };
 
+const struct tsens_data data_tsens_v2 = {
+	.ops            = &ops_v2,
+};
+
+/* Kept around for backward compatibility with old msm8996.dtsi.
+ * New platforms should use data_tsens_v2 if possible and define
+ * the #qcom,sensors property in DT.
+ */
 const struct tsens_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_v2,
 };
-
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3440166c..a2c9bfa 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -72,6 +72,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,tsens-v2",
+		.data = &data_tsens_v2,
 	},
 	{}
 };
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dc56e1e..69212cb 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -87,6 +87,9 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
 int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 
-extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
+/* TSENS v1 targets */
+extern const struct tsens_data data_8916, data_8974, data_8960;
+/* TSENS v2 targets */
+extern const struct tsens_data data_8996, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.7.4

