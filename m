Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D101CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CDF208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CDF208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbeGKMbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:31:47 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35795 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733245AbeGKMbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:31:46 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LvkQW-1g8s9M1tTY-017Wjx; Wed, 11 Jul 2018 14:27:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Abhishek Sahu <absahu@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Archit Taneja <architt@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nand: ranw: qcom_nand: stop using phys_to_dma()
Date:   Wed, 11 Jul 2018 14:26:58 +0200
Message-Id: <20180711122709.358159-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:DRtCrIgwEcOl4UrtxCWSpWoKFBivG4uXqQsT4Tx7GaY+m3uLTbW
 xgTZaDxg/Cu06JJZ/Q088ziFlWpYuMJhSi5sYVR3GP3GoEojx/qVQ8Pc3zR3hvuI8vZyo2N
 oxkCnmYR3ZAiU2tLpAGRFCTMCKK+015YocJqT9QVk8h1f0ANHbdDMEkXNVPGpt36IZX+Uxk
 zdMX3suWUyhsm7QlGRXaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2FqddtewKMA=:KT8mvOnDm6BgQ1toIPTPt0
 j4WChLuKpgM871dFnmcz1hnDXIvvKlq/HMiHZNM+nQ8A2MqgLzdTeGforAMvZP3E7xS+qBFrC
 j6g+RF1TtXkqmkvmGIAVwHoDybXmr4unBNG2u9MwK+WcADk8Pw9SSaGle8wBQMEnnF2v1X+pX
 q2DjqAKQLC4QgcFj+6NnOeN7Aqv13FuvXM0JpbaiWsX18lHHe/oVmyr3HpzzPZrtH1MqVr6ve
 pEwzGyRF7/KTiZcULzVVTR81EaskmDlVEBfXItrswqbzdVOSzGmcYOk/u1SLnBgSO6chVTXnZ
 vi75NiyvIwr3Fa68PuNGKxT6+D6GtL4TcutqbaJmTd8+wFfsHN9hoffpkxWr7YJ2P+uVknz98
 8Cf/rw0h52Lu6vwZg+045pxOM0Yh2JYTU1VglsdMN8bfH545D9EcKIobvW+T+3asMPso8ZsG1
 zyqHmzplON6I1vXE4IoF21fw/uWE5CsnCEDrurqfZ6xIQmU9t1YW1XsPaaKeeGbf1WZl3Jl2D
 VIw1V7cF+QszA3CtSN+6vRLki+lYQAYkAHjF68NN/aeogtIEjE0dwhWIkB0XLiwzGZ+yuWUee
 HB9COaWSJjyrvS4TM3jjpZpap41+yOQsoWBQy4d9gIB1WeISmDiux5qPDzD2nac5tVO/1pbfW
 64FzhSVGg1NXri1p7ni2gQ5BuRfroCmzFT1dSPIDI+R7VUXlSAl/8mk7O3oukUoghdg4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile-testing this driver on x86 caused a link error:

ERROR: "__phys_to_dma" [drivers/mtd/nand/raw/qcom_nandc.ko] undefined!

The problem here is that the driver attempts to convert the physical
address into the DMA controller as a dma_addr_t and calls phys_to_dma()
to do the conversion.

However, there is no generic way to convert a phys_addr_t into a dma_addr_t
for anything other than RAM (which should use the dma-mapping API instead).
The only correct use of phys_to_dma() instead is inside of the dma-mapping
implementation.

In all other drivers that deal with DMA FIFO addresses, we just pass the
physical address directly and have the DMA controller deal with that
if necessary, so let's do the same thing here.

Fixes: c76b78d8ec05 ("mtd: nand: Qualcomm NAND controller driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 994f980c6d86..f047e2819041 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -338,7 +338,6 @@ struct nandc_regs {
  * @dev:			parent device
  * @base:			MMIO base
  * @base_phys:			physical base address of controller registers
- * @base_dma:			dma base address of controller registers
  * @core_clk:			controller clock
  * @aon_clk:			another controller clock
  *
@@ -372,7 +371,6 @@ struct qcom_nand_controller {
 
 	void __iomem *base;
 	phys_addr_t base_phys;
-	dma_addr_t base_dma;
 
 	struct clk *core_clk;
 	struct clk *aon_clk;
@@ -935,11 +933,11 @@ static int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
 	slave_conf.device_fc = flow_control;
 	if (read) {
 		slave_conf.src_maxburst = 16;
-		slave_conf.src_addr = nandc->base_dma + reg_off;
+		slave_conf.src_addr = (dma_addr_t)nandc->base_phys + reg_off;
 		slave_conf.slave_id = nandc->data_crci;
 	} else {
 		slave_conf.dst_maxburst = 16;
-		slave_conf.dst_addr = nandc->base_dma + reg_off;
+		slave_conf.dst_addr = (dma_addr_t)nandc->base_phys + reg_off;
 		slave_conf.slave_id = nandc->cmd_crci;
 	}
 
@@ -2963,7 +2961,6 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 		return PTR_ERR(nandc->base);
 
 	nandc->base_phys = res->start;
-	nandc->base_dma = phys_to_dma(dev, (phys_addr_t)res->start);
 
 	nandc->core_clk = devm_clk_get(dev, "core");
 	if (IS_ERR(nandc->core_clk))
-- 
2.9.0

