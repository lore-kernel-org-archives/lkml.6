Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDDEC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C8B2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jK8F+2Uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfAKT5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:57:22 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33746 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfAKT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:57:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BJvKGD098702;
        Fri, 11 Jan 2019 13:57:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547236640;
        bh=XC/TOnaoY1Kxf8eT4PNhV6VhfPKTETz4rPDtGj0hPlQ=;
        h=From:To:CC:Subject:Date;
        b=jK8F+2Uq3hADZRHaVjSZowT4UInpIIXdp/qIjxcM4X49moS4K3u3tpFjvCCYHp6mn
         WLPIcQ+HkQJ3kwKv6gsdDv0en57hCXQutDJLVtgX/mnvi5RRDJfk7ADOWBrfE9xKNA
         gC1n2QNscuo3f4yDXfFdRV4D7yO9wqpZqg4dVfwE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BJvKgc001113
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 13:57:20 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 13:57:20 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 13:57:20 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BJvK3F031019;
        Fri, 11 Jan 2019 13:57:20 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.73.213])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BJvJU18761;
        Fri, 11 Jan 2019 13:57:19 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 1/3] iio: ti-ads124s08: Add DT binding documentation
Date:   Fri, 11 Jan 2019 13:57:05 -0600
Message-ID: <20190111195707.2086-1-dmurphy@ti.com>
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

v3 - Fixed the compatible made the colon spacing consistent - https://lore.kernel.org/patchwork/patch/1023969/
v2 - Fixed incorrect compatible example and removed vref-supply - https://lore.kernel.org/patchwork/patch/1021047/

 .../bindings/iio/adc/ti-ads124s08.txt         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
new file mode 100644
index 000000000000..ecf807bb32f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
@@ -0,0 +1,25 @@
+* Texas Instruments' ads124s08 and ads124s06 ADC chip
+
+Required properties:
+ - compatible :
+	"ti,ads124s08"
+	"ti,ads124s06"
+ - reg : spi chip select number for the device
+
+Recommended properties:
+ - spi-max-frequency : Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+ - spi-cpha : Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+ - reset-gpios : GPIO pin used to reset the device.
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
2.20.1.98.gecbdaf0899

