Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297DFC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC2620666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBNbkOyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC2620666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeJCF6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:58:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43288 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeJCF6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:58:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so3953056qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D7wWhz+ACZGst/p+dZI367wFQGcrbVbbrfqZCMmfyrA=;
        b=nBNbkOypdNRRjqZKNQOmA3F4Z6/zbbvv4ddykdAqWYCzZyFv9c3Kl58zzHdeWKBb28
         zk5MQAcCW3U9ZxuxTK3g+j7PUFKSMtpEwdDI4VBW+MFSk6O2iinGj4K2QT2Rw2qUloFT
         eIYyZdluktRWwNsZnvZR5gf2d6j2eF7Zc/KAnwV9nb9wsKzQ2+g7ph9Z6xG8F4Ydoinz
         flvvyldr7cgaEpqpUhmzxYYTledxJPODImBKLKf5qNXtQbhhnuAmhN5UXGUJU3C1e6ZV
         q5oNqMqII417nh9Ru6I5joYMdef6prSQHZRsKUSaGR6KXlLeADhkrtHWPC/gPu5BrUGy
         RRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D7wWhz+ACZGst/p+dZI367wFQGcrbVbbrfqZCMmfyrA=;
        b=Yx0EgzPoDsU1I4fWzXk+hvEmexb2dQelAY5fenpZe1dx6oqDKN8/VY04DDHikAMGCH
         krBxZb/MsGgK33INlb690UBIXR2Ic93CZT1khIqWn+hSZntG/T3gept8hnQo69H3nmXi
         d1IUKQcMTCnsaGg4CRVaNS6TqoMp7eD3RZJZQa0LkVawFvBB8Kogfxh14C9TYRDB8XPa
         rF6nmu/T4qZuuB/QHmBwLJfvimfLdJ5Uy5jYUcTM4r01Nyb7rlSUPO7XrOIcXXaoYAWi
         JNU61FPPfvCF9Q7dzuW/yYnRfPByHOYgKNjZjzWHbITU5lAqqPNmuGjA5UnWZUu8l+Mv
         vObg==
X-Gm-Message-State: ABuFfojNeIkPC415oQij40KaN2b5HzMQrITcoLLdo6nEu+/5+6i4IhaT
        QZJ3Rbz2MD/GT0FWUJTBLK0=
X-Google-Smtp-Source: ACcGV60ZM9BzrBbCXtG7JkSUUiw9Vb8gLf8gA6mphCNYZf0AvpGmE74jTl1RiUCArgzC39UkvDpV9g==
X-Received: by 2002:ac8:248c:: with SMTP id s12-v6mr14383571qts.116.1538521965262;
        Tue, 02 Oct 2018 16:12:45 -0700 (PDT)
Received: from localhost.localdomain (modemcable043.227-201-24.mc.videotron.ca. [24.201.227.43])
        by smtp.gmail.com with ESMTPSA id 35-v6sm5537272qtr.91.2018.10.02.16.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:12:44 -0700 (PDT)
From:   Maxime Desroches <desroches.maxime@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Maxime Desroches <desroches.maxime@gmail.com>
Subject: [PATCH 5/6] Staging: rts5208: spi.c: Fixed all braces issues of the file
Date:   Tue,  2 Oct 2018 19:12:39 -0400
Message-Id: <20181002231239.10569-1-desroches.maxime@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all the braces issues of the spi.c file

Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
---
 drivers/staging/rts5208/spi.c | 153 +++++++++++++---------------------
 1 file changed, 59 insertions(+), 94 deletions(-)

diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
index 4675668ad977..420264bc03e5 100644
--- a/drivers/staging/rts5208/spi.c
+++ b/drivers/staging/rts5208/spi.c
@@ -41,14 +41,13 @@ static int spi_init(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, SPI_CONTROL, 0xFF,
 				     CS_POLARITY_LOW | DTO_MSB_FIRST
 				     | SPI_MASTER | SPI_MODE0 | SPI_AUTO);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, SPI_TCTL, EDO_TIMING_MASK,
 				     SAMPLE_DELAY_HALF);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -60,42 +59,37 @@ static int spi_set_init_para(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER1, 0xFF,
 				     (u8)(spi->clk_div >> 8));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER0, 0xFF,
 				     (u8)(spi->clk_div));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = switch_clock(chip, spi->spi_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = select_card(chip, SPI_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, SPI_CLK_EN,
 				     SPI_CLK_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, CARD_OE, SPI_OUTPUT_EN,
 				     SPI_OUTPUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	wait_timeout(10);
 
 	retval = spi_init(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -247,47 +241,45 @@ static int spi_init_eeprom(struct rtsx_chip *chip)
 		clk = CLK_30;
 
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER1, 0xFF, 0x00);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER0, 0xFF, 0x27);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = switch_clock(chip, clk);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
+
 
 	retval = select_card(chip, SPI_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
+
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, SPI_CLK_EN,
 				     SPI_CLK_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, CARD_OE, SPI_OUTPUT_EN,
 				     SPI_OUTPUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 
 	wait_timeout(10);
 
 	retval = rtsx_write_register(chip, SPI_CONTROL, 0xFF,
 				     CS_POLARITY_HIGH | SPI_EEPROM_AUTO);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, SPI_TCTL, EDO_TIMING_MASK,
 				     SAMPLE_DELAY_HALF);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -306,9 +298,8 @@ static int spi_eeprom_program_enable(struct rtsx_chip *chip)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -318,14 +309,12 @@ int spi_erase_eeprom_chip(struct rtsx_chip *chip)
 	int retval;
 
 	retval = spi_init_eeprom(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = spi_eeprom_program_enable(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -339,14 +328,12 @@ int spi_erase_eeprom_chip(struct rtsx_chip *chip)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -356,14 +343,12 @@ int spi_erase_eeprom_byte(struct rtsx_chip *chip, u16 addr)
 	int retval;
 
 	retval = spi_init_eeprom(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = spi_eeprom_program_enable(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -379,14 +364,12 @@ int spi_erase_eeprom_byte(struct rtsx_chip *chip, u16 addr)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -397,9 +380,8 @@ int spi_read_eeprom(struct rtsx_chip *chip, u16 addr, u8 *val)
 	u8 data;
 
 	retval = spi_init_eeprom(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -416,23 +398,20 @@ int spi_read_eeprom(struct rtsx_chip *chip, u16 addr, u8 *val)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	wait_timeout(5);
 	retval = rtsx_read_register(chip, SPI_DATA, &data);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (val)
 		*val = data;
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -442,14 +421,12 @@ int spi_write_eeprom(struct rtsx_chip *chip, u16 addr, u8 val)
 	int retval;
 
 	retval = spi_init_eeprom(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = spi_eeprom_program_enable(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -466,14 +443,12 @@ int spi_write_eeprom(struct rtsx_chip *chip, u16 addr, u8 val)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -577,9 +552,8 @@ int spi_read_flash_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (len) {
 		buf = kmalloc(len, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return STATUS_ERROR;
-		}
 
 		retval = rtsx_read_ppbuf(chip, buf, len);
 		if (retval != STATUS_SUCCESS) {
@@ -621,9 +595,8 @@ int spi_read_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	buf = kmalloc(SF_PAGE_LEN, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	while (len) {
 		u16 pagelen = SF_PAGE_LEN - (u8)addr;
@@ -716,9 +689,8 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (program_mode == BYTE_PROGRAM) {
 		buf = kmalloc(4, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return STATUS_ERROR;
-		}
 
 		while (len) {
 			retval = sf_enable_write(chip, SPI_WREN);
@@ -762,14 +734,12 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		int first_byte = 1;
 
 		retval = sf_enable_write(chip, SPI_WREN);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		buf = kmalloc(4, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return STATUS_ERROR;
-		}
 
 		while (len) {
 			rtsx_stor_access_xfer_buf(buf, 1, srb, &index, &offset,
@@ -808,19 +778,17 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		kfree(buf);
 
 		retval = sf_disable_write(chip, SPI_WRDI);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = sf_polling_status(chip, 100);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	} else if (program_mode == PAGE_PROGRAM) {
 		buf = kmalloc(SF_PAGE_LEN, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return STATUS_NOMEM;
-		}
 
 		while (len) {
 			u16 pagelen = SF_PAGE_LEN - (u8)addr;
@@ -893,24 +861,22 @@ int spi_erase_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (erase_mode == PAGE_ERASE) {
 		retval = sf_enable_write(chip, SPI_WREN);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = sf_erase(chip, ins, 1, addr);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	} else if (erase_mode == CHIP_ERASE) {
 		retval = sf_enable_write(chip, SPI_WREN);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = sf_erase(chip, ins, 0, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
+
 	} else {
 		spi_set_err_code(chip, SPI_INVALID_COMMAND);
 		return STATUS_FAIL;
@@ -935,9 +901,8 @@ int spi_write_flash_status(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = sf_enable_write(chip, ewsr);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
-- 
2.17.1

