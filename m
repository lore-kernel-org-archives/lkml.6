Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4100528-1523638381-2-2050289671983219782
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523638380; b=DQQqEK+HhVw/rQQjaUemhJss985FMeARLTGDts7ScgGvQVM/XE
    4huNvTwESKmPKyLVn3cxhLaojiDWrM1y2XL4TmsW+ERfg6lKQu97NyVCDzYYmdbo
    OH1OXecmzaFNHGlph5XQH7otz69AlrddskSWno2WmWMk5sSHkAmIRSTeVKWM8Y53
    6sLLA2846A+e0wkp9sU4PgtrSs7OGNi7SU/64vtO9HSb5U4yCYE8gfhOUainWnpZ
    RiefGcVKZbVAF8R3eLR8S+zclKmrcQsNNJksDEJQ5KsHNmkdNYAcSshRB7+c+n3B
    orjpwdROujq4VBXOj7bJuAF4nEB6etMXMD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523638380; bh=
    guCuIuyCQXGu+/YV3j8L5BADKi5n7dNg7SxCwaLmtpg=; b=Ak8uVOxHBdq+0kJr
    J89lDp7Fge0OZLqyw2kMaET2q004li37TNkfJM8rKaC2dCBxej9rl9Vai507G7CE
    3fF5Ho5nVurmDGb413rsQMXFCg0/jVnOQyt8jZlFd/g8OO3DlNRXz3VASqAWgqqD
    g68AfV7PMetx+R6mtE9aP4jD7BEQLQV7SYugyOMz73KRLkbrUR2/dkeQxqPHgf87
    g73irXln3cGsPZ09KAWraPFkX3ZY4A/H9Q8fI5k3xgN3tzbeyZ1ITc6jteZ7FqXB
    MdKmK5SLz+GADFHXLgKUGVEBthFA99Ax1SjBlsn9eO/pbxgBMf3attSQmjqpb0uL
    H5EieQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Vh0xg8sp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=aMhOnz3s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Vh0xg8sp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=aMhOnz3s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMlvnx6eOSdUSeZKpJm/MSziOikK32EbB+6QjJ3PzkvvFUqy0aKWLYngBqLtPJdAIJO8sAobaFKm4FsFuXlWydqkRBLNvObRJ72WT834YbwQgrXGowUH
    WL5RQsPsEXIMjandy6w2RPoS6gVXV1MN69iZ1uQ/7HddE/pC7y5gjtvpnl/riI8NBgQ6ed8hzrrSzVVPksxXp6E6ubTlz5QHZsUfQd+oe8EsSKB40ytGA4wT
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=dhdgKvSqoBfuT13nVz4A:9 a=OJIhrffI176TiY_Z:21
    a=FQ8BLUTFVLIboxyk:21 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeDMQwG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 12:52:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDMQwC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 12:52:02 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EE2260F6C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/3] dt-bindings: usb: Update documentation for Qualcomm DWC3 driver
Date: Fri, 13 Apr 2018 22:21:22 +0530
Message-Id: <1523638285-5742-2-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
References: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Existing documentation has lot of incorrect information as it
was originally added for a driver that no longer exists.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 .../devicetree/bindings/usb/qcom,dwc3.txt          | 78 ++++++++++++++++------
 1 file changed, 57 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
index bc8a2fa..fdc574a 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
@@ -1,54 +1,90 @@
 Qualcomm SuperSpeed DWC3 USB SoC controller
 
 Required properties:
-- compatible:	should contain "qcom,dwc3"
+- compatible:		should contain "qcom,dwc3"
+- reg:			offset and length of register set for QSCRATCH wrapper
+- power-domains:	specifies a phandle to PM domain provider node
 - clocks:		A list of phandle + clock-specifier pairs for the
 				clocks listed in clock-names
-- clock-names:	Should contain the following:
+- clock-names:		Should contain the following:
   "core"		Master/Core clock, have to be >= 125 MHz for SS
 				operation and >= 60MHz for HS operation
+  "mock_utmi"		Mock utmi clock needed for ITP/SOF generation in
+				host mode. Its frequency should be 19.2MHz.
+  "sleep"		Sleep clock, used for wakeup when USB3 core goes
+				into low power mode (U3).
 
 Optional clocks:
   "iface"		System bus AXI clock.  Not present on all platforms
-  "sleep"		Sleep clock, used when USB3 core goes into low
-				power mode (U3).
+  "cfg_noc"		System Config NOC clock. Not present on all platforms
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
+			clocks = <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				<&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				<&gcc GCC_USB30_PRIM_SLEEP_CLK>;
+			clock-names = "core", "mock_utmi", "sleep";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <133000000>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+			reset-names = "core_reset";
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+			qcom,select-utmi-as-pipe-clk;
 
 			dwc3@10000000 {
 				compatible = "snps,dwc3";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

