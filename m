Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFD7C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0960C20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="shzvbxIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0960C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeLKTMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:12:15 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44397 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLKTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:12:14 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBJCDTf069973;
        Tue, 11 Dec 2018 13:12:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544555533;
        bh=g1Gu1tvMv1Y9EMPNKEnhoJEhOF9s2cZZX0dAjPhIBK4=;
        h=From:To:CC:Subject:Date;
        b=shzvbxIn9zf1+v7iCuyQYx6Fc87jJB+m1OoklhHfC/kxIHPQgcmc8c70K/6z0QBHk
         JZYkSzdn7wGRc8xu9YahLYf/7Bju/NoSDqHxxaK7hHLqH2d51LITrHACYSfsOGCJJr
         BCY3NDfEWi+z4SDZwJqoXpnL8Cq8XnIqMhnIEg7I=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBJCCSx127630
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 13:12:13 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 13:12:12 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 13:12:12 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBJCCNl008718;
        Tue, 11 Dec 2018 13:12:12 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.100.89])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wBBJCCU05298;
        Tue, 11 Dec 2018 13:12:12 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 1/4] iio: ti-ads124s08: Add DT binding documentation
Date:   Tue, 11 Dec 2018 13:12:04 -0600
Message-ID: <20181211191207.21900-1-dmurphy@ti.com>
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

v2 - Fixed incorrect compatible example and removed vref-supply - https://lore.kernel.org/patchwork/patch/1021047/

 .../bindings/iio/adc/ti-ads124s08.txt         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
new file mode 100644
index 000000000000..6993e76e61c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
@@ -0,0 +1,23 @@
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
+ - reset-gpios: GPIO pin used to reset the device.
+
+Example:
+adc@0 {
+	compatible = "ti,ads124s08";
+	reg = <0>;
+	spi-max-frequency = <1000000>;
+	spi-cpha;
+	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+};
-- 
2.20.0.rc2.7.g965798d1f2

