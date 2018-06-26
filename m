Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA53C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E912526910
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E912526910
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964919AbeFZK0z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:26:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35317 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934448AbeFZK0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:26:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fXlB8-00009T-94; Tue, 26 Jun 2018 10:26:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: rawnand: fix a couple of spelling mistakes
Date:   Tue, 26 Jun 2018 11:26:29 +0100
Message-Id: <20180626102629.31083-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix of two spelling mistakes in dev_err error messages:
"supportes" -> "supports" and "strenght" -> "strength"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nand/raw/tegra_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 4daa88d81413..9f7de36be893 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -1002,14 +1002,14 @@ static int tegra_nand_chips_init(struct device *dev,
 	}
 
 	if (chip->ecc.algo == NAND_ECC_BCH && mtd->writesize < 2048) {
-		dev_err(dev, "BCH supportes 2K or 4K page size only\n");
+		dev_err(dev, "BCH supports 2K or 4K page size only\n");
 		return -EINVAL;
 	}
 
 	if (!chip->ecc.strength) {
 		ret = tegra_nand_select_strength(chip, mtd->oobsize);
 		if (ret < 0) {
-			dev_err(dev, "No valid strenght found, minimum %d\n",
+			dev_err(dev, "No valid strength found, minimum %d\n",
 				chip->ecc_strength_ds);
 			return ret;
 		}
-- 
2.17.1

