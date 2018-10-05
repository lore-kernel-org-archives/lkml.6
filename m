Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBBF20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBBF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJENFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:05:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726732AbeJENFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:05:07 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF3D7B4269EB2;
        Fri,  5 Oct 2018 14:07:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Fri, 5 Oct 2018 14:07:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] eeprom: at25: remove unneeded 'at25_remove'
Date:   Fri, 5 Oct 2018 06:19:12 +0000
Message-ID: <1538720352-85691-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/misc/eeprom/at25.c: In function 'at25_remove':
drivers/misc/eeprom/at25.c:384:20: warning:
 variable 'at25' set but not used [-Wunused-but-set-variable]

Since commit 96d08fb43e30 ("eeprom: at25: use devm_nvmem_register()"),
at25_remove is do nothing, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/misc/eeprom/at25.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index d874df7..99de693 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -379,15 +379,6 @@ static int at25_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int at25_remove(struct spi_device *spi)
-{
-	struct at25_data	*at25;
-
-	at25 = spi_get_drvdata(spi);
-
-	return 0;
-}
-
 /*-------------------------------------------------------------------------*/
 
 static const struct of_device_id at25_of_match[] = {
@@ -402,7 +393,6 @@ static int at25_remove(struct spi_device *spi)
 		.of_match_table = at25_of_match,
 	},
 	.probe		= at25_probe,
-	.remove		= at25_remove,
 };
 
 module_spi_driver(at25_driver);

