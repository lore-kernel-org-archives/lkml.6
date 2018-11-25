Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D449BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41912082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41912082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeKZIMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:12:20 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45242 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKZIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:12:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so15495729qtr.12;
        Sun, 25 Nov 2018 13:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=0I+uWKN4GS3+l65NpqS0JmEUsO4byaMbcY6AlhK07H0=;
        b=ryGLxBRoxPZ/Jra5QLQLDVlFQ2BkRRUKNr8qzLf63uRAUe6lcQSz+TOYf/OuBW44bU
         WGqz/9hwDZsb9RX+oALXhdTSSwLWDUojGvs8fmgicH5keOvwjwgHq0r14yXXROMpn+Av
         QyST4Y9NuRWLxWHt01p0kMulMPwch623ztsfZuc+ZMcqk9342DI8irv1LoH2i0rrDeGR
         yvTmC+kTZnE1Dgd8PyyRgXFxGQ14/exaxVWH0cV1eGAWEkcON5WBhp/KTluL/JkP0dNF
         dzSha2wRMy5S1+yZNWJsjVhjYLWA5pcLfghh8g8DVFELBBvoOtU84Vito/9MIF5XZx2X
         65xA==
X-Gm-Message-State: AGRZ1gJp2HVhGucR3Gzhq0II8gCuoXh/S5hWHNFgmo7Gk6mHM1X5d+Hm
        Nm25w8PEBJ72lDdcm3VAD4wR3aZT
X-Google-Smtp-Source: AFSGD/VyrfXG1zCyouLtc+1trJ7a4jJe26htoOZVOqbegObwHN0OYxggUWdpxqj9LnAD001l+l+ulA==
X-Received: by 2002:aed:3fb1:: with SMTP id s46mr22756161qth.208.1543180820330;
        Sun, 25 Nov 2018 13:20:20 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id v32sm32303696qta.37.2018.11.25.13.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:20:19 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:20:13 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 10/13] ARM: dts: rv1108: Add UART DMA support
Date:   Sun, 25 Nov 2018 19:19:04 -0200
Message-Id: <20181125211907.9895-10-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the 'dmas' property to the UART ports so that DMA can
be supported.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index ce5509c4657b..7ef6d965871c 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -114,6 +114,8 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dmas = <&pdma 6>, <&pdma 7>;
+		#dma-cells = <2>;
 		clock-frequency = <24000000>;
 		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 		clock-names = "baudclk", "apb_pclk";
@@ -128,6 +130,8 @@
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dmas = <&pdma 4>, <&pdma 5>;
+		#dma-cells = <2>;
 		clock-frequency = <24000000>;
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 		clock-names = "baudclk", "apb_pclk";
@@ -142,6 +146,8 @@
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dmas = <&pdma 2>, <&pdma 3>;
+		#dma-cells = <2>;
 		clock-frequency = <24000000>;
 		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 		clock-names = "baudclk", "apb_pclk";
-- 
2.19.1

