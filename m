Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11562C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA52E24FAC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA52E24FAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeGBSLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:11:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37992 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeGBSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:11:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id j17-v6so7869747pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JwKOqWJyrr/39mWOVkjZxVWrT/c0a+cxPW5ln8IJw8=;
        b=Kslwrzgqgr6gXl7iZHWiNXpaIiRMGCiQZhjfuXXVgzfWOeDSNx72ugWs6u5Fo6/wPq
         bBALFl2wr5QV0BG37jTsZp6UgvVOO42TWpfpyN+CUqb1eDXm65ppeEt2sCvovshnB8N0
         qWfR7vm9EI5Qw6xnyZ0ZAbv7r5WPXg3DwmSAC+vB3I8ewfnnQ967cge9KJk2PeBjYX5g
         OHHeqQzNC8s/H/hU8vgoKD+mwuMzK6vG8ICmL/FTJwTC/W5s36KoK8OiZcEzSoQFZ4e9
         SP9Y1v3kr7zyl9hcD/Z10fN5xPvPU5YHbb0xVVpaHnPF8UCMIVDiG6p5k8HZn2Z6Nyx/
         oJ3w==
X-Gm-Message-State: APt69E0rPsOE97bAR1S7fIaq3KISu43mFLiZR4Ko6MsMLTI/CoURtlGL
        yjp4z76YOHcZT/8bBHQwAA0C2Q==
X-Google-Smtp-Source: AAOMgpcWFnlOQzG5VEcAvfAJl+Ip/pJou2TYu9xA8GwIJRBNu2OYmIa3Y13fYxHrl0pItTPgpxWtrA==
X-Received: by 2002:a62:fd0b:: with SMTP id p11-v6mr26498302pfh.52.1530555063334;
        Mon, 02 Jul 2018 11:11:03 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id h75-v6sm10048372pfh.86.2018.07.02.11.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:11:02 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
Date:   Mon,  2 Jul 2018 11:10:05 -0700
Message-Id: <20180702181005.18247-2-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180702181005.18247-1-mka@chromium.org>
References: <20180702181005.18247-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone uses spmi-temp-alarm as sensor. If the sensor is
configured without an IIO input it always reports 37°C for temperatures
below the first hardware trip point at 105°C. This hardware trip point
is configured as critical trip point, to initiate a system shutdown
before the temperature reaches the next hardware trip point at 125°C,
where the PMIC performs a partial shutdown.

The temperature of the critical trip point can be raised after adding
the die temperature ADC as IIO input for spmi-temp-alarm, which
significantly increases the precision of the temperature measurements.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- defined 'thermal-zones' node in pm8998.dtsi instead of using a label
  to refer to it
- use 105°C hardware trip point as critical trip point
- reduced number of trip points to 2
- lowered temperature of passive trip point
- updated trip point names and added labels
- updated commit message

 arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 2f4989e7ef68..e7caa334e6c7 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/thermal/thermal.h>
 
 &spmi_bus {
 	pm8998_lsid0: pmic@0 {
@@ -60,3 +61,27 @@
 		#size-cells = <0>;
 	};
 };
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
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pm8998_crit: pm8998-crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
-- 
2.18.0.399.gad0ab374a1-goog

