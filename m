Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5821C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9686C208A5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9686C208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbeG0N1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:27:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35187 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbeG0N1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:27:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E2E4B20884; Fri, 27 Jul 2018 14:05:45 +0200 (CEST)
Received: from localhost (unknown [88.128.81.178])
        by mail.bootlin.com (Postfix) with ESMTPSA id A41C2206EE;
        Fri, 27 Jul 2018 14:05:45 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 3/4] mips: dts: mscc: Add spi on Ocelot
Date:   Fri, 27 Jul 2018 14:05:34 +0200
Message-Id: <20180727120535.16504-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
References: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SPI controller

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index 4f33dbc67348..f7616a476247 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -91,6 +91,17 @@
 			status = "disabled";
 		};
 
+		spi: spi@101000 {
+			compatible = "mscc,ocelot-spi", "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x101000 0x100>, <0x3c 0x18>;
+			interrupts = <9>;
+			clocks = <&ahb_clk>;
+
+			status = "disabled";
+		};
+
 		switch@1010000 {
 			compatible = "mscc,vsc7514-switch";
 			reg = <0x1010000 0x10000>,
-- 
2.18.0

