Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D39C46465
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C356B208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="bQ7FNyHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C356B208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbeGaIuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:50:50 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.121]:22021 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732179AbeGaIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021114;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ypn1VZYtfLPJ/2OFX7+IAG5V1o1IG5l5MI+F5lKK4+s=;
        b=bQ7FNyHiwkhtnM9Cnw69cRQ67wGNwgKbxHMdbdP+wNhsIb7v3LMLsyhda6Qd/OUF6H
        IqrCrgCgCyRbjZUwOd6HChG0GfzUvClosd5cXZhep+3sR2b3FBYyoKYnJCgvwYgjFleD
        BWJDpHq6kgeh4s2uZJPMmLLP9BKapi5sudd35Naa1T+HrM6Ut8Ed92r3hqf82KfdZ2ph
        8NAldHwv7uVQ28XAH0ZW9EtrNMyUyeqEsJHG35xVxotSkrW4bYwG/40mTbz5DlbRL9pM
        USVpiD3ylCALMM+WJF05ZUxDyUAQDcoVspXHS8a6z/jycAjdYEWAtgQGF2kFVD2TKyNi
        XcRw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BmwOy
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:48 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 32/32] ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND
Date:   Tue, 31 Jul 2018 09:11:35 +0200
Message-Id: <5015c23de053719349e01912f3701d49c16952cf.1533021094.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GTA04A5 has been produced with MCP chips either with
 512MB RAM +  512MB NAND
 512MB RAM + 1024MB NAND
1024MB RAM +  512MB OneNAND

RAM setup is done by U-Boot (MLO/SPL) but OneNAND needs
a different setup of the GPMC. So we need to derive a
DTB variant that modifies the gpmc and nand setup.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5one.dts | 114 +++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-gta04a5one.dts

diff --git a/arch/arm/boot/dts/omap3-gta04a5one.dts b/arch/arm/boot/dts/omap3-gta04a5one.dts
new file mode 100644
index 000000000000..9b7bbdc344b3
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-gta04a5one.dts
@@ -0,0 +1,114 @@
+/*
+ * Copyright (C) 2014-18 H. Nikolaus Schaller <hns@goldelico.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap3-gta04a5.dts"
+
+&omap3_pmx_core {
+	model = "Goldelico GTA04A5/Letux 2804 with OneNAND";
+
+	gpmc_pins: pinmux_gpmc_pins {
+		pinctrl-single,pins = <
+
+			/* address lines */
+			OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
+			OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
+			OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
+
+			/* data lines, gpmc_d0..d7 not muxable according to TRM */
+			OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
+			OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
+			OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
+			OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
+			OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
+			OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
+			OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
+			OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
+
+			/*
+			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, gpmc_wait0 not muxable
+			 * according to TRM. OneNAND seems to require PIN_INPUT on clock.
+			 */
+			OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
+			OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
+		>;
+	};
+};
+
+&gpmc {
+	/* switch inherited setup to OneNAND */
+
+	ranges = <0 0 0x04000000 0x1000000>;	/* CS0: 16MB for OneNAND */
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpmc_pins>;
+
+	/delete-node/ nand@0,0;
+
+	onenand@0,0 {
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "ti,omap2-onenand";
+		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
+
+		gpmc,sync-read;
+		gpmc,sync-write;
+		gpmc,burst-length = <16>;
+		gpmc,burst-read;
+		gpmc,burst-wrap;
+		gpmc,burst-write;
+		gpmc,device-width = <2>;
+		gpmc,mux-add-data = <2>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <87>;
+		gpmc,cs-wr-off-ns = <87>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <10>;
+		gpmc,adv-wr-off-ns = <10>;
+		gpmc,oe-on-ns = <15>;
+		gpmc,oe-off-ns = <87>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <87>;
+		gpmc,rd-cycle-ns = <112>;
+		gpmc,wr-cycle-ns = <112>;
+		gpmc,access-ns = <81>;
+		gpmc,page-burst-access-ns = <15>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <5>;
+		gpmc,wr-data-mux-bus-ns = <30>;
+		gpmc,wr-access-ns = <81>;
+		gpmc,sync-clk-ps = <15000>;
+
+		x-loader@0 {
+			label = "X-Loader";
+			reg = <0 0x80000>;
+		};
+
+		bootloaders@80000 {
+			label = "U-Boot";
+			reg = <0x80000 0x1c0000>;
+		};
+
+		bootloaders_env@240000 {
+			label = "U-Boot Env";
+			reg = <0x240000 0x40000>;
+		};
+
+		kernel@280000 {
+			label = "Kernel";
+			reg = <0x280000 0x600000>;
+		};
+
+		filesystem@880000 {
+			label = "File System";
+			reg = <0x880000 0>;	/* 0 = MTDPART_SIZ_FULL */
+		};
+
+	};
+};
-- 
2.12.2

