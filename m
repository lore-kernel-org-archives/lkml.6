Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C9ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051EB2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BknCy2LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051EB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbeISFQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:16:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36774 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbeISFQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:16:34 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8INb2fg023894
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 16:41:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=JriOzuGSBXjp2zfTuinXCfo08czmhOPGUL1rWQK3bQE=;
 b=BknCy2LEWwPMEGkcNTGICi0p13i4SJ+gA8oKFmnqiWTgBP95/lfU9/h0xoe0OJnOzOld
 TxG5qtDmTvm9XKQXZuF4GhWPLkcZQlfAH95NVm+gO98Q0rq1I+38itEiwwb1xY2jXC1w
 3T8dJ3jguZX++o54RC78DuI8TZI7eYZKfLE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2mkat5r2m9-14
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 16:41:35 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.13) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 18 Sep
 2018 16:41:30 -0700
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)  id
 DC20C1715CB7; Tue, 18 Sep 2018 16:41:28 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>
CC:     <vijaykhemka@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3] ARM: dts: aspeed: Adding Facebook TiogaPass BMC
Date:   Tue, 18 Sep 2018 16:41:08 -0700
Message-ID: <20180918234110.1908926-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial introduction of Facebook TiogaPass family equipped with
Aspeed 2500 BMC SoC. TiogaPass is a x86 server development kit
with a ASPEED ast2500 BMC manufactured by Facebook.
Specifically, This adds the tiogapass platform device tree file
including the flash layout used by the tiogapass BMC machines.

This also adds an entry of tiogapass device tree file in Makefile

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-tiogapass.dts     | 146 ++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..1a2db605185a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1199,6 +1199,7 @@ dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
 	aspeed-bmc-arm-centriq2400-rep.dtb \
+	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-palmetto.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
new file mode 100644
index 000000000000..050e72df8683
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+// Author: Vijay Khemka <vijaykhemka@fb.com>
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Facebook TiogaPass BMC";
+	compatible = "facebook,tiogapass-bmc", "aspeed,ast2500";
+	aliases {
+		serial0 = &uart1;
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+	};
+};
+
+&uart1 {
+	// Host Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart5 {
+	// BMC Console
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&i2c0 {
+	status = "okay";
+	//Airmax Conn B, CPU0 PIROM, CPU1 PIROM
+};
+
+&i2c1 {
+	status = "okay";
+	//X24 Riser
+};
+
+&i2c2 {
+	status = "okay";
+	// Mezz Management SMBus
+};
+
+&i2c3 {
+	status = "okay";
+	// SMBus to Board ID EEPROM
+};
+
+&i2c4 {
+	status = "okay";
+	// BMC Debug Header
+};
+
+&i2c5 {
+	status = "okay";
+  //CPU Voltage regulators
+};
+
+&i2c6 {
+	status = "okay";
+	tpm@20 {
+		compatible = "infineon,slb9645tt";
+		reg = <0x20>;
+	};
+	tmp421@4e {
+		compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+		pagesize = <32>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+  //HSC, AirMax Conn A
+};
+
+&i2c8 {
+	status = "okay";
+  //Mezz Sensor SMBus
+};
+
+&i2c9 {
+	status = "okay";
+  //USB Debug Connector
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan@1 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+};
-- 
2.17.1

