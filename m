Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF92C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE91520838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyQq/Rh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE91520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeH3VTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeH3VTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:19:42 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381DD20658;
        Thu, 30 Aug 2018 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649394;
        bh=PNN87A65UfxHviIwzInsOFxL5QQ0ihIMedvB7HJZ5fw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eyQq/Rh6W5MppnhkymAOBwNQu7ZVxf7wLMdADdOstzN1F4ZlHUhFC5xTioaTmayov
         jA+Bv9L2dxlj5Fgp+Z78hQWyZKOTyxdVO4M7a0c10kPZcHLdHZodZCzjyReGirtSTL
         yOU8msJai0kFzScLQXKZgZvnOZPCI5NKFjrOpoos=
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
Subject: [PATCH 5/6] crypto - Group Freescale/NXP ARM architecture Kconfig entires together
Date:   Thu, 30 Aug 2018 19:15:38 +0200
Message-Id: <20180830171539.20008-6-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180830171539.20008-1-krzk@kernel.org>
References: <20180830171539.20008-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group Freescale/NXP Kconfig entires for ARM architecture CPUs/SoCs
together to make it more consistent and easy to read.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/Kconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index a8c4ce07fc9d..20314d7a7b58 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -402,6 +402,22 @@ config CRYPTO_DEV_MXC_SCC
 	  This option enables support for the Security Controller (SCC)
 	  found in Freescale i.MX25 chips.
 
+config CRYPTO_DEV_MXS_DCP
+	tristate "Support for Freescale MXS DCP"
+	depends on (ARCH_MXS || ARCH_MXC)
+	select STMP_DEVICE
+	select CRYPTO_CBC
+	select CRYPTO_ECB
+	select CRYPTO_AES
+	select CRYPTO_BLKCIPHER
+	select CRYPTO_HASH
+	help
+	  The Freescale i.MX23/i.MX28 has SHA1/SHA256 and AES128 CBC/ECB
+	  co-processor on the die.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mxs-dcp.
+
 config CRYPTO_DEV_EXYNOS_RNG
 	tristate "EXYNOS HW pseudo random number generator support"
 	depends on ARCH_EXYNOS || COMPILE_TEST
@@ -542,22 +558,6 @@ if CRYPTO_DEV_CCP
 	source "drivers/crypto/ccp/Kconfig"
 endif
 
-config CRYPTO_DEV_MXS_DCP
-	tristate "Support for Freescale MXS DCP"
-	depends on (ARCH_MXS || ARCH_MXC)
-	select STMP_DEVICE
-	select CRYPTO_CBC
-	select CRYPTO_ECB
-	select CRYPTO_AES
-	select CRYPTO_BLKCIPHER
-	select CRYPTO_HASH
-	help
-	  The Freescale i.MX23/i.MX28 has SHA1/SHA256 and AES128 CBC/ECB
-	  co-processor on the die.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called mxs-dcp.
-
 source "drivers/crypto/qat/Kconfig"
 source "drivers/crypto/cavium/cpt/Kconfig"
 source "drivers/crypto/cavium/nitrox/Kconfig"
-- 
2.14.1

