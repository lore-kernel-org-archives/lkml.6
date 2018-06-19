Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27FBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A292075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A292075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937782AbeFSMHr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:07:47 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45534 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937592AbeFSMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:07:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id AD3A318188A22;
        Tue, 19 Jun 2018 14:07:44 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        marek.vasut@gmail.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, miquel.raynal@bootlin.com,
        boris.brezillon@bootlin.com, yamada.masahiro@socionext.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
Date:   Tue, 19 Jun 2018 14:07:19 +0200
Message-Id: <20180619120719.26921-1-richard@nod.at>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The denali NAND flash controller needs at least two clocks to operate,
nand_clk and nand_x_clk.
Since 1bb88666775e ("mtd: nand: denali: handle timing parameters by
setup_data_interface()") nand_x_clk is used to derive timing settings.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
Strictly speaking denali needs a ecc_clk too, but AFAIK such a clock
is not present on this SoC.
But my SoCFPGA knowledge is very limited.

Thanks,
//richard
---
 arch/arm/boot/dts/socfpga.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 486d4e7433ed..562f7b375bbd 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -754,7 +754,8 @@
 			reg-names = "nand_data", "denali_reg";
 			interrupts = <0x0 0x90 0x4>;
 			dma-mask = <0xffffffff>;
-			clocks = <&nand_clk>;
+			clocks = <&nand_clk>, <&nand_x_clk>;
+			clock-names = "nand", "nand_x";
 			status = "disabled";
 		};
 
-- 
2.17.1

