Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EEBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D557320841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kmp7wS2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D557320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeHaXnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:43:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37154 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeHaXnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:43:12 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJY4ss111244;
        Fri, 31 Aug 2018 14:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535744044;
        bh=ygJ+v9ZqvPZcffqfc5EcC/F/KuFpj2k8g1wTVtvmHPY=;
        h=From:To:CC:Subject:Date;
        b=Kmp7wS2o55zTC8bNMDOLaqkxX5KJ0U4GR8FGbB/5P1P9pDo3T8zVkx+eafBerA/hE
         VhZL8ZCcvRuAxSLn1IoC1LV6Y97z1vlo13vUGQoHpj34fZ3MXTqYBFpsgQF6YLr3+r
         yU/LxLl0+6C+Cq0xr4aQ+cIPtqFLkg6TFyoMNdwc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJY4p3026758;
        Fri, 31 Aug 2018 14:34:04 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:34:04 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:34:04 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJY4u9031564;
        Fri, 31 Aug 2018 14:34:04 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJY3x15921;
        Fri, 31 Aug 2018 14:34:03 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 1/3] ARM: dts: am571x-idk: Add tricolor Industrial LED support
Date:   Fri, 31 Aug 2018 14:34:01 -0500
Message-ID: <20180831193403.26777-1-afd@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM571x-IDK rev 1.2A has tricolor RGB LEDs that can be controlled using
GPIO. Expose these to userspace for usage as necessary.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index d9a2049a1ea8..a206f3e344d7 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -64,6 +64,82 @@
 			linux,default-trigger = "mmc0";
 		};
 	};
+
+	idk-leds {
+		status = "disabled";
+		compatible = "gpio-leds";
+		red0-led {
+			label = "idk:red0";
+			gpios = <&gpio6 19 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green0-led {
+			label = "idk:green0";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue0-led {
+			label = "idk:blue0";
+			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		red1-led {
+			label = "idk:red1";
+			gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green1-led {
+			label = "idk:green1";
+			gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue1-led {
+			label = "idk:blue1";
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		red2-led {
+			label = "idk:red2";
+			gpios = <&gpio7 9 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green2-led {
+			label = "idk:green2";
+			gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue2-led {
+			label = "idk:blue2";
+			gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		red3-led {
+			label = "idk:red3";
+			gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green3-led {
+			label = "idk:green3";
+			gpios = <&gpio7 25 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		blue3-led {
+			label = "idk:blue3";
+			gpios = <&gpio7 24 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
 };
 
 &extcon_usb2 {
-- 
2.18.0

