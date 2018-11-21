Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C800EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1E120C01
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="inH/Fp7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1E120C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbeKUWNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:13:22 -0500
Received: from mail-sender240.upb.ro ([141.85.13.240]:38946 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729031AbeKUWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:13:20 -0500
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id D7C7EB560073;
        Wed, 21 Nov 2018 13:28:53 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id B557AB56006E;
        Wed, 21 Nov 2018 13:28:53 +0200 (EET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro B557AB56006E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1542799733;
        bh=UARTU5rCrs/F7oPVpIMAN/3yS88WsiHePM4C3sd7yRI=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=inH/Fp7C7YUJgnw2mE3ZY9LezKeZHY99J9QdaHmOnZIK9934m/7ui9s+QQFvCVELw
         lRYBI6qYm2YiUlqW1E0B9f0nSdGMcsxiPBc+BTEwHGi33NdsU8Rnm9TTXR8NmERePI
         EjKdLzMxbpUpAkuYp/A/AK4QXxrpm/otDVd+x6FI=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id USNASV4Z7DhC; Wed, 21 Nov 2018 13:28:53 +0200 (EET)
Received: from asus-rog.localdomain (arh.pub.ro [141.85.160.17])
        by mx.upb.ro (Postfix) with ESMTPSA id 8B940B560070;
        Wed, 21 Nov 2018 13:28:53 +0200 (EET)
From:   Radu Pirea <radu_nicolae.pirea@upb.ro>
To:     richard.genoud@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.co,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>
Subject: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for SPI mode
Date:   Wed, 21 Nov 2018 13:27:31 +0200
Message-Id: <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for DMA are now common for both drivers of the USART
IP.

The node given as an example for USART in SPI mode has been updated in
order to include DMA bindings.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
---
 .../devicetree/bindings/mfd/atmel-usart.txt       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Docu=
mentation/devicetree/bindings/mfd/atmel-usart.txt
index 7f0cd72f47d2..8ad008175343 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -17,17 +17,19 @@ Required properties for USART in SPI mode:
 - cs-gpios: chipselects (internal cs not supported)
 - atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings=
/mfd/at91-usart.h)
=20
+Optional properties in serial and SPI mode:
+- dma bindings for dma transfer:
+	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
+		memory peripheral interface and USART DMA channel ID, FIFO configurati=
on.
+		Refer to dma.txt and atmel-dma.txt for details.
+	- dma-names: "rx" for RX channel, "tx" for TX channel.
+
 Optional properties in serial mode:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI=
/DCD line respectively.
   It will use specified PIO instead of the peripheral function pin for t=
he USART feature.
   If unsure, don't specify this property.
-- add dma bindings for dma transfer:
-	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
-		memory peripheral interface and USART DMA channel ID, FIFO configurati=
on.
-		Refer to dma.txt and atmel-dma.txt for details.
-	- dma-names: "rx" for RX channel, "tx" for TX channel.
 - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store =
for FIFO
   capable USARTs.
 - rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time:=
 see rs485.txt
@@ -81,5 +83,8 @@ Example:
 		interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH 5>;
 		clocks =3D <&usart0_clk>;
 		clock-names =3D "usart";
+		dmas =3D <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
+		       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+		dma-names =3D "tx", "rx";
 		cs-gpios =3D <&pioB 3 0>;
 	};
--=20
2.19.1

