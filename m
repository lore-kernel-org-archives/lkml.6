Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A164C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D15D20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBHRtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:49:35 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.119]:47051 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbfBHRtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:49:35 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id E143A1311A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 11:49:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sAHNgRMz6iQersAHNghch0; Fri, 08 Feb 2019 11:49:33 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=57452 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gsAHM-003yuk-E5; Fri, 08 Feb 2019 11:49:33 -0600
Date:   Fri, 8 Feb 2019 11:49:30 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3] mtd: rawnand: Mark expected switch fall-throughs
Message-ID: <20190208174930.GA12962@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gsAHM-003yuk-E5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:57452
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/mtd/nand/raw/diskonchip.c: In function ‘doc_probe’:
./include/linux/printk.h:303:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/diskonchip.c:1479:4: note: in expansion of macro ‘pr_err’
    pr_err("DiskOnChip Millennium Plus 32MB is not supported, ignoring.\n");
    ^~~~~~
drivers/mtd/nand/raw/diskonchip.c:1480:3: note: here
   default:
   ^~~~~~~
drivers/mtd/nand/raw/nandsim.c: In function ‘ns_init_module’:
drivers/mtd/nand/raw/nandsim.c:2254:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
    chip->bbt_options |= NAND_BBT_NO_OOB;
drivers/mtd/nand/raw/nandsim.c:2255:2: note: here
  case 1:
  ^~~~
drivers/mtd/nand/raw/nuc900_nand.c: In function ‘nuc900_nand_command_lp’:
./arch/x86/include/asm/io.h:91:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
 #define __raw_writel __writel
drivers/mtd/nand/raw/nuc900_nand.c:52:2: note: in expansion of macro ‘__raw_writel’
  __raw_writel((val), (dev)->reg + REG_SMCMD)
  ^~~~~~~~~~~~
drivers/mtd/nand/raw/nuc900_nand.c:196:3: note: in expansion of macro ‘write_cmd_reg’
   write_cmd_reg(nand, NAND_CMD_READSTART);
   ^~~~~~~~~~~~~
drivers/mtd/nand/raw/nuc900_nand.c:197:2: note: here
  default:
  ^~~~~~~
drivers/mtd/nand/raw/omap_elm.c: In function ‘elm_context_restore’:
drivers/mtd/nand/raw/omap_elm.c:512:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    elm_write_reg(info, ELM_SYNDROME_FRAGMENT_4 + offset,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      regs->elm_syndrome_fragment_4[i]);
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/omap_elm.c:514:3: note: here
   case BCH8_ECC:
   ^~~~
drivers/mtd/nand/raw/omap_elm.c:517:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    elm_write_reg(info, ELM_SYNDROME_FRAGMENT_2 + offset,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      regs->elm_syndrome_fragment_2[i]);
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/omap_elm.c:519:3: note: here
   case BCH4_ECC:
   ^~~~
drivers/mtd/nand/raw/omap_elm.c: In function ‘elm_context_save’:
drivers/mtd/nand/raw/omap_elm.c:466:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
    regs->elm_syndrome_fragment_4[i] = elm_read_reg(info,
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
      ELM_SYNDROME_FRAGMENT_4 + offset);
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/omap_elm.c:468:3: note: here
   case BCH8_ECC:
   ^~~~
drivers/mtd/nand/raw/omap_elm.c:471:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
    regs->elm_syndrome_fragment_2[i] = elm_read_reg(info,
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
      ELM_SYNDROME_FRAGMENT_2 + offset);
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/omap_elm.c:473:3: note: here
   case BCH4_ECC:
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v3:
 - Leave out of this patch the following files:
	drivers/mtd/nand/onenand/onenand_base.c
	drivers/mtd/nand/raw/nand_base.c
	drivers/mtd/nand/raw/nand_legacy.c
	
   The first one needs to be reworked, and the last
   two have already been addressed.

Changes in v2:
 - Add extra /* fall through */ comment in nandsim.c file.

 drivers/mtd/nand/raw/diskonchip.c  | 1 +
 drivers/mtd/nand/raw/nandsim.c     | 6 ++++--
 drivers/mtd/nand/raw/nuc900_nand.c | 3 ++-
 drivers/mtd/nand/raw/omap_elm.c    | 4 ++++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 53f57e0f007e..ead54c90f2d1 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1477,6 +1477,7 @@ static int __init doc_probe(unsigned long physadr)
 			break;
 		case DOC_ChipID_DocMilPlus32:
 			pr_err("DiskOnChip Millennium Plus 32MB is not supported, ignoring.\n");
+			/* fall through */
 		default:
 			ret = -ENODEV;
 			goto notfound;
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 933d1a629c51..edf5fd3d5f07 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2251,9 +2251,11 @@ static int __init ns_init_module(void)
 
 	switch (bbt) {
 	case 2:
-		 chip->bbt_options |= NAND_BBT_NO_OOB;
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+		/* fall through */
 	case 1:
-		 chip->bbt_options |= NAND_BBT_USE_FLASH;
+		chip->bbt_options |= NAND_BBT_USE_FLASH;
+		/* fall through */
 	case 0:
 		break;
 	default:
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 38b1994e7ed3..56fa84029482 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -192,8 +192,9 @@ static void nuc900_nand_command_lp(struct nand_chip *chip,
 		return;
 
 	case NAND_CMD_READ0:
-
 		write_cmd_reg(nand, NAND_CMD_READSTART);
+		/* fall through */
+
 	default:
 
 		if (!chip->legacy.dev_ready) {
diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index a3f32f939cc1..94c6401ef32f 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -465,11 +465,13 @@ static int elm_context_save(struct elm_info *info)
 					ELM_SYNDROME_FRAGMENT_5 + offset);
 			regs->elm_syndrome_fragment_4[i] = elm_read_reg(info,
 					ELM_SYNDROME_FRAGMENT_4 + offset);
+			/* fall through */
 		case BCH8_ECC:
 			regs->elm_syndrome_fragment_3[i] = elm_read_reg(info,
 					ELM_SYNDROME_FRAGMENT_3 + offset);
 			regs->elm_syndrome_fragment_2[i] = elm_read_reg(info,
 					ELM_SYNDROME_FRAGMENT_2 + offset);
+			/* fall through */
 		case BCH4_ECC:
 			regs->elm_syndrome_fragment_1[i] = elm_read_reg(info,
 					ELM_SYNDROME_FRAGMENT_1 + offset);
@@ -511,11 +513,13 @@ static int elm_context_restore(struct elm_info *info)
 					regs->elm_syndrome_fragment_5[i]);
 			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_4 + offset,
 					regs->elm_syndrome_fragment_4[i]);
+			/* fall through */
 		case BCH8_ECC:
 			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_3 + offset,
 					regs->elm_syndrome_fragment_3[i]);
 			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_2 + offset,
 					regs->elm_syndrome_fragment_2[i]);
+			/* fall through */
 		case BCH4_ECC:
 			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_1 + offset,
 					regs->elm_syndrome_fragment_1[i]);
-- 
2.20.1

