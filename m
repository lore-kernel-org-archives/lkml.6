Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BC2C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF248208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7myTgUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF248208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeHAFIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:08:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33461 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeHAFIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:08:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so10087598pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DxnWsbyfbSjBul6d/KiPq17rQBjw0nemsI/HJNpCW7o=;
        b=e7myTgUbdMRMc6rkCB+lLHKWZX7DHCcwajipyNur++ODvk5DOKlMqE05tDnUppQ/Ou
         krdFuaSOWSa6KblaDRhJHQtz6Rs8VeUOgtQdqxqZaKkjhXNB5mc7HcR4/VwLEcz1i7yx
         1mRYTcN4c4n4/HPkpWbuaIokWzeBG9NGM6sKkW7sL40jTnJC4gXmXhHqUCwalbqqoc+x
         04wdoxLM8WhTJw0wX1Z1WWI9nMQvB8wdkTeoTiLLMAc1mD2hgvqLezn3KJwfuWzTepik
         aAPpvdfVO2CBnlL+9c7y9ZvlH7qoz1pkfVoaxIE+3cCdoiMM67RCMF8W0lMFqkl0yemP
         0RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DxnWsbyfbSjBul6d/KiPq17rQBjw0nemsI/HJNpCW7o=;
        b=rfeRt14wQVGFRPR/v8tXfOHuxFXzXMJVwNdYftuJzu8+bY/t8NucacKcgtGSkyWWlq
         EAlt+/bu21lcURfnezKo1ooiHeSh7FwaoPdelW3Bj61LGC7IgEKIDVpdx/baIJ/J8/xq
         oY2azoYikWsh2yGfQHoQdpjCnCTwSfp6ZkD9FMISmz1HGNtYTFu4fKY64xqdyCk3+GnH
         EIuoxkaDAjKWbTqfcZMf113v3jOe/rRXYRthFj4iyTaTghVPm8fAgosBNiQEYIRJkAj/
         JhknACVnknkt87rngb1aYQMOMEf+SQcMwNU1x3bp8ThGrp45U1NyQMKaedQDbF3ei1wq
         VWFw==
X-Gm-Message-State: AOUpUlGnGWUgKojaYrXzeYiILeMwFkHVdU6rhMNXOHZ3cW6mskZu26tg
        pZfROpV8Lv0HGZcYsdsL39c=
X-Google-Smtp-Source: AAOMgpeNmss9TOTo3mryfYLWR9SWDsh1xczJiqFpH2fTHTJF+5i56ufA2NgjTsO4gUEwX6LS5Dw/CQ==
X-Received: by 2002:a63:614d:: with SMTP id v74-v6mr22845436pgb.328.1533093880806;
        Tue, 31 Jul 2018 20:24:40 -0700 (PDT)
Received: from localhost.localdomain (220-133-8-147.HINET-IP.hinet.net. [220.133.8.147])
        by smtp.gmail.com with ESMTPSA id g7-v6sm20462758pfi.175.2018.07.31.20.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 20:24:40 -0700 (PDT)
From:   Jheng-Jhong Wu <goodwater.wu@gmail.com>
Cc:     goodwater.wu@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arun Nagendran <arunrasppi@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Palle Christensen <palle.christensen@microsemi.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging:mt29f_spinand: MT29F2G failing as only 16-bit arguments and variables used for addressing.
Date:   Wed,  1 Aug 2018 11:24:19 +0800
Message-Id: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For NAND flash chips with more than 1Gbit (e.g. MT29F2G) more than 16 bits
are necessary to address the correct page. The driver sets the address for
more than 16 bits, but it uses 16-bit arguments and variables (these are
page_id, block_id, row) to do address operations. Obviously, these
arguments and variables cannot deal with more than 16-bit address.

Signed-off-by: Jheng-Jhong Wu <goodwater.wu@gmail.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 4484784..a0f4cbcb 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -308,10 +308,10 @@ static int spinand_write_enable(struct spi_device *spi_nand)
 	return spinand_cmd(spi_nand, &cmd);
 }
 
