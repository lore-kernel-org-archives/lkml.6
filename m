Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE46C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B6D20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B6D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeGIVZk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:25:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36159 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933209AbeGIVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:25:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so14533774pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QSC1XjZ85hv+T9C9ra9S9sf5IMwZc+y3e+ROIYg7CI=;
        b=I098J+cc6jE7uVeY+2h9H9qisldw5MzK+YtmPtmyehcthdAqM27Bbw4W1DwRNLdii0
         vq9El2xN3IJagMVArXNvfugx/WsKpaCmExePBHp31bcnK/24g+ncgulSH6wuQJVPDA8x
         Wtv9dDBafpRnmTirA7ahDewqPTPecKm6/T1+sJZKbJH0TKn+5vT7lcwpulbhFHvJP3Ug
         sWwMkCeHir4H/dIRriAYD8uoS8Ow3NT/XK6/V6XcSouho0g334jegYUulq8wdTCtaXZi
         J0ekuEeOZdzS0Jd8jQ7K/oenBjF3MhO25mOk4MYG8AuXsMm9R/C9WHgPgx1L/qNmg47h
         h9MA==
X-Gm-Message-State: APt69E3qu4/8mlieZ/x9jdIDB13Zk+JzqhGJ8W+s995QFzjar8Eb6ubu
        OzXJh5yD+FIIpUyM2OawX8Zhww==
X-Google-Smtp-Source: AAOMgpew67XywVog+yjtECUMth5hS+nWk3DGGoQvwrURvozM29GuHSFZWJdpidDdVYyiIgwsXUUx0g==
X-Received: by 2002:a63:c608:: with SMTP id w8-v6mr391628pgg.16.1531171529295;
        Mon, 09 Jul 2018 14:25:29 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id m9-v6sm22566221pge.25.2018.07.09.14.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 14:25:28 -0700 (PDT)
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
Subject: [PATCH v3 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
Date:   Mon,  9 Jul 2018 14:25:22 -0700
Message-Id: <20180709212522.187257-2-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180709212522.187257-1-mka@chromium.org>
References: <20180709212522.187257-1-mka@chromium.org>
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

The temperature of the critical trip point can be increased after
adding the die temperature ADC as IIO input for spmi-temp-alarm, which
significantly increases the precision of the temperature measurements.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
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
index 7eea94701b23..52c5e797aab2 100644
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
 
 &spmi_bus {
 	pm8998_lsid0: pmic@0 {
-- 
2.18.0.203.gfac676dfb9-goog

