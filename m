Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7802ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A3920850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQ1zB8U6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A3920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeGRHUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:20:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36965 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbeGRHUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:20:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id a19-v6so1604851wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=oUO1jTYttP/QLbWHGOr2MUnHUZOUMjTQ0O4rLImfJII=;
        b=YQ1zB8U6wZg3c8D198e2AHWegXFdKLfD26VsNN19w2TRMNlzoNglwKxp48ZG8r9H1k
         Qy+mD4vuIEf2hEkJpvCUBCd8lCRC1FRKhA8OLmaLk8hdjXQAns56q0cItd/DN/oik5Z7
         Kb8a8/3R8fHP0ggd+pHRAK/nQa28FKsQ30TXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oUO1jTYttP/QLbWHGOr2MUnHUZOUMjTQ0O4rLImfJII=;
        b=l37RgJ850l4yC/szflZrPuQFgDgNqlLsN11DShWXL70MFs186nTnHqgotwmMH78aKE
         /3HDD3yFzHDCMClnAXjlE9lPWvJE+aqjKc/SGM1Xwi42WA4h2NJNhnheFeEOtPKcAF1b
         SzO9aiqx6YEe/+6CLaVAUta27KT9ceOl5X6/M8ozdRc4RSu5SixRkjKjLcLczRBqlQnM
         PNW5+pMuP5luMTq9hxs64RLePV+aBZp8JzWfxDYnX1kZl8xyEU8c+b4YsDaPyeWnwoEI
         zAvdTCTGulcBZbXS/lBRK5cF/+qa+sY1uZQflRG8f8f4DwG+SOxcmDeY1eMiEqxUT1cC
         E4fw==
X-Gm-Message-State: AOUpUlFU5jAvrZS8FD+lbX47DAYp//LEJ2m7U3OCk1XfoLcJX2NobKwy
        d3w13+3h+cc7FgvymrQxjKWehD3UQBg=
X-Google-Smtp-Source: AAOMgpflDB1OKMOVa1pGl3wojpBItzjygrfP6MVo/pr+DFsGYxqQR2ZbWrNjH7sSc3WVsBmFKbl53A==
X-Received: by 2002:a1c:2396:: with SMTP id j144-v6mr725114wmj.26.1531896245241;
        Tue, 17 Jul 2018 23:44:05 -0700 (PDT)
Received: from localhost ([103.249.91.115])
        by smtp.gmail.com with ESMTPSA id 35-v6sm2161913wrh.52.2018.07.17.23.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 23:44:04 -0700 (PDT)
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
Subject: [PATCH v8 4/7] arm64: dts: msm8996: thermal: Initialise via DT and add second controller
Date:   Wed, 18 Jul 2018 12:13:10 +0530
Message-Id: <540bcdb06d3e032de903748545076327ebc04026.1531895128.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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

