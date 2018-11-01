Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B2720833
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B2720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeKBC7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:59:21 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:58266 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbeKBC7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:59:20 -0400
X-Greylist: delayed 1328 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Nov 2018 22:59:19 EDT
Received: from 74.172.62.81.static.wline.lns.sme.cust.swisscom.ch ([81.62.172.74] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1gIGqB-00050B-OD; Thu, 01 Nov 2018 18:33:07 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
Date:   Thu,  1 Nov 2018 18:32:47 +0100
Message-Id: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
function blocks. Add their ipg and per clocks to the device tree.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---

I tried to make this similar to gpt1 and gpt2.

 arch/arm/boot/dts/imx25.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index b25309d26ea5..e80101847aff 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -388,12 +388,16 @@
 			epit1: timer@53f94000 {
 				compatible = "fsl,imx25-epit";
 				reg = <0x53f94000 0x4000>;
+				clocks = <&clks 83>, <&clks 43>;
+				clock-names = "ipg", "per";
 				interrupts = <28>;
 			};
 
 			epit2: timer@53f98000 {
 				compatible = "fsl,imx25-epit";
 				reg = <0x53f98000 0x4000>;
+				clocks = <&clks 84>, <&clks 43>;
+				clock-names = "ipg", "per";
 				interrupts = <27>;
 			};
 
-- 
2.1.4

