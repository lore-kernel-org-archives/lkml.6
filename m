Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF36C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347E620658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vZ6i4p0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347E620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeH3VTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeH3VTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:19:34 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B7120839;
        Thu, 30 Aug 2018 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649387;
        bh=AYT+tlMLbLnMs5G9xn7bAHdPUM2XlEciB1aMR6XRHvU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vZ6i4p0HL9lrqUOQOonjsRuO5D9LZUbUukflm4A4wejpTEVR0mwz4Ze2J6aTK92Vs
         ZZY0+j+75+BvZ806oLH+gIp1chZTcsM1qY4qAcY3V6om3WYajlcbdnn3hIxqp511Nc
         6KrX4276A1jtobo333/Bktp4ujm+jTw3/1ccTYmM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 3/6] ARM: dts: vfxxx: Add node for CRC hardware block
Date:   Thu, 30 Aug 2018 19:15:36 +0200
Message-Id: <20180830171539.20008-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180830171539.20008-1-krzk@kernel.org>
References: <20180830171539.20008-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for HW CRC16/CRC32 accelerator present on VF500 and VF610 SoCs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/vfxxx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index d392794d9c13..d6d0eca02939 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -276,6 +276,13 @@
 				status = "disabled";
 			};
 
+			crc: crc@40033000 {
+				compatible = "fsl,vf610-crc";
+				reg = <0x40033000 0x10>;
+				clocks = <&clks VF610_CLK_CRC>;
+				clock-names = "crc";
+			};
+
 			pit: pit@40037000 {
 				compatible = "fsl,vf610-pit";
 				reg = <0x40037000 0x1000>;
-- 
2.14.1

