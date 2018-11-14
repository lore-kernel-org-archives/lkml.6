Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AC8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44684208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44684208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbeKNX1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:27:38 -0500
Received: from smtprz14.163.net ([106.3.154.247]:36102 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbeKNX1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:27:38 -0500
X-Greylist: delayed 1713 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Nov 2018 18:27:37 EST
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 9AEBFB00D6E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 20:55:26 +0800 (CST)
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 56FEE8150B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 20:55:25 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QfkRvXp9gk1u for <linux-kernel@vger.kernel.org>;
        Wed, 14 Nov 2018 20:55:23 +0800 (CST)
Received: from localhost (unknown [110.184.153.105])
        by antispam2.tom.com (Postfix) with ESMTPA id 4104781424;
        Wed, 14 Nov 2018 20:55:23 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to is25lp256
Date:   Wed, 14 Nov 2018 20:55:18 +0800
Message-Id: <1542200118-3024-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is25lp256 supports 4-byte opcodes and quad output.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3e54e31..3eba13a 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1357,7 +1357,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	{ "is25lp128",  INFO(0x9d6018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ) },
 	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 512,
-			SECT_4K | SPI_NOR_DUAL_READ) },
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128,
-- 
1.9.1

