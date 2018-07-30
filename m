Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C948E16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8282820870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Xp2e+nM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8282820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeG3SC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:02:29 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:43638 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3SC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:02:28 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D3B3D24E0720;
        Mon, 30 Jul 2018 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532968003; bh=+kw6nYGXjpBLIvz93CLsMvrtH/MFycvnS4Ofyj2LSD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xp2e+nM+t1Gk2u5AueGHtdNWOvq+k7VgsMD1r0uzKu9Na4eCq/znhuiKH4iUXC+R8
         WMRUFwn+Ybo7CM4LHgzLFJVWSHJXi8YUc7jDM/8VE1srQXk3IUGlEmCRe6KSfWrEVl
         z5/P0Gq7dGeYkhLvEVzJjPkef/et8gwcFwWPro9Llfn+hULmNkw4veAEJABi+2MFci
         IUtNBQXfU2koMHzyZil0L5s1Ds79ouG7wgOLMrkw7+55x1nYQ8otuSmzED7VegjV2P
         v59jTRxw5Pvl68muTbKrbCOJXAjpMlSjin1oE6+Y1LRQfaqkS/VZ2G3ugRWhH4sOkr
         Y8IHgBu+l4Ezw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1D2B13F60;
        Mon, 30 Jul 2018 09:26:41 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 1/4] ARC: DTS: mark DMA devices connected through IOC port as dma-coherent
Date:   Mon, 30 Jul 2018 19:26:33 +0300
Message-Id: <20180730162636.3556-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark DMA devices on AXS103 and HSDK boards connected through IOC
port as dma-coherent.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * None.

 arch/arc/boot/dts/axc003.dtsi     | 26 ++++++++++++++++++++++++++
 arch/arc/boot/dts/axc003_idu.dtsi | 26 ++++++++++++++++++++++++++
 arch/arc/boot/dts/hsdk.dts        |  4 ++++
 3 files changed, 56 insertions(+)

diff --git a/arch/arc/boot/dts/axc003.dtsi b/arch/arc/boot/dts/axc003.dtsi
index dc91c663bcc0..d75d65ddf8e3 100644
--- a/arch/arc/boot/dts/axc003.dtsi
+++ b/arch/arc/boot/dts/axc003.dtsi
@@ -93,6 +93,32 @@
 		};
 	};
 
+	/*
+	 * Mark DMA peripherals connected via IOC port as dma-coherent. We do
+	 * it via overlay because peripherals defined in axs10x_mb.dtsi are
+	 * used for both AXS101 and AXS103 boards and only AXS103 has IOC (so
+	 * only AXS103 board has HW-coherent DMA peripherals)
+	 * We don't need to mark pgu@17000 as dma-coherent because it uses
+	 * external DMA buffer located outside of IOC aperture.
+	 */
+	axs10x_mb {
+		ethernet@0x18000 {
+			dma-coherent;
+		};
+
+		ehci@0x40000 {
+			dma-coherent;
+		};
+
+		ohci@0x60000 {
+			dma-coherent;
+		};
+
+		mmc@0x15000 {
+			dma-coherent;
+		};
+	};
+
 	/*
 	 * The DW APB ICTL intc on MB is connected to CPU intc via a
 	 * DT "invisible" DW APB GPIO block, configured to simply pass thru
diff --git a/arch/arc/boot/dts/axc003_idu.dtsi b/arch/arc/boot/dts/axc003_idu.dtsi
index 69ff4895f2ba..a05bb737ea63 100644
--- a/arch/arc/boot/dts/axc003_idu.dtsi
+++ b/arch/arc/boot/dts/axc003_idu.dtsi
@@ -100,6 +100,32 @@
 		};
 	};
 
+	/*
+	 * Mark DMA peripherals connected via IOC port as dma-coherent. We do
+	 * it via overlay because peripherals defined in axs10x_mb.dtsi are
+	 * used for both AXS101 and AXS103 boards and only AXS103 has IOC (so
+	 * only AXS103 board has HW-coherent DMA peripherals)
+	 * We don't need to mark pgu@17000 as dma-coherent because it uses
+	 * external DMA buffer located outside of IOC aperture.
+	 */
+	axs10x_mb {
+		ethernet@0x18000 {
+			dma-coherent;
+		};
+
+		ehci@0x40000 {
+			dma-coherent;
+		};
+
+		ohci@0x60000 {
+			dma-coherent;
+		};
+
+		mmc@0x15000 {
+			dma-coherent;
+		};
+	};
+
 	/*
 	 * This INTC is actually connected to DW APB GPIO
 	 * which acts as a wire between MB INTC and CPU INTC.
diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 006aa3de5348..ebb686c21393 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -176,6 +176,7 @@
 			phy-handle = <&phy0>;
 			resets = <&cgu_rst HSDK_ETH_RESET>;
 			reset-names = "stmmaceth";
+			dma-coherent;
 
 			mdio {
 				#address-cells = <1>;
@@ -194,12 +195,14 @@
 			compatible = "snps,hsdk-v1.0-ohci", "generic-ohci";
 			reg = <0x60000 0x100>;
 			interrupts = <15>;
+			dma-coherent;
 		};
 
 		ehci@40000 {
 			compatible = "snps,hsdk-v1.0-ehci", "generic-ehci";
 			reg = <0x40000 0x100>;
 			interrupts = <15>;
+			dma-coherent;
 		};
 
 		mmc@a000 {
@@ -212,6 +215,7 @@
 			clock-names = "biu", "ciu";
 			interrupts = <12>;
 			bus-width = <4>;
+			dma-coherent;
 		};
 	};
 
-- 
2.14.4

