Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F9BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C81620657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILT1Vd9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfAQEkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:40:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37343 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfAQEks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:40:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so3857286pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O9bXpLtNT+BCUQn2SVVOAyTOCBVSMfnXKC0pq9Dc3To=;
        b=ILT1Vd9lVTjPjFCbeBmU60KOldkj10NPIbOEm8awbeWPx78oyzFVsT0obLEE7Dcpmw
         JbGUA/HEond+46wiq8KQbSzxl5JaSE8pei7a0ZJ3oYlUTq3YCtBLeJerzzCgVhbuBSKu
         U9MlNWBMqkuMCsN3ZIcNpX0AihLwK7qaoWWU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O9bXpLtNT+BCUQn2SVVOAyTOCBVSMfnXKC0pq9Dc3To=;
        b=e56ZqinSpLq2VmmSpVmsQFiI26b3NeMDQmkO9ZX9siWI9LAf5zERoifZUwUvvGb6A3
         8fLypb2OA884NvGsm8+7zS/Y/20CFuVlWfc+kiS4ugrQUi0xDR7xIwYEo5kjn4zUQSr6
         ItNheZyd5/lVHWgjM6yWs+hRzZnBZNV59pRxg78nA0WnR+DSR5exNKqTPc2J7bptay6o
         1HGlP4oPk4tuft6ecnjwR8ZnY5hPS3d2NYFgv9VMpWAu9aL4xPfdCICXQu2OguhHPKND
         8/y0Q30zkt5gEArh/OkFo4P+Tz+Ku1GVzdkKzI7zL0SwsJaaCKYwk5rd+StouAoo2iZV
         Qz9w==
X-Gm-Message-State: AJcUukd67jhNXGxarLNv/+/SPUDNQj6wOeMBlbosFqWKmdvYHu2K36Op
        xN6E7VLq1fGFRv14UepxXGtN5w==
X-Google-Smtp-Source: ALg8bN5ZDX7xXiit1yMMk7njXrggfuyMRKFNIFppvO4ZqXRcpJ+ByIJwetWZ0XBue3etqhtc+gS27w==
X-Received: by 2002:a62:4b4d:: with SMTP id y74mr13310399pfa.186.1547700047764;
        Wed, 16 Jan 2019 20:40:47 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b5sm630667pfc.150.2019.01.16.20.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 20:40:47 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sdm845-mtp: Add WCN3990 BT node
Date:   Wed, 16 Jan 2019 20:40:06 -0800
Message-Id: <20190117044006.12463-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM845 MTP has a WCN3990 Bluetooth chip on UART6, enable this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index af8c6a2445a2..f65d5a674103 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -17,6 +17,7 @@
 
 	aliases {
 		serial0 = &uart9;
+		hsuart0 = &uart6;
 	};
 
 	chosen {
@@ -357,6 +358,10 @@
 	clock-frequency = <400000>;
 };
 
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
@@ -373,6 +378,20 @@
 	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
 };
 
+&uart6 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		max-speed = <3200000>;
+	};
+};
+
 &uart9 {
 	status = "okay";
 };
@@ -470,6 +489,31 @@
 	};
 };
 
+&qup_uart6_default {
+	pinmux {
+		pins = "gpio45", "gpio46", "gpio47", "gpio48";
+		function = "qup6";
+	};
+
+	ctsrx {
+		pins = "gpio45", "gpio48";
+		drive-strength = <2>;
+		bias-no-pull;
+	};
+
+	rts {
+		pins = "gpio46";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	tx {
+		pins = "gpio47";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
 &qup_uart9_default {
 	pinconf-tx {
 		pins = "gpio4";
-- 
2.18.0

