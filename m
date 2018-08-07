Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874C8C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B2E21885
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LATccLrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B2E21885
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389200AbeHGSTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:19:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57936 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGSTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:19:52 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w77G4qxU035922;
        Tue, 7 Aug 2018 11:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533657892;
        bh=ZwxdefT9hmBdDGuZvOa8UUJrMZ1KZEX8jND7UKNJnGs=;
        h=From:To:CC:Subject:Date;
        b=LATccLrPiAAMBnubFSY9vfMtrSrfT4+bjo0oeEagkA4yPy9s8PBURogaf/Hr6R5AA
         W3T7BzPcpfKcvnL9+eczqhiLKO1AKUVOSug0A3kr+qiuKe4VEC0W69qxMqFNOATXmL
         fObFeEpoPnBxn3O+bEFzC/eTJK3Sum2j8tNJTMuE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w77G4qOd032123;
        Tue, 7 Aug 2018 11:04:52 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 7 Aug
 2018 11:04:51 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 7 Aug 2018 11:04:51 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w77G4pc2003532;
        Tue, 7 Aug 2018 11:04:51 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.157.47])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w77G4px02685;
        Tue, 7 Aug 2018 11:04:51 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697 driver
Date:   Tue, 7 Aug 2018 11:04:41 -0500
Message-ID: <20180807160442.8937-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree bindings for the lm3697
led driver for backlighting and display.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/

 .../devicetree/bindings/leds/leds-lm3697.txt  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
new file mode 100644
index 000000000000..7b8e490f1ea1
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
@@ -0,0 +1,64 @@
+* Texas Instruments - LM3697 Highly Efficient White LED Driver
+
+The LM3697 11-bit LED driver provides high-
+performance backlight dimming for 1, 2, or 3 series
+LED strings while delivering up to 90% efficiency.
+
+This device is suitable for Display and Keypad Lighting
+
+Required properties:
+	- compatible:
+		"ti,lm3967"
+	- reg :  I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+	- control-bank-cfg - : Indicates which sink is connected to which control bank
+		0 - All HVLED outputs are controlled by bank A
+		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
+		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
+		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
+		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
+		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
+		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
+		7 - All HVLED outputs are controlled by bank B
+
+Optional properties:
+	- enable-gpios : gpio pin to enable/disable the device.
+	- vled-supply : LED supply
+
+Required child properties:
+	- reg : 0 - LED is Controlled by bank A
+		1 - LED is Controlled by bank B
+
+Optional child properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+
+led-controller@36 {
+	compatible = "ti,lm3967";
+	reg = <0x36>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vbatt>;
+	control-bank-cfg = <0>;
+
+	led@0 {
+		reg = <0>;
+		label = "white:first_backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		label = "white:second_backlight_cluster";
+		linux,default-trigger = "frontlight";
+	};
+}
+
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lm3697.pdf
-- 
2.17.0.582.gccdcbd54c

