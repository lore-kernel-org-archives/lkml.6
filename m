Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDFA2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501133;
	bh=kSzJd+3sIdJQWuww93jKHd9VHKiS55/5CuxEiWTwV60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h99YtDLwc6M/21WGrCwHmwXxSWEqrZBw/2uKq9XbN3c1fQyDu5RfIHR7x9R6MzF7A
	 geENp5XtNJUc+Z4lvuUPF43ZbbwMTDURw20WCERPCjLmG3xFm1EYnlz2WORd+F88Ob
	 FAPn2X/YwDePFKO58jlgHFUqUB5t0HvOEdeyx4gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbfBROpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbfBRNrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7367F218FC;
        Mon, 18 Feb 2019 13:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497652;
        bh=kSzJd+3sIdJQWuww93jKHd9VHKiS55/5CuxEiWTwV60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnEqoVaIw0yliQnJf1DI5n4rL4W6oF8a4MUyesJ20DuqNnYHoRBDxA7b1fWAWu3l+
         RxtkYOv6VFdxWuapAeWOQ4Ukrotfo+K1YULGXwQ3YnXG0evZjjQXSKcXX9owJg4q9R
         42E2dvkiOTFECUd4/YL207MYaX8/Ae3jq7CMKBNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 34/92] ARM: dts: da850-lcdk: Correct the audio codec regulators
Date:   Mon, 18 Feb 2019 14:42:37 +0100
Message-Id: <20190218133457.931314874@linuxfoundation.org>
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



