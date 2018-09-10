Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2689C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967C920833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hfa6G2ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967C920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeIJMKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:10:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38948 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeIJMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:10:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so15683112edi.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QeCifftAwNierF00ZXGccAXC6GN8pVph0sqiZdMEE8I=;
        b=Hfa6G2udqYy0Gf2BMRbyD1UnEP0tVoLRkTni80ik0l9g9kI4JTZ7BPVav/AUAclyXq
         KKlzmchMLDAokIeG9F75nvl3RsCEJQEwQD6XEqx6/jdbycUjvpDAi/hFQXU3cj1F9Q/t
         BuzB18FSJfXkamWUvVEOTtHzqhCoT6QpA4McE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QeCifftAwNierF00ZXGccAXC6GN8pVph0sqiZdMEE8I=;
        b=AxANkx2LhH+ezSjY+G98w8FHABtSuIrNIr0QgbmVeaXhwePs88jXiEETc9cuKxtC/a
         RLeO1mrXdcOP9Dj/Nk+eyAEJnYmTur4pF+2elJm480TElgfILDWs/Qc7nCc/7LF9FLiY
         x9UG4QhwfUTN5ANuV08+on5IASxKfidt5H24aUAPHzIXv92C0V4Po9zlMvM+9EFrVGpZ
         xV21qvsWcl+5v+CrUCq6e+dBXbS7dErXkPeAyWTmq6dfahyO/mggatDDn5p9pNwlhDri
         WQ18thPtftZrQ/xWcaNtvTWLExTb0Jv65e1xfhLRhy90WYrRXMTWi8JIDSlQ1kfUsovL
         Xolg==
X-Gm-Message-State: APzg51Dya9OFGhrsvn/pruONZY2PkQLLFgGo3keeV1BTfcP+4PdSJh+c
        gXHGgqWfSr1KjADDJiVW/6DH1IhhdoQ=
X-Google-Smtp-Source: ANB0VdY6hYXjN2pWFcwr6nV9Hn8WGIsg75U9nqmKIbgLMbJozUCAJ4aalXKngChJeLIfmKfz0eHelw==
X-Received: by 2002:a50:898b:: with SMTP id g11-v6mr21881633edg.82.1536563848345;
        Mon, 10 Sep 2018 00:17:28 -0700 (PDT)
Received: from localhost ([49.248.190.103])
        by smtp.gmail.com with ESMTPSA id p28-v6sm10908039eda.85.2018.09.10.00.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 00:17:27 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: msm8916: Add gpu thermal management
Date:   Mon, 10 Sep 2018 12:47:14 +0530
Message-Id: <3f859c7f5af7955d779cdaa88fc09f0b1d79a35e.1536563656.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536563656.git.amit.kucheria@linaro.org>
References: <cover.1536563656.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536563656.git.amit.kucheria@linaro.org>
References: <cover.1536563656.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the gpu thermal zone to export temperature to userspace.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7b32b8990d62..a494196a657e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -237,6 +237,26 @@
 			};
 		};
 
+		gpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				gpu_alert: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				gpu_crit: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
 	};
 
 	cpu_opp_table: cpu_opp_table {
-- 
2.17.1

