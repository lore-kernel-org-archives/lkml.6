Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E91CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED46B21761
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i87sBhcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED46B21761
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeHCQ7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:59:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57878 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbeHCQ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:59:20 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w73F2aBs071623;
        Fri, 3 Aug 2018 10:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533308556;
        bh=KDy998hrVVb3vinrnEoFj4S71//k/nYLMnh7XYNp+DM=;
        h=From:To:CC:Subject:Date;
        b=i87sBhcWsOL5/84WCGbP7vPfWmvBpzyvqsulGP4u3wtxMCOEJBwf2De/gMQ3XXESL
         ghi80ZPC6MI92Q3Ksgh1VU8qOuO5mvkh7Zwodg4SE6dbN0/2z0Otg7+zGNmdn/J8uQ
         KFgU+yZKcr34z8FswH/iNufebb54FiShS85LOCys=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w73F2aEM020605;
        Fri, 3 Aug 2018 10:02:36 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 3 Aug
 2018 10:02:35 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 3 Aug 2018 10:02:35 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w73F2Zk3019504;
        Fri, 3 Aug 2018 10:02:35 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.161.114])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w73F2Zx08534;
        Fri, 3 Aug 2018 10:02:35 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] di: bindings: lm3697: Introduce the lm3697 driver
Date:   Fri, 3 Aug 2018 10:02:30 -0500
Message-ID: <20180803150231.7172-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the device tree bindings for the lm3697
led driver for backlighting and display.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
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

