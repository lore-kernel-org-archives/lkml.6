Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC15320870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfAWH4g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:56:36 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:46640 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfAWH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:56:36 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 5D2EE67A64A;
        Wed, 23 Jan 2019 08:56:32 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 23 Jan
 2019 08:56:31 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 23 Jan 2019 08:56:31 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Marek Vasut <marek.vasut@gmail.com>
CC:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "Schrempf Frieder" <frieder.schrempf@kontron.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Topic: [PATCH 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Index: AQHUsvEnBk05JSMTaE23Hh40f7Dvaw==
Date:   Wed, 23 Jan 2019 07:56:31 +0000
Message-ID: <20190123075538.12681-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 5D2EE67A64A.ADDBB
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com, richard@nod.at,
        tudor.ambarus@microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This adds support for the EON EN25Q80A, a 8Mb SPI NOR chip.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6e13bbd1aaa5..aa8a04293a25 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1737,6 +1737,8 @@ static const struct flash_info spi_nor_ids[] = {
 	/* EON -- en25xxx */
 	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64, SECT_4K) },
 	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64, 0) },
+	{ "en25q80a",   INFO(0x1c3014, 0, 64 * 1024,   16,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "en25q32b",   INFO(0x1c3016, 0, 64 * 1024,   64, 0) },
 	{ "en25p64",    INFO(0x1c2017, 0, 64 * 1024,  128, 0) },
 	{ "en25q64",    INFO(0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
-- 
2.17.1
