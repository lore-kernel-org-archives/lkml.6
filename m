Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C93C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F52217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u3VzuqbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfBLPO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:14:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37794 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbfBLPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:14:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so3090237wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 07:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDe4aAi8cWOpUlWHZyGvUtYiH4SuiuWIL60odXAqVwg=;
        b=u3VzuqbVabAtgyilTvr4DWePjyaC/yqXewpEx7NJTVP0W5XasF7iJZcw/ztVxEQEk4
         mIMUpuu7Ibb9MHGTmtjrU+UeBeImjLfHoyOnVK/RAKGLCs5z29kgcKiCj/ZimH2D3uUg
         92+XztIPVFhoUczxj77nvCCpWu0D3EWcw8KS7HHt2h2OFpaaeQn67iy+ewjXov0jaoBt
         /PHsrA3tiZ535JNF6eMJKobxvO5P1tQ+Are+O6zO3BFMvc2965fYz5pU4tvoIRHBugoA
         xbevr19WthfxZiXBjQcji0/j8qcaNSezAcaW2jZcNQ5XvLhQFxorGepdNUwST5nThNl8
         TP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDe4aAi8cWOpUlWHZyGvUtYiH4SuiuWIL60odXAqVwg=;
        b=DayV5RIf+2yYANDYxz53THLfCMxNt9TSLMlnV50K3xk2mKPXuBspa7UOulWPKUAYJ6
         T+mEWy5VMnfzZAoJwtybjVsDUvSDIgPKrOz5fVAYpzDV4MjDHJfkIWxGUV99BIwMcODz
         EGmIuXnvxLL6s9urvyp0RWnvklWSD/BUstaMoNc36jKIuckvsXnGeIu5eFIqP07kwSgu
         3sb952chIwy7xms1b0D81grV2Ay+5oQkIj0TjqwkdYdohx/5cwr23GuD8LlFm8QmAUC5
         GpImn0R1XV2JOCekMfmZ098MtqYRa/N1dQbZufCkv35eT85OSYp69yX/UU2KOQgrw1vo
         CVWQ==
X-Gm-Message-State: AHQUAuZLkIODMc3TRD8S2Ppiyy7BBzCA8UCzez702hPQCju/gzTmuMi4
        94khp5zHP4mCsJUx8KS8sWs7EQ==
X-Google-Smtp-Source: AHgI3IZBteN6I1Nx2a1nkXaxlfbF++ZHexZn12R+Py3UOMqKpk1+t72geiC8EpAmXDMz51ovd7eciQ==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr3079320wrw.87.1549984463488;
        Tue, 12 Feb 2019 07:14:23 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 07:14:22 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
Date:   Tue, 12 Feb 2019 16:14:09 +0100
Message-Id: <20190212151413.24632-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the bindings for the Amlogic G12A USB Glue HW.

The Amlogic G12A SoC Family embeds 2 USB Controllers :
- a DWC3 IP configured as Host for USB2 and USB3
- a DWC2 IP configured as Peripheral USB2 Only

A glue connects these both controllers to 2 USB2 PHYs,
and optionnally to an USB3+PCIE Combo PHY shared with the PCIE controller.

The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
routing of the OTG PHY between the DWC3 and DWC2 controllers, and
setups the on-chip OTG mode selection for this PHY.

The PHYs are children of the Glue node since the Glue controls the interface
with the PHY, not the DWC3 controller.

The PHY interconnect is handled into ports subnodes, which eases describing
which PHY is enabled (like the USB3 shared PHY) and futures layouts on
derivatives of the G12A Family.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/usb/amlogic,dwc3.txt  | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt b/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
index 9a8b631904fd..c7c4726ef10d 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
@@ -40,3 +40,112 @@ Example device nodes:
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};
+
+Amlogic Meson G12A DWC3 USB SoC Controller Glue
+
+The Amlogic G12A embeds a DWC3 USB IP Core configured for USB2 and USB3
+in host-only mode, and a DWC2 IP Core configured for USB2 peripheral mode
+only.
+
+A glue connects the DWC3 core to USB2 PHYs and optionnaly to an USB3 PHY.
+
+One of the USB2 PHY can be re-routed in peripheral mode to a DWC2 USB IP.
+
+The DWC3 Glue controls the PHY routing and power, an interrupt line is
+connected to the Glue to serve as OTG ID change detection.
+
+Required properties:
+- compatible:	Should be "amlogic,meson-g12a-usb-ctrl"
+- clocks:	a handle for the "USB" clock
+- clock-names:	must be "usb"
+- resets:	a handle for the shared "USB" reset line
+- reset-names:	must be "usb"
+- reg:		The base address and length of the registers
+- interrupts:	the interrupt specifier for the OTG detection
+
+Required child nodes:
+
+USB Ports are described as child 'port' nodes grouped under a 'ports' node,
+with #address-cells, #size-cells specified.
+
+Each 'port' sub-node identifies a possible USB Port served by an USB PHY
+identified by the 'phy' property as decribed in ../phy/phy-bindings.txt
+
+Each 'port' is identified by a reg property to number the port.
+
+The following table lists for each supported model the port number
+corresponding to each PHY serving a physical USB Port.
+
+ Family	   Port 0     Port 1    Port 2    Port 3    Port 4
+---------------------------------------------------------------
+ G12A	   USBHOST_A  USBOTG_B  Reserved  Reserved  USB3_0
+
+A child node must exist to represent the core DWC3 IP block. The name of
+the node is not important. The content of the node is defined in dwc3.txt.
+
+A child node must exist to represent the core DWC2 IP block. The name of
+the node is not important. The content of the node is defined in dwc2.txt.
+
+PHY documentation is provided in the following places:
+- Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
+- Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
+
+
+Example device nodes:
+	usb: usb@ffe09000 {
+			compatible = "amlogic,meson-g12a-usb-ctrl";
+			reg = <0x0 0xffe09000 0x0 0xa0>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&clkc CLKID_USB>;
+			clock-names = "usb";
+			resets = <&reset RESET_USB>;
+			reset-names = "usb";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* USB2 Port 0 */
+				usb20: port@0 {
+					reg = <0>;
+					phys = <&usb2_phy0>;
+				};
+
+				/* USB2 Port 1 */
+				usb21: port@1 {
+					reg = <1>;
+					phys = <&usb2_phy1>;
+				};
+
+				/* USB3 Port 0 */
+				usb3: port@4 {
+					reg = <4>;
+					phys = <&usb3_pcie_phy PHY_TYPE_USB3>;
+				};
+			};
+
+			dwc2: usb@ff400000 {
+				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
+				reg = <0x0 0xff400000 0x0 0x40000>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
+				clock-names = "ddr";
+				dr_mode = "peripheral";
+				g-rx-fifo-size = <192>;
+				g-np-tx-fifo-size = <128>;
+				g-tx-fifo-size = <128 128 16 16 16>;
+			};
+
+			dwc3: dwc3@ff500000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff500000 0x0 0x100000>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,dis_u2_susphy_quirk;
+				snps,quirk-frame-length-adjustment;
+			};
+	};
-- 
2.20.1

