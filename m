Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1A2C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 06:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901612084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 06:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dv7Typ/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfATGjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 01:39:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38646 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfATGjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 01:39:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so8008913pgc.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 22:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OQfVRzCzHA4WSBdCjgd+0IRJW2iisS/CcO4MaoQg3i8=;
        b=Dv7Typ/HYxrw8biRC7OXQmZR+uTVsJTxceUWyO8L1hwuy7r+L9EAYUj9Wuzp1fqsxi
         53ckfNfQmZeeEquWV0kGayPzQnuf7kOZtaGIx+fH21wFNy65KaVPVnrpqVJtvW6yMNVS
         sWuNXLStR1uhvJtAoxZlaWq/qlJld5/hUquVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OQfVRzCzHA4WSBdCjgd+0IRJW2iisS/CcO4MaoQg3i8=;
        b=cZHyIc9K0sbgl7IMAD97Ot6Oq6PAZZUITTS53J9i+QOn1Xc06spsOzZUdt9sBOF697
         UA8/FlJBwi/JzzMHyjdQRZoC9LNV0da4mXmFQPV2mTE+FK+9igNEXZ7eK5q39emoIfr/
         JBzI7a2dU2Q1BP3Llt9gXdRmvt1Cco9ZafiuD8UFIZDKVUYih9fio3WigSZU9+oe4FVI
         TPBUl7PnUh6Rb2Kx3IX5zsiqI1WKzg3e3GcRA35QY7VLwspFtK8mT/aRtDOl3ydORiUv
         3LEjfR4wFHZwHiV6jeF9JLJsCuDGU+YC9M7YX4EDeYuxUzSgt0NrPX+YSTDmei8ZSQW2
         mRUg==
X-Gm-Message-State: AJcUukcuV+vwvKZ1wSG0kUVOfhQOuAFECus0tWtA+sM4VdUI7yhPdgfe
        B7NrUtXNGfp8iwijFBFiW2E0vw==
X-Google-Smtp-Source: ALg8bN4Jcd0kJf1puf97Qz7E/At0O6dWiQ9dMqH6grrZb1jfoPDDP/JZHL8Cg3pCR+AQU/3UjeWksQ==
X-Received: by 2002:a63:f811:: with SMTP id n17mr24331927pgh.23.1547966377877;
        Sat, 19 Jan 2019 22:39:37 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x12sm8836776pgr.55.2019.01.19.22.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 22:39:37 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sdm845-mtp: Add WCN3990 BT node
Date:   Sat, 19 Jan 2019 22:39:02 -0800
Message-Id: <20190120063902.1714-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM845 MTP has a WCN3990 Bluetooth chip on UART6, enable this.

Pinconf and the associated comments are copied from a patch by
Matthias Kaehlcke <mka@chromium.org>.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Fixed the pinconf

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index af8c6a2445a2..5aec2c680033 100644
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
@@ -470,6 +489,40 @@
 	};
 };
 
+&qup_uart6_default {
+	pinmux {
+		pins = "gpio45", "gpio46", "gpio47", "gpio48";
+		function = "qup6";
+	};
+
+	cts {
+		/*
+		 * Configure a pull-down on 45 (CTS) to match the pull of
+		 * the Bluetooth module.
+		 */
+		pins = "gpio45";
+		bias-pull-down;
+	};
+
+	rts-tx {
+		/* We'll drive 46 (RTS) and 47 (TX), so no pull */
+		pins = "gpio46", "gpio47";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rx {
+		/*
+		 * Configure a pull-up on 48 (RX). This is needed to avoid
+		 * garbage data when the TX pin of the Bluetooth module is
+		 * in tri-state (module powered off or not driving the
+		 * signal yet).
+		 */
+		pins = "gpio48";
+		bias-pull-up;
+	};
+};
+
 &qup_uart9_default {
 	pinconf-tx {
 		pins = "gpio4";
-- 
2.18.0

