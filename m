Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E1F217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497576;
	bh=0k9pf4DvBtMAW82BMoRJoqlnok2BwbapYvBE/9Ymo9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eGp7S6skfG0oacCVKegwDoZaypZwqVx1Kju9Q6Q2STtUzK2Uke7XoyzQtKhwZe2fu
	 7avYQCwbR7Jtr+x1IGceh8hPOgT4HjEKGKtHcCUBfD1dalu8QhorvBDSsUJ8mdPhUk
	 h2Pf6D8PYK17FO4mJ489Kmww6ML2A5VSZ5HlW7kY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfBRNqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730733AbfBRNqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F587217F5;
        Mon, 18 Feb 2019 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497568;
        bh=0k9pf4DvBtMAW82BMoRJoqlnok2BwbapYvBE/9Ymo9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VziJT4C0+E2zfbRIE6kVV8ip13C0DiKzynVLca+ULtg9vLAI9eTHjOuvy2g/efk5r
         gPv2Qciwgms70XeO4wqxV0q2ptsRqdjkbyAJt7eZKJKZ50BjE/VL7JFB6Dcw/He5gl
         Yo3hzOEx3bl8v88JQDz8yJCFVRxqD6zHUrpFq6I8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 32/92] ARM: dts: da850-evm: Correct the audio codec regulators
Date:   Mon, 18 Feb 2019 14:42:35 +0100
Message-Id: <20190218133457.748846790@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



