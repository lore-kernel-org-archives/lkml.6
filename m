Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4049C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7657020877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7657020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934080AbeGIP7n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:59:43 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933565AbeGIP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:59:40 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MFKbs-1fqu1w2NG8-00EMEx; Mon, 09 Jul 2018 17:58:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mtd: sunxi_nand: fix build warning
Date:   Mon,  9 Jul 2018 17:57:04 +0200
Message-Id: <20180709155730.2422841-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180709155730.2422841-1-arnd@arndb.de>
References: <20180709155730.2422841-1-arnd@arndb.de>
X-Provags-ID: V03:K1:rs37fhogpXsDddcc/Tg/tg9RyRGZES2mpCS2k8fM/bageXDxj0G
 Uvplqtd0sa94pn4FviKHPFaKDCplZ8MGTjZdvi0I5ZvbZ1kruA299+TzpLQUTycdWKCBQ0x
 YmGgJhg6fq071b4+gp32U+1sfQw3DXWQ1ly2+4WYMvgK3kvicleQ0ANI9iCGQDlKBTisw3h
 TmIR5xdtwbnbFkFJJZ46A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j+AbLGmx0kQ=:Gz4zVvVpyB1kYk+nRQlNCB
 clCz+JHxRzHCtuFEwEoROzXKQ3GMC9e6WYVmg40CqBuTnPV0ogLlCghP4ZxBO0MXv4QiFfzPH
 2UwPrKGLzDLewq6QlDQ9fPNfI+CvHivZ99OzYIoTQ2IH+xw31DV/UcS4BDy0aUqNxNPo/+rfa
 cTBOAymHEW5YzfTujnFlKTjULkIzv1vSCxTZw3RTgqE6vCtTec5av+zW9R4OPeXQ1kmvnPjoz
 6khRakSrMmxAqWvyoKZbcTY4rvm+wbBvDhTaTUm2D+a1LVT6EyuVk5drRAyFc1mcCnQh4ZtWj
 8cfFAei+KiJxMNibi1nHdooF5McC284JEejNJXAS+S5HF1un6PkdtUwjmhhf4NovoT03xXwGJ
 WAnAEVuk2EH9lqQCUwlraJqQ3CVrx4P06JG8Ca/YAwV7d98YSOKAx/n9BHcmus8tFnTk2h5YT
 yAT6c8DWprWrEAemKGUxs05owlJlDUItciTpXsdbvffXxzegdSL2GtEylcpABMR78IpGE/Op5
 bqGnaRiN3WV2RNYEhN8xGVTONsq/6Fd9rnBs0YS9HxuSSdOlWDmnF8u5mw7V2IuN8W1pIvtX3
 hIX1r6sCbhZcMoAzvszLTTNlV4dyDpFoDDWWE63bFLb5QT745I7B0Y6Cs1IFvt2dllajRJnVn
 wfpkuY48s9Lh3rK9iipgpOAoaxcb2xBi/2nKYdj2em2pFiylVX9YEkvxZHLxosWnYx+A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

build-testing this driver on x86 shows a new warning:

Fixes: b3d926a3d6e0 ("mtd: rawnand: sunxi: Allow selection of this driver when COMPILE_TEST=y")
drivers/mtd/nand/raw/sunxi_nand.c: In function 'sunxi_nfc_hw_ecc_read_chunks_dma':
drivers/mtd/nand/raw/sunxi_nand.c:130:22: error: conversion from 'long unsigned int' to 'unsigned int' changes value from '18446744071631273984' to '2216689664' [-Werror=overflow]
 #define NFC_PAGE_OP  (2 << 30)
drivers/mtd/nand/raw/sunxi_nand.c:1040:9: note: in expansion of macro 'NFC_PAGE_OP'
  writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD | NFC_DATA_TRANS,
         ^~~~~~~~~~~
drivers/mtd/nand/raw/sunxi_nand.c: In function 'sunxi_nfc_hw_ecc_write_page_dma':
drivers/mtd/nand/raw/sunxi_nand.c:130:22: error: conversion from 'long unsigned int' to 'unsigned int' changes value from '18446744071632322560' to '2217738240' [-Werror=overflow]
 #define NFC_PAGE_OP  (2 << 30)
drivers/mtd/nand/raw/sunxi_nand.c:1406:9: note: in expansion of macro 'NFC_PAGE_OP'
  writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD |

This is easy to avoid by ensuring that the constants are 'unsigned'.

Fixes: b3d926a3d6e0 ("mtd: rawnand: sunxi: Allow selection of this driver when COMPILE_TEST=y")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index d831a141a196..fa5c48502fa8 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -125,9 +125,9 @@
 #define NFC_SEND_CMD3		BIT(28)
 #define NFC_SEND_CMD4		BIT(29)
 #define NFC_CMD_TYPE_MSK	GENMASK(31, 30)
-#define NFC_NORMAL_OP		(0 << 30)
-#define NFC_ECC_OP		(1 << 30)
-#define NFC_PAGE_OP		(2 << 30)
+#define NFC_NORMAL_OP		(0u << 30)
+#define NFC_ECC_OP		(1u << 30)
+#define NFC_PAGE_OP		(2u << 30)
 
 /* define bit use in NFC_RCMD_SET */
 #define NFC_READ_CMD_MSK	GENMASK(7, 0)
-- 
2.9.0

