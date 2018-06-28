Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E8CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6713C21477
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6713C21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935318AbeF1MbA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:31:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44935 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932371AbeF1Ma5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:30:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41GfJc0d89z1qx8s;
        Thu, 28 Jun 2018 14:30:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41GfJb6W3dz1qqkc;
        Thu, 28 Jun 2018 14:30:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Gflr7UYQKIkS; Thu, 28 Jun 2018 14:30:49 +0200 (CEST)
X-Auth-Info: h3NygOKCiPXAqS/WVP84WIJOpwHX3h7Q9bjXXquL3wY=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 28 Jun 2018 14:30:49 +0200 (CEST)
From:   Parthiban Nallathambi <pn@denx.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH 2/2] iio: light: Add device tree binding for vishay vcnl4035
Date:   Thu, 28 Jun 2018 14:30:21 +0200
Message-Id: <20180628123021.1628338-2-pn@denx.de>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628123021.1628338-1-pn@denx.de>
References: <20180628123021.1628338-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding device tree binding for vcnl4035 and vendor
prefix for Vishay Intertechnology

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 .../devicetree/bindings/iio/light/vcnl4035.txt        | 19 +++++++++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
new file mode 100644
index 000000000000..7ffdc0246300
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
@@ -0,0 +1,19 @@
+VISHAY VCNL4035 -  Ambient Light and proximity sensor
+
+Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
+
+Required properties:
+
+	-compatible: should be "vishay,vcnl4035"
+	-reg: I2C address of the sensor, should be 0x60
+	- interrupt-parent: should be the phandle for the interrupt controller
+	- interrupts: interrupt mapping for GPIO IRQ (level active low)
+
+Example:
+
+vcnl4035@60 {
+	compatible = "vishay,vcnl4035";
+	reg = <0x60>;
+	interrupt-parent = <&gpio4>;
+	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad066191ee..3cc46d5735a9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -395,6 +395,7 @@ v3	V3 Semiconductor
 variscite	Variscite Ltd.
 via	VIA Technologies, Inc.
 virtio	Virtual I/O Device Specification, developed by the OASIS consortium
+vishay	Vishay Intertechnology, Inc
 vivante	Vivante Corporation
 vocore VoCore Studio
 voipac	Voipac Technologies s.r.o.
-- 
2.14.4

