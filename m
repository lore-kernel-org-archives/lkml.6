Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD44C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E8D20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E8D20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934769AbeFRIRP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:17:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934694AbeFRIRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:17:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 880E8C7A;
        Mon, 18 Jun 2018 08:17:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 050/279] arm64: dts: correct SATA addresses for Stingray
Date:   Mon, 18 Jun 2018 10:10:35 +0200
Message-Id: <20180618080610.910242796@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinath Mannam <srinath.mannam@broadcom.com>

[ Upstream commit 4555a5021fe88fc4f19ff53d1e58b410cf30a49a ]

Correct all SATA ahci and phy controller register
addresses and interrupt lines to proper values.

Fixes: 344a2e514182 ("arm64: dts: Add SATA DT nodes for Stingray SoC")

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi |   80 +++++++--------
 1 file changed, 40 insertions(+), 40 deletions(-)

--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
@@ -36,11 +36,11 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x67d00000 0x00800000>;
 
-		sata0: ahci@210000 {
+		sata0: ahci@0 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00210000 0x1000>;
+			reg = <0x00000000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -52,9 +52,9 @@
 			};
 		};
 
-		sata_phy0: sata_phy@212100 {
+		sata_phy0: sata_phy@2100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00212100 0x1000>;
+			reg = <0x00002100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -66,11 +66,11 @@
 			};
 		};
 
-		sata1: ahci@310000 {
+		sata1: ahci@10000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00310000 0x1000>;
+			reg = <0x00010000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -82,9 +82,9 @@
 			};
 		};
 
-		sata_phy1: sata_phy@312100 {
+		sata_phy1: sata_phy@12100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00312100 0x1000>;
+			reg = <0x00012100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -96,11 +96,11 @@
 			};
 		};
 
-		sata2: ahci@120000 {
+		sata2: ahci@20000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00120000 0x1000>;
+			reg = <0x00020000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -112,9 +112,9 @@
 			};
 		};
 
-		sata_phy2: sata_phy@122100 {
+		sata_phy2: sata_phy@22100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00122100 0x1000>;
+			reg = <0x00022100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -126,11 +126,11 @@
 			};
 		};
 
-		sata3: ahci@130000 {
+		sata3: ahci@30000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00130000 0x1000>;
+			reg = <0x00030000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -142,9 +142,9 @@
 			};
 		};
 
-		sata_phy3: sata_phy@132100 {
+		sata_phy3: sata_phy@32100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00132100 0x1000>;
+			reg = <0x00032100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -156,11 +156,11 @@
 			};
 		};
 
-		sata4: ahci@330000 {
+		sata4: ahci@100000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00330000 0x1000>;
+			reg = <0x00100000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -172,9 +172,9 @@
 			};
 		};
 
-		sata_phy4: sata_phy@332100 {
+		sata_phy4: sata_phy@102100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00332100 0x1000>;
+			reg = <0x00102100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -186,11 +186,11 @@
 			};
 		};
 
-		sata5: ahci@400000 {
+		sata5: ahci@110000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00400000 0x1000>;
+			reg = <0x00110000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -202,9 +202,9 @@
 			};
 		};
 
-		sata_phy5: sata_phy@402100 {
+		sata_phy5: sata_phy@112100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00402100 0x1000>;
+			reg = <0x00112100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -216,11 +216,11 @@
 			};
 		};
 
-		sata6: ahci@410000 {
+		sata6: ahci@120000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00410000 0x1000>;
+			reg = <0x00120000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -232,9 +232,9 @@
 			};
 		};
 
-		sata_phy6: sata_phy@412100 {
+		sata_phy6: sata_phy@122100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00412100 0x1000>;
+			reg = <0x00122100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -246,11 +246,11 @@
 			};
 		};
 
-		sata7: ahci@420000 {
+		sata7: ahci@130000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00420000 0x1000>;
+			reg = <0x00130000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -262,9 +262,9 @@
 			};
 		};
 
-		sata_phy7: sata_phy@422100 {
+		sata_phy7: sata_phy@132100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00422100 0x1000>;
+			reg = <0x00132100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;


