Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967668AbeE2V7j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:59:39 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37345 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967606AbeE2V7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:59:22 -0400
X-Google-Smtp-Source: ADUXVKK3mKuP/J1lMh1bsl6FlAVmdFM9XVHk4lcPsXnM5ShTZ2FD1NLN1QbFStktx1sWeL+KzJ08Kg==
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 6/6] arm64: dts: Change PCIe INTx mapping for NS2
Date: Tue, 29 May 2018 14:58:50 -0700
Message-Id: <1527631130-20045-7-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 4a2a6af..0373ebe 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -116,9 +116,14 @@
 		reg = <0 0x20020000 0 0x1000>;
 		dma-coherent;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0 1>,
+				<0 0 0 2 &pcie0 2>,
+				<0 0 0 3 &pcie0 3>,
+				<0 0 0 4 &pcie0 4>;
+		interrupts = <GIC_SPI 281 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <0>;
 
@@ -147,9 +152,14 @@
 		reg = <0 0x50020000 0 0x1000>;
 		dma-coherent;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_NONE>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie4 1>,
+				<0 0 0 2 &pcie4 2>,
+				<0 0 0 3 &pcie4 3>,
+				<0 0 0 4 &pcie4 4>;
+		interrupts = <GIC_SPI 305 IRQ_TYPE_NONE>;
 
 		linux,pci-domain = <4>;
 
@@ -169,7 +179,6 @@
 
 		phys = <&pci_phy1>;
 		phy-names = "pcie-phy";
-
 		msi-parent = <&v2m0>;
 	};
 
-- 
2.1.4
