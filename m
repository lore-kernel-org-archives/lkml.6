Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C486C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9E42064E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0YHWyCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9E42064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeI2Wi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:38:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42541 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbeI2Wi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:38:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id g20-v6so4585324qke.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D7wWhz+ACZGst/p+dZI367wFQGcrbVbbrfqZCMmfyrA=;
        b=X0YHWyCaKtsebmaKibIaSMMWAeGmsdzBacLR0ePW8oxuXMQOK0cZlA33/IQY6+kZsn
         +0N6pN2VbEQ2c2OhX8iMUfXt1FotPZn3AhZaL+tp6kEzvLHTQFR/QliQMTamkrpI3ill
         YLXKUV73384bYLspIKRRXJU+tzzHmzpwUpKc+xMn6qUDCvBiwzqBDLrZW+XuudY2js5b
         CfNzIi8tVsKxytHf8bLV0glyQx/lLnmjfoa5nfAadNXsafdsovB0OGkmxS/vXh+NB2M/
         GFLZ6I4reimd637+Lzpkxd5YIYmF319IIo8Y57VrpM5WWsjqtJc+1b/pGxRYNuTSfRLb
         io4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D7wWhz+ACZGst/p+dZI367wFQGcrbVbbrfqZCMmfyrA=;
        b=GpF8cPEEO1UkOC2GyBLsIfUjaOfO0qSY+a2+MqUKHq1yBC1cfp/NyURv8tkWnAX27I
         xIx61RsJ79RpwaqFb2qw+ggaG8SfauJQo/jonnC/CJ/tfZlt4nFZkoLRX9/poyfTo51j
         mdAgMKjt2o5NiPhEF9/f82CjaU6+u+5d+hAGHNpxvLVq8yk3LhO5m83bSrSuRpuP5+pm
         7WRRaFcR/GygzJUQZAIBJcKslxuplonwk++TBCKvOLtslPNkOjayWTgeeBPsz0nXdKZz
         p67PYObmLzd3ThvJYMC2lv39e7K9p2P/kzU5EYFxVEqexx5iswRyoaCyLfInFquTSawd
         tHuQ==
X-Gm-Message-State: ABuFfoisAERvVuDZGdA9y11oMDHxcp7keDCeAESkedklsMr9zMSyAvUp
        UJFlhK5zbJaR+kH8P73+HfU=
X-Google-Smtp-Source: ACcGV60mG/ZwxgN45D/9DY7hFypUue6wEtyBfv4mgEtsi9XnSioUsb+8jDtgXK4zpzaQkyeuAF6oSw==
X-Received: by 2002:a37:895:: with SMTP id 143-v6mr2527699qki.99.1538237396912;
        Sat, 29 Sep 2018 09:09:56 -0700 (PDT)
Received: from localhost.localdomain (modemcable211.182-179-173.mc.videotron.ca. [173.179.182.211])
        by smtp.gmail.com with ESMTPSA id n25-v6sm779072qtf.14.2018.09.29.09.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 09:09:56 -0700 (PDT)
From:   Maxime Desroches <desroches.maxime@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Maxime Desroches <desroches.maxime@gmail.com>
Subject: [PATCH 5/5] Staging: rts5208: spi.c: Fixed all braces issues of the file
Date:   Sat, 29 Sep 2018 12:09:50 -0400
Message-Id: <20180929160950.19094-1-desroches.maxime@gmail.com>
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

