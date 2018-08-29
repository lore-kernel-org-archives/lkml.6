Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55759C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D26D20658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7MBNBGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D26D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeH3DMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:12:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34386 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeH3DMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:12:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so2968662plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 16:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QGum6WMbhgDLWXu15YSCCf+nSJoU4qkhFTooN6vMglo=;
        b=c7MBNBGwa6umbaSWHub1O1fxqMTJPyrQ0uNb5l5gAFRp5ngwxVu3xOlr7yabrn/Tng
         MSTXZ0kSLvPNmMa/eS2tP5jlyAH7Q1F7QSsogBwKEFA+WPJJ0Hyhj7FTnPswCww7LYRk
         xuHqCHehWTJ95BGdqUId4PXarqS8rIZqzgPx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QGum6WMbhgDLWXu15YSCCf+nSJoU4qkhFTooN6vMglo=;
        b=J+4RFq7uE2sFWAk4z68BQcIqstTI6EOeegUxZJjlCp1S3534n1ywrPCvn4m6Yu5iUe
         cEB+98+C+nBk3DelY3Cdecf+uN4wZq1plOg1HD/oMMLF9WkV4qMaLhIcLaR8X4P8xc0N
         WOORZeqxZIDHud2hzoN5fw6SDq/nMNbcHfDkOmcHdNlgmog1lLwu9vUlGwA+zVd74gp/
         CniIDdmBaR8iA0u75JnmEzMYPJqQS8fq4XvfnCkgwTYFyinb0039MLip2uDbnvFw12kM
         OSOmTNBqv5RUvCWSC0qrmVL9GfC3zkwgnOHUongy5UsLu7GU/y6ndbTF1csVZFpSdWJT
         d3pQ==
X-Gm-Message-State: APzg51Am65NR9lK8iTVltbIXCzmPonxJQiyolexdl9CLBRwd6tpxFPnu
        XARsQXgA5rQpR/KGpLptWHqOvA==
X-Google-Smtp-Source: ANB0VdasMUdmb2dpuTdpemY5b1N1BE1T6g1DhnGYP0fJ/H4dx/XYrZbU86aDx63oJfcjddIswoVHzQ==
X-Received: by 2002:a17:902:22e:: with SMTP id 43-v6mr7821339plc.118.1535584407314;
        Wed, 29 Aug 2018 16:13:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w69-v6sm14035404pgd.37.2018.08.29.16.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 16:13:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Craig Tatlor <ctatlor97@gmail.com>
Subject: [PATCH 1/3] dt-bindings: firmware: scm: Refactor compatibles and clocks
Date:   Wed, 29 Aug 2018 16:15:03 -0700
Message-Id: <20180829231505.22660-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829231505.22660-1-bjorn.andersson@linaro.org>
References: <20180829231505.22660-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the binding was written all "future" platforms required three
clocks, so the default compatible (qcom,scm) was defined to require
this. But as history shows all "future" platforms actually lack required
clocks. Given how the binding is written these compatibles have to be
added as an exception to the default.

Refactor the description of compatible to define that a platform
compatible should be given, followed by the fallback of qcom,scm. Also
refactor the description of the clocks in a way that this does not need
to be updated as new platform specific compatibles are added.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/firmware/qcom,scm.txt | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index fcf6979c0b6d..1c8e24530f7c 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -7,16 +7,21 @@ assorted actions.
 
 Required properties:
 - compatible: must contain one of the following:
- * "qcom,scm-apq8064" for APQ8064 platforms
- * "qcom,scm-msm8660" for MSM8660 platforms
- * "qcom,scm-msm8690" for MSM8690 platforms
- * "qcom,scm-msm8996" for MSM8996 platforms
- * "qcom,scm-ipq4019" for IPQ4019 platforms
- * "qcom,scm" for later processors (MSM8916, APQ8084, MSM8974, etc)
-- clocks: One to three clocks may be required based on compatible.
- * No clock required for "qcom,scm-msm8996", "qcom,scm-ipq4019"
- * Only core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660", and "qcom,scm-msm8960"
- * Core, iface, and bus clocks required for "qcom,scm"
+ * "qcom,scm-apq8064"
+ * "qcom,scm-apq8084"
+ * "qcom,scm-msm8660"
+ * "qcom,scm-msm8916"
+ * "qcom,scm-msm8960"
+ * "qcom,scm-msm8974"
+ * "qcom,scm-msm8996"
+ * "qcom,scm-ipq4019"
+ and:
+ * "qcom,scm"
+- clocks: Specifies clocks needed by the SCM interface, if any:
+ * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
+   "qcom,scm-msm8960"
+ * core, iface and bus clocks required for "qcom,scm-apq8084",
+   "qcom,scm-msm8916" and "qcom,scm-msm8974"
 - clock-names: Must contain "core" for the core clock, "iface" for the interface
   clock and "bus" for the bus clock per the requirements of the compatible.
 - qcom,dload-mode: phandle to the TCSR hardware block and offset of the
@@ -26,8 +31,10 @@ Example for MSM8916:
 
 	firmware {
 		scm {
-			compatible = "qcom,scm";
-			clocks = <&gcc GCC_CRYPTO_CLK> , <&gcc GCC_CRYPTO_AXI_CLK>, <&gcc GCC_CRYPTO_AHB_CLK>;
+			compatible = "qcom,msm8916", "qcom,scm";
+			clocks = <&gcc GCC_CRYPTO_CLK> ,
+				 <&gcc GCC_CRYPTO_AXI_CLK>,
+				 <&gcc GCC_CRYPTO_AHB_CLK>;
 			clock-names = "core", "bus", "iface";
 		};
 	};
-- 
2.18.0

