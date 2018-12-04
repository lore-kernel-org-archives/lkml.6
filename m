Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC01C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E42B2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qm6WNx/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E42B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeLDSAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:00:08 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37680 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeLDSAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:00:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB4I05lc024478;
        Tue, 4 Dec 2018 12:00:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543946406;
        bh=9V25X/s/7z9j5DxzpgBZfsq8q4Yjw8TDD4F1Bwxzkow=;
        h=From:To:CC:Subject:Date;
        b=qm6WNx/Hi45VCm6mbRcSSpYIPbLvIwdfcsnjcZtUpSLNKKtKz0ZQz3M/tiU0EFgY/
         p66s+axNM+2ihN8zCI9CAReYQuWw+MuboqFUaJ4wKsW+GbxXB0lv2E4+YIjEXr0Nb0
         Q5jEV7Z52PTFQPeTSi32yqp/sVA0jkM+4oBfX9Ow=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB4I05Ec008996
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 12:00:05 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 12:00:05 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 12:00:05 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB4I05ZZ017924;
        Tue, 4 Dec 2018 12:00:05 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.101.186])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wB4I04U27060;
        Tue, 4 Dec 2018 12:00:04 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] iio: ti-ads124s08: Add DT binding documentation
Date:   Tue, 4 Dec 2018 11:59:54 -0600
Message-ID: <20181204175955.8259-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding binding documentation for Texas Instruments ADS124S08
and ADS124S06 ADC.

S08 is a 12 channel ADC
S06 is a 6 channel ADC

Datesheet can be found here:
http://www.ti.com/lit/gpn/ads124s08

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/iio/adc/ti-ads124s08.txt         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
new file mode 100644
index 000000000000..41ab67379ee1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
@@ -0,0 +1,25 @@
+* Texas Instruments' ads124s08 and ads124s06 ADC chip
+
+Required properties:
+ - compatible: Should be "ti,ads124s08" or "ti,ads124s06"
+ - reg: spi chip select number for the device
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+ - spi-cpha: Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+ - vref-supply: The regulator supply for ADC reference voltage
+ - reset-gpios: GPIO pin used to reset the device.
+
+Example:
+adc@0 {
+	compatible = "ti,ads8688";
+	reg = <0>;
+	vref-supply = <&vdd_supply>;
+	spi-max-frequency = <1000000>;
+	spi-cpha;
+	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+};
-- 
2.20.0.rc1.10.g7068cbc4ab

