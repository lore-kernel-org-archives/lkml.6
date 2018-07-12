Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA53C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EAA20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dt25UugJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EAA20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbeGLIsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:48:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38299 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbeGLIse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:48:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id m1-v6so8072998wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZzpPOX6HBv8psnc5B12jO2LM/pMBPBiDKEZDZJj29Fs=;
        b=Dt25UugJfUcDrC8jI0eto6dR1LNDIhQU3TA9bAiyOL9fLyHjtMTeJ0BTqMhcu2bQIa
         0xf1PldJugHUqSZElVHVrHEsSAQ5SrPrFmLl9zW9hXPpAb+f5e1nv9EMgHpRhyCuS8u7
         3RG7Lum2+YdkpqQ4rm9yhUCSqgvbN1GvkwKT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZzpPOX6HBv8psnc5B12jO2LM/pMBPBiDKEZDZJj29Fs=;
        b=C9U8SAJp3rh3/L/oMQccRh1sHEFqRFuGlhjrIFsWwlZBvQOZPiUu9SJ1RNGZ+gZHpl
         t6/fAYu2AAouiBRCRHlg1WobFCCBaxmGh+Fx1A7/o8j8qjjtP8P3UchKrevvt8R4oB9u
         bj+K86q7H0HvHlvIUMkg/Dv6Fc22M/7A+s0zr3TMVp+/D0g22vGXgFy/pjO4oM3z2UFn
         CDvRzVtgdUL1YMvqP7Vx3GcsuFpNY4bKS0t2GXCj6BmXHlMtf6l7h0ffiWfRCs0iy5gC
         V171bosQwtbdMU4WEoX2FPHcuMmCmrAVBGEpvP66o/KWeO1ejpj0YgxQV0x01lFRfJFe
         mhow==
X-Gm-Message-State: AOUpUlFNJwJhV2PTyoZqOVvr+tvV4AgWAkKzdt64Qe/NdF9eKM0TqK98
        ddvKLhyabOk9CDWxISVK1GzS6ovfsXA=
X-Google-Smtp-Source: AAOMgpeLbvqjs1FH4W86ThLSU1LnxUvBxFdqokeHQkWK0gOqquSQf6Ll8ofjlTE8QXFc0Ue1Sn6rMg==
X-Received: by 2002:adf:d142:: with SMTP id b2-v6mr961799wri.17.1531384798662;
        Thu, 12 Jul 2018 01:39:58 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id r194-v6sm4336410wmd.36.2018.07.12.01.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 01:39:57 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 3/7] arm64: dts: msm8996: thermal: Initialise via DT and add second controller
Date:   Thu, 12 Jul 2018 14:09:04 +0530
Message-Id: <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We also split up the regmap address space into two, for the TM and SROT
registers. This was required to deal with different address offsets for the
TM and SROT registers across different SoC families.

8996 has two TSENS IP blocks, initialise the second one too.

Since tsens-common.c/init_common() currently only registers one address
space, the order is important (TM before SROT). This is OK since the code
doesn't really use the SROT functionality yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8c7f9ca..688e752 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -459,9 +459,19 @@
 			status = "disabled";
 		};
 
-		tsens0: thermal-sensor@4a8000 {
+		tsens0: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8996-tsens";
-			reg = <0x4a8000 0x2000>;
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@4ad000 {
+			compatible = "qcom,msm8996-tsens";
+			reg = <0x4ad000 0x1000>, /* TM */
+			      <0x4ac000 0x1000>; /* SROT */
+			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.7.4

