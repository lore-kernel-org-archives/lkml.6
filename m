Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F1CC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D4321855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="h5hFIIMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfAYUJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:09:52 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48098 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbfAYUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548446986; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NM4ItCzfJO9pq/qOaOe9KSqoi+LEuDtakbCpByYR+7k=;
        b=h5hFIIMFOhZZkp1I38ABRbo1oYLPDzUfho/o42eHYwGpsR+6Ak0Doy1r8wt3p9yTpTwuJm
        8mK92IkCtpu5m9lcCLxVRCMX2ljHEsGMW/8/gBVXX4QX438h76fQ9iOEnurwWK2r5DAzKC
        +zGlAufUh6xiIpg++p0tw8xVIW1lTSY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] MIPS: DTS: jz4740: Add node for the MMC driver
Date:   Fri, 25 Jan 2019 17:09:26 -0300
Message-Id: <20190125200927.21045-2-paul@crapouillou.net>
In-Reply-To: <20190125200927.21045-1-paul@crapouillou.net>
References: <20190125200927.21045-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree node for the jz4740-mmc driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 6fb16fd24035..35c48e1e853f 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -132,6 +132,24 @@
 		};
 	};
 
+	mmc: mmc@10021000 {
+		compatible = "ingenic,jz4740-mmc";
+		reg = <0x10021000 0x1000>;
+
+		clocks = <&cgu JZ4740_CLK_MMC>;
+		clock-names = "mmc";
+
+		interrupt-parent = <&intc>;
+		interrupts = <14>;
+
+		dmas = <&dmac 27 0xffffffff>, <&dmac 26 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		cap-sdio-irq;
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4740-uart";
 		reg = <0x10030000 0x100>;
@@ -164,9 +182,6 @@
 		interrupts = <29>;
 
 		clocks = <&cgu JZ4740_CLK_DMA>;
-
-		/* Disable dmac until we have something that uses it */
-		status = "disabled";
 	};
 
 	uhc: uhc@13030000 {
-- 
2.11.0

