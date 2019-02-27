Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2216C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8AA20643
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfB0RZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:25:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:44139 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbfB0RZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:25:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303030792"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 09:25:28 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org
Cc:     thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/5] Documentation: dt: edac: Add Stratix10 Peripheral bindings
Date:   Wed, 27 Feb 2019 11:27:22 -0600
Message-Id: <1551288445-22335-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add peripheral bindings for Stratix10 EDAC to capture
the differences between the ARM64 and ARM32 architecture.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2 No change
---
 .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
index a0ac50e15912..a0fa80c53d2a 100644
--- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
@@ -258,6 +258,49 @@ Required Properties:
 - compatible : Should be "altr,sdram-edac-s10"
 - interrupts : Should be single bit error interrupt.
 
+On-Chip RAM ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-ocram-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent OCRAM node.
+- interrupts      : Should be single bit error interrupt.
+
+Ethernet FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-eth-mac-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent Ethernet node.
+- interrupts      : Should be single bit error interrupt.
+
+NAND FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-nand-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent NAND node.
+- interrupts      : Should be single bit error interrupt.
+
+DMA FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-dma-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent DMA node.
+- interrupts      : Should be single bit error interrupt.
+
+USB FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-usb-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent USB node.
+- interrupts      : Should be single bit error interrupt.
+
+SDMMC FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-sdmmc-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent SD/MMC node.
+- interrupts      : Should be single bit error interrupt for port A
+		    and then single bit error interrupt for port B.
+
 Example:
 
 	eccmgr {
@@ -274,4 +317,67 @@ Example:
 			compatible = "altr,sdram-edac-s10";
 			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ocram-ecc@ff8cc000 {
+			compatible = "altr,socfpga-s10-ocram-ecc";
+			reg = <ff8cc000 0x100>;
+			altr,ecc-parent = <&ocram>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		emac0-rx-ecc@ff8c0000 {
+			compatible = "altr,socfpga-s10-eth-mac-ecc";
+			reg = <0xff8c0000 0x100>;
+			altr,ecc-parent = <&gmac0>;
+			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		emac0-tx-ecc@ff8c0400 {
+			compatible = "altr,socfpga-s10-eth-mac-ecc";
+			reg = <0xff8c0400 0x100>;
+			altr,ecc-parent = <&gmac0>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>'
+		};
+
+		nand-buf-ecc@ff8c8000 {
+			compatible = "altr,socfpga-s10-nand-ecc";
+			reg = <0xff8c8000 0x100>;
+			altr,ecc-parent = <&nand>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		nand-rd-ecc@ff8c8400 {
+			compatible = "altr,socfpga-s10-nand-ecc";
+			reg = <0xff8c8400 0x100>;
+			altr,ecc-parent = <&nand>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		nand-wr-ecc@ff8c8800 {
+			compatible = "altr,socfpga-s10-nand-ecc";
+			reg = <0xff8c8800 0x100>;
+			altr,ecc-parent = <&nand>;
+			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		dma-ecc@ff8c9000 {
+			compatible = "altr,socfpga-s10-dma-ecc";
+			reg = <0xff8c9000 0x100>;
+			altr,ecc-parent = <&pdma>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+
+		usb0-ecc@ff8c4000 {
+			compatible = "altr,socfpga-s10-usb-ecc";
+			reg = <0xff8c4000 0x100>;
+			altr,ecc-parent = <&usb0>;
+			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		sdmmc-ecc@ff8c8c00 {
+			compatible = "altr,socfpga-s10-sdmmc-ecc";
+			reg = <0xff8c8c00 0x100>;
+			altr,ecc-parent = <&mmc>;
+			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+				     <15 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
-- 
2.7.4

