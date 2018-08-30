Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CBFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206DC2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCrUtyh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206DC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeH3VT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeH3VT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:19:27 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9FDF20837;
        Thu, 30 Aug 2018 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649380;
        bh=wdtKmOXaY4WjtXrllkSL4FAoAX5EMhJB0CJTALyH6gg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QCrUtyh4G6xhSiTciFgi2GYLviXCeSRyeAU+lMrvHYQ57a2TdgW1R7tYx820Vxmql
         jFGLXcWIgicnsi+VSZi4uKSMdUaijHEntDFldaGbCIoi48v2yqH3Hclaa65or/4gE+
         UXu0RbkD6MmkkRCCX8jtxqqp3CjfaYbg8x012coo=
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
Subject: [PATCH 1/6] dt-bindings: crypto: Add Freescale Vybrid CRC
Date:   Thu, 30 Aug 2018 19:15:34 +0200
Message-Id: <20180830171539.20008-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180830171539.20008-1-krzk@kernel.org>
References: <20180830171539.20008-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Freescale/NXP Vybrid CRC HW accelerator.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/crypto/fsl-vf610-crc.txt         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt

diff --git a/Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt b/Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt
new file mode 100644
index 000000000000..cdd7e26baeac
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt
@@ -0,0 +1,16 @@
+Freescale/NXP Vybrid VF500/VF610 CRC HW accelerator
+
+Required properties:
+- compatible : Should be "fsl,vf610-crc"
+- reg : Should contain register location and length.
+- clocks : Should contain the clock driving the CRC block.
+- clock-names : Should be set to "crc".
+
+Example:
+
+crc@40033000 {
+	compatible = "fsl,vf610-crc";
+	reg = <0x40033000 0x10>;
+	clocks = <&clks VF610_CLK_CRC>;
+	clock-names = "crc";
+};
-- 
2.14.1

