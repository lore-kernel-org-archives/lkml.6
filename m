Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F54DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073C4216F6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A9bUS5oL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073C4216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeGBMot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:44:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44958 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbeGBMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:44:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so7911126pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LboO0m9tdUv5OClL5JGmFqiWh7zVC6d1MgWg2XNw1k8=;
        b=A9bUS5oLTtxNgUSE6dn+mKeLHV9rp/OQZhO+/XOqgzQICw7pdUHDfaiKUx8KkXQIqR
         HnC8+FMkpHVulcwHTj7FZTih/GT1Ln1yLdMFAHZ/dBVyNqHOxe8FTNn7Lk3y/OABjA/4
         Jf8HcYhZFHdWaqxFQPy3qOdRq+MPzWLhNgO9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LboO0m9tdUv5OClL5JGmFqiWh7zVC6d1MgWg2XNw1k8=;
        b=Wo9RBBCla5yVGvJZm0ZRZeVTSXIqEwMpwkg5M6iMnhvF96qwLTjhDuY1NchCQVqOlj
         COc7OWX+OhEVSCbSfMlOtt7PUthUqK+ZNvZCSHhsKTZjQFraukIGTt2m8A6lVCum6gIX
         eYt11MUqDhl9G//yB2LLJaqqM6Er398ie3V5cUoW6FbIJ/AHuYKPZ8WusH7VqrRJ6XxM
         OHPFlQG6W71qj/gDoe+eh20fLGh4V8NIhdLnnumwnKuq76z46oDAW3BSomFU/PSAL7rs
         r3XkeYi6xa6HxlD9m9+B8XxtWxgjkKGPdJUUEN6/rSd4YmcMeieaEu0anH2NIpV1pN+p
         GBgg==
X-Gm-Message-State: APt69E19cx4dmlJEVaIZqJlYfaNbjm104duWhdS8I6dI8MVTfT+5EUty
        yXiRnHGRNGxgLW8WGxA/p7XeBFyp6b8=
X-Google-Smtp-Source: ADUXVKKzXCqoqkQIW+zEhG8iyt6Qw3FfuYEKQvCmO7pihGqN9CLtnGVMb6pNxYANo9Xh7Sm2SuSujw==
X-Received: by 2002:a17:902:1023:: with SMTP id b32-v6mr26243957pla.145.1530535477316;
        Mon, 02 Jul 2018 05:44:37 -0700 (PDT)
Received: from localhost ([49.248.63.129])
        by smtp.gmail.com with ESMTPSA id n18-v6sm8913718pge.37.2018.07.02.05.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:44:36 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/6] dt: qcom: 8996: thermal: Move to DT initialisation
Date:   Mon,  2 Jul 2018 18:14:05 +0530
Message-Id: <80e54ddfa672ae05db24a90c5f5463fc7fcbec46.1530533998.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We also split up the regmap address space into two, one for the TM
registers, the other for the SROT registers. This was required to deal with
different address offsets for the TM and SROT registers across different
SoC families.

Since tsens-common.c/init_common() currently only registers one address
space, the order is important (TM before SROT). This is OK since the code
doesn't really use the SROT functionality yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8c7f9ca..6c8a857 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -461,7 +461,17 @@
 
 		tsens0: thermal-sensor@4a8000 {
 			compatible = "qcom,msm8996-tsens";
-			reg = <0x4a8000 0x2000>;
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@4ac000 {
+			compatible = "qcom,msm8996-tsens";
+			reg = <0x4ad000 0x1000>, /* TM */
+			      <0x4ac000 0x1000>; /* SROT */
+			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.7.4

