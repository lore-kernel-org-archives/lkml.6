Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC20C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2945821709
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="dCFR4ZT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2945821709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeHCCMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:12:41 -0400
Received: from onstation.org ([52.200.56.107]:34042 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeHCCMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:12:40 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id BFE102A10;
        Fri,  3 Aug 2018 00:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1533255545;
        bh=NFrl+H1XPDXYImUuzA2UQWaoeXL0nZv7HfVcp0lprw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCFR4ZT0g/R5MvEykfcCJLy/AIrhJfvgqfjuzBbxm+1dSl6uIeB+DVDoFfqNg21hJ
         iAPyzTEgE4Qwa9D34OKbXVUvN+MiHUc5CTITTnDT+ZC6mOaW4DzxW4Q59PV9C2Acwd
         C5DnfAQCIOjkNP9CisAiJ8IX4RSZhnpiyt7iQm58=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: [PATCH v3 4/9] dt-bindings: iio: tsl2772: add new bindings
Date:   Thu,  2 Aug 2018 20:18:55 -0400
Message-Id: <20180803001900.25371-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803001900.25371-1-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new properties amstaos,proximity-diodes and
led-max-microamp to the tsl2772 driver. This patch also removes the
driver from the trivial-devices.txt.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
I got a Reviewed-by: Rob Herring <robh@kernel.org> on my last series but
didn't include it due to the new file tsl2772.txt in this patch. Device
tree bindings need to be complete.

 .../devicetree/bindings/iio/light/tsl2772.txt | 37 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.txt   | 10 -----
 2 files changed, 37 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt

diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
new file mode 100644
index 000000000000..6f33169344f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
@@ -0,0 +1,37 @@
+* AMS/TAOS ALS and proximity sensor
+
+Required properties:
+
+  - compatible: Should be one of
+		"amstaos,tsl2571"
+		"amstaos,tsl2671"
+		"amstaos,tmd2671"
+		"amstaos,tsl2771"
+		"amstaos,tmd2771"
+		"amstaos,tsl2572"
+		"amstaos,tsl2672"
+		"amstaos,tmd2672"
+		"amstaos,tsl2772"
+		"amstaos,tmd2772"
+  - reg: the I2C address of the device
+
+Optional properties:
+
+  - amstaos,proximity-diodes - proximity diodes to enable. <0>, <1>, or <0 1>
+                               are the only valid values.
+  - led-max-microamp - current for the proximity LED. Must be 100000, 50000,
+                       25000, or 13000.
+  - interrupts: the sole interrupt generated by the device
+
+  Refer to interrupt-controller/interrupts.txt for generic interrupt client
+  node bindings.
+
+Example:
+
+tsl2772@39 {
+	compatible = "amstaos,tsl2772";
+	reg = <0x39>;
+	interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
+	amstaos,proximity-diodes = <0>;
+	led-max-microamp = <100000>;
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 763a2808a95c..a977ccef7230 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -21,16 +21,6 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 ams,iaq-core		AMS iAQ-Core VOC Sensor
-amstaos,tsl2571		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2671		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2671		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2771		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2771		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2572		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2672		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2672		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2772		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2772		AMS/TAOS ALS and proximity sensor
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
-- 
2.17.1

