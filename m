Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDAAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B9520865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B9520865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeK0Fxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:53:54 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:47857 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeK0Fxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:53:54 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 433bmV3bcDz1r35J;
        Mon, 26 Nov 2018 19:58:49 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 433bmT0P6vz1qtfd;
        Mon, 26 Nov 2018 19:58:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 1d1bVJE-83fp; Mon, 26 Nov 2018 19:58:46 +0100 (CET)
X-Auth-Info: hsPyHv9sQPRXuPrtOkmr9s79GpXJtgCbOKtPmTnphsQ=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Nov 2018 19:58:46 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@cubietech.com, thomas.liau@actions-semi.com,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v2 4/4] arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1
Date:   Mon, 26 Nov 2018 19:58:21 +0100
Message-Id: <20181126185821.2480449-5-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126185821.2480449-1-pn@denx.de>
References: <20181126185821.2480449-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl definitions for Actions Semiconductor S700 I2C controllers.
Pinctrl definitions are only available for I2C0, I2C1 and I2C2.
Enable I2C0 (PMIC), I2C1 (gyro, touchscreen) in cubieboard7.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index 28f3f4a0f7f0..6a75fdd7ab42 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -37,3 +37,56 @@
 &uart3 {
 	status = "okay";
 };
+
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_default>;
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_default>;
+};
+
+&i2c2 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_default>;
+};
+
+&pinctrl {
+	i2c0_default: i2c0_default {
+		pinmux {
+			groups = "i2c0_mfp";
+			function = "i2c0";
+		};
+		pinconf {
+			pins = "i2c0_sclk", "i2c0_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c1_default: i2c1_default {
+		pinmux {
+			groups = "i2c1_dummy";
+			function = "i2c1";
+		};
+		pinconf {
+			pins = "i2c1_sclk", "i2c1_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c2_default: i2c2_default {
+		pinmux {
+			groups = "i2c2_dummy";
+			function = "i2c2";
+		};
+		pinconf {
+			pins = "i2c2_sclk", "i2c2_sdata";
+			bias-pull-up;
+		};
+	};
+};
-- 
2.17.2

