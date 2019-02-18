Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA16C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03DD21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdFBjGnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfBRMgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:36:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38646 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbfBRMgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:36:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so18169334wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=X8u9l4N6lQKfR92IM8mSGGsF856tgRM+MVFm0jbOT8A=;
        b=CdFBjGnMmIzlCGGIHIQdv1jeCRGmsYPp9cLii/fuQwY5FhzLYescGI4BKddG+UJa4Y
         tB7dsCeBce00eSCzfM40f95CVt47Bk2gTbk1Kpp0f3ne8q5e2XWYFKXFFUlW1K+qW/D6
         0oXyJv0Ol8yFAkk3u+Z5NY5GsXK6SotAGsMRQWyvoXuYtAfqsssMtF3wcyC3YYSLBH+L
         vJpItXxaZJvAuqEj6Auy/APNEOReVD9ThTrG1inrWE4OwhP/lPgq6vtAdonTtga2AjQk
         Jk4dCaAzZFDIrmOueqQKqpbUOaewIPniqZvRsMh4Dwgy3HNfTSEWOauh8nmc0LcRPYub
         oleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=X8u9l4N6lQKfR92IM8mSGGsF856tgRM+MVFm0jbOT8A=;
        b=JSJn47gJDo810y6x62qeEVN8J23LN8DzUxJViSnWg2O5i2Tv86yUwOb/s+BC99P4bY
         poo6lXZI9S5t0Vk4VAPpZ4AefQ+2/uB81VfI/4ImHM5m8kQJizH6b1o5aN1B9/0peDCv
         YIGSO+2FqP/duVZ0Dnbn80ZCPwDywQn/luX7K1aeKAiFHT79pYJhy4JZ5IoOr2KsOyLH
         WAzbJaiYhPn/PAb4VQgZFRbDrOjI+6mRjgGcBLBxFD9TTtFd0g+jW67lL6Vx+nlStLrp
         mvc2afHn7FoG76J5jmYk0rpD9jVhpBCJVJKpe6jVVzDQejyjL5gXTDpI+CWhSyv360Tr
         mWAA==
X-Gm-Message-State: AHQUAuan2Uh4D3+vEH4VpKsa8PBfawZ8andrmNnLbkv2lkbilZhrl4p7
        J+o2oCwnhT+zNGq/pzDlycrwIyZVZlA=
X-Google-Smtp-Source: AHgI3IawnusF0Y/v7IS4QYOYmuUXJTXwkAl5ZE8wZgE8pnWQK3fnbbIm/eRD3NNMSh8Tj4pbQBHd0w==
X-Received: by 2002:a5d:68c2:: with SMTP id p2mr15424289wrw.23.1550493390452;
        Mon, 18 Feb 2019 04:36:30 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id p9sm7265051wmc.14.2019.02.18.04.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:36:29 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 09/12] arm64: dts: sdm845: thermal: Add temperature sensors near major peripherals
Date:   Mon, 18 Feb 2019 18:05:23 +0530
Message-Id: <1a57e10249dfb9d97b45d748338dbd188a6cf6d5.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdm845 has a total of 21 temperature sensors. Populate DT with
information about them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 91 ++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..55c8f3f99add 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1851,5 +1851,96 @@
 				};
 			};
 		};
+
+		aoss0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 0>;
+		};
+
+		cluster0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 5>;
+		};
+
+		cluster1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 6>;
+		};
+
+		gpu-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 11>;
+		};
+
+		gpu-thermal-bottom {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 12>;
+		};
+
+		aoss1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 0>;
+		};
+
+		q6-modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
+		};
+
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 2>;
+		};
+
+		wlan-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
+		};
+
+		q6-hvx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+		};
+
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 5>;
+		};
+
+		video-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+		};
+
+		modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 7>;
+		};
 	};
 };
-- 
2.17.1

