Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28018C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E229321934
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738160;
	bh=M0xUpen9jh4L/GKMQsRT3zrXLHdG3/AzVdvPNJz22S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+NSxuwBw7zOkfQoLCB02AFnMOz65lEoC+2YsqSjId022IaG3ISYZLH/pzOETKSGf
	 TaQMEsNXAICPTg5Pdt+m95RWXRqIp9mH2Ucault8zWKjQ5AKCyuVnM3T4aXIPZklpN
	 nSAePrYYJaz9zanqNGeo9PL8Dy3mGCQFppsnIP6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfBIStS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbfBIStQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46F120821;
        Sat,  9 Feb 2019 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738155;
        bh=M0xUpen9jh4L/GKMQsRT3zrXLHdG3/AzVdvPNJz22S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXZOQG+ydrXyL1WRlqEOjdhTuTDLAgigEfeEzndgb/euUNfPQBpiyCQqq2GXhZiuj
         jdcTMb5qVwAKs/wdkfab5VeTZrEn3pKbZm6F5XQlIDqpje136zIgF+Z6nX938Yf5C3
         5+Su2TkfudMVIlM0UwoqPjZXeYUXAQVFeusyHCiY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/28] ARM: dts: da850-lcdk: Correct the audio codec regulators
Date:   Sat,  9 Feb 2019 13:48:29 -0500
Message-Id: <20190209184840.126418-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit bd540ebe68c3017194a1caa38e075bbbc0832749 ]

Add the board level fixed regulators for 3.3V and 1.8V which is used to
power - among other things - the tlv320aic3106 codec.

Apart from removing the following warning during boot:
tlv320aic3x-codec 0-0018: Invalid supply voltage(s) AVDD: -22, DVDD: -22

With the correct voltages the driver can select correct OCMV value to
reduce pop noise.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/da850-lcdk.dts | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 0177e3ed20fe..c196e37606c4 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -39,6 +39,36 @@
 		};
 	};
 
+	vcc_5vd: fixedregulator-vcc_5vd {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5vd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+
+	vcc_3v3d: fixedregulator-vcc_3v3d {
+		/* TPS650250 - VDCDC1 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3d";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5vd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_1v8d: fixedregulator-vcc_1v8d {
+		/* TPS650250 - VDCDC2 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8d";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_5vd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DA850/OMAP-L138 LCDK";
@@ -221,6 +251,12 @@
 		compatible = "ti,tlv320aic3106";
 		reg = <0x18>;
 		status = "okay";
+
+		/* Regulators */
+		IOVDD-supply = <&vcc_3v3d>;
+		AVDD-supply = <&vcc_3v3d>;
+		DRVDD-supply = <&vcc_3v3d>;
+		DVDD-supply = <&vcc_1v8d>;
 	};
 };
 
-- 
2.19.1

