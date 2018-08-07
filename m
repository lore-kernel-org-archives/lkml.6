Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E403C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248612178F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="k46fEyrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248612178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbeHGN4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:56:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54812 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389047AbeHGN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:56:44 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v4 17/18] MIPS: JZ4770: DTS: Add DMA nodes
Date:   Tue,  7 Aug 2018 13:42:17 +0200
Message-Id: <20180807114218.20091-18-paul@crapouillou.net>
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
References: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642166; bh=6PZ4W3wcbIozOYTqMg5B5IS+k6rfWWaRVcH3tkCjET0=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k46fEyrnLK/CwEMltVMG2Wua5p45FIc7WxFXsOUcEi4PC9yXbDYK7Hctsa+S0BIWRc6L0WGn/D/CGJavlg+AR5hzyRI4YkDB7jISohomjREhgtAMua4OQmMJkddUtV/qTYf6ONGS8HibEj34wlM4Kl/CdVy8QSq/e8Nv8PIZo8E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two devicetree nodes for the two DMA cores of the JZ4770 SoC,
disabled by default, as currently there are no clients for the DMA
driver (until the MMC driver and/or others get a devicetree node).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Acked-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/boot/dts/ingenic/jz4770.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

 v2: No change

 v3: Modify nodes to comply with devicetree specification

 v4: No change

diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
index 7c2804f3f5f1..49ede6c14ff3 100644
--- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
@@ -196,6 +196,36 @@
 		status = "disabled";
 	};
 
+	dmac0: dma-controller@13420000 {
+		compatible = "ingenic,jz4770-dma";
+		reg = <0x13420000 0xC0
+		       0x13420300 0x20>;
+
+		#dma-cells = <1>;
+
+		clocks = <&cgu JZ4770_CLK_DMA>;
+		interrupt-parent = <&intc>;
+		interrupts = <24>;
+
+		/* Disable dmac0 until we have something that uses it */
+		status = "disabled";
+	};
+
+	dmac1: dma-controller@13420100 {
+		compatible = "ingenic,jz4770-dma";
+		reg = <0x13420100 0xC0
+		       0x13420400 0x20>;
+
+		#dma-cells = <1>;
+
+		clocks = <&cgu JZ4770_CLK_DMA>;
+		interrupt-parent = <&intc>;
+		interrupts = <23>;
+
+		/* Disable dmac1 until we have something that uses it */
+		status = "disabled";
+	};
+
 	uhc: uhc@13430000 {
 		compatible = "generic-ohci";
 		reg = <0x13430000 0x1000>;
-- 
2.11.0