-static int spinand_read_page_to_cache(struct spi_device *spi_nand, u16 page_id)
+static int spinand_read_page_to_cache(struct spi_device *spi_nand, u32 page_id)
 {
 	struct spinand_cmd cmd = {0};
-	u16 row;
+	u32 row;
 
 	row = page_id;
 	cmd.cmd = CMD_READ;
@@ -331,7 +331,7 @@ static int spinand_read_page_to_cache(struct spi_device *spi_nand, u16 page_id)
  *   locations.
  *   No tRd delay.
  */
-static int spinand_read_from_cache(struct spi_device *spi_nand, u16 page_id,
+static int spinand_read_from_cache(struct spi_device *spi_nand, u32 page_id,
 				   u16 byte_id, u16 len, u8 *rbuf)
 {
 	struct spinand_cmd cmd = {0};
@@ -362,7 +362,7 @@ static int spinand_read_from_cache(struct spi_device *spi_nand, u16 page_id,
  *   The read includes two commands to the Nand - 0x13 and 0x03 commands
  *   Poll to read status to wait for tRD time.
  */
-static int spinand_read_page(struct spi_device *spi_nand, u16 page_id,
+static int spinand_read_page(struct spi_device *spi_nand, u32 page_id,
 			     u16 offset, u16 len, u8 *rbuf)
 {
 	int ret;
@@ -430,7 +430,7 @@ static int spinand_read_page(struct spi_device *spi_nand, u16 page_id,
  *   Since it is writing the data to cache, there is no tPROG time.
  */
 static int spinand_program_data_to_cache(struct spi_device *spi_nand,
-					 u16 page_id, u16 byte_id,
+					 u32 page_id, u16 byte_id,
 					 u16 len, u8 *wbuf)
 {
 	struct spinand_cmd cmd = {0};
@@ -457,10 +457,10 @@ static int spinand_program_data_to_cache(struct spi_device *spi_nand,
  *   the Nand array.
  *   Need to wait for tPROG time to finish the transaction.
  */
-static int spinand_program_execute(struct spi_device *spi_nand, u16 page_id)
+static int spinand_program_execute(struct spi_device *spi_nand, u32 page_id)
 {
 	struct spinand_cmd cmd = {0};
-	u16 row;
+	u32 row;
 
 	row = page_id;
 	cmd.cmd = CMD_PROG_PAGE_EXC;
@@ -486,7 +486,7 @@ static int spinand_program_execute(struct spi_device *spi_nand, u16 page_id)
  *   Poll to wait for the tPROG time to finish the transaction.
  */
 static int spinand_program_page(struct spi_device *spi_nand,
-				u16 page_id, u16 offset, u16 len, u8 *buf)
+				u32 page_id, u16 offset, u16 len, u8 *buf)
 {
 	int retval;
 	u8 status = 0;
@@ -573,10 +573,10 @@ static int spinand_program_page(struct spi_device *spi_nand,
  *   one block--64 pages
  *   Need to wait for tERS.
  */
-static int spinand_erase_block_erase(struct spi_device *spi_nand, u16 block_id)
+static int spinand_erase_block_erase(struct spi_device *spi_nand, u32 block_id)
 {
 	struct spinand_cmd cmd = {0};
-	u16 row;
+	u32 row;
 
 	row = block_id;
 	cmd.cmd = CMD_ERASE_BLK;
@@ -599,7 +599,7 @@ static int spinand_erase_block_erase(struct spi_device *spi_nand, u16 block_id)
  *   and then send the 0xd8 erase command
  *   Poll to wait for the tERS time to complete the tranaction.
  */
-static int spinand_erase_block(struct spi_device *spi_nand, u16 block_id)
+static int spinand_erase_block(struct spi_device *spi_nand, u32 block_id)
 {
 	int retval;
 	u8 status = 0;
-- 
2.7.4

