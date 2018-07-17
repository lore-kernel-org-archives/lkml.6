Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B71ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F7220693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F7220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbeGQVn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:43:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46519 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbeGQVn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:43:28 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so981397pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKgItULpWv/JusAWZlHp/HHgqWsf1L9Tz79AKNI73hM=;
        b=SUWrlvXZPDk8see1jBnqNWkK7bIpEL/Zl3ty5RbIy1JGnWgy1LO2TJ5QKVfom52fmk
         a1S0IxAmSjPULBv9AdEykG4YPbQxabW3tLxH8pGzVJJeEIuFA9pIiQBg/HQ4HbsLfAAT
         d54fp8hFPUgn2E52xW0sEOS4zQTIchV5Lu8S0QLw5x4IzsuOW119+us58+JEA1Od0A8/
         Zp5fklIiD0sDXPb7HU4RrWzKl+M4NaWb94zBxMCT3Jd2QKtywPcNYYgYURvdOpvB/7TW
         Eb0YBMp6u/AXjUB8k+D7bcBp6U2t9MfoKs9+oEPJGb+QcZwUI2iD1gjzRcznsMwW0ztC
         aNyw==
X-Gm-Message-State: AOUpUlE0t1hDv2jjHvJfGoaAKHjz7m8umygqkzN2I8pPfwAbkT2kklGb
        kGZeMIS7vy/8/e+Fu9/m2Ccf4g==
X-Google-Smtp-Source: AAOMgpf8ibqETWbw1taelIpS4ixt5mBMlaR81P1Ndj3kMrMboYDtEz8KtRtXjR8lfn53Aa/ZjUJV7g==
X-Received: by 2002:a17:902:28a6:: with SMTP id f35-v6mr3154150plb.110.1531861738851;
        Tue, 17 Jul 2018 14:08:58 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b23-v6sm5081924pfc.49.2018.07.17.14.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:08:57 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 3/3] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
Date:   Tue, 17 Jul 2018 14:08:15 -0700
Message-Id: <20180717210815.245639-3-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717210815.245639-1-mka@chromium.org>
References: <20180717210815.245639-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone uses spmi-temp-alarm as sensor. The trip points
correspond to stage 1 and 2 temperatures. Stage 2 shutdown is disabled,
instead the stage 2 temperature is configured as critical trip point to
allow for an ordely shutdown.

Without an IIO input the sensor only reports a limited number of
temperatures:

- 37°C for temperatures below 105°C
- 107°C for temperatures >= 105°C and < 125°C
- 127°C for temperatures >= 125°C

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v4:
- updated trip point temperatures to match stage 1 and 2 ones
- disabled stage 2 shutdown
- updated commit message

Changes in v3:
- moved 'thermal-zones' node to the beginning of the .dtsi

Changes in v2:
- defined 'thermal-zones' node in pm8998.dtsi instead of using a label
  to refer to it
- use 105°C hardware trip point as critical trip point
- reduced number of trip points to 2
- lowered temperature of passive trip point
- updated trip point names and added labels
- updated commit message
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 7eea94701b23..3bb179b85a44 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -3,6 +3,31 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	thermal-zones {
+		pm8998 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&pm8998_temp>;
+
+			trips {
+				pm8998_alert0: pm8998-alert0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pm8998_crit: pm8998-crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
 
 &spmi_bus {
 	pm8998_lsid0: pmic@0 {
@@ -15,6 +40,7 @@
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
 			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			stage2-shutdown-disabled;
 			#thermal-sensor-cells = <0>;
 		};
 
-- 
2.18.0.203.gfac676dfb9-goog

