Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17835C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD21821B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C7vQ+4AY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438118AbfBNS2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:28:43 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53142 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394268AbfBNS2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:28:19 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1EISD8c055186;
        Thu, 14 Feb 2019 12:28:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550168893;
        bh=YsjwZpbQbe0xs1O7DEzDwnvSqaLup+bjvAEDOMyIzpc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C7vQ+4AYV5wWAZEKWUGIzPn4hbW0xV+dgvBLgxgRSb/AAGQEdHzVmuS43dbzTIqX2
         JzBpEs3mvgj/Tt2t0ST8wXZIFMZIvBcEIR59feTs0Sdwm7QABCdRCZBX6uxye1SJk8
         ZtE/d87wG+1s76Lbke36N4DkXU7pmmQUmF2vLgOE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1EISDlP117652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 12:28:13 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 12:28:12 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 12:28:12 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1EISCaH011782;
        Thu, 14 Feb 2019 12:28:12 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.120.181])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x1EISCU11376;
        Thu, 14 Feb 2019 12:28:12 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 4/5] dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
Date:   Thu, 14 Feb 2019 12:27:53 -0600
Message-ID: <20190214182754.30721-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190214182754.30721-1-dmurphy@ti.com>
References: <20190214182754.30721-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding documentation for TI TCAN4x5x driver.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v5 - No changes - https://lore.kernel.org/patchwork/patch/1033097/

 .../devicetree/bindings/net/can/tcan4x5x.txt  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
new file mode 100644
index 000000000000..781c19887538
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -0,0 +1,37 @@
+Texas Instruments TCAN4x5x CAN Controller
+================================================
+
+This file provides device node information for the TCAN4x5x interface contains.
+
+Required properties:
+	- compatible: "ti,tcan4x5x"
+	- reg: 0
+	- #address-cells: 1
+	- #size-cells: 0
+	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
+			     operate at should be less than or equal to 18 MHz.
+	- data-ready-gpios: Interrupt GPIO for data and error reporting.
+	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
+	- device-state-gpios: Input GPIO that indicates if the device is in
+			      a sleep state or if the device is active.
+
+See Documentation/devicetree/bindings/net/can/m_can.txt for additional
+required property details.
+
+Optional properties:
+	- reset-gpios: Hardwired output GPIO. If not defined then software
+		       reset.
+
+Example:
+tcan4x5x: tcan4x5x@0 {
+		compatible = "ti,tcan4x5x";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <10000000>;
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+		data-ready-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+};
-- 
2.20.1.390.gb5101f9297

