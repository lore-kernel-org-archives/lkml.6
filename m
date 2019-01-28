Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC95C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0CE2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFVq7lgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfA1LpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:45:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41861 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfA1LpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:45:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so17644328wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 03:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OjZqKa0JsCFXQBMWFlziSlyjddwilKU0eYG9FICLYwE=;
        b=YFVq7lgrxQxLmfi0tFZf4vrtQu0raMENfQHUf6OEDCObXMd0SuBHmmmzrgArPBA4PW
         7rEmobnXsKn1wXlQxz+YoopbgkpQ9cZOUbTKUbXIoY2tNLUUQ/1Ef/tHQBLQP52Y50RQ
         +xTkCvBIUMW7fE1Lfs76af7Iy3Hkm+bsPe6vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OjZqKa0JsCFXQBMWFlziSlyjddwilKU0eYG9FICLYwE=;
        b=EfFc4THwRR2HrPUU5aDtK0QMKTMGPTiiNL/wswEQEAMAlB3loMP4lt1a9seNzWJk62
         Dcsnh/osf//uvMkeier543gzqz5xp73DAKcw+VbTImMG9Im7eIkOPzwdsJ6DTshKD5D1
         B//IXPztagJbLAMkZQZhg/j8WfQkZbxkvhgvtjyxidRxQZ93A9+7n+DpkJa3ZtnPsZXo
         kaAbdO3W8+e2ZwbJjF/8p8I7pTl9bTbkJGta4hXKrbYMfGF3BDYTR10IPpQryswcZGeY
         DpBLOhSWhG4cSsMGT/WtZDrJWb7FTtTdJE/fzCnLLUv4Mjx9vsvUX2eMBq9pnmJW8+28
         mrHw==
X-Gm-Message-State: AJcUukc+Uf49Et7sreg/DcLEjB2Bp/KtVDAwwtRWwfhVMGVgBxoFRK0Q
        G/urNVJgkCSb/dwvwMnTbpKJxQ==
X-Google-Smtp-Source: ALg8bN7xFthXe1kgQ/y/bEMicB/fxWPJWQm8Vb750rYFL0VZ2qCIbSZ4KPcPnP8YDkd7DWGv2nnh3Q==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr21057133wrr.201.1548675914895;
        Mon, 28 Jan 2019 03:45:14 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id z9sm122968775wrs.63.2019.01.28.03.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 03:45:14 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: qcom_spmi: Document pms405 support
Date:   Mon, 28 Jan 2019 12:45:02 +0100
Message-Id: <1548675904-18324-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMS405 supports 5 SMPS and 13 LDO regulators.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../bindings/regulator/qcom,spmi-regulator.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
index 406f2e5..8ee7aac 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
@@ -9,6 +9,7 @@ Qualcomm SPMI Regulators
 			"qcom,pm8941-regulators"
 			"qcom,pm8994-regulators"
 			"qcom,pmi8994-regulators"
+			"qcom,pms405-regulators"
 
 - interrupts:
 	Usage: optional
@@ -110,6 +111,29 @@ Qualcomm SPMI Regulators
 	Definition: Reference to regulator supplying the input pin, as
 		    described in the data sheet.
 
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_s4-supply:
+- vdd_s5-supply:
+- vdd_l1-supply:
+- vdd_l2-supply:
+- vdd_l3-supply:
+- vdd_l4-supply:
+- vdd_l5-supply:
+- vdd_l6-supply:
+- vdd_l7-supply:
+- vdd_l8-supply:
+- vdd_l9-supply:
+- vdd_l10-supply:
+- vdd_l11-supply:
+- vdd_l12-supply:
+- vdd_l13-supply:
+	Usage: optional (pms405 only)
+	Value type: <phandle>
+	Definition: Reference to regulator supplying the input pin, as
+		    described in the data sheet.
+
 - qcom,saw-reg:
 	Usage: optional
 	Value type: <phandle>
-- 
2.7.4

