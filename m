Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8475C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B971279B9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B971279B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935399AbeF1VJe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:09:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42911 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934313AbeF1VJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:09:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id v9-v6so2035348pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 14:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CKfmZi7JXwI0meuLJKxvvAFnTdfBFv0OAY0IQctqTUI=;
        b=mc7I0N46rPtFuGjSSZ6wWsXkWgBV6qYGf3/DJg5tMYQZ4gYwnmFlYaycViJEWUeIRp
         0N4cGauhdAPJex3ODAyt+GiizoPA9dcIQri63bwNsqRbNjtiMRxCd1r1Mlky5WLCgMew
         kioKCe6m8kT69LsxKqov2r/tXUTxrxTOnDv6RVt8AG3IvHSUP9dYHYdevTeKBxoteXX0
         q2lPhncSUhuI5r6ll51vfe47dBtiguOfGHsNnyZvO0/4z8/TwTvmT5zT7/Qpyk02iU4M
         IKhbSx2SoDk5F5dITrJQHTbSgMQoIcmp+N6H2XJozr8iMh44qgVGDYiC+HFNovTI8qFW
         /5Hw==
X-Gm-Message-State: APt69E2mMiBaB1iPhpMEqdjZr8QK0X1xus7SYo+7vLLBh/41b2vAHIBf
        C+Z9395SeglTJEUb5JOBmWg3OQ==
X-Google-Smtp-Source: ADUXVKITG7oHhEzyewUb4Px7/Er0Sh7lTddorOSTzD7INo1skAGgZKNp9cohQsWGSwcOEQFNNanUwQ==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr10336889pgc.344.1530220170685;
        Thu, 28 Jun 2018 14:09:30 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id w18-v6sm9006838pgq.1.2018.06.28.14.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 14:09:29 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
Date:   Thu, 28 Jun 2018 14:09:15 -0700
Message-Id: <20180628210915.160893-3-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180628210915.160893-1-mka@chromium.org>
References: <20180628210915.160893-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm8998 thermal zone based on the examples in the spmi-temp-alarm
bindings.

Note: devices with the pm8998 need to have a 'thermal-zones' node (which
may be empty) with a label 'thermal_zones'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index f2d39074ed74..d85ceb4f976b 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/thermal/thermal.h>
 
 &spmi_bus {
 	pm8998_lsid0: pmic@0 {
@@ -59,3 +60,30 @@
 		#size-cells = <0>;
 	};
 };
+
+&thermal_zones {
+	pm8998 {
+		polling-delay-passive = <250>;
+		polling-delay = <1000>;
+
+		thermal-sensors = <&pm8998_temp>;
+
+		trips {
+			passive {
+				temperature = <1050000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+			alert {
+				temperature = <125000>;
+				hysteresis = <2000>;
+				type = "hot";
+			};
+			crit {
+				temperature = <145000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+	};
+};
-- 
2.18.0.rc2.346.g013aa6912e-goog

