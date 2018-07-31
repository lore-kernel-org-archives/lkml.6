Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF623C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9240820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9240820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeGaU1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:27:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32882 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbeGaU1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:27:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so6301288pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWHD3U11wghvwRII1kRUIs8QoNbRmHkZbA9xigt5SRw=;
        b=jO11pij8W9GoirbGEMLFaDaF9oRJ/7JJDoBFM2hAycl5XXqHoYiQtO00a/afhw0wMp
         ywrjVcY8ESOsE7JFjIRsx1Bme5W501BKclxaf9ekcPYbCQ/lV4RZ7Hzuv1qKODKYZXaQ
         T821gvjvHZxAeZjK3Dd1mRbDRXxugsKGfy5mKPkXaBUmrVaI5crHvdW9QYW0WeKSZzhX
         G/R6Y1HPzIGYYy62UGvxbyMPvrOYt+mLNkWgdwwgTmnuKFLI/tiD1oL/pbpp+wF6yBXj
         QP6wFEE71WB46i6tRenIzvt65FBraN209nQ3jIlvdbyziWH8N4vTYKyziZYnDzonKt+o
         NPWg==
X-Gm-Message-State: AOUpUlEUnRFjbl+j2l2UpASDt5sgB2mXKsJhYp6w+/j/F/Gvv6Zlutsj
        xhnABTYIzEFCx/gPxJKkFndSZw==
X-Google-Smtp-Source: AAOMgpftK6VTik1iP9nFlcx7ntOye747JELX84OSDJcz9G0DVVKUu/tcmDwuawxnh1cK9zEp6EzsSQ==
X-Received: by 2002:a63:6441:: with SMTP id y62-v6mr21271003pgb.240.1533062776409;
        Tue, 31 Jul 2018 11:46:16 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b21-v6sm4981683pgw.79.2018.07.31.11.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:46:15 -0700 (PDT)
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
Subject: [PATCH v6 2/5] dt-bindings: thermal: qcom-spmi-temp-alarm: Improve thermal zone in example
Date:   Tue, 31 Jul 2018 11:45:53 -0700
Message-Id: <20180731184556.169290-2-mka@chromium.org>
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

The current example for a thermal zone isn't very useful as reference
since it would result in a hardware shutdown at 145°C, instead of
allowing the system to try to shutdown gracefully. Without an ADC
channel a maximum of two trip points is useful in practice for this
sensor, with temperatures corresponding to the stage 1 and stage 2
'hardware trip points'. A critical trip point at stage 2 may allow the
system to shutdown before a hardware shutdown at stage 3 kicks in. It
should be noted though that by default the chip performs a 'partial
shutdown' when the temperature reaches stage 2, which may prevent an
orderly shutdown. The 'partial shutdown' can be disabled by software.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- patch added to the series
---
 .../bindings/thermal/qcom-spmi-temp-alarm.txt         | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 86fb41fe772f..0273a92a2a84 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -35,19 +35,14 @@ Example:
 			thermal-sensors = <&pm8941_temp>;
 
 			trips {
-				passive {
-					temperature = <1050000>;
+				stage1 {
+					temperature = <105000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				alert {
+				stage2 {
 					temperature = <125000>;
 					hysteresis = <2000>;
-					type = "hot";
-				};
-				crit {
-					temperature = <145000>;
-					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
-- 
2.18.0.345.g5c9ce644c3-goog

