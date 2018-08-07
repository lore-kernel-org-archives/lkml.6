Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385C6C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40E121779
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="F25MCOdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40E121779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389137AbeHGN4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:56:46 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55482 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389094AbeHGN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:56:46 -0400
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
Subject: [PATCH v4 18/18] MIPS: JZ4740: DTS: Add DMA nodes
Date:   Tue,  7 Aug 2018 13:42:18 +0200
Message-Id: <20180807114218.20091-19-paul@crapouillou.net>
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
References: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642168; bh=okrC9ogkwAF/BkmrvZ9VIzAvliCVk0o5dmB+A3fikkw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=F25MCOdJ2YqUaQ8aTrFON/UETUJuQCFZTHUaveQdqO/Ju9NoyJ2vq7wArwoCDLFRVWxSXRxsbt7O7M82BJK7orobBmyim7wutpW4JnX87/+JZaP4LY5m15sH+pFIXo5Tl3ULR0P5eDmue/QXkOSPGqvh1KIJgKGuCj0RtzT2RX0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree nodes for the DMA core of the JZ4740 SoC, disabled
by default, as currently there are no clients for the DMA driver
(until the MMC driver and/or others get a devicetree node).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Acked-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

 v2: New patch in this series

 v3: Modify node to comply with devicetree specification

 v4: No change

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 26c6b561d6f7..6fb16fd24035 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -154,6 +154,21 @@
 		clock-names = "baud", "module";
 	};
 
+	dmac: dma-controller@13020000 {
+		compatible = "ingenic,jz4740-dma";
+		reg = <0x13020000 0xbc
+		       0x13020300 0x14>;
+		#dma-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <29>;
+
+		clocks = <&cgu JZ4740_CLK_DMA>;
+
+		/* Disable dmac until we have something that uses it */
+		status = "disabled";
+	};
+
 	uhc: uhc@13030000 {
 		compatible = "ingenic,jz4740-ohci", "generic-ohci";
 		reg = <0x13030000 0x1000>;
-- 
2.11.0

