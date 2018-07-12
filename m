Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91503C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B0320883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGYTKa3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B0320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbeGLItK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:49:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39325 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732546AbeGLItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:49:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so5081982wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gaOY9NRaeiUkrGltnYCPQSkt3TOSQxN5osLFYQfxr7M=;
        b=TGYTKa3Aoi2HhgmODW8Qq1+XRJjUTd0lpRR0I1O0YajhSECFoKaYA6kSrbupgKTbZC
         +3rDlvWL1X8iWwsi3pin+BEQHW0XF6ftghqLHvsPJlYNEMeNmj4OQJVlEAKWKFRgbXF6
         DeicoWZ1irBQH06MhWNV7a+H1Y7tjvmWXZrKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gaOY9NRaeiUkrGltnYCPQSkt3TOSQxN5osLFYQfxr7M=;
        b=WDKiqVf1oYtLR5mba6Ter/s5WjhDQSPz3c7N0vnacQnrBDDelA5Ogrn+NnHQbzvcil
         auyK/AjUtfudjFrURc1bloGYCMeYnFB0cc425ahmrB+SBhLHqYrj14jlLG1ImhggxjtU
         dkMcdePwuoetIh3Zwe58BmiGVOnUTNNxpOTti4O6R9BrvUW9bIpRhJjGF3Trm9FWheNk
         /UYQVKc8j64h+NqRsuvLXaGzR3xZ6+2f+j0jJl7ZWFc4OE5KFIJXtqnQu6Q6U1+/9kNT
         L2EvD2p/A1HpNpRIRcmCJXFjYp5qCz0R0bGrI4Al6Omw8OoptyE/ksoLq/R3hjY+B0Hk
         jCdA==
X-Gm-Message-State: AOUpUlGs5zLMTvsxjgsGE5JdV6vGN+1+ze/seMLKASgsg7RO6U4Z1Dj2
        PECxu8KXADJB8RVltCIEV9OB5wcUdBQ=
X-Google-Smtp-Source: AAOMgpcwgVC2JcKu1KPIYKG6V4Ik1hPcTU2l3UrjvqqvSObhcX0OvD7CwRbpquEeM77BhfGUkg442w==
X-Received: by 2002:a1c:cc08:: with SMTP id h8-v6mr698144wmb.82.1531384832987;
        Thu, 12 Jul 2018 01:40:32 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id n8-v6sm20484249wrn.69.2018.07.12.01.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 01:40:32 -0700 (PDT)
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
Subject: [PATCH v7 7/7] arm64: dts: sdm845: Add tsens nodes
Date:   Thu, 12 Jul 2018 14:09:08 +0530
Message-Id: <0dfdbfa82edced85ea5be02e1d74d73d232c7a08.1531384019.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 has two tsens blocks, one with 13 sensors and the other with 8
sensors. It uses version 2 of the TSENS IP, so use the fallback property to
allow more common code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb..01ff146 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -221,6 +221,22 @@
 			#interrupt-cells = <2>;
 		};
 
+		tsens0: thermal-sensor@c263000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc263000 0x1ff>, /* TM */
+			      <0xc222000 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@c265000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc265000 0x1ff>, /* TM */
+			      <0xc223000 0x1ff>; /* SROT */
+			#qcom,sensors = <8>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.7.4

