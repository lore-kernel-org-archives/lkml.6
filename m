Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DE9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D114920676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SzSRE+Ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D114920676
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeIZTXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:23:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37564 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIZTWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:22:48 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QD9peQ007653;
        Wed, 26 Sep 2018 08:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537967391;
        bh=4HhnUTHee9Xjhob+0dNdMrGz/S1MYMjSYmFeZeYcDwE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SzSRE+Yah58aTzuxSLK6bOqPOTkn92UqiVRS4PyObZS43SJvza0g1NLLZuU6hzc4F
         ecfCuolAyD5qmmQ6DjtJsBDS//pYylVBT6+l+Yhr1NQI3I/grahpZN3yyjpkXYZoid
         wJd09iESO93gVyiWTY53pUHMK6DlEPh5tKqrFGck=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9pvq021367;
        Wed, 26 Sep 2018 08:09:51 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 08:09:51 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 08:09:50 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9ohh023742;
        Wed, 26 Sep 2018 08:09:50 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.176.238])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8QD9ox11655;
        Wed, 26 Sep 2018 08:09:50 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 8/9] dt-bindings: leds: Add the LM3632 LED dt binding
Date:   Wed, 26 Sep 2018 08:09:20 -0500
Message-ID: <20180926130921.12329-9-dmurphy@ti.com>
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

Add the TI LM3632 LED binding.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/leds/leds-lm3632.txt  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3632.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3632.txt b/Documentation/devicetree/bindings/leds/leds-lm3632.txt
new file mode 100644
index 000000000000..1befd17174ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3632.txt
@@ -0,0 +1,53 @@
+* Texas Instruments - lm3632 Single-Chip Backlight and 1.5-A Flash LED Driver
+
+The LM3632A integrates LED drivers for both
+the backlight of the LCD panel and the camera flash
+along with the bias power for the LCD panel into one
+device.
+
+Required properties:
+	- compatible : Can be one of the following
+		"ti,lm3632"
+	- reg : I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Required child properties:
+	- reg : 0 - Indicates a backlight mode
+		1 - Indicates a Torch/Strobe (white LED) mode
+
+Required properties for flash LED child nodes:
+	See Documentation/devicetree/bindings/leds/common.txt
+	- flash-max-microamp : Range from 100mA - 1.5A
+	- flash-max-timeout-us : Range from 32ms - 1024ms
+	- led-max-microamp : Range from 25mA - 375mA
+
+Optional child properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+led-controller@11 {
+	compatible = "ti,lm3632";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x11>;
+
+	led@0 {
+		reg = <0>;
+		label = "white:backlight";
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		label = "white:torch";
+		led-max-microamp = <375000>;
+		flash-max-microamp = <1500000>;
+		flash-max-timeout-us = <1000000>;
+	};
+}
+
+For more product information please see the links below:
+http://www.ti.com/product/LM3632
-- 
2.19.0

