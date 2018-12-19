Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D588C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF4B218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="olsTHawL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeLSQ0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:26:39 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33056 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeLSQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:26:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJGQUSK073976;
        Wed, 19 Dec 2018 10:26:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545236790;
        bh=/LSjOsRNH5QRTZ7BuqhedU9db9iQlFt46tuC87SEf5Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=olsTHawLId0Spcsgx1AgL9sc57fQy1Zmpgl0RScXB5KjBONvBTTTtCZw7MF3UbgnY
         MDa6hVPDyaca0yKsikCKThZudpE5AmgqZewf4WnPiS7YbcC3enIx3vhpYjKF6rToIA
         DmAtBuOuf2MQZ2QtEif7nJvmwYDXZJ+IKptJxSAY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJGQUoH040872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 10:26:30 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 10:26:30 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 10:26:30 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJGQUCZ001694;
        Wed, 19 Dec 2018 10:26:30 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.111.148])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wBJGQTU26344;
        Wed, 19 Dec 2018 10:26:29 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt: bindings: lp5024: Introduce the lp5024 and lp5018 RGB driver
Date:   Wed, 19 Dec 2018 10:26:25 -0600
Message-ID: <20181219162626.12297-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181219162626.12297-1-dmurphy@ti.com>
References: <20181219162626.12297-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the bindings for the Texas Instruments LP5024 and the LP5018
RGB LED device driver.  The LP5024/18 can control RGB LEDs individually
or as part of a control bank group.  These devices have the ability
to adjust the mixing control for the RGB LEDs to obtain different colors
independent of the overall brightness of the LED grouping.

Datasheet:
http://www.ti.com/lit/ds/symlink/lp5024.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lp5024.txt b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
new file mode 100644
index 000000000000..9567aa6f7813
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
@@ -0,0 +1,63 @@
+* Texas Instruments - LP5024/18 RGB LED driver
+
+The LM3692x is an ultra-compact, highly efficient,
+white-LED driver designed for LCD display backlighting.
+
+The main difference between the LP5024 and L5018 is the number of
+RGB LEDs they support.  The LP5024 supports twenty four strings while the
+LP5018 supports eighteen strings.
+
+Required properties:
+	- compatible:
+		"ti,lp5018"
+		"ti,lp5024"
+	- reg :  I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Optional properties:
+	- enable-gpios : gpio pin to enable/disable the device.
+	- vled-supply : LED supply
+
+Required child properties:
+	- reg : Is the child node iteration.
+	- led-sources : LP5024 - 0 - 7
+			LP5018 - 0 - 5
+			Declares the LED string or strings that the child node
+			will control.  If ti,control-bank is set then this
+			property will contain multiple LED IDs.
+
+Optional child properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+	- ti,control-bank : Indicates that the LED strings declared in the
+			    led-sources property are grouped within a control
+			    bank for brightness and mixing control.
+
+Example:
+
+led-controller@28 {
+	compatible = "ti,lp5024";
+	reg = <0x28>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vbatt>;
+
+	led@0 {
+		reg = <0>;
+		led-sources = <1>;
+	};
+
+	led@1 {
+		reg = <1>;
+		led-sources = <0 6>;
+		ti,control-bank;
+	};
+
+}
+
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lp5024.pdf
-- 
2.20.0.rc2.7.g965798d1f2

