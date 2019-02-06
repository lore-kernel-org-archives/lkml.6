Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452EBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D2A2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dLi4gift"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfBFRdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:33:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35934 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbfBFRd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:33:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so3400341pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vCZzyrDDCvMOjsaqAXAzp/AE/7pbIygjlfYoxlnSqFc=;
        b=dLi4gift0wwE53cPPf+YHcWGXDbO1P98Y67tEnD0zGXbZxsn/Eav+uTb3xdU/BLLrI
         MyCgPoBH6TELi3kkDHgfpeSBFH+RTOBShm2VBONbsfei+8EQcNWwlYDmxPs/1H3d8sAc
         lBwE35vZpG0IivS6AyCwDfOGHJ/CBWFOb3yRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vCZzyrDDCvMOjsaqAXAzp/AE/7pbIygjlfYoxlnSqFc=;
        b=DtchHbV3XIG7iRsBn+CzU0nQ+p5kabCjHdn9PqnUeQXP8wT8eFw92U0lJXCb8ykz3r
         xZ7Y+rLWy7avPUvrts2MsQl4MFudkjVlJCIRxcQJ0hnmLpLMK45E779fZXyl3Ilhr+T/
         35gnIElWtZRvVHOBHosP5mbq6Nn7P5gXdwNzVRzR90sADiyq3mqRD6l+fiZB6ELk1sk9
         nexSetusIMQEMHLCXYoJRTy0GoZsqK1sxhZY1vssSRvM9TKV6RfKSR2qdRPI71GAulup
         dFO7qkltYnQuvfS1MDr01uWJXC4t+GYgOTzDhhNhqRm4c3Xz3NIC8sdCuYCidqkpy44H
         UBUA==
X-Gm-Message-State: AHQUAuZShvVWcL5X4yXfvN0sOHaKxCCs24tak6mOIhlvV5PlEnUadmOB
        A3sG1tfqWwEqBEIYr9XPhkx+Xg==
X-Google-Smtp-Source: AHgI3Ibd4Pb8c2nNGzOxcMPEa52xWVG9KBEhiLZjo1vhguT1oWcDwt+ERypM4mIMhP2Noml6SOEkoQ==
X-Received: by 2002:a63:e051:: with SMTP id n17mr10667151pgj.258.1549474407982;
        Wed, 06 Feb 2019 09:33:27 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s6sm9270281pgo.4.2019.02.06.09.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 09:33:27 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 3/3] arm64: dts: Add USB DT nodes for Stingray SoC
Date:   Wed,  6 Feb 2019 23:02:27 +0530
Message-Id: <1549474347-7224-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549474347-7224-1-git-send-email-srinath.mannam@broadcom.com>
References: <1549474347-7224-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for
  - Two xHCI host controllers
  - Two BDC Broadcom USB device controller
  - Five USB PHY controllers

[xHCI0]      [BDC0]            [xHCI1]            [BDC1]
   |           |                  |                 |
  ---------------               -----------------------
   |           |                 |         |         |
[SS-PHY0]   [HS-PHY0]        [SS-PHY1] [HS-PHY2] [HS-PHY1]

[SS-PHY0/HS-PHY0] and [SS-PHY1/HS-PHY1] are combo PHYs of
version1 category has both SS and HS PHYs..
[HS-PHY2] is HS PHY of version2 category.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   | 95 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
new file mode 100644
index 0000000..164a1de
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *Copyright(c) 2018 Broadcom
+ */
+	usb {
+		compatible = "simple-bus";
+		dma-ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x68500000 0x00400000>;
+
+		usbphy0: usb-phy@0 {
+			compatible = "brcm,sr-usb-phy";
+			reg = <0x00000000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			usb0_phy0: phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+			usb0_phy1: phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+
+		};
+
+		xhci0: usb@1000 {
+			compatible = "generic-xhci";
+			reg = <0x00001000 0x1000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb0_phy1>, <&usb0_phy0>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc0: usb@2000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00002000 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb0_phy1>, <&usb0_phy0>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		usbphy1: usb-phy@10000 {
+			compatible = "brcm,sr-usb-phy";
+			reg = <0x00010000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			usb1_phy0: phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+			usb1_phy1: phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
+
+		usbphy2: usb-phy@20000 {
+			compatible = "brcm,sr-usb-phy-v2";
+			reg = <0x00020000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		xhci1: usb@11000 {
+			compatible = "generic-xhci";
+			reg = <0x00011000 0x1000>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb1_phy1>, <&usbphy2>, <&usb1_phy0>;
+			phy-names = "phy0", "phy1", "phy2";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc1: usb@21000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00021000 0x1000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy2>;
+			phy-names = "phy0";
+			dma-coherent;
+			status = "disabled";
+		};
+	};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index cfeaa85..21dbb12 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -287,6 +287,7 @@
 	#include "stingray-fs4.dtsi"
 	#include "stingray-sata.dtsi"
 	#include "stingray-pcie.dtsi"
+	#include "stingray-usb.dtsi"
 
 	hsls {
 		compatible = "simple-bus";
-- 
2.7.4

