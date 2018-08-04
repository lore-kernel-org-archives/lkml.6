Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B77C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B123217B7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B123217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHDJDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 05:03:48 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:59333 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHDJDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 05:03:48 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 7B84F664FD;
        Sat,  4 Aug 2018 07:04:10 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id C37C288E31;
        Sat,  4 Aug 2018 07:04:09 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 4566F15D4E;
        Sat,  4 Aug 2018 07:04:08 +0000 (UTC)
        (envelope-from manu@freebsd.org)
From:   Emmanuel Vadot <manu@freebsd.org>
To:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH 1/7] dt-bindings: Add DT bindings documentation for Allwinner Thermal Sensor Controller
Date:   Sat,  4 Aug 2018 09:03:49 +0200
Message-Id: <20180804070355.14857-1-manu@freebsd.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation for Device-Tree bindings for the Allwinner
Thermal Sensor Controller found on the H3, H5 and A64 SoCs

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 .../bindings/thermal/allwinner-thermal.txt    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/allwinner-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/allwinner-thermal.txt b/Documentation/devicetree/bindings/thermal/allwinner-thermal.txt
new file mode 100644
index 000000000000..5810d44cf495
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/allwinner-thermal.txt
@@ -0,0 +1,41 @@
+* Thermal Sensor Controller on Allwinner SoCs
+
+Required properties:
+- compatible : should be "allwinner,<name>-ths"
+   "allwinner,sun8i-h3-ths": found on H3 and H2+ SoCs
+   "allwinner,sun50i-h5-ths": found on H5 SoC
+   "allwinner,sun50i-a64-ths": found on H5 SoC
+- reg : physical base address of the controller and length of memory mapped
+	region.
+- interrupts : The interrupt number to the cpu. The interrupt specifier format
+	       depends on the interrupt controller.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Shall be "apb" for the bus, and "ths" for
+		the peripheral clock.
+- resets : Must contain an entry for each entry in reset-names.
+	   See ../reset/reset.txt for details.
+- reset-names : Must be "apb".
+- #thermal-sensor-cells : Depend on the SoC
+   For H3 should be 0
+   For H5 should be 1
+   For A64 should be 2
+   See ./thermal.txt for a description.
+- nvmem-cells : Phandle to the calibration data
+- nvmem-cell-names = Should be "ths-calib"
+
+Example:
+
+ths: thermal_sensor@1c25000 {
+	compatible = "allwinner,sun8i-h3-ths";
+	reg = <0x01c25000 0x100>;
+	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+	clock-names = "apb", "ths";
+	resets = <&ccu RST_BUS_THS>;
+	reset-names = "apb";
+	#thermal-sensor-cells = <0>;
+	status = "disabled";
+
+	nvmem-cells = <&ths_calib>;
+	nvmem-cell-names = "ths-calib";
+};
-- 
2.18.0

