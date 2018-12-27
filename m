Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A11C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF6D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeL0HfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 02:35:03 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:54143 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728625AbeL0He6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 02:34:58 -0500
X-UUID: e30c9c35426e45f794f99bde7381183f-20181227
X-UUID: e30c9c35426e45f794f99bde7381183f-20181227
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 692165439; Thu, 27 Dec 2018 15:34:47 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Dec 2018 15:34:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 15:34:45 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Min Guo <min.guo@mediatek.com>
Subject: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek musb controller
Date:   Thu, 27 Dec 2018 15:34:23 +0800
Message-ID: <1545896066-897-2-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Guo <min.guo@mediatek.com>

This adds support for MediaTek musb controller in
host, peripheral and otg mode

Signed-off-by: Min Guo <min.guo@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,musb.txt      | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt

diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
new file mode 100644
index 0000000..e899c9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
@@ -0,0 +1,49 @@
+MediaTek musb DRC/OTG controller
+-------------------------------------------
+
+Required properties:
+ - compatible      : should be "mediatek,<soc-model>-musb",
+   "mediatek,mtk-musb", soc-model is the name of SoC, such as
+   mt2701, when using "mediatek,mtk-musb" compatible string, you
+   need SoC specific ones in addition, one of:
+   - "mediatek,mt2701-musb"
+ - reg             : specifies physical base address and size of
+   the registers
+ - interrupts      : interrupt used by musb controller
+ - interrupt-names : must be "mc"
+ - phys            : PHY specifier for the OTG phy
+ - phy-names       : should be "usb2-phy"
+ - dr_mode         : should be one of "host", "peripheral" or "otg",
+   refer to usb/generic.txt
+ - clocks          : a list of phandle + clock-specifier pairs, one for
+   each entry in clock-names
+ - clock-names     : must contain "main","mcu","univpll"
+   for clocks of controller
+
+Optional properties:
+ - extcon : external connector for VBUS and IDPIN changes detection,
+   needed when supports dual-role mode.
+ - vbus-supply : reference to the VBUS regulator, needed when supports
+   dual-role mode.
+ - power-domains   : a phandle to USB power domain node to control USB's
+   MTCMOS
+
+Example:
+
+usb2: usb@11200000 {
+	compatible = "mediatek,mt2701-musb";
+		"mediatek,mtk-musb";
+	reg = <0 0x11200000 0 0x1000>;
+	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-names = "mc";
+	phys = <&u2port2 PHY_TYPE_USB2>;
+	phy-names = "usb2-phy";
+	vbus-supply = <&usb_vbus>;
+	extcon = <&extcon_usb>;
+	dr_mode = "otg";
+	clocks = <&pericfg CLK_PERI_USB0>,
+		 <&pericfg CLK_PERI_USB0_MCU>,
+		 <&pericfg CLK_PERI_USB_SLV>;
+	clock-names = "main","mcu","univpll";
+	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+};
-- 
1.9.1

