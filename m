Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1767CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A972086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="klT+euW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A972086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeIKBIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:08:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33096 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeIKBIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:08:46 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8AKCoxc116948;
        Mon, 10 Sep 2018 15:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536610370;
        bh=NpOfsU5ZsxnrqjCmCUWaxikiWFKsH97Gl9NXdvubZSA=;
        h=From:To:CC:Subject:Date;
        b=klT+euW+Il0qLe1h04OKdnRLrcu1rJWJ6VJRcQ21aE3298swucCnz2I1HfUCezQcz
         sin6QSi1YNjqbwwLxmc9bm8ftTacwRcSWgdTZnuoN1LNJJiLtVK53wV2ms15AVnjFM
         Q/qJH/pBwq7AiyZNZweKddNM7Rz3i6W7tMVIi3NA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8AKCoIR003201;
        Mon, 10 Sep 2018 15:12:50 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 10
 Sep 2018 15:12:50 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 10 Sep 2018 15:12:50 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8AKCnPg021574;
        Mon, 10 Sep 2018 15:12:50 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.175.150])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8AKCnx05726;
        Mon, 10 Sep 2018 15:12:49 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
Date:   Mon, 10 Sep 2018 15:12:40 -0500
Message-ID: <20180910201241.24092-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
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
 .../devicetree/bindings/net/can/tcan4x5x.txt  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
new file mode 100644
index 000000000000..3eea2f2bb8a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -0,0 +1,33 @@
+Texas Instruments TCAN4x5x CAN Controller
+================================================
+
+This file provides device node information for the TCAN4x5x interface contains.
+
+Required properties:
+	- compatible: "ti,tcan4x5x"
+	- reg: 0
+	- #address-cells : 1
+	- #size-cells : 0
+	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
+			     operate at should be less than or equal to 18 MHz.
+	- data-ready-gpios: Interrupt GPIO for data and error reporting. 
+	- wake-up-gpios: Wake up GPIO to wake up the TCAN device
+
+Optional properties:
+	- clocks: Processor clock phandles (see clock bindings for details)
+		  If no clock is defined then the default 40MHz freq is set.
+	- reset-gpios: Hardwired output GPIO. If not defined then software
+		       reset.
+
+Example:
+tcan4x5x: tcan4x5x@0 {
+		compatible = "ti,tcan4x5x";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&tclkin_ck>;
+		spi-max-frequency = <10000000>;
+		data-ready-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+		wake-up-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+	};
-- 
2.17.0.1855.g63749b2dea

