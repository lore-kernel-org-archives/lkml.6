Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A925FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDBD20824
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ndPgo5bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDBD20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbeKQN6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:58:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38980 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:58:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so7605906pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 19:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UctOztwiUIDM8tj6Dp2aFB/TMb5+Jhqeb5E9QTkTSjo=;
        b=ndPgo5bjvZYHAAadUbnfpZtqgYPW7pMfFwsjNDnqb6IID6eppm0mS9CWHC2jPBmaao
         ZLs4E4ZfdU1z2kx0f72yb/dojT99MY+t0qmiM/xgicumXEoNgg/0Cb5sbrxDfmT7GiFK
         VCeA7WDC+zLANLebrPbP3VqP+JE6pWfwC60inrTkp6LWwgy0r0NdPLagpruzJK3rgLng
         /YGnCMqDTMePE+LF5YFG8NTxxtw0Pe29YdrAibsNscJ73o2859Ck4r6weVbDAPCVOn31
         PEGYwO5sJomeI2VQJz0G6Z+msFpq0fOkLZS4kr53umgAkPMzZkcEyx1BxS+txACS4zZa
         PJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UctOztwiUIDM8tj6Dp2aFB/TMb5+Jhqeb5E9QTkTSjo=;
        b=TaG+ALJ3no+9hu++c7pwv3HJDMwHmWrYO7Q3yTS8gWRUxI715tKgtqugzFWE6jsLaL
         xghQGHh75mWN6j3gNs0sAm29WNJWQTcKJPu4FraXPZoUhUfoJRihT42vdJSnGuZy9Nz3
         XPqFq3r0cqv2BWkDODkhukf7Vd/ipRe/cQKrSEJxD3YGrW7KijoKVy+uCiUJTN5aCapj
         AboN7zRVU/76c7mOzoRfa/p9ufrEDPa5Jsm0WsgALw2ID522wQqF1X1QaNqPyqr28NrN
         Ymys4HPwGS21EKUrdXqc9SlnqO+INI6D/npTl9hNNinRRAJFsi23ACyMMB+QOt6fSCJh
         z4/w==
X-Gm-Message-State: AGRZ1gLXFd8FkGXANwVMIKTf2tjV5STPaCdFuuTD9wVvg7H7dlOTS2Lb
        ndalxcTBkCVIJlk0JiAgAXGxZg==
X-Google-Smtp-Source: AJdET5fysTD2vhoCYu+xPL8w/GFeLXFedYu6fNNKaMf9GQpm0SzZVuE0bsDuKiLMQLX5dJV11kUuAg==
X-Received: by 2002:a62:7687:: with SMTP id r129mr13763452pfc.17.1542426213852;
        Fri, 16 Nov 2018 19:43:33 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id x27sm38799630pfe.178.2018.11.16.19.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 19:43:32 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] mtd: rawnand: qcom: Namespace prefix some commands
Date:   Fri, 16 Nov 2018 19:43:27 -0800
Message-Id: <20181117034327.72638-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_READ is used by RISC-V arch code included through mm headers,
and it makes sense to bring in a prefix on these in the driver.

drivers/mtd/nand/raw/qcom_nandc.c:153: warning: "PAGE_READ" redefined
 #define PAGE_READ   0x2
In file included from include/linux/memremap.h:7,
                 from include/linux/mm.h:27,
                 from include/linux/scatterlist.h:8,
                 from include/linux/dma-mapping.h:11,
                 from drivers/mtd/nand/raw/qcom_nandc.c:17:
arch/riscv/include/asm/pgtable.h:48: note: this is the location of the previous definition

Caught by riscv allmodconfig.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index ef75dfa62a4f8..699d3cf49c6da 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -150,15 +150,15 @@
 #define	NAND_VERSION_MINOR_SHIFT	16
 
 /* NAND OP_CMDs */
