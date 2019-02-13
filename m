Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D115C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8A3222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmteZ4Ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392174AbfBMMeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:34:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38166 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392160AbfBMMeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:34:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so1081262pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FGaARlyO45jSVlRCo3Ba46kwztIqiQvxEWOsLPfUyBY=;
        b=tmteZ4Yadx1Xj9sG8FjJzb/XQPKilq9yCsNYjoVZLRWUeNlKFBj20Hj8lf4izmYo+Y
         bbeGCWqccyS9rQx2mLdyJdaEyxg9LQoJHkArA1j4+WFLIBkZ/KsWvN4ODiaQxNttHHkR
         EwMAQ79vWNIuNG+PBfqs86YTYnu68D6h2ZruC0dK3pdyx7t9OTXKx+SzPO0DDz3kPl7X
         Pl9ZnKlNAzcHzZatc7X9UWT1XsN3zg5o6jD0fqONbJ4Rhm8+a5ZizaCaK1lwGBmReHOj
         IY4QGtiQ/igG6Lco8H4XRwozAfMo9moQS56Kiu8zFudHq+QrCqC3OnbFRLQlPQSC4Sml
         +nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FGaARlyO45jSVlRCo3Ba46kwztIqiQvxEWOsLPfUyBY=;
        b=RzFeTAW81ErbW03+zgiBPs5xuTxAR2BLuIGGByjRAgu3xw/hrOu7/dJ6wbZMMIQw2b
         fhlo2943v1pmo5f/kYRKzR5KsHB+yu4wAjIRQmVL741po0F5kkQcTEGHJGHKdIoqh1OP
         6ptaGzIK5BarbyWsJg9cmPdp3WJMSYDPWtNZv3msmlSvreYWZANUlfvb0bcU0l6boKoX
         cZkJu0l1PG14i89I4h0RUx8qzS3F1fYjubfvIGXfYsbBOsgxAGzH5L4AmctFyV59QTPe
         /F0PEU6j0upKan6tHQzgllKE6yNAbfy1u7m6Y5nLKrprc8qfL2hmyIjytqmEdylXmqpU
         cGkQ==
X-Gm-Message-State: AHQUAubGuPHZhtbXppNXWX6RSuty+H+3qp5JTAsZxs8jfRdXYgPGn5Ct
        nwCsiywpvyPjxfG9yN1NdmFGig==
X-Google-Smtp-Source: AHgI3IZrWYzG9huHS10ehbGpwHIHSv79LI09Vcrf45ydQgH291PARN3sX4S/vYIcLE4vYgUdlpfxRw==
X-Received: by 2002:a63:d347:: with SMTP id u7mr232319pgi.383.1550061259786;
        Wed, 13 Feb 2019 04:34:19 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 04:34:19 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de
Cc:     olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH v2 3/5] arm64: dts: sprd: Add SC2731 charger device
Date:   Wed, 13 Feb 2019 20:32:47 +0800
Message-Id: <ecfa4740cd1255f358b307af946cb059f7776090.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add charger device node and related battery node for SC2731 PMIC.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi      |    6 ++++++
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |   16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index a2edc25..dbf6242 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -17,6 +17,12 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		charger@0 {
+			compatible = "sprd,sc2731-charger";
+			reg = <0x0>;
+			monitored-battery = <&bat>;
+		};
+
 		led-controller@200 {
 			compatible = "sprd,sc27xx-bltc", "sprd,sc2731-bltc";
 			reg = <0x200>;
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 3bd18e3..2a963bd 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -41,6 +41,22 @@
 		#size-cells = <2>;
 		ranges;
 	};
+
+	bat: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <1900000>;
+		charge-term-current-microamp = <120000>;
+		constant_charge_voltage_max_microvolt = <4350000>;
+		internal-resistance-micro-ohms = <250000>;
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
+			<4022000 85>, <3983000 80>, <3949000 75>,
+			<3917000 70>, <3889000 65>, <3864000 60>,
+			<3835000 55>, <3805000 50>, <3787000 45>,
+			<3777000 40>, <3773000 35>, <3770000 30>,
+			<3765000 25>, <3752000 20>, <3724000 15>,
+			<3680000 10>, <3605000 5>, <3400000 0>;
+	};
 };
 
 &uart0 {
-- 
1.7.9.5

