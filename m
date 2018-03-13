Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2832218-1520937471-2-16275828575364333795
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520937470; b=ZvIW3YjTEyQELemxtOrVp26jsqp6MUA3xylDxlUA8rTcFtR
    2MI0oODzf1xz9pDjUiPWQ99c48p03jTMOApyUda7Na2p5dtKouN/pjv1lSLp5SR1
    GJX6QOIkgACqKO2VJl8IH6drYj5nNxmTyWey0ms0Jj+UbG4N6w9h5CUDdDTDxyOO
    3JvuIVtUWh8iQ7sy9J1bL+KtMeL/ePrkqzy+KDG5Lv4jxP9fy4XwezOQ4JIvYTrL
    EDfPMKfiZtBp2/wvGtwibXFiSP+kCz8s9A9uaaow1C1h/m6Qpf1ZUB4DX8wGExW/
    wlTJadI99E2eRmNO2mwsilAJ7r6yKWyjF6ZKOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520937470; bh=iPq1JS2RWo7wc2C69PWveIT3TV
    qKKf8sFTxeuzbDcH8=; b=XiDEnbYeTGMz8H4CivOuiv0USPSVa0aUGZ2SXqj/rX
    CKoT0sYi4dnIs4K+qCmxVupMBobcQEWp4uHueH0rSH4l9wUUx89vb4fJPwSjC8wt
    CeTf67/+ZBU4vYacsxcexCn8V+aBwJTzyZR1P9xQqjCpG6LMEbtM3qTa5N5Qk5BD
    9MC9naJhHVG/EGLPh2KJals64m3z7Gqlz5uRS4d86NNYk1rj4lnHinQyqBRS8p6y
    vRjVBqMqf30dlwEHzdnKtR30/lD82EFHhx5gqGSwmAdC8roJLBwDVhCeQX3RrgUd
    puYHfoDIB5J/oiU1N/EFA6jzTpxfmaoZEAsIl6GpEYUQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=R6l0/yCx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=R6l0/yCx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=R6l0/yCx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=R6l0/yCx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932814AbeCMKgS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 06:36:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932489AbeCMKgP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 13 Mar 2018 06:36:15 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5A1360592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 1/2] dt-bindings: usb: Update documentation for Qualcomm DWC3 driver
Date: Tue, 13 Mar 2018 16:06:00 +0530
Message-Id: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Existing documentation has lot of incorrect information as it
was originally added for a driver that no longer exists.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 .../devicetree/bindings/usb/qcom,dwc3.txt          | 87 +++++++++++++++-------
 1 file changed, 59 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
index bc8a2fa..df312f7 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
@@ -1,54 +1,85 @@
 Qualcomm SuperSpeed DWC3 USB SoC controller
 
 Required properties:
-- compatible:	should contain "qcom,dwc3"
-- clocks:		A list of phandle + clock-specifier pairs for the
-				clocks listed in clock-names
-- clock-names:	Should contain the following:
-  "core"		Master/Core clock, have to be >= 125 MHz for SS
-				operation and >= 60MHz for HS operation
-
-Optional clocks:
-  "iface"		System bus AXI clock.  Not present on all platforms
-  "sleep"		Sleep clock, used when USB3 core goes into low
-				power mode (U3).
+- compatible:		should contain "qcom,dwc3"
+- reg:			offset and length of register set for QSCRATCH wrapper
+- reg-names:		should be "qscratch"
+- power-domains:	specifies a phandle to PM domain provider node
+- clocks:		list of phandle + clock-specifier pairs
+- assigned-clocks:	should be:
+				MOCK_UTMI_CLK
+				MASTER_CLK
+- assigned-clock-rates: should be:
+                                19.2Mhz (192000000) for MOCK_UTMI_CLK
+                                >=125Mhz (125000000) for MASTER_CLK in SS mode
+                                >=60Mhz (60000000) for MASTER_CLK in HS mode
+
+Optional properties:
+- resets:		list of phandle and reset specifier pairs
+- interrupts:		specifies interrupts from controller wrapper used
+			to wakeup from low power/susepnd state.	Must contain
+			one or more entry for interrupt-names property
+- interrupt-names:	Must include the following entries:
+			- "hs_phy_irq": The interrupt that is asserted when a
+			   wakeup event is received on USB2 bus
+			- "ss_phy_irq": The interrupt that is asserted when a
+			   wakeup event is received on USB3 bus
+			- "dm_hs_phy_irq" and "dp_hs_phy_irq": Separate
+			   interrupts for any wakeup event on DM and DP lines
+- qcom,select-utmi-as-pipe-clk: if present, disable USB3 pipe_clk requirement.
+				Used when dwc3 operates without SSPHY and only
+				HS/FS/LS modes are supported.
 
 Required child node:
 A child node must exist to represent the core DWC3 IP block. The name of
 the node is not important. The content of the node is defined in dwc3.txt.
 
 Phy documentation is provided in the following places:
-Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
+Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt   - USB3 QMP PHY
+Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt - USB2 QUSB2 PHY
 
 Example device nodes:
 
 		hs_phy: phy@100f8800 {
-			compatible = "qcom,dwc3-hs-usb-phy";
-			reg = <0x100f8800 0x30>;
-			clocks = <&gcc USB30_0_UTMI_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
+			compatible = "qcom,qusb2-v2-phy";
+			...
 		};
 
 		ss_phy: phy@100f8830 {
-			compatible = "qcom,dwc3-ss-usb-phy";
-			reg = <0x100f8830 0x30>;
-			clocks = <&gcc USB30_0_MASTER_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
+			compatible = "qcom,qmp-v3-usb3-phy";
+			...
 		};
 
-		usb3_0: usb30@0 {
+		usb3_0: usb30@a6f8800 {
 			compatible = "qcom,dwc3";
+			reg = <0xa6f8800 0x400>;
+			reg-names = "qscratch";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			clocks = <&gcc USB30_0_MASTER_CLK>;
-			clock-names = "core";
-
 			ranges;
 
+			interrupts = <0 131 0>, <0 486 0>, <0 488 0>, <0 489 0>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+				  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			clocks = <&clock_gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				<&clock_gcc GCC_USB30_PRIM_MASTER_CLK>,
+				<&clock_gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				<&clock_gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				<&clock_gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				<&clock_gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&clock_gcc GCC_USB3_PRIM_CLKREF_CLK>;
+			clock-names = "cfg_noc", "core", "aggr_noc", "utmi",
+					"sleep", "cfg_ahb", "ref";
+
+			assigned-clocks = <&clock_gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&clock_gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <133000000>;
+
+			resets = <&clock_gcc GCC_USB30_PRIM_BCR>;
+			reset-names = "core_reset";
+			power-domains = <&clock_gcc USB30_PRIM_GDSC>;
+			qcom,select-utmi-as-pipe-clk;
 
 			dwc3@10000000 {
 				compatible = "snps,dwc3";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

