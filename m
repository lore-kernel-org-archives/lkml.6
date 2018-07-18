Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F603ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53DE205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6dmlguk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53DE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeGRHUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:20:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33787 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbeGRHUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:20:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so1560362pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=v7ifTUzkyvVtGx5wt0pGx0Zah3Qa2i6PSQqCHrSBSkU=;
        b=T6dmlguk24aBlZ6ctNglJS2Gx1gJKrcspfIbnkRUlXpf8SpxJ8Pet6vtzeqgDk236u
         FNKKjFonXyOUrsOV/UClu7WRvnvjsIYoWuE2oN+g+DVoUxeBzCZbPqBnSrzRr0rDCAUC
         aFEKf5fwFV4B3CPie6AUKSiCFEJkjpbEN/bQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=v7ifTUzkyvVtGx5wt0pGx0Zah3Qa2i6PSQqCHrSBSkU=;
        b=tvil6M/ZlZJ3lvYS4q0XBRfV3SxErCIDmSWeYlSETdudS8zqL6A0S0eh/0L9y8qWFH
         4Q81rbbK/CeEVBmRA/vUIJi+5eHa8dHF4lSpNkfR7+VgX7iAKlYYOlWecanIWXb6IBU0
         8pW8yr41MSinO0yeJ/D1c+bbnbPqcrrxTonp5+hzeGHn7CyV7O6BBSYZi6poqfQOFihR
         2eE9fKa1ZvqDM70KweuUl3OO5yxY+XwR0i1/v3Gg/AcEqx4UKxMJjTvtKKAOnzI2czVh
         h6Tq1XiPjzET3TKZaz17kn0L/XKQIIYNiRIEkdUsRFR/Q+s2HiLvIwYLXSjzzfByxMw/
         Xa3A==
X-Gm-Message-State: AOUpUlH/ypWMsZnX3uZjvUZrqRYIwTggRMzpXMW2zh6sFOlY78uyiitX
        wscTxxXDtMleX3FR7FskRIE36WnUuTo=
X-Google-Smtp-Source: AAOMgpdEmZhc8Fx4bxJ8+GrSeC8PHCaAmvGPUInDNkXpYYZUnupJPBVxeVQiqhTbcWyZ5Y6syKo6Wg==
X-Received: by 2002:a62:4a41:: with SMTP id x62-v6mr3951433pfa.45.1531896265134;
        Tue, 17 Jul 2018 23:44:25 -0700 (PDT)
Received: from localhost ([103.249.91.115])
        by smtp.gmail.com with ESMTPSA id z8-v6sm4054244pfe.163.2018.07.17.23.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 23:44:24 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org
Subject: [PATCH v8 6/7] thermal: tsens: Add generic support for TSENS v2 IP
Date:   Wed, 18 Jul 2018 12:13:12 +0530
Message-Id: <d528d52da925462561a061da5bf8a337dffa5157.1531895128.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 uses v2 of the TSENS IP block but the get_temp() function appears to
be identical across v2.x.y in code seen so far. We use the generic
get_temp() function defined as part of ops_generic_v2.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/thermal/qcom/tsens-v2.c | 5 +++++
 drivers/thermal/qcom/tsens.c    | 3 +++
 drivers/thermal/qcom/tsens.h    | 5 ++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 44d3736..f40150f 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -69,6 +69,11 @@ static const struct tsens_ops ops_generic_v2 = {
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
index d785b37..14331eb 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -88,6 +88,9 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
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

