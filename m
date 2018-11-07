Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68550C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4702081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4702081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbeKHCkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:40:10 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:35321 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeKHCkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:40:09 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42qtDN2zKNz1qwHy;
        Wed,  7 Nov 2018 18:08:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42qtDN1rW8z1qrn2;
        Wed,  7 Nov 2018 18:08:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id v5qSsqEu69pD; Wed,  7 Nov 2018 18:08:50 +0100 (CET)
X-Auth-Info: WiNfnnfLcZ/YXbHQ3H5zm+LZEJbkmGVVh/JbvFi3GsU=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  7 Nov 2018 18:08:50 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v7 2/2] iio: light: Add device tree binding for vishay vcnl4035
Date:   Wed,  7 Nov 2018 18:08:21 +0100
Message-Id: <20181107170821.1171886-2-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181107170821.1171886-1-pn@denx.de>
References: <20181107170821.1171886-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding device tree binding for vcnl4035 and vendor
prefix for Vishay Intertechnology

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changelog in v4:
    - commit message fix
    - same indexing/space in binding
    
    Changelog in v3:
    - removed interrupt-parent property reference in documentation
    - renamed vcnl4035 to light-sensor

 .../devicetree/bindings/iio/light/vcnl4035.txt | 18 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt    |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
new file mode 100644
index 000000000000..c07c7f052556
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
@@ -0,0 +1,18 @@
+VISHAY VCNL4035 -  Ambient Light and proximity sensor
+
+Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
+
+Required properties:
+
+	-compatible: should be "vishay,vcnl4035"
+	-reg: I2C address of the sensor, should be 0x60
+	-interrupts: interrupt mapping for GPIO IRQ (level active low)
+
+Example:
+
+light-sensor@60 {
+	compatible = "vishay,vcnl4035";
+	reg = <0x60>;
+	interrupt-parent = <&gpio4>;
+	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..3c5e0c6f6cee 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -415,6 +415,7 @@ vamrs	Vamrs Ltd.
 variscite	Variscite Ltd.
 via	VIA Technologies, Inc.
 virtio	Virtual I/O Device Specification, developed by the OASIS consortium
+vishay	Vishay Intertechnology, Inc
 vitesse	Vitesse Semiconductor Corporation
 vivante	Vivante Corporation
 vocore VoCore Studio
-- 
2.17.2

