Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE72C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01343208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01343208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeGKIoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:44:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeGKIoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:44:00 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M8iVg-1fn7Ld25oC-00C7RG; Wed, 11 Jul 2018 10:40:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: nand/raw: MTD_NAND_BCM47XXNFLASH needs CONFIG_BCMA
Date:   Wed, 11 Jul 2018 10:39:44 +0200
Message-Id: <20180711084010.57950-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:uT/RAWCKnBwr/+bmP8FQZgIQSgieh1sy0A7sM8MAqcrtiXdqUYk
 OguazQp4+1nbZ4QBcixmt2Y9AE7Zq1MhKO//jaoUUb73uIcjrT2PsC6Z5U9RL48NhRlg5qc
 L+yesTvxF7EIa9XKh7lSa3Tuqjhzl1Tb633ciBfhQXwnAzaHAq+rKyWyUquRUMXX5v0fcqx
 dcUgTudWIXb9/7Wk+4wsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rVp2tNtIMMk=:nmjtm83V6ZsMKmbK6qH9eW
 h+u5MV8RRSGdcuDckyqRct4HM92ssWd8clJNsnKl/8N/tBNLi5Ggycv5SjsBaGkQ6LD8HwQiF
 IRCs39E9slRI9l9tqqv+SCpG/wVdg0YFdwRNCgLTdfWbM8x372B29/Beh/kX+lFck2251AXAW
 1dOQ4IN0cfrnwmgyxHxtMNFw8Vd5IMudT201Ya48a2i63uYTvWtsAzElPAdAdvQ5dSy8w6XT+
 VylJSeqX/sCNXV+B5XWTR6nbzZnK5dAytC7qtrVXg/Zdcz64HnDhsa3+oYj+ZGKhVfPlXlEa+
 y06Pm0+p7bWo4nVW+S1d5eKdoa2F8tO3p/Hr+Av0t0RodsrigknXMY74TWeasWuwpXvGtmx77
 U0CZnTTEtI5fx0FCm5Rn6udMpZBjf3QeMgpcb2lpKvNGMzUx2W5Ji3oWs9bAcbEu/lP19Lk7B
 6aA4BjtErKX3CZOnI+H8V5sJIm6nEdUe5u37rpgAe3hnjV4Vk/XK0PQGcpPlPZWGfU66frEfr
 43fWyEqDJXNcJKXQnx612XrMo6auBmHxmqOMT4x/+6JmRH5t02tRLII69c6baMh90veqAB3q5
 +aLM064dMKAk1XhHg/YbA8XDZRe4Gh27eG1e+B1l4+XnmGFiFseT7we1oVf1p5kbKUOLQo9e4
 5A1c19SxbxyhmAZlbmCsCfUWOnmFFAM1s1Bx+m5t6RXYKBb6mCjQ4ygHrjkf9KxnydDA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have a dependency on BCMA_NFLASH, which in turn depends on
BCMA, but since BCMA is a tristate option and BCMA_NFLASH is bool,
we can run into an invalid configuration with MTD_NAND_BCM47XXNFLASH=y
and BCMA=m:

drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.o: In function `bcm47xxnflash_ops_bcm4706_init':
ops_bcm4706.c:(.text+0x790): undefined reference to `bcma_chipco_pll_read'

Adding the dependency here forces MTD_NAND_BCM47XXNFLASH to only be
configured =m here so it can link against the BCMA driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 230311fa2cc0..b457f92d55d4 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -364,6 +364,7 @@ config MTD_NAND_BRCMNAND
 config MTD_NAND_BCM47XXNFLASH
 	tristate "Support for NAND flash on BCM4706 BCMA bus"
 	depends on BCMA_NFLASH
+	depends on BCMA
 	help
 	  BCMA bus can have various flash memories attached, they are
 	  registered by bcma as platform devices. This enables driver for
-- 
2.9.0

