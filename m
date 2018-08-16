Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C58CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4092148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLEyRbHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4092148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbeHPLka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:40:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39725 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390107AbeHPLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:40:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id a134-v6so2817394lfe.6;
        Thu, 16 Aug 2018 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1koQvgLpOHKSo2UbGrEiF0QLYvVVtdV9mxihlxpb/Nw=;
        b=aLEyRbHn7weMfGOwwxj0FsrASVihKCTEW75/IDvvg+sxLPp2nLP9y8XNxy5QvAvy5u
         ACVld4KihjEBdxFZ6W8hMZq0yLF5x9Osw97hGNzhP4Vi0jc8nIptKRmmgJxXQLPn0lLK
         5wbsE4zw5DXniySvQgQbQcH3bScIZtfNSiJk7qn6O7PTB6WdX0PKpt3Ueq84VJtYYloQ
         X9fqE+JJh3toV0G35i2myCWffCC34S7O1waEVT78my5qxu1gCRxyO1HWhZLPfAm7ga5R
         GAzuzLJtvXFevg4iXAu+HZZalAV/9gQNwuw0eSvMvM8DhRgu43uFrPfygIpvMD/Y7RWf
         zNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1koQvgLpOHKSo2UbGrEiF0QLYvVVtdV9mxihlxpb/Nw=;
        b=Exg8oL6IS6hV3qQfkF/hxvmXNFYLUs5x6Actf8tIWlIHM+IUS/PZMSeUm2ICKJzWVp
         lE1F7cnhBsYuorf7w3r6EMT5l21cNdd1rr2kV977f+YqMzfGsoknUih85ovJvboyBRnl
         FGPgKdMLaODfWeInt0ev6aUt2Jerp2PrHA+dk3GJlcGwifd0tPp8W9pCtYsmSa3kFFc6
         jPFhTwD4XdIqsBDd/D63cbTcTjAWzDAXAoTLILGZBURIreFx1wdguNMm3RYZEKOaGCGp
         RviQqwhUoXYOKHcockI6Eb78EZQ3tojLzHYeve3THAagS1jiimUUK9Eser0rxT50/9On
         Gtbw==
X-Gm-Message-State: AOUpUlFpEgLW+D/HC2A7W1atyy05Hm2VqoIB+8n68Z+Frzj5CJmRAWF7
        ANaqwW1xOXmyqU8w3BmJLzJiUnwyJOM=
X-Google-Smtp-Source: AA+uWPwih7gYGb466Tl2kKRvW09uUTpCRY/vu6QcU9jMLa/Ziy9Cw/vISxalucrzVJPTeRS3XcvgSg==
X-Received: by 2002:a19:a2d5:: with SMTP id l204-v6mr18561688lfe.65.1534409008090;
        Thu, 16 Aug 2018 01:43:28 -0700 (PDT)
Received: from localhost ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id a140-v6sm4901927lfb.21.2018.08.16.01.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 01:43:27 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Esben Haabendal <eha@deif.com>, Shawn Guo <shawnguo@kernel.org>,
        kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] arm: dts: ls1021a: Enable I2C DMA support
Date:   Thu, 16 Aug 2018 10:43:14 +0200
Message-Id: <20180816084315.7857-4-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816084315.7857-1-esben.haabendal@gmail.com>
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Gives substantial performance improvement for transfers larger than 16
bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c55d479971cc..1e5640701c65 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -363,6 +363,8 @@
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 39>, <&edma0 1 38>;
 			status = "disabled";
 		};
 
@@ -374,6 +376,8 @@
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 37>, <&edma0 1 36>;
 			status = "disabled";
 		};
 
@@ -385,6 +389,8 @@
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 35>, <&edma0 1 34>;
 			status = "disabled";
 		};
 
-- 
2.18.0

