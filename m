Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015FCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B6620658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B6620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeHaUry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:54 -0400
Received: from mout.perfora.net ([74.208.4.194]:48097 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeHaUrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:53 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LvTAD-1fnHuW2wrr-010f02; Fri, 31 Aug 2018 18:39:28 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 32/34] ARM: tegra: apalis_t30: fix mcp2515 can controller interrupt polarity
Date:   Fri, 31 Aug 2018 18:38:14 +0200
Message-Id: <20180831163817.23970-33-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:230Xtk2ZiwwNKyuXJcaSY41Ajy7eB8weI5O/ZeqGSGP+OSEq4nu
 EizLFxH3XLlnmwkCAIUKS9w9tW4ZaL9BKgsjA2Nqoy0CtOWvI5+tUKysDSPEQvqHidPS2yi
 5PS+D/pamYroiynNa8Ibgx89Pf8RkmyWD6RbNPGrU32GdAse2mhLx7DyBvPb8XpEtL1qxzn
 Me9HnE1nXEBsF9HYwQljw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GfRrexuqcP8=:EnOUi5EUOaaYwAVxzH+qO0
 hSTEOYmm7Vfq7ypQwmXCfMNxDfSPTzBZ0fF3nTcZo6WJId2WpP3c0sBnDwct/ZO6eoAFJpwLb
 Xa4wCSNRC/mqBGE8ThA2LwQGxgskVeEKsY1YbIO4C538GhoVZbEQ9TCdaygAbT4Agpn4rHWPa
 HITeL6eFNmT4EqQewoDWUBW4gg8C6vV5Xn3akZoSVWDF7DusWv8Ac0clDRt52Sp5IZVDcSa3C
 f59QaiwyFPAbS4U9sE57qVIA8ukoWNKdTTDrfvY1WZlAThNpqkGG4HfLY3/UcaK7voG8bnAc1
 74HtQFoANzafQSjikgZOEjZTgoI4hL6agLbMJi2vbYdtHSUXA0jSIJSuVUU4dlJplASkBxxOa
 l58/JM2qE3ETX0IXIE4HzFBuvkS1/YQAaWVqiOWVHKc75RCf8d2hxuR15/NIJkrRoArmYalRF
 UtT/haI0vC6vnXp1i8p22LUv9EyGcmRXkgSHjrbi2OcpPmPoFfPJds9jOoIFYVxrTwYBYo3og
 eWoBZ+AuaNu7uO4wuE7fJWprKLriEmksIs2MgBy1OeBHC9LPXeSN73Jeewu6273UJLyHSAnbi
 oBgFgZnhBvl+mubikRJCIvv0hA87fvTFVPuDOIyeJ4Q7JXu1XoCvKN5haxASYjyybdiSoH9uh
 rowJWUSUSYAtf2trTaVASwvbDvCmmEzkCLy0M71dBewum81N9Pw8EjIy1ZdE6Qrpux48=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix the MCP2515 SPI CAN controller interrupt polarity which according
to its datasheet defaults to low-active aka falling edge.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra30-apalis.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index a31b112f631d..e44b2bce6736 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1039,7 +1039,7 @@
 			reg = <1>;
 			clocks = <&clk16m>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_EDGE_RISING>;
+			interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_EDGE_FALLING>;
 			spi-max-frequency = <10000000>;
 		};
 	};
@@ -1054,7 +1054,7 @@
 			reg = <0>;
 			clocks = <&clk16m>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(W, 2) IRQ_TYPE_EDGE_RISING>;
+			interrupts = <TEGRA_GPIO(W, 2) IRQ_TYPE_EDGE_FALLING>;
 			spi-max-frequency = <10000000>;
 		};
 	};
-- 
2.14.4

