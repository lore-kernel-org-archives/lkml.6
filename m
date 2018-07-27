Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5B6C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EEF20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EEF20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbeG0VSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:18:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46751 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389406AbeG0VSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:18:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4E17220908; Fri, 27 Jul 2018 21:54:55 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2CC37209DD;
        Fri, 27 Jul 2018 21:54:00 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 4/5] mips: dts: mscc: Add spi on Ocelot
Date:   Fri, 27 Jul 2018 21:53:57 +0200
Message-Id: <20180727195358.23336-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
References: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
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

