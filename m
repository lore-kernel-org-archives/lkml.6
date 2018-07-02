Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD157C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971E825547
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1QRH4ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971E825547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeGBMpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:45:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43139 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeGBMo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:44:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so7910268plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2chRnc2W7u7nDJkgcN8SuxEHelsCQc93uFuFBC70dN0=;
        b=L1QRH4nedVyn8SXsrAlvztQC6tpo4mF/Qj+0PRkN6Y12blWvHG4IRuOurcx+N7fbDC
         cnDINuQbdoT8W9wGoRj5JWnqHOd3AgotDLfQ3RoosOlTbnXhmmE/P8gcOwSE+gbpoQSY
         /Jl6xiKBiZZy1/t4m0c0qNoo0Dbx6WpmfH51c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2chRnc2W7u7nDJkgcN8SuxEHelsCQc93uFuFBC70dN0=;
        b=pfxGG014DefJUsmExmAmdFVqZH6R46AiEYfbtDl+pLNIm7J/UcKr3CX43X8dqf5vwH
         DVw27tIkgUsngGPhbN99t8H3qI38rz9DsLag9P+ycJgFla7omozCpFAdor/tNqY+vXmK
         U5vz0ePl49p7hFM9EtHz9dsL/RCnVKhO1vt2zWllHHa4AvOP3TsgEAwmxzwQkTfvJlmE
         6LRHvMRoCBK6lIqkVRKik4dH0+c5rnEcNuS2Q6D5gWdX+onExAz/URK9w+XH+45pch8I
         6YgdhAQIJd6BN8PEr/48aMdalIilQMzVxfkhI83gzZegrcJ8juHTVaLbeViUzbLPY4fg
         iCKg==
X-Gm-Message-State: APt69E28vMJimqu+vFL+VlZsembPTZ5gd7tONnBtmdZ+AJSEDYSRb8Ud
        rTnm4GFitRPLT4hO+1DW28IB39Oyc3g=
X-Google-Smtp-Source: ADUXVKJrybn1Xc3HNujcy6LFFNXLqVV9MbbBshqcCiZbFafxcMrvIi+HrJtTYXyhnh0k9N0USW/8PA==
X-Received: by 2002:a17:902:8e87:: with SMTP id bg7-v6mr25600756plb.129.1530535495526;
        Mon, 02 Jul 2018 05:44:55 -0700 (PDT)
Received: from localhost ([49.248.63.129])
        by smtp.gmail.com with ESMTPSA id e10-v6sm20453604pgv.48.2018.07.02.05.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:44:54 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 4/6] thermal: tsens: Add support for SDM845
Date:   Mon,  2 Jul 2018 18:14:07 +0530
Message-Id: <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 uses v2.4.0 of the TSENS IP block but the get_temp() function
appears to be identical across v2.x.y in code seen so far. We use the
generic get_temp() function.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 2 ++
 drivers/thermal/qcom/tsens-v2.c                          | 6 +++++-
 drivers/thermal/qcom/tsens.c                             | 6 ++++++
 drivers/thermal/qcom/tsens.h                             | 5 ++++-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 06195e8..075182e 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -5,6 +5,8 @@ Required properties:
  - "qcom,msm8916-tsens" : For 8916 Family of SoCs
  - "qcom,msm8974-tsens" : For 8974 Family of SoCs
  - "qcom,msm8996-tsens" : For 8996 Family of SoCs
+ - "qcom,tsens-v2.4.0"  : For SDM845 Family of SoCs
+ - "qcom,tsens-v2"      : Generic fallback binding for any Soc using 2.x.y version of the tsens IP
 
 - reg: Address range of the thermal registers
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 2eca7ff..1871945 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -69,8 +69,12 @@ static const struct tsens_ops ops_generic_v2 = {
 	.get_temp	= get_temp_tsens_v2,
 };
 
+const struct tsens_data data_tsens_v2 = {
+	.ops            = &ops_generic_v2,
+};
+
+/* Kept around for backward compatibility with old msm8996.dtsi */
 const struct tsens_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
 };
-
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3440166c..992ed17 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -72,6 +72,12 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,tsens-v2.4.0",
+		.data = &data_tsens_v2,
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

