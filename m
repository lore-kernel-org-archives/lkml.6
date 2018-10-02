Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440BFC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD84820666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj9IN0zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD84820666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJCF6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:58:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37276 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeJCF6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:58:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id n6-v6so3979641qtl.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mybv1bPm12Lf5Uice4/lCZ5nQ6JOL9bYQDTePFpNcdI=;
        b=lj9IN0zqFFn8V98Bgk0GUa2sZPcFl40bUJ2UOVoQat7R2xB6uBETfjyYGXqjPLlBFT
         zIHSL2IG3Vfbz4VqGvl5wOC5/SG0ilDQi0FVmEiJ0VIVekSxyBvLOKMY2HGepThXQKgV
         Wasxt6Sq15er6TVH4qPiLklNU/Em1UpEzrwavHBTOfq9WiMMmY2UGDNvBfkTZbhh7pvS
         5nTO6+okmJFhOTwE2QydJkGDuAh1ZwNKIZ4tQAkFUjJSGzA/lc3zcisIH9gL7KmprFYD
         mtNrdr1pdI75TDTDKhpJbsEIjcGxZbAumdRQIcmpO0HIZ4yxObhym2Q8h55/yBhi3yc6
         FM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mybv1bPm12Lf5Uice4/lCZ5nQ6JOL9bYQDTePFpNcdI=;
        b=pdP7vc3YQGV2e31vPZGa+PR8u93/AgHrhPWT67JaqIDd0SfRk6yULxjfmwhVT3Xcce
         U0joGl8qfN54raoZC9sflaJnK/Hllwslwp6IzLs7gWG5ZExwj9cH6Qu/5mzvufL4WRnr
         eymSF4ukjC/WkAJkC1LybT/ti4ZPuYTij1JjTNQXJTBilj0eni/TtPrN6JITNnC6PEed
         03sBq/rlSd9eRQM8utQYUdKTxGL+/StkH9J1eIheyrWyLiQYYzV+FQLrhxKR2U8IRD/p
         AqckbjJC7Q8KmVC6wPp/DVvx3zt95kBIRNPempDrjw3HCGOni8kAjvXeeh4NvXmJ3EJ9
         O6og==
X-Gm-Message-State: ABuFfohXM1sYzEGBXwFFi8nVec0f1OphvDkxJ4vio8i64Z79YyIvx+N4
        CmJOzIM1s9/vB1VcAUBeWvI=
X-Google-Smtp-Source: ACcGV62lJ02UlgoIA21lXxeFOmLuMuirhVhtmX0sfHyfvoJWRVKU3fghdihov7Nzvc0LOkanD20tGw==
X-Received: by 2002:aed:38c7:: with SMTP id k65-v6mr14938841qte.84.1538521986052;
        Tue, 02 Oct 2018 16:13:06 -0700 (PDT)
Received: from localhost.localdomain (modemcable043.227-201-24.mc.videotron.ca. [24.201.227.43])
        by smtp.gmail.com with ESMTPSA id j125-v6sm7770884qke.61.2018.10.02.16.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:13:05 -0700 (PDT)
