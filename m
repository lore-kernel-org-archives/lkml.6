Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB3FC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DE12177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XJxGGvxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfA2Bz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:55:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37983 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfA2Bzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:55:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so8051019pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mocO6vGvRfAbOOJlOrYtXKsYBuRMgFTLyYUhfc5KtPg=;
        b=XJxGGvxlnIRX6CV9BITN5qfPqUlPgDQhUugQA9z1zmpr8cUoAu2FOjE2ipEMRpbJsK
         gEBv04AvL5JW6dNhvCAx++E4ud0MDrI+IsQjLkKEIldR0rNouBXDuwpfBfCeYRs7d+9A
         VKjltjNPojxeMgOR/LXifSVGvjclhoD2FeG4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mocO6vGvRfAbOOJlOrYtXKsYBuRMgFTLyYUhfc5KtPg=;
        b=LS1CAYPE8426ehUM2saCTPNVh5gJB2eW14jI+c1vcIwb+bIK9qPJgrXDe2aYoXEbma
         HAMu7F/Dfn0B3MK7dh1vGUgroBt7WuolfD6hMT7bVjeu+8PLh0BguIKQbyWi2Qk3f5c1
         7rgOf4+o18IuCShrov5oUmd50iFM/OqNWVMo23NBW3iTYkvvzzyf6uKAlif26ShYL9Ya
         sxnHOe/E1BYbnfE7CLQc2burKoFtAhS7qH/jSe2dY/NU+P4mKJ65LGe712lU2tXuD8B6
         DcuKz10vCcUIPorra7CSrGHsxN2Pe18D8z/wgU+sa9R1cl26XE/nJNy5TwE7jJdeRwuO
         GAXQ==
X-Gm-Message-State: AJcUukfuKiUVWX3Q5gSzYB9yMe8Qrig5cZxjqNr5cNTG7UyCkLWsX2MX
        3vyGUgpHLQoSgpEnKptjKWQnW0hEufZbng==
X-Google-Smtp-Source: ALg8bN6t038dLEinem6pKf5+d1Vji/JqPX6x2hWkBNgFn52ytDdCK6P9qclQyp6RXUGIkjitGoRJUw==
X-Received: by 2002:aa7:8045:: with SMTP id y5mr24008449pfm.62.1548726954818;
        Mon, 28 Jan 2019 17:55:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g15sm142911530pfj.131.2019.01.28.17.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:55:54 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [RFC/PATCH 5/5] arm64: dts: sdm845: Add OPP table for all qup devices
Date:   Mon, 28 Jan 2019 17:55:47 -0800
Message-Id: <20190129015547.213276-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129015547.213276-1-swboyd@chromium.org>
References: <20190129015547.213276-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

qup has a requirement to vote on the performance state of the CX domain
in sdm845 devices. Add OPP tables for these and also add power-domains
property for all qup instances.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 115 +++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 22dc2b2df662..05c4862a195c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -366,6 +366,25 @@
 			clock-names = "core";
 		};
 
+		qup_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-19200000 {
+				opp-hz = /bits/ 64 <19200000>;
+				required-opps = <&rpmhpd_opp_min_svs>;
+			};
+
+			opp-75000000 {
+				opp-hz = /bits/ 64 <75000000>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				required-opps = <&rpmhpd_opp_svs>;
+			};
+		};
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x8c0000 0x6000>;
@@ -387,6 +406,8 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -400,6 +421,8 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -411,6 +434,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -424,6 +449,8 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -437,6 +464,8 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -448,6 +477,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart1_default>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -461,6 +492,8 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -474,6 +507,8 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -485,6 +520,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -498,6 +535,8 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -511,6 +550,8 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -522,6 +563,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_default>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -535,6 +578,8 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -548,6 +593,8 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -559,6 +606,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart4_default>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -572,6 +621,8 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -585,6 +636,8 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -596,6 +649,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart5_default>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -609,6 +664,8 @@
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -622,6 +679,8 @@
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -633,6 +692,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -646,6 +707,8 @@
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -659,6 +722,8 @@
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -670,6 +735,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_default>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 		};
@@ -695,6 +762,8 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -708,6 +777,8 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -719,6 +790,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart8_default>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -732,6 +805,8 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -745,6 +820,8 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -756,6 +833,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -769,6 +848,8 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -782,6 +863,8 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -793,6 +876,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart10_default>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -806,6 +891,8 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -819,6 +906,8 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -830,6 +919,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart11_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -843,6 +934,8 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -856,6 +949,8 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -867,6 +962,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart12_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -880,6 +977,8 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -893,6 +992,8 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -904,6 +1005,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart13_default>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -917,6 +1020,8 @@
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -930,6 +1035,8 @@
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -941,6 +1048,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart14_default>;
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -954,6 +1063,8 @@
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -967,6 +1078,8 @@
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -978,6 +1091,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart15_default>;
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 		};
-- 
Sent by a computer through tubes

