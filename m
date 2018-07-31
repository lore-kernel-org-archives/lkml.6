Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C33C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30D8208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="lZsMQYXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30D8208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbeGaIwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:52:38 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.120]:22662 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731812AbeGaIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021108;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=GR07VrPMtLalDspEAzwbk6I9eXKCstK/rDvm8VRsuls=;
        b=lZsMQYXp6CfvscARPt9hCZUj5RWEh71nTLaijLuVEKucwZmYN/PqT5bgU1fyUj9TPO
        JP0Z1p9fjqdcPE/tHP1jN6KuKMJnBIX+CNpKt1SvabN8BbLKK7acdFt7ify6Zv+pmre3
        BZN4A0DJ5MKFwzSWDRhYu1KvRikcRIjn7GvovEovNTOdZgTxzpF1CUeHqyEdgzjN7Z6X
        NABpkpr5W+EABLkYa1Mmw3p9icdwoRwccamy2mtVyVzNiPg0oHjvR0PCJCy7/lhDETn9
        Wjtj/pGSRuEOjm24FdtF8nbzGmFp/DzJZqThq6tIBQk1D/TNoRZT4ddLTtkNrWKMbMip
        xXgw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BlwOw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:47 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 30/32] ARM: dts: omap3-gta04a5: uses different sensors than gta04a4
Date:   Tue, 31 Jul 2018 09:11:33 +0200
Message-Id: <e26890fd9fcc33b87454eb92324207ac5f0bc092.1533021094.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sensors for acceleration, rotation, magnetic heading and
barometer have been replaced in the A5 variant.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index 453a87ebb860..973d07d0b4c8 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -105,3 +105,30 @@
 		ref-clock-frequency = <26000000>;
 	};
 };
+
+&i2c2 {
+	/delete-node/ bmp085@77;
+	/delete-node/ bma180@41;
+	/delete-node/ itg3200@68;
+	/delete-node/ hmc5843@1e;
+
+	bmg160@69 {
+		compatible = "bosch,bmg160";
+		reg = <0x69>;
+	};
+
+	bmc150@10 {
+		compatible = "bosch,bmc150_accel";
+		reg = <0x10>;
+	};
+
+	bmc150@12 {
+		compatible = "bosch,bmc150_magn";
+		reg = <0x12>;
+	};
+
+	bme280@76 {
+		compatible = "bosch,bme280";
+		reg = <0x76>;
+	};
+};
-- 
2.12.2

