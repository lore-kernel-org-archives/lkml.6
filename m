Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC70C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C82208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C82208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbeGaU2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:28:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36469 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbeGaU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:28:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so1351827pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gF9UpcqWCQAPpTAYxBGWl2YKXDfCJhhLRmXour3w3OY=;
        b=jocaEbUGAGZxO/NjBAO+zf8eHY0NlMjfMWapgkbpxmf0SzKVwc40KWasvPjTj9GwTc
         WDz6nQkqqbinjeCjqxCigYuqCX19TM1J0XpUGN3IrCimdEfCVls+FhkzR3vDuEOnnYhp
         SrG/7HnRlBB+su0bELOoBa9bc77CrBzqwVGgpZAUFPd1fEbE4cmTgii2hUAuBQ411F65
         6tn79AnYrOPBRfcE6OAJTclJHy/IKDd+vI9lhJE/L07vXLTemWgs/wODykUjFfxR3Dim
         sSYEW0aiU1LHWmy2wwlCnNRWKvHVkfIxj22ITlSyTDQFhoMUbheZNBsXdk3FoK9qjcFV
         57UA==
X-Gm-Message-State: AOUpUlEiBKBBlj9Gj9qZIGmpfy9D0YyfgbXoeD+OQ2FUGhd4lM6gxf8J
        wWTeeEFAceAyyHpM2hGEKHJL6A==
X-Google-Smtp-Source: AAOMgpfnJeNT74Ik84Xtmb362AyNCkl7juPvgdh0EJ4/1hXnpWyobA6yAC9Fn0M/R51x5f5j3ct9+A==
X-Received: by 2002:a63:e247:: with SMTP id y7-v6mr21619785pgj.231.1533062783269;
        Tue, 31 Jul 2018 11:46:23 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b21-v6sm4981683pgw.79.2018.07.31.11.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:46:22 -0700 (PDT)
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
Subject: [PATCH v6 5/5] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
Date:   Tue, 31 Jul 2018 11:45:56 -0700
Message-Id: <20180731184556.169290-5-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731184556.169290-1-mka@chromium.org>
References: <20180731184556.169290-1-mka@chromium.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

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
2.18.0.345.g5c9ce644c3-goog

