Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2641C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9936520684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lK3Yv9cR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9936520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeIZTXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:23:04 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41820 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbeIZTWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:22:48 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QD9oot059961;
        Wed, 26 Sep 2018 08:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537967390;
        bh=SLaNrTbr5c0JIt7MHA43+1lR4bMOb4vjZXUhHH7B4oU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lK3Yv9cR6pA8ITyE6rN3dwA9Zunai1tDVk2TJyhgz55Qbxjr4X3cHiAgHw8Nb0vDd
         mR6SXjI72dDVsA4Z8J/s+rFOHrh1pZYHwf0N2QQ780g7sFQpwbjOR27l/lTHrh0q8/
         hSRvH/5lvQgErEsWk82O5qjv/PYgmXLzl9oAz5XU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9o49020255;
        Wed, 26 Sep 2018 08:09:50 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 08:09:49 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 08:09:49 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9n6I003567;
        Wed, 26 Sep 2018 08:09:49 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.176.238])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8QD9mx11647;
        Wed, 26 Sep 2018 08:09:49 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 6/9] dt-bindings: leds: Add support for the LM3633
Date:   Wed, 26 Sep 2018 08:09:18 -0500
Message-ID: <20180926130921.12329-7-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180926130921.12329-1-dmurphy@ti.com>
References: <20180926130921.12329-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the TI LM3633 LED driver.
This device has 9 control banks 3 high voltage
LED channels and 6 low voltage LED channels.

Data sheet:
http://www.ti.com/lit/ds/symlink/lm3633.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/leds/leds-lm3633.txt  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3633.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3633.txt b/Documentation/devicetree/bindings/leds/leds-lm3633.txt
new file mode 100644
index 000000000000..19571ad251ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3633.txt
@@ -0,0 +1,69 @@
+* Texas Instruments - LM3633 Lighting Power Solution for Smartphone Handsets
+
+The LM3633 is a complete power source for
+backlight, keypad, and indicator LEDs in smartphone
+handsets.
+
+This device is suitable for display and keypad Lighting
+
+Required properties:
+	- compatible:
+		"ti,lm3633"
+	- reg :  I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Optional properties:
+	- enable-gpios : GPIO pin to enable/disable the device
+	- vled-supply : LED supply
+
+Required child properties:
+	- reg : 0 - HVLED is Controlled by bank A
+		1 - HVLED is Controlled by bank B
+		2,3,4 - LVLED1, 2 and 3 are Controlled by bank C, D and E
+		5,6,7 - LVLED4, 5 and 6 are Controlled by bank F, G and H
+	- led-sources : Indicates which LED string is associated to which
+			control bank.
+			0 - LED is not active in this control bank
+			1 - LED string is controlled by this control bank
+
+Optional child properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+
+led-controller@36 {
+	compatible = "ti,lm3633";
+	reg = <0x36>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vbatt>;
+
+	led@0 {
+		reg = <0>;
+		led-sources = <1 0 1>;
+		label = "white:first_backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		led-sources = <0 1 0>;
+		label = "white:second_backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+
+	led@2 {
+		reg = <2>;
+		led-sources = <0 1 0>;
+		label = "white:indicator1";
+	};
+
+}
+
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lm3633.pdf
-- 
2.19.0

