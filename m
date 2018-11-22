Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF83620672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AECXo4KT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF83620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436563AbeKVWTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:19:33 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50486 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390979AbeKVWTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:19:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAMBeTTd075957;
        Thu, 22 Nov 2018 05:40:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542886829;
        bh=ftWSvjI7qlQpDwhFOSUwMXmg9aHPDUkp4ZjQ1EVmo1M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AECXo4KTS3LGIVPSMWHWqm+L2Rje9fz2e6lv8SCmhFNHFN1lmhbhBW2qnd9QyayPN
         YWYkJPxG/a9rHGMR9+xhw8gqe9/qkklj+GbsvpxO/xOblCmXf4NJBMU1oXXtLF4RGQ
         GxoLe5D77igtnzkkOl71ZKhl9pyHqBMo72X5n7kE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAMBeTgR130760
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 05:40:29 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 05:40:27 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 05:40:27 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBeRFU028296;
        Thu, 22 Nov 2018 05:40:27 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.239.63])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdDfG013203;
        Thu, 22 Nov 2018 05:40:23 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 17/17] ARM: dts: am335x-*: Enable PRU-ICSS nodes
Date:   Thu, 22 Nov 2018 13:39:13 +0200
Message-ID: <1542886753-17625-18-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRU-ICSS processor bus node and subsystem nodes were left in
disabled state in the base am33xx.dtsi file. PRU-ICSS is supported
on these AM335x boards so enable the PRUSS node.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 8 ++++++++
 arch/arm/boot/dts/am335x-evm.dts          | 8 ++++++++
 arch/arm/boot/dts/am335x-evmsk.dts        | 8 ++++++++
 arch/arm/boot/dts/am335x-icev2.dts        | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 9e5e75e..ea0e869 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -422,3 +422,11 @@
 	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
+
+&pruss_soc_bus {
+	status = "okay";
+
+	pruss: pruss@4a300000 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 98ec9c3..0e07160 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -800,3 +800,11 @@
 	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
+
+&pruss_soc_bus {
+	status = "okay";
+
+	pruss: pruss@4a300000 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 245868f..f152c15 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -741,3 +741,11 @@
 	clocks = <&clk_32768_ck>, <&l4_per_clkctrl AM3_CLKDIV32K_CLKCTRL 0>;
 	clock-names = "ext-clk", "int-clk";
 };
+
+&pruss_soc_bus {
+	status = "okay";
+
+	pruss: pruss@4a300000 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index f2005ec..7d2fff2e 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -504,3 +504,11 @@
 		reg = <3>;
 	};
 };
+
+&pruss_soc_bus {
+	status = "okay";
+
+	pruss: pruss@4a300000 {
+		status = "okay";
+	};
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

