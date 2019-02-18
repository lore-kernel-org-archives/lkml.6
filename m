Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF44B217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGEc4QEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfBRMg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:36:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44792 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730967AbfBRMg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:36:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so3565262wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9U95FbF25ViJswUkrIR1g6AQUt6aGXXn7Rwca8tPtIo=;
        b=eGEc4QExCkJp0UwEHtuBBvbhlsO3OgbyxZSfLvym0jqGn78n6PlUJHNzp1+YzHhMi1
         2aOmXquTExBGw+w6ImLDQubILng9lOzlL45Db4sJr1qhSw2cqqLbWy+H6kfg9U/FDDh1
         Ffg6CMXKLkpuaYfvG+z3EtzvTM62QCphywJoxhNseLcZ1HAg4I7TwEvAguPWv/9AUTph
         +OekJPnuGaFd+IXwvvBkG0dvGrPLoa7JG7VNChH6GPKsaoD7yVtn0xasHUYFUHdbcmHe
         cVYwAYs1HCQZF2EoSXteN/8iH9UCBadyoZkZz9o2zo5P1fyrCOlmuvUwz++C6jO6QlXW
         6dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9U95FbF25ViJswUkrIR1g6AQUt6aGXXn7Rwca8tPtIo=;
        b=d+FfHnJNphwUAWyWWGokRPm5MNvpEr1PR7Cx8HJoKlKJnHV2AzhOuvLrVoXMglZeCm
         KspTqriw225OTKH2bePtyBXuwGuDQorg4ocPRAfZcMjj0AfBIyLRieX7dHFVxSCOuZM2
         KWHe5I0IUvt1Ow/lgYssnSarG2ypJ09HdpwdqM7gAQDSMPL3Kkv0VB/mtftVz7AO6BA7
         lzrQ1hesjxbI8LgeKgZ8m4zXeV9G78vuJx0umWWMPu3lxyFzfURUk/2uC1ImDLpGzIB8
         PQ6aElwRy1CH61m182oQzSZTokmtkGBEvmuHxuozg1Y6B1HDCD5pO6n94Grcwbvn1DFv
         A4DQ==
X-Gm-Message-State: AHQUAuZuuedxtiquHdToO/X+x368mAldGjZDf2VSd7HW7vwBbGjziI9H
        5BtXbOYdGqcSPQ0RC3LqYVUSMg1rQ2A=
X-Google-Smtp-Source: AHgI3IY9u4rVtAuEj7+ZdNFFvjhdA5lkRoI6a0KXlbuh0BAJqGkF7zb5W3onUCaovlECHjKnm/iDJw==
X-Received: by 2002:adf:eb90:: with SMTP id t16mr15906905wrn.324.1550493384509;
        Mon, 18 Feb 2019 04:36:24 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id u8sm1209194wrr.33.2019.02.18.04.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:36:24 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 08/12] arm64: dts: msm8998: thermal: Add temperature sensors near major peripherals
Date:   Mon, 18 Feb 2019 18:05:22 +0530
Message-Id: <cfbf5b94cde763ea739b1c6e63d9d30463c0a63d.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8998 has a total of 22 temperature sensors. Populate DT with
information about them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 63 +++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index dc641523fcbd..26a493af0866 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -513,6 +513,69 @@
 
 			thermal-sensors = <&tsens0 13>;
 		};
+
+		cluster0-mhm-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 5>;
+		};
+
+		cluster1-mhm-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 6>;
+		};
+
+		cluster1-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 11>;
+		};
+
+		modem-thermal {
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
+		q6-dsp-thermal {
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
+		multimedia-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+		};
 	};
 
 	timer {
-- 
2.17.1