From:   Maxime Desroches <desroches.maxime@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Maxime Desroches <desroches.maxime@gmail.com>
Subject: [PATCH 6/6] Staging: rts5208: xd.c: Fixed all braces issues of the file
Date:   Tue,  2 Oct 2018 19:12:59 -0400
Message-Id: <20181002231259.10624-1-desroches.maxime@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all the braces issues of the xd.c file

Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
---
 drivers/staging/rts5208/xd.c | 232 ++++++++++++++---------------------
 1 file changed, 92 insertions(+), 140 deletions(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index 261d868a3072..415fea2f9ff1 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -60,9 +60,8 @@ static int xd_set_init_para(struct rtsx_chip *chip)
 		xd_card->xd_clock = CLK_50;
 
 	retval = switch_clock(chip, xd_card->xd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -73,14 +72,12 @@ static int xd_switch_clock(struct rtsx_chip *chip)
 	int retval;
 
 	retval = select_card(chip, XD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = switch_clock(chip, xd_card->xd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -102,9 +99,8 @@ static int xd_read_id(struct rtsx_chip *chip, u8 id_cmd, u8 *id_buf, u8 buf_len)
 		rtsx_add_cmd(chip, READ_REG_CMD, (u16)(XD_ADDRESS1 + i), 0, 0);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 20);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	ptr = rtsx_get_cmd_data(chip) + 1;
 	if (id_buf && buf_len) {
@@ -173,9 +169,8 @@ static int xd_read_redundant(struct rtsx_chip *chip, u32 page_addr,
 	rtsx_add_cmd(chip, READ_REG_CMD, XD_PARITY, 0, 0);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 500);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	if (buf && buf_len) {
 		u8 *ptr = rtsx_get_cmd_data(chip) + 1;
@@ -193,9 +188,8 @@ static int xd_read_data_from_ppb(struct rtsx_chip *chip, int offset,
 {
 	int retval, i;
 
-	if (!buf || (buf_len < 0)) {
+	if (!buf || (buf_len < 0))
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -220,9 +214,8 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 	int retval;
 	u8 reg;
 
-	if (!buf || (buf_len < 10)) {
+	if (!buf || (buf_len < 10))
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -246,36 +239,35 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 	}
 
 	retval = rtsx_read_register(chip, XD_PAGE_STATUS, &reg);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	if (reg != XD_GPG) {
 		rtsx_clear_xd_error(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, XD_CTL, &reg);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	if (!(reg & XD_ECC1_ERROR) || !(reg & XD_ECC1_UNCORRECTABLE)) {
 		retval = xd_read_data_from_ppb(chip, 0, buf, buf_len);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 		if (reg & XD_ECC1_ERROR) {
 			u8 ecc_bit, ecc_byte;
 
 			retval = rtsx_read_register(chip, XD_ECC_BIT1,
 						    &ecc_bit);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_read_register(chip, XD_ECC_BYTE1,
 						    &ecc_byte);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 
 			dev_dbg(rtsx_dev(chip), "ECC_BIT1 = 0x%x, ECC_BYTE1 = 0x%x\n",
 				ecc_bit, ecc_byte);
@@ -291,22 +283,21 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 		rtsx_clear_xd_error(chip);
 
 		retval = xd_read_data_from_ppb(chip, 256, buf, buf_len);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 		if (reg & XD_ECC2_ERROR) {
 			u8 ecc_bit, ecc_byte;
 
 			retval = rtsx_read_register(chip, XD_ECC_BIT2,
 						    &ecc_bit);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_read_register(chip, XD_ECC_BYTE2,
 						    &ecc_byte);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 
 			dev_dbg(rtsx_dev(chip), "ECC_BIT2 = 0x%x, ECC_BYTE2 = 0x%x\n",
 				ecc_bit, ecc_byte);
@@ -404,68 +395,67 @@ static int xd_pull_ctl_disable(struct rtsx_chip *chip)
 					     XD_D2_PD |
 					     XD_D1_PD |
 					     XD_D0_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL2, 0xFF,
 					     XD_D7_PD |
 					     XD_D6_PD |
 					     XD_D5_PD |
 					     XD_D4_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL3, 0xFF,
 					     XD_WP_PD |
 					     XD_CE_PD |
 					     XD_CLE_PD |
 					     XD_CD_PU);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL4, 0xFF,
 					     XD_RDY_PD |
 					     XD_WE_PD |
 					     XD_RE_PD |
 					     XD_ALE_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL5, 0xFF,
 					     MS_INS_PU |
 					     SD_WP_PD |
 					     SD_CD_PU |
 					     SD_CMD_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL6, 0xFF,
 					     MS_D5_PD | MS_D4_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	} else if (CHECK_PID(chip, 0x5288)) {
 		if (CHECK_BARO_PKG(chip, QFN)) {
 			retval = rtsx_write_register(chip, CARD_PULL_CTL1,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PULL_CTL2,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PULL_CTL3,
 						     0xFF, 0x4B);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PULL_CTL4,
 						     0xFF, 0x69);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	}
 
@@ -479,9 +469,8 @@ static int reset_xd(struct rtsx_chip *chip)
 	u8 *ptr, id_buf[4], redunt[11];
 
 	retval = select_card(chip, XD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -505,15 +494,13 @@ static int reset_xd(struct rtsx_chip *chip)
 	rtsx_add_cmd(chip, WRITE_REG_CMD, CARD_OE, XD_OUTPUT_EN, 0);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, XD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		wait_timeout(250);
 
@@ -529,14 +516,12 @@ static int reset_xd(struct rtsx_chip *chip)
 		}
 
 		retval = rtsx_send_cmd(chip, XD_CARD, 100);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 
 		retval = card_power_on(chip, XD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 #ifdef SUPPORT_OCP
 		wait_timeout(50);
@@ -565,17 +550,15 @@ static int reset_xd(struct rtsx_chip *chip)
 	rtsx_add_cmd(chip, WRITE_REG_CMD, XD_CTL, XD_CE_DISEN, XD_CE_DISEN);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	if (!chip->ft2_fast_mode)
 		wait_timeout(200);
 
 	retval = xd_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	/* Read ID to check if the timing setting is right */
 	for (i = 0; i < 4; i++) {
@@ -598,9 +581,8 @@ static int reset_xd(struct rtsx_chip *chip)
 		rtsx_add_cmd(chip, READ_REG_CMD, XD_CTL, 0, 0);
 
 		retval = rtsx_send_cmd(chip, XD_CARD, 100);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 
 		ptr = rtsx_get_cmd_data(chip) + 1;
 
@@ -612,9 +594,8 @@ static int reset_xd(struct rtsx_chip *chip)
 			continue;
 
 		retval = xd_read_id(chip, READ_ID, id_buf, 4);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		dev_dbg(rtsx_dev(chip), "READ_ID: 0x%x 0x%x 0x%x 0x%x\n",
 			id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
@@ -694,9 +675,8 @@ static int reset_xd(struct rtsx_chip *chip)
 		/* Confirm timing setting */
 		for (j = 0; j < 10; j++) {
 			retval = xd_read_id(chip, READ_ID, id_buf, 4);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			if (id_buf[1] != xd_card->device_code)
 				break;
@@ -716,22 +696,20 @@ static int reset_xd(struct rtsx_chip *chip)
 	}
 
 	retval = xd_read_id(chip, READ_xD_ID, id_buf, 4);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
+
 	dev_dbg(rtsx_dev(chip), "READ_xD_ID: 0x%x 0x%x 0x%x 0x%x\n",
 		id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
-	if (id_buf[2] != XD_ID_CODE) {
+	if (id_buf[2] != XD_ID_CODE)
 		return STATUS_FAIL;
-	}
 
 	/* Search CIS block */
 	for (i = 0; i < 24; i++) {
 		u32 page_addr;
 
-		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
+		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		page_addr = (u32)i << xd_card->block_shift;
 
@@ -769,9 +747,8 @@ static int reset_xd(struct rtsx_chip *chip)
 			page_addr += j;
 
 			retval = xd_read_cis(chip, page_addr, buf, 10);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			if ((buf[0] == 0x01) && (buf[1] == 0x03) &&
 			    (buf[2] == 0xD9) &&
@@ -841,17 +818,15 @@ static int xd_init_l2p_tbl(struct rtsx_chip *chip)
 	dev_dbg(rtsx_dev(chip), "%s: zone_cnt = %d\n", __func__,
 		xd_card->zone_cnt);
 
-	if (xd_card->zone_cnt < 1) {
+	if (xd_card->zone_cnt < 1)
 		return STATUS_FAIL;
-	}
 
 	size = xd_card->zone_cnt * sizeof(struct zone_entry);
 	dev_dbg(rtsx_dev(chip), "Buffer size for l2p table is %d\n", size);
 
 	xd_card->zone = vmalloc(size);
-	if (!xd_card->zone) {
+	if (!xd_card->zone)
 		return STATUS_ERROR;
-	}
 
 	for (i = 0; i < xd_card->zone_cnt; i++) {
 		xd_card->zone[i].build_flag = 0;
@@ -1028,19 +1003,16 @@ int reset_xd_card(struct rtsx_chip *chip)
 	xd_card->delay_write.delay_write_flag = 0;
 
 	retval = enable_card_clock(chip, XD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = reset_xd(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = xd_init_l2p_tbl(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1054,9 +1026,8 @@ static int xd_mark_bad_block(struct rtsx_chip *chip, u32 phy_blk)
 
 	dev_dbg(rtsx_dev(chip), "mark block 0x%x as bad block\n", phy_blk);
 
-	if (phy_blk == BLK_NOT_FOUND) {
+	if (phy_blk == BLK_NOT_FOUND)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -1107,12 +1078,11 @@ static int xd_init_page(struct rtsx_chip *chip, u32 phy_blk,
 
 	dev_dbg(rtsx_dev(chip), "Init block 0x%x\n", phy_blk);
 
-	if (start_page > end_page) {
+	if (start_page > end_page)
 		return STATUS_FAIL;
-	}
-	if (phy_blk == BLK_NOT_FOUND) {
+
+	if (phy_blk == BLK_NOT_FOUND)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -1164,13 +1134,11 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 	dev_dbg(rtsx_dev(chip), "Copy page from block 0x%x to block 0x%x\n",
 		old_blk, new_blk);
 
-	if (start_page > end_page) {
+	if (start_page > end_page)
 		return STATUS_FAIL;
-	}
 
-	if ((old_blk == BLK_NOT_FOUND) || (new_blk == BLK_NOT_FOUND)) {
+	if ((old_blk == BLK_NOT_FOUND) || (new_blk == BLK_NOT_FOUND))
 		return STATUS_FAIL;
-	}
 
 	old_page = (old_blk << xd_card->block_shift) + start_page;
 	new_page = (new_blk << xd_card->block_shift) + start_page;
@@ -1179,9 +1147,9 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 
 	retval = rtsx_write_register(chip, CARD_DATA_SOURCE, 0x01,
 				     PINGPONG_BUFFER);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 
 	for (i = start_page; i < end_page; i++) {
 		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
@@ -1287,9 +1255,8 @@ static int xd_reset_cmd(struct rtsx_chip *chip)
 	rtsx_add_cmd(chip, READ_REG_CMD, XD_CTL, 0, 0);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	ptr = rtsx_get_cmd_data(chip) + 1;
 	if (((ptr[0] & READY_FLAG) == READY_STATE) && (ptr[1] & XD_RDY))
@@ -1305,9 +1272,8 @@ static int xd_erase_block(struct rtsx_chip *chip, u32 phy_blk)
 	u8 reg = 0, *ptr;
 	int i, retval;
 
-	if (phy_blk == BLK_NOT_FOUND) {
+	if (phy_blk == BLK_NOT_FOUND)
 		return STATUS_FAIL;
-	}
 
 	page_addr = phy_blk << xd_card->block_shift;
 
@@ -1333,9 +1299,9 @@ static int xd_erase_block(struct rtsx_chip *chip, u32 phy_blk)
 			}
 			xd_set_err_code(chip, XD_ERASE_FAIL);
 			retval = xd_reset_cmd(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
+
 			continue;
 		}
 
@@ -1382,17 +1348,16 @@ static int xd_build_l2p_tbl(struct rtsx_chip *chip, int zone_no)
 
 	if (!zone->l2p_table) {
 		zone->l2p_table = vmalloc(2000);
-		if (!zone->l2p_table) {
+		if (!zone->l2p_table)
 			goto build_fail;
-		}
+
 	}
 	memset((u8 *)(zone->l2p_table), 0xff, 2000);
 
 	if (!zone->free_table) {
 		zone->free_table = vmalloc(XD_FREE_TABLE_CNT * 2);
-		if (!zone->free_table) {
+		if (!zone->free_table)
 			goto build_fail;
-		}
 	}
 	memset((u8 *)(zone->free_table), 0xff, XD_FREE_TABLE_CNT * 2);
 
@@ -1555,9 +1520,8 @@ static int xd_send_cmd(struct rtsx_chip *chip, u8 cmd)
 		     XD_TRANSFER_END, XD_TRANSFER_END);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 200);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1636,17 +1600,15 @@ static int xd_read_multiple_pages(struct rtsx_chip *chip, u32 phy_blk,
 
 fail:
 	retval = rtsx_read_register(chip, XD_PAGE_STATUS, &reg_val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (reg_val !=  XD_GPG)
 		xd_set_err_code(chip, XD_PRG_ERROR);
 
 	retval = rtsx_read_register(chip, XD_CTL, &reg_val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (((reg_val & (XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE)) ==
 				(XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE)) ||
@@ -1702,9 +1664,8 @@ static int xd_finish_write(struct rtsx_chip *chip,
 	dev_dbg(rtsx_dev(chip),	"new_blk = 0x%x, ", new_blk);
 	dev_dbg(rtsx_dev(chip), "log_blk = 0x%x\n", log_blk);
 
-	if (page_off > xd_card->page_off) {
+	if (page_off > xd_card->page_off)
 		return STATUS_FAIL;
-	}
 
 	zone_no = (int)(log_blk / 1000);
 	log_off = (u16)(log_blk % 1000);
@@ -1760,9 +1721,8 @@ static int xd_prepare_write(struct rtsx_chip *chip,
 
 	if (page_off) {
 		retval = xd_copy_page(chip, old_blk, new_blk, 0, page_off);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1858,9 +1818,9 @@ static int xd_write_multiple_pages(struct rtsx_chip *chip, u32 old_blk,
 
 fail:
 	retval = rtsx_read_register(chip, XD_DAT, &reg_val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	if (reg_val & PROGRAM_ERROR) {
 		xd_set_err_code(chip, XD_PRG_ERROR);
 		xd_mark_bad_block(chip, new_blk);
@@ -1880,9 +1840,8 @@ int xd_delay_write(struct rtsx_chip *chip)
 	if (delay_write->delay_write_flag) {
 		dev_dbg(rtsx_dev(chip), "%s\n", __func__);
 		retval = xd_switch_clock(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		delay_write->delay_write_flag = 0;
 		retval = xd_finish_write(chip,
@@ -1890,9 +1849,8 @@ int xd_delay_write(struct rtsx_chip *chip)
 					 delay_write->new_phyblock,
 					 delay_write->logblock,
 					 delay_write->pageoff);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1924,9 +1882,8 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 	ptr = (u8 *)scsi_sglist(srb);
 
 	retval = xd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
 		chip->card_fail |= XD_CARD;
@@ -2180,34 +2137,30 @@ int xd_power_off_card3v3(struct rtsx_chip *chip)
 	int retval;
 
 	retval = disable_card_clock(chip, XD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_OE, XD_OUTPUT_EN, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, XD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		wait_timeout(50);
 	}
 
 	if (chip->asic_code) {
 		retval = xd_pull_ctl_disable(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL, 0xFF, 0xDF);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2227,9 +2180,8 @@ int release_xd_card(struct rtsx_chip *chip)
 	xd_free_l2p_tbl(chip);
 
 	retval = xd_power_off_card3v3(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
-- 
2.17.1

