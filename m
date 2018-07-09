Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97BAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C992086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmRT4KXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C992086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933040AbeGIL3C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:29:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33233 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932951AbeGIL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:28:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so1688317wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AsozHnJmlM1Of3480z5nTOd6XCOnsdEnjdMHZCjbbAY=;
        b=UmRT4KXC6dh9XyvOlXRgLe7EcBFV+ei1mOccSYOl5D0J59znmmgQXzX3Cz7mWo1WAO
         fH5so49O2taeeqgI+8np1vHDNCCrd2KNzSg/7lcQ7hT0CTQmNeh2bxAgrcZx7OHQDGtH
         h+v/l7GQOEUfyt3wWrgeWqFsgcrEwwiwf3EiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AsozHnJmlM1Of3480z5nTOd6XCOnsdEnjdMHZCjbbAY=;
        b=WBsUDTmmw4AN39FzRyiRDKet+puSGtaHiIDuKwZBoadPOz9BI1TDWihj5vCugUBovv
         UIHza4c1+xh+WBojNZlrpKYfm1I0nKnrU5yKf4pGXwV/99ahpZPzIjJFwmj6NYXp6lXy
         UXH9O515W6mJ0mQInppRfDGH+uvwDVDNKxWXnFK+r9REdqAT+WvBTNOkk5pIex35YK2r
         6AuKvMJ5by0ry5a7TjRPLVXQJol0mQM8EE6T/q5HCNJRXSzMB7Gta1h59rONZ2V6tbS4
         XA3Q2x2hhmgBRj6qZZmYBgArUikEH8FVxjP/jbeImSo3VjVGUnQ49yGKcF7UeEW8Vw6B
         +kbQ==
X-Gm-Message-State: APt69E2VcNAvnB/ogGVFJQibuEmcJHL0mNCco+grH/bt1D0QYupPhcKY
        UfU6qyO/fN2Z5djM7kL/pTabwCMBpZA=
X-Google-Smtp-Source: AAOMgpfZHUwKhxx9XMV1r7z1yGCC80radvi0mQfkkPhPcrHvL01PEy6Z4qicakqDYdkcxUNsd5KxKw==
X-Received: by 2002:adf:a14a:: with SMTP id r10-v6mr13982869wrr.104.1531135737108;
        Mon, 09 Jul 2018 04:28:57 -0700 (PDT)
Received: from localhost ([49.248.189.240])
        by smtp.gmail.com with ESMTPSA id q200-v6sm7081768wmg.8.2018.07.09.04.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:28:56 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 6/7] dt: thermal: tsens: Document the fallback DT property for v2 of TSENS IP
Date:   Mon,  9 Jul 2018 16:57:39 +0530
Message-Id: <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531133612.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to create common code for v2 of the TSENS IP block that is used in
a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
most of the common functionality start with a common get_temp() function.

It is also necessary to split out the memory regions for the TM and SROT
register banks because their offsets are not constant across SoC families.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.txt     | 25 +++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 06195e8..8f963b1 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -1,10 +1,16 @@
 * QCOM SoC Temperature Sensor (TSENS)
 
 Required properties:
-- compatible :
- - "qcom,msm8916-tsens" : For 8916 Family of SoCs
- - "qcom,msm8974-tsens" : For 8974 Family of SoCs
- - "qcom,msm8996-tsens" : For 8996 Family of SoCs
+- compatible:
+  Must be one of the following:
+    - "qcom,msm8916-tsens" (MSM8916)
+    - "qcom,msm8974-tsens" (MSM8974)
+    - "qcom,msm8996-tsens" (MSM8996)
+    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
+    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
+  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC with
+  version 2 of the TSENS IP. MSM8996 is the only exception beacause the generic
+  property did not exist when support was added.
 
 - reg: Address range of the thermal registers
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
@@ -12,7 +18,7 @@ Required properties:
 - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
 nvmem cells
 
-Example:
+Example 1 (legacy support before a fallback tsens-v2 propoerty was introduced):
 tsens: thermal-sensor@900000 {
 		compatible = "qcom,msm8916-tsens";
 		reg = <0x4a8000 0x2000>;
@@ -20,3 +26,12 @@ tsens: thermal-sensor@900000 {
 		nvmem-cell-names = "caldata", "calsel";
 		#thermal-sensor-cells = <1>;
 	};
+
+Example 2 (for any platform containing v2 of the TSENS IP):
+tsens0: tsens@c222000 {
+		compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+		reg = <0xc263000 0x1ff>, /* TM */
+			<0xc222000 0x1ff>; /* SROT */
+		#qcom,sensors = <13>;
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.7.4

