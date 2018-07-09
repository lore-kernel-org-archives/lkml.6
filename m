Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53C5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AE120844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AE120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeGIP7J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:59:09 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbeGIP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:59:04 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LhNMu-1gOrsJ3LlI-00maWp; Mon, 09 Jul 2018 17:58:04 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Peter Rosin <peda@axentia.se>,
        Romain Izard <romain.izard.pro@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mtd: atmel nand: fix build warning on 64-bit
Date:   Mon,  9 Jul 2018 17:57:03 +0200
Message-Id: <20180709155730.2422841-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180709155730.2422841-1-arnd@arndb.de>
References: <20180709155730.2422841-1-arnd@arndb.de>
X-Provags-ID: V03:K1:c+dyJrgBfWh82vW2V2LsrYOJDpfCWcJnKt7zsAaCGvu5HDWD4UZ
 4Wpdd7nX+So7cJLlksTteChSOs+kLr8WUcKUIo5zRjWMgiyjwBNseoZ3mGQav2UMeJrDCox
 fQj7nIJqBllgbW8Mw5BEVdotBxaygHHJW/tHBhJfIbr08viTfntFCZxOxQH/Y5V7AWLtbVg
 OmlGwuLWqxVaLbW0/kxlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tN3BDP4gkMo=:gxpR7gzPxnst2CeETPdXhc
 3Z1+rDyiqthkDyuWxCjSSMmfDYqW14SijW0wbrG/Ndk/CUAaE3BnG0OcArX0Foi/Px4GgAqhf
 CfR7AmGwelVFlF4RJjafyrHCuCHjPMidp6Yei8nR/4fqbK2HaLT1ZvsRXh6k07+YxUCorT+Ze
 kpfTkONYv5lxTjU0EpF1viO/PUZksrLBtEQ8d8Fy1PA47jo7CkVizkcQx54C+jVfuvGZK7Ct7
 1sV31Zpf0QsWeuiomGJxvwmBqNd2hnWQj32kxgdKenJKuqBFE0+XUyNk0Cm1OesJK9zm7HnML
 unLVbJ3jEO/q5X7anHSSHXt54f8mKoBe6FSqqkZkVE7fnXOqQWsIFZi+4QutxbNZ/8n/voXFI
 nd85sa+o7a4LfSuao1bzkB1sL6MN09X2tWZdiVbTvk/HlTsuMmcZkbhuBJmqaXS5XhjEF0FiL
 XMnNdFpyo9UqrgT2Er4IcmSJzG3bG9qHeq/i0p3GW1QVLHhF0fj7AkGkwT6X+VbIsTv9lWaxg
 Nf0LK5eMphS/55R8HPzM6AnAJuufJly+bJZR8TzA05RYzsP3gN9C3UwBXAFtgc0V4X6zkkF1C
 uydq3ul9gILTZh3eG5qaIYv0zngoy4I0E1hj30yjco0hTAT6ayzZ0r0FHndwoFuvuKr30FXbr
 bZP6BUKBeumldwpSJsXTC/rv+OGW6DENyBHeaGdQiQn7xNXPasi2Q4TVMozh+34VCkU0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build-testing this driver on a 64-bit architecture produces a
harmless warning:

drivers/mtd/nand/raw/atmel/nand-controller.c: In function 'atmel_smc_nand_controller_init':
drivers/mtd/nand/raw/atmel/nand-controller.c:2053:21: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

To cast the pointer correctly, the destination type should be
uintptr_t rather than a 32-bit int.

Fixes: c2f3d0b913a5 ("mtd: rawnand: atmel: Allow selection of this driver when COMPILE_TEST=y")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index e686fe73159e..e8f7549d0354 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2050,7 +2050,7 @@ atmel_smc_nand_controller_init(struct atmel_smc_nand_controller *nc)
 		return ret;
 	}
 
-	nc->ebi_csa_offs = (unsigned int)match->data;
+	nc->ebi_csa_offs = (uintptr_t)match->data;
 
 	/*
 	 * The at91sam9263 has 2 EBIs, if the NAND controller is under EBI1
-- 
2.9.0

