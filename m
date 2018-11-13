Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA149C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881832175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881832175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbeKMXbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:31:03 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:34891 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeKMXbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:31:03 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42vT8N35nsz1qvnN;
        Tue, 13 Nov 2018 14:32:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42vT8N2BkCz1qr2s;
        Tue, 13 Nov 2018 14:32:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id elDuKfltx3Sp; Tue, 13 Nov 2018 14:32:49 +0100 (CET)
X-Auth-Info: R5iPonscUAsV0w8jyJl6d1dlR8rRr6/t/FayjhwBg8E=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 13 Nov 2018 14:32:49 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH] arm64: dts: actions: s700: Add I2C controller nodes
Date:   Tue, 13 Nov 2018 14:32:35 +0100
Message-Id: <20181113133235.37754-1-pn@denx.de>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C controller nodes for Actions Semiconductor S700 SoC.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 192c7b39c8c1..573c844d7afe 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -174,6 +174,46 @@
 			#clock-cells = <1>;
 		};
 
+		i2c0: i2c@e0170000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0170000 0 0x1000>;
+			clocks = <&cmu CLK_I2C0>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@e0174000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0174000 0 0x1000>;
+			clocks = <&cmu CLK_I2C1>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@e0178000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0178000 0 0x1000>;
+			clocks = <&cmu CLK_I2C2>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@e017c000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe017c000 0 0x1000>;
+			clocks = <&cmu CLK_I2C3>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		sps: power-controller@e01b0100 {
 			compatible = "actions,s700-sps";
 			reg = <0x0 0xe01b0100 0x0 0x100>;
-- 
2.17.2

