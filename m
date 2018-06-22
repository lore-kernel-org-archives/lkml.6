Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A698AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9AB2403B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bYTvZM4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9AB2403B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933463AbeFVKQh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:16:37 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:9032 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754314AbeFVKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:16:34 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5MAGRLN001418;
        Fri, 22 Jun 2018 05:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529662587;
        bh=XaLb560xNzXhp8tlgjsKSuYW5H1uIlQpaZRlPNx5J8U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bYTvZM4CEzv9l3yUwMo0geD/I3gw0J27Mu7zgArIv4+DEbeG8P8kxkPImP862evZW
         Ud3hqh1BzcukgeIPgvcFuqKyD/mUi8l9StTCKaVpYGWxpnhnrd04PsC+7IOMPDxme9
         drzdBIPx8FfnSTFo3BZiE7sVWlGH+PX3B+Q7ucKU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MAGR3Q011880;
        Fri, 22 Jun 2018 05:16:27 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 22
 Jun 2018 05:16:27 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 22 Jun 2018 05:16:27 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MAGI3U032544;
        Fri, 22 Jun 2018 05:16:25 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>, <kishon@ti.com>
CC:     <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH RESEND 2/3] ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model
Date:   Fri, 22 Jun 2018 15:46:16 +0530
Message-ID: <20180622101617.11157-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622101617.11157-1-kishon@ti.com>
References: <20180622101617.11157-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sdhci-omap programming model based on the generic sdhci
library for programming the MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index da78c0034427..af6bf1301cf5 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -391,13 +391,10 @@
 		};
 
 		mmc0: mmc@23000000 {
-			compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
+			compatible = "ti,k2g-sdhci";
 			reg = <0x23000000 0x400>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>;
-			dmas = <&edma1 24 0>, <&edma1 25 0>;
-			dma-names = "tx", "rx";
 			bus-width = <4>;
-			ti,needs-special-reset;
 			no-1-8-v;
 			max-frequency = <96000000>;
 			power-domains = <&k2g_pds 0xb>;
@@ -407,13 +404,12 @@
 		};
 
 		mmc1: mmc@23100000 {
-			compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
+			compatible = "ti,k2g-sdhci";
 			reg = <0x23100000 0x400>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_EDGE_RISING>;
-			dmas = <&edma1 26 0>, <&edma1 27 0>;
-			dma-names = "tx", "rx";
 			bus-width = <8>;
-			ti,needs-special-reset;
+			no-1-8-v;
+			non-removable;
 			max-frequency = <96000000>;
 			power-domains = <&k2g_pds 0xc>;
 			clocks = <&k2g_clks 0xc 1>, <&k2g_clks 0xc 2>;
-- 
2.17.1

