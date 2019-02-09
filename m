Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B9C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8892192C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738098;
	bh=R5YUPGIzmUvILUQcvRXLlaZ/DbS53cFZHRjFvSAlZFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xKliuOnQtQF3dNq49ZSHmpnJPvZcR5ybC/vMEhw+Jp4acOPj8062t26+CxzyFByF1
	 WT3+AAxNJ2t22lRIuvImRcNNyhL//G5nF5OI5kQxq8pqDAaTEK/S7bzzjo1j8+0VfK
	 bn/FgYpfTXXfhN+R/mBnTECIBe4GUx61T7Ev+OCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfBISsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbfBISsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C1B21934;
        Sat,  9 Feb 2019 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738094;
        bh=R5YUPGIzmUvILUQcvRXLlaZ/DbS53cFZHRjFvSAlZFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X09HVPEhyiqYf1yp2OXRmuPMvNwpebX1PGh+ejLxBPt//VB0gzUY08grRxiMxHahb
         K4F4xiPY6hDbTpSB3zMvZmxkeLfzEJG3Nwmxmo1ev6FygY/k5uVtuuayaWdhtDVAAa
         y8x7FjTPDQSsx0TQ651M2rXaBZj32a9mV2Z6vWww=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 29/42] ARM: dts: da850-evm: Correct the audio codec regulators
Date:   Sat,  9 Feb 2019 13:47:21 -0500
Message-Id: <20190209184734.125935-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 706edaa88835e3d8de8920584ad5da76dd3d6666 ]

Add the board level fixed regulators for 3.3V and 1.8V which is used to
power - among other things - the tlv320aic3106 codec.

Apart from removing the following warning during boot:
tlv320aic3x-codec 0-0018: Too high supply voltage(s) AVDD: 5000000, DVDD: 5000000

With the correct voltages the driver can select correct OCMV value to
reduce pop noise.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/da850-evm.dts | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index a3c9b346721d..482a54587b44 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -94,6 +94,28 @@
 		regulator-boot-on;
 	};
 
+	baseboard_3v3: fixedregulator-3v3 {
+		/* TPS73701DCQ */
+		compatible = "regulator-fixed";
+		regulator-name = "baseboard_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vbat>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	baseboard_1v8: fixedregulator-1v8 {
+		/* TPS73701DCQ */
+		compatible = "regulator-fixed";
+		regulator-name = "baseboard_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vbat>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	backlight_lcd: backlight-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "lcd_backlight_pwr";
@@ -210,10 +232,9 @@
 
 		/* Regulators */
 		IOVDD-supply = <&vdcdc2_reg>;
-		/* Derived from VBAT: Baseboard 3.3V / 1.8V */
-		AVDD-supply = <&vbat>;
-		DRVDD-supply = <&vbat>;
-		DVDD-supply = <&vbat>;
+		AVDD-supply = <&baseboard_3v3>;
+		DRVDD-supply = <&baseboard_3v3>;
+		DVDD-supply = <&baseboard_1v8>;
 	};
 	tca6416: gpio@20 {
 		compatible = "ti,tca6416";
-- 
2.19.1

