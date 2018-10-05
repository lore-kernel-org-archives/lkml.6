Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C47C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7B12148D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z74Ik7xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7B12148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeJEXOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729411AbeJEXOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D56E52148D;
        Fri,  5 Oct 2018 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756098;
        bh=+rkcwb05et1xdaBXiVpZMvPEXsoplu22uNTKnFq/kUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z74Ik7xlZ11x7eoeZlFLGKSt+B3Q8hX/5T/pEPa3k4WSuOrODkMOQ6yYXgnz1Np3F
         LIdz3ytxqeOrS5ErG6ZhzNIgJamgI2ZWicpWx1GdXS9Y//Ui3UHI2YLFLaD2zMx2V+
         Jt4lesrWL8I0pCjwi92v3JQI/PbXu3wchNooFJcw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 37/48] ARM: dts: at91: add new compatibility string for macb on sama5d3
Date:   Fri,  5 Oct 2018 12:14:13 -0400
Message-Id: <20181005161424.20521-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

[ Upstream commit 321cc359d899a8e988f3725d87c18a628e1cc624 ]

We need this new compatibility string as we experienced different behavior
for this 10/100Mbits/s macb interface on this particular SoC.
Backward compatibility is preserved as we keep the alternative strings.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/devicetree/bindings/net/macb.txt | 1 +
 arch/arm/boot/dts/sama5d3_emac.dtsi            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index 457d5ae16f23..3e17ac1d5d58 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -10,6 +10,7 @@ Required properties:
   Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
   the Cadence GEM, or the generic form: "cdns,gem".
   Use "atmel,sama5d2-gem" for the GEM IP (10/100) available on Atmel sama5d2 SoCs.
+  Use "atmel,sama5d3-macb" for the 10/100Mbit IP available on Atmel sama5d3 SoCs.
   Use "atmel,sama5d3-gem" for the Gigabit IP available on Atmel sama5d3 SoCs.
   Use "atmel,sama5d4-gem" for the GEM IP (10/100) available on Atmel sama5d4 SoCs.
   Use "cdns,zynq-gem" Xilinx Zynq-7xxx SoC.
diff --git a/arch/arm/boot/dts/sama5d3_emac.dtsi b/arch/arm/boot/dts/sama5d3_emac.dtsi
index 7cb235ef0fb6..6e9e1c2f9def 100644
--- a/arch/arm/boot/dts/sama5d3_emac.dtsi
+++ b/arch/arm/boot/dts/sama5d3_emac.dtsi
@@ -41,7 +41,7 @@
 			};
 
 			macb1: ethernet@f802c000 {
-				compatible = "cdns,at91sam9260-macb", "cdns,macb";
+				compatible = "atmel,sama5d3-macb", "cdns,at91sam9260-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
-- 
2.17.1

