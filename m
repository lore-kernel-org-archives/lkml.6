Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB9C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9A2204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxOuWwRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9A2204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeILO6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:58:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34295 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeILO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:58:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so1279557eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YWY514Ho56MqP+3xVlX6Wcdqohkkp5DZVbhXeb5xcpo=;
        b=IxOuWwRYpJkUsVrLRpCfzYi4uv8X52mWzMaPrOdfDb9B8/iwDZqUxEhV92wc6WOSW8
         xXq2XobjiJ0f37w6Os+R307z+o+hXXiiQeFHSw0uteDUFfOxw6hv8Em9uuxK58Q4MrvF
         pcE+CCM4xtLnXq6WipI+5wvNp/v0PdTXPcTjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YWY514Ho56MqP+3xVlX6Wcdqohkkp5DZVbhXeb5xcpo=;
        b=fznebUAiBA2XZJ+VT7jUDNHsrPBu27YGTacslVHphdVTS6EmbbNY/a5sR7Mv48t5A2
         RW8HmzSHqmmEg+LlDgmMorHRfaWQBxPsftGRH0TgWCowctJC6DR7/WLumtCdaU14oYGz
         7x2yZ8dT0wJ2frTws7Ca+kk1xbMyKb5zQZNrfHxOHKYBCy2AKwvkN68oFKTtCHeFwBkP
         e0L+YdkzVr87wPvbqTPAtVijWFBjyrmhdtzeEBeYsfPNB0Yms4cVbObqOUDlDbuTmc2C
         b7a1aDeIvWFi1H1SrchEN555cjg2utB+fUdOIWYgxnBTRZtfCJ1pv5D301Y8ILt8tOHY
         WREg==
X-Gm-Message-State: APzg51C5Rj9kpKioKzGDe8aJDCedCwfCqLjgc/WqK35Tj6ZznRTfZgdY
        KmFCCWpSeSE6mEjm2gNGAjdjBvhQW3Q=
X-Google-Smtp-Source: ANB0VdbAWtv+yFoepm8zly/1MsFNSAoPA21BsZQejqo6qXDjcauQMNLUo3z43QTvUiIP0V4uvlleKw==
X-Received: by 2002:a50:8a66:: with SMTP id i93-v6mr1786761edi.281.1536746104156;
        Wed, 12 Sep 2018 02:55:04 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id 25-v6sm557988edz.45.2018.09.12.02.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:55:03 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 15/16] arm64: dts: msm8916: Add camera thermal zone
Date:   Wed, 12 Sep 2018 15:23:00 +0530
Message-Id: <5c678cd9c1f9d531efa39e9edb6151106957a077.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the camera thermal zone to export temperature to userspace.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 62f079ae9ba3..3dc8b8aa76c7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -257,6 +257,27 @@
 			};
 		};
 
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				cam_alert: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cam_crit: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+		};
+
 	};
 
 	cpu_opp_table: cpu_opp_table {
-- 
2.17.1

