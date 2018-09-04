Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C559AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EB520843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4WSqiWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EB520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeIDJ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:29:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34981 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeIDJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:29:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2-v6so77500plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 22:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=r5V00MrubVDBWJAixs5Od0W/Pv1V1sSqZapFo7Tegf0=;
        b=A4WSqiWutBjN5EG6jIHJbT+rsfQWjT6I0JV55stq/oDsEPUaS3A7zai1D1z7K19Tfs
         5auXCayzdc7Bb8jmooBag3hKQ9m0+9rLzRzNCFXyb3nDLP769xk2FGAMHh2WzumhL1wH
         z1f953o93ZB7oeBBRbAuttMKDV931PGbrZhdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r5V00MrubVDBWJAixs5Od0W/Pv1V1sSqZapFo7Tegf0=;
        b=R9gkyaeviOCkjwqChbANKqglrCvrgpUFx0c4dT+LWO8f+SdwQ/Uc1UvJMdImam6G+I
         /1wouJjAYjZccLeOw+Nysu8+Oz5QDoV3NB2gzzjpGOatR/D3Rfh5lpfQ5DqNo1t8OpQX
         0KR0vQPrBXpWbnGBpcFw4YQkhdpRNNtIc7dtxgXgU2/wFT12gKTlrb/Iuv30wBu6O69D
         x24YbiGa8UKYjYHy+kQB+bF0jnltd0ZlCiKgpkLwtrZX9AkoH5oZREfBeHzjcchnOyeW
         qEJnzQqWu2WaQwhKOTrhqFYOH4NhnZKhiPrszldPL36mYPjbdc5/fFfSCC3eP3odCagy
         2CGA==
X-Gm-Message-State: APzg51BqZDXE35xXFQfuG8FTw1PKnPz5GWgF5FAuMKmsf+51jSok6I7r
        ENgMN/sbzlhTmOXFOnZO1g62eQ==
X-Google-Smtp-Source: ANB0Vdb4lMQuERG1YGJUPHPP92wbNvdC9Uypyg1QPNznmatdHWq4aW0ha0gG19rPHnfnolzcNlEACg==
X-Received: by 2002:a17:902:9302:: with SMTP id bc2-v6mr32384799plb.280.1536037540858;
        Mon, 03 Sep 2018 22:05:40 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w69-v6sm34119899pgd.37.2018.09.03.22.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 22:05:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Populate pm8998 with some nodes
Date:   Mon,  3 Sep 2018 22:07:29 -0700
Message-Id: <20180904050729.26738-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pon, coincell and rtc to the first pm8998 sid.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..c96d6d018137 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 &spmi_bus {
 	pm8998_lsid0: pmic@0 {
@@ -11,6 +12,36 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_pon: pon@800 {
+			compatible = "qcom,pm8916-pon";
+
+			reg = <0x800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+		};
+
+		pm8998_coincell: coincell@2800 {
+			compatible = "qcom,pm8941-coincell";
+			reg = <0x2800>;
+
+			status = "disabled";
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pm8998_gpio: gpios@c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.18.0

