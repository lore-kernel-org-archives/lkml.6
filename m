Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC46C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392FE21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axHX+SI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBGKuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:50:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35338 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfBGKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:50:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id z18so10246171wrh.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zy0Ocp2xe2rob5f0FFseaWF46iQU7ldkZ5vVgEtDGww=;
        b=axHX+SI8VrHFD9eTNpJyqzKr/RCveBepo8QUYU1jO+KhECXGIKwjFLjwvuD3PAD5VN
         yfJ0TaSRiiGOt/Bl4Ftg39nXeCBchI7MWk9euMQ8tHXWvHJHDE0QcpjMYrLNll/FchoD
         frBWBQ0r3WcExc+3PvinKZ4d/Zv0OKBpZYaUAviBVBMpQl9gaLnl2w9sqiOkykXbZXUB
         /dLz9LICBZyCg6enI4MzGpS/nWHoxYnYrdgrgGF8Zt6I/jl1BYj77ZxKiw119nHCabnh
         kpO0TRbhh0wJSNk/Mx6T8FutpdLzqwVjbI1IMjJwBUFh4YBjSSgUs05iuUd1aVz5vWQE
         To1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zy0Ocp2xe2rob5f0FFseaWF46iQU7ldkZ5vVgEtDGww=;
        b=K+Y10q5gXVoItuMESRRJ5uDrcVTEtij1mLSlGw+BxyaP1iHM9jrxzfqsbkHUDQ2Tha
         lUyxhlGzqnyO3UbPnDrFa6w9lVY+N0utQwYPNVxs7dh/w9K9ERiSlGlHHOk+dMA5MnaG
         JHL6jiFrquO4IY+guETSK3YJUYS1sBXG2p4y+g4DNSotCFOl7w5XG1lDwrjOLJY+vj/0
         IeIYcLakenP5BghLaj0w2/pKX4e2Zl9cIsae/mkWUzkUWwmxhOYQujUDhLfR6xI4+CfH
         eDI2AHfVi0yYYfFe4FFhlul5zhio14SUhxuYgcXRgyBVNTQGnFZH8Dbc65Vwr+l4Wc1n
         +LSw==
X-Gm-Message-State: AHQUAuY0PVSHjjYB+EJ4fhsA/AOTIFj8wYrkBSIWKKoiJUYp23w0V2G9
        9S4gagIgix/XoFRxINBEf1fqGsZbQLQ=
X-Google-Smtp-Source: AHgI3IYRIDNhoDPIFZf5xVoDH/wCOQnSs5adQGFneGb1g2f9Uqb5zZ3Cp7GCkqC5MZXv28iXzy+pRg==
X-Received: by 2002:a5d:5101:: with SMTP id s1mr11704265wrt.89.1549536607260;
        Thu, 07 Feb 2019 02:50:07 -0800 (PST)
Received: from localhost ([49.248.196.115])
        by smtp.gmail.com with ESMTPSA id y145sm18945331wmd.30.2019.02.07.02.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:50:06 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 02/24] drivers: thermal: tsens: Rename tsens_data
Date:   Thu,  7 Feb 2019 16:19:20 +0530
Message-Id: <c85198235ef4eb5800a3239267441a31504bf487.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename to tsens_plat_data to denote that it is platform-data passed in
at compile-time.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8916.c | 2 +-
 drivers/thermal/qcom/tsens-8960.c | 2 +-
 drivers/thermal/qcom/tsens-8974.c | 2 +-
 drivers/thermal/qcom/tsens-v2.c   | 4 ++--
 drivers/thermal/qcom/tsens.c      | 2 +-
 drivers/thermal/qcom/tsens.h      | 8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
index c6dd620ac029..66edcfca1526 100644
--- a/drivers/thermal/qcom/tsens-8916.c
+++ b/drivers/thermal/qcom/tsens-8916.c
@@ -97,7 +97,7 @@ static const struct tsens_ops ops_8916 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_data data_8916 = {
+const struct tsens_plat_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 0f0adb302a7b..f3c3820e6e8e 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -277,7 +277,7 @@ static const struct tsens_ops ops_8960 = {
 	.resume		= resume_8960,
 };
 
-const struct tsens_data data_8960 = {
+const struct tsens_plat_data data_8960 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8960,
 };
diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
index 3d3fda3d731b..5023f20afc14 100644
--- a/drivers/thermal/qcom/tsens-8974.c
+++ b/drivers/thermal/qcom/tsens-8974.c
@@ -229,7 +229,7 @@ static const struct tsens_ops ops_8974 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_data data_8974 = {
+const struct tsens_plat_data data_8974 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8974,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 381a212872bf..cc98a61e093b 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -66,13 +66,13 @@ static const struct tsens_ops ops_generic_v2 = {
 	.get_temp	= get_temp_tsens_v2,
 };
 
-const struct tsens_data data_tsens_v2 = {
+const struct tsens_plat_data data_tsens_v2 = {
 	.ops            = &ops_generic_v2,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
 };
 
 /* Kept around for backward compatibility with old msm8996.dtsi */
-const struct tsens_data data_8996 = {
+const struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index f1ec9bbe4717..065ec2189bd3 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -102,7 +102,7 @@ static int tsens_probe(struct platform_device *pdev)
 	struct device *dev;
 	struct device_node *np;
 	struct tsens_device *tmdev;
-	const struct tsens_data *data;
+	const struct tsens_plat_data *data;
 	const struct of_device_id *id;
 	u32 num_sensors;
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 89318523c848..232376c690cc 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -65,13 +65,13 @@ enum reg_list {
 };
 
 /**
- * struct tsens_data - tsens platform data
+ * struct tsens_plat_data - tsens compile-time platform data
  * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
  * @reg_offsets: Register offsets for commonly used registers
  */
-struct tsens_data {
+struct tsens_plat_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
 	const u16		reg_offsets[REG_ARRAY_SIZE];
@@ -117,8 +117,8 @@ int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 
 /* TSENS v1 targets */
-extern const struct tsens_data data_8916, data_8974, data_8960;
+extern const struct tsens_plat_data data_8916, data_8974, data_8960;
 /* TSENS v2 targets */
-extern const struct tsens_data data_8996, data_tsens_v2;
+extern const struct tsens_plat_data data_8996, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.17.1

