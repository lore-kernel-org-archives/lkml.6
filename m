Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA2CC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1132820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1132820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeGYA4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:56:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44984 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeGYA4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:56:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so3953834pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 16:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tC1F0WSPmy1nQ+5vpiUHI5ckgmbtENgVHo/RRNbZpME=;
        b=JBXs3tAf5yGMEJxh2EFZjYc3TCNpx+xmd5RZdA9r32RQ067K7g9byd8NlMWIK3Gbmp
         tAVmxwnbeS1SdJD4klZdJJNojfuJUUXdwPLOCJMVs4UD6dDRU+2RzSR2ffOEho9Ps1Ja
         ozkIr2XO1ySl3fwPpyEJzbR/LZzeYfxcaFLIEe2djaFeN7i/ckVFZ5Y7ZzgNQXxWYuQ0
         SyOkm+jYVlfKpZAzGhqb0Zkgcl30zDoXvCAOORLkSgnxK3n2wER1Ph2PK3tXb08a//Xj
         MuEoY/fuMizXPch8swAeEA+2hcPWRnKxKC8Un4lafCUn3tOXmRDMK6v3NgjKUFzIp7g2
         Jcuw==
X-Gm-Message-State: AOUpUlEd6owXTaV4r0sk6/MfrOZVbixCz+z/SpMeKGFonxQe4BUBKHim
        rPKglQEAzFJW6SmOt7JhIQq6DQ==
X-Google-Smtp-Source: AAOMgpfK5bik85dK5TdJ1rOkZx4FT7/VIEGZP897IYlkibvP4ZlvUo4GHa2zH/+8wbs0SDyLynS7zg==
X-Received: by 2002:a63:dd09:: with SMTP id t9-v6mr18427399pgg.370.1532476027316;
        Tue, 24 Jul 2018 16:47:07 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 12-v6sm17267970pfx.128.2018.07.24.16.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 16:47:06 -0700 (PDT)
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
Subject: [PATCH v5 3/3] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
Date:   Tue, 24 Jul 2018 16:46:36 -0700
Message-Id: <20180724234636.57137-3-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
References: <20180724234636.57137-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone uses spmi-temp-alarm as sensor, the trip points
correspond to the PMIC thermal stages 1 and 2. The critical trip
point at 125°C disables the partial PMIC shutdown at stage 2.

Without an IIO input the sensor only reports a limited number of
temperatures:

- 37°C for temperatures below 105°C
- 107°C for temperatures >= 105°C and < 125°C
- 127°C for temperatures >= 125°C

(the numbers correspond to a stage 1 threshold of 105°C)

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v5:
- removed 'stage2-shutdown-disabled' property from spmi-temp-alarm
- updated commit message

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
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 7eea94701b23..34c259ba3919 100644
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
-- 
2.18.0.233.g985f88cf7e-goog