-#define	PAGE_READ			0x2
-#define	PAGE_READ_WITH_ECC		0x3
-#define	PAGE_READ_WITH_ECC_SPARE	0x4
-#define	PROGRAM_PAGE			0x6
-#define	PAGE_PROGRAM_WITH_ECC		0x7
-#define	PROGRAM_PAGE_SPARE		0x9
-#define	BLOCK_ERASE			0xa
-#define	FETCH_ID			0xb
-#define	RESET_DEVICE			0xd
+#define	OP_PAGE_READ			0x2
+#define	OP_PAGE_READ_WITH_ECC		0x3
+#define	OP_PAGE_READ_WITH_ECC_SPARE	0x4
+#define	OP_PROGRAM_PAGE			0x6
+#define	OP_PAGE_PROGRAM_WITH_ECC	0x7
+#define	OP_PROGRAM_PAGE_SPARE		0x9
+#define	OP_BLOCK_ERASE			0xa
+#define	OP_FETCH_ID			0xb
+#define	OP_RESET_DEVICE			0xd
 
 /* Default Value for NAND_DEV_CMD_VLD */
 #define NAND_DEV_CMD_VLD_VAL		(READ_START_VLD | WRITE_START_VLD | \
@@ -692,11 +692,11 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
 
 	if (read) {
 		if (host->use_ecc)
-			cmd = PAGE_READ_WITH_ECC | PAGE_ACC | LAST_PAGE;
+			cmd = OP_PAGE_READ_WITH_ECC | PAGE_ACC | LAST_PAGE;
 		else
-			cmd = PAGE_READ | PAGE_ACC | LAST_PAGE;
+			cmd = OP_PAGE_READ | PAGE_ACC | LAST_PAGE;
 	} else {
-			cmd = PROGRAM_PAGE | PAGE_ACC | LAST_PAGE;
+		cmd = OP_PROGRAM_PAGE | PAGE_ACC | LAST_PAGE;
 	}
 
 	if (host->use_ecc) {
@@ -1170,7 +1170,7 @@ static int nandc_param(struct qcom_nand_host *host)
 	 * in use. we configure the controller to perform a raw read of 512
 	 * bytes to read onfi params
 	 */
-	nandc_set_reg(nandc, NAND_FLASH_CMD, PAGE_READ | PAGE_ACC | LAST_PAGE);
+	nandc_set_reg(nandc, NAND_FLASH_CMD, OP_PAGE_READ | PAGE_ACC | LAST_PAGE);
 	nandc_set_reg(nandc, NAND_ADDR0, 0);
 	nandc_set_reg(nandc, NAND_ADDR1, 0);
 	nandc_set_reg(nandc, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
@@ -1224,7 +1224,7 @@ static int erase_block(struct qcom_nand_host *host, int page_addr)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
 	nandc_set_reg(nandc, NAND_FLASH_CMD,
-		      BLOCK_ERASE | PAGE_ACC | LAST_PAGE);
+		      OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE);
 	nandc_set_reg(nandc, NAND_ADDR0, page_addr);
 	nandc_set_reg(nandc, NAND_ADDR1, 0);
 	nandc_set_reg(nandc, NAND_DEV0_CFG0,
@@ -1255,7 +1255,7 @@ static int read_id(struct qcom_nand_host *host, int column)
 	if (column == -1)
 		return 0;
 
-	nandc_set_reg(nandc, NAND_FLASH_CMD, FETCH_ID);
+	nandc_set_reg(nandc, NAND_FLASH_CMD, OP_FETCH_ID);
 	nandc_set_reg(nandc, NAND_ADDR0, column);
 	nandc_set_reg(nandc, NAND_ADDR1, 0);
 	nandc_set_reg(nandc, NAND_FLASH_CHIP_SELECT,
@@ -1276,7 +1276,7 @@ static int reset(struct qcom_nand_host *host)
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
-	nandc_set_reg(nandc, NAND_FLASH_CMD, RESET_DEVICE);
+	nandc_set_reg(nandc, NAND_FLASH_CMD, OP_RESET_DEVICE);
 	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
 
 	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-- 
2.11.0

