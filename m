Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FE9C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671182145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671182145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLCDpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:45:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16065 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbeLCDpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:45:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1C557B4D0BDBD;
        Mon,  3 Dec 2018 11:45:37 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 11:45:29 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "John Stultz" <john.stultz@linaro.org>
Subject: [PATCH v1 01/12] dt-bindings: usb: add support for dwc3 controller on HiSilicon SoCs
Date:   Mon, 3 Dec 2018 11:45:04 +0800
Message-ID: <20181203034515.91412-2-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20181203034515.91412-1-chenyu56@huawei.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding descriptions to support the dwc3 controller
on HiSilicon SoCs and boards like the HiKey960.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
 .../devicetree/bindings/usb/dwc3-hisi.txt          | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.txt

diff --git a/Documentation/devicetree/bindings/usb/dwc3-hisi.txt b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
new file mode 100644
index 000000000000..d32d2299a0a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
@@ -0,0 +1,67 @@
+HiSilicon DWC3 USB SoC controller
+
+This file documents the parameters for the dwc3-hisi driver.
+
+Required properties:
+- compatible:	should be "hisilicon,hi3660-dwc3"
+- clocks:	A list of phandle + clock-specifier pairs for the
+		clocks listed in clock-names
+- clock-names:	Specify clock names
+- resets:	list of phandle and reset specifier pairs.
+
+Sub-nodes:
+The dwc3 core should be added as subnode to HiSilicon DWC3 as shown in the
+example below. The DT binding details of dwc3 can be found in:
+Documentation/devicetree/bindings/usb/dwc3.txt
+
+Example:
+	usb3: hisi_dwc3 {
+		compatible = "hisilicon,hi3660-dwc3";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
+			 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
+		clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
+		assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
+		assigned-clock-rates = <229000000>;
+		resets = <&crg_rst 0x90 8>,
+			 <&crg_rst 0x90 7>,
+			 <&crg_rst 0x90 6>,
+			 <&crg_rst 0x90 5>;
+
+		dwc3: dwc3@ff100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xff100000 0x0 0x100000>;
+			interrupts = <0 159 4>, <0 161 4>;
+			phys = <&usb_phy>;
+			phy-names = "usb3-phy";
+			dr_mode = "otg";
+			maximum-speed = "super-speed";
+			phy_type = "utmi";
+			snps,dis-del-phy-power-chg-quirk;
+			snps,lfps_filter_quirk;
+			snps,dis_u2_susphy_quirk;
+			snps,dis_u3_susphy_quirk;
+			snps,tx_de_emphasis_quirk;
+			snps,tx_de_emphasis = <1>;
+			snps,dis_enblslpm_quirk;
+			snps,gctl-reset-quirk;
+
+			port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dwc3_role_switch: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&rt1711h_ep>;
+				};
+
+				dwc3_role_switch_notify: endpoint@1 {
+					reg = <1>;
+					remote-endpoint = <&hikey_usb_ep>;
+				};
+			};
+		};
+	};
-- 
2.15.0-rc2

