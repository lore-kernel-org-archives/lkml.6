Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2515C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AA420883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScWUq/gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AA420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbeGLItE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:49:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35703 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeGLItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:49:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id v3-v6so5141688wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vbAo4YPMYQgk6zgSFWvnv30sIR33ZaQ7TfJtCgG/Otw=;
        b=ScWUq/gloUeYlWyNN6xomryUM3I6GoUtc6E5mtv6tj6cP1pax2GRMfy71Za/UyRL/J
         oaDyoDRAPfEMtuLaa+CbGp/rPFk6xO9wZ6TNo5RjCKj/RO4lawt1DN1O8HvaoGAaRG1q
         yMR/dpzOF4wOVzJOtcxwzojyYnjblyGyziX0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vbAo4YPMYQgk6zgSFWvnv30sIR33ZaQ7TfJtCgG/Otw=;
        b=f0Fffhq5vVHVlAiwo0W/CQm3XpTXdWuZDBj92A50TAy0PkxQt/Cpvzv2/1VmfOFmfq
         kfvxgMqINiMzIdHeswLME+MikBRw+bicQCiElIokN6Cav/wl36sWBsBGa75Cf13a4eCL
         kKEI/NEkqsYG5W1gChkqFQN2nZgEp6iJkewrNbv8URYr4ZWyj3H8PSrsPF8jkRM5UJhm
         rrzo/iunP92XMB7T+5Qz4UY8cR/8R479oMuS4GGOS8LVWT42+O82JMu7V36bVtZxqqzd
         K8G1TjwV0rXRQS9bvf8zflf8LrEAafMal2dyf0kMLELi8jjfH9A5lVj8gvkjydggDdYi
         ePVA==
X-Gm-Message-State: AOUpUlFMDfALfUI8KHO//F30ZxnRI4f0/w+hyl7qjQUOs2lqPAaRIZA8
        AnBujvhX7QvLe7MaPyRBpcOIDUeCVSA=
X-Google-Smtp-Source: AAOMgpdR3ARENGWUdkWDVhsUJws5tCs2qgSJMsQhOhyKI30hRH23c1wb0KeVfwzSPG+Oab26f6nvaQ==
X-Received: by 2002:a1c:ac84:: with SMTP id v126-v6mr709276wme.32.1531384826945;
        Thu, 12 Jul 2018 01:40:26 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id u4-v6sm21762797wro.12.2018.07.12.01.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 01:40:26 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org
Subject: [PATCH v7 6/7] thermal: tsens: Add generic support for TSENS v2 IP
Date:   Thu, 12 Jul 2018 14:09:07 +0530
Message-Id: <34de426540a878bf77a77dd2c42a16678d6545a7.1531384019.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
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

