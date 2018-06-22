Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD513C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D79124082
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HeFnNsYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D79124082
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932968AbeFVKoa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:44:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59002 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeFVKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:44:28 -0400
X-Greylist: delayed 1677 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jun 2018 06:44:28 EDT
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5MAGPm9044071;
        Fri, 22 Jun 2018 05:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529662585;
        bh=56ekOV6VA3aR+GHFwQWLfnVzLudJ+eyQsWjORFa8TqM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HeFnNsYeuwRAQ3IiXrM00ooSqYg9Zj6OQS63I/4P3VO2UfXFQXJjg3iUl6Y5BATb8
         bxiXWdFBMjS1ZFtiRbPbQy1LexCRzfmQO7ILLiDZYukWH3RACpa5FoZrh5E6c941mb
         sGpC6ToO4rWtCbS5UvueFhgtVko99VbryRkYAAXo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MAGO3f011819;
        Fri, 22 Jun 2018 05:16:25 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 22
 Jun 2018 05:16:24 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 22 Jun 2018 05:16:24 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MAGI3T032544;
        Fri, 22 Jun 2018 05:16:22 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>, <kishon@ti.com>
CC:     <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH RESEND 1/3] ARM: dts: keystone-k2g-evm: Add "vqmmc-supply" property for mmc0/mmc1
Date:   Fri, 22 Jun 2018 15:46:15 +0530
Message-ID: <20180622101617.11157-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622101617.11157-1-kishon@ti.com>
References: <20180622101617.11157-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "vqmmc-supply" property for mmc0/mmc1 to indicate the supply connected
to the IO lines. Also add dt node for ldo1 regulator required for mmc1
vqmmc-supply.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 154fdd7a7022..ba030c496f51 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -37,6 +37,14 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	vcc1v8_ldo1_reg: fixedregulator-vcc1v8-ldo1 {
+		compatible = "regulator-fixed";
+		regulator-name = "ldo1";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
 };
 
 &k2g_pinctrl {
@@ -144,6 +152,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&vcc3v3_dcin_reg>;
+	vqmmc-supply = <&vcc3v3_dcin_reg>;
 	cd-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
@@ -152,6 +161,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vcc3v3_dcin_reg>; /* VCC3V3_EMMC is connected to VCC3V3_DCIN */
+	vqmmc-supply = <&vcc1v8_ldo1_reg>;
 	ti,non-removable;
 	status = "okay";
 };
-- 
2.17.1

