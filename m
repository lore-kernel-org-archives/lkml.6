Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DFEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7A8205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TWck4qYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7A8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeH3BcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:32:23 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55478 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeH3BcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:32:12 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 18/18] MIPS: JZ4740: DTS: Add DMA nodes
Date:   Wed, 29 Aug 2018 23:33:00 +0200
Message-Id: <20180829213300.22829-19-paul@crapouillou.net>
In-Reply-To: <20180829213300.22829-1-paul@crapouillou.net>
References: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578403; bh=4ZMDlIEdF6HWrLwcHbIYcp/zmQ+d8Y1/lmjcE4wTz08=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TWck4qYe6xuM8veyK9VFqzE8CJ7O7AHEpgnGPFEd/d/68ff1zR3urwLoocOzDuyJS6JrlBDDlamVWW0DczdIX/2ZY5YonyjTov1ujbx0v7860KlqBjAMC2YkcHpkypmdKOtjbjN5b4JSTOnHpUunXaBXd2cZhBElvpU3phKH8v4=
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

Notes:
     v2: New patch in this series
    
     v3: Modify node to comply with devicetree specification
    
     v4: No change
    
     v5: No change

 arch/mips/boot/dts/ingenic/jz4740.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

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

