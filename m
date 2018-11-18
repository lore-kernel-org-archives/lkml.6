Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0F0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DBD2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DBD2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeKSC5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:57:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41457 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeKSC5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 21:57:55 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gOQ48-0000Zw-Pw; Sun, 18 Nov 2018 16:36:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: nftl: clean up indentation, remove extraneous tabs
Date:   Sun, 18 Nov 2018 16:36:56 +0000
Message-Id: <20181118163656.30698-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The hunk of code is indented too much by one level, fix this by
removing the extraneous tabs. Also terminate block comment using
the recommended coding style to clean up checkpatch warning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nftlmount.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
index 91b7fb326f9a..334aa5b3a655 100644
--- a/drivers/mtd/nftlmount.c
+++ b/drivers/mtd/nftlmount.c
@@ -346,25 +346,26 @@ int NFTL_formatblock(struct NFTLrecord *nftl, int block)
 		goto fail;
 	}
 
-		/* increase and write Wear-Leveling info */
-		nb_erases = le32_to_cpu(uci.WearInfo);
-		nb_erases++;
-
-		/* wrap (almost impossible with current flash) or free block */
-		if (nb_erases == 0)
-			nb_erases = 1;
-
-		/* check the "freeness" of Erase Unit before updating metadata
-		 * FixMe:  is this check really necessary ? since we have check the
-		 *         return code after the erase operation. */
-		if (check_free_sectors(nftl, instr->addr, nftl->EraseSize, 1) != 0)
-			goto fail;
-
-		uci.WearInfo = le32_to_cpu(nb_erases);
-		if (nftl_write_oob(mtd, block * nftl->EraseSize + SECTORSIZE +
-				   8, 8, &retlen, (char *)&uci) < 0)
-			goto fail;
-		return 0;
+	/* increase and write Wear-Leveling info */
+	nb_erases = le32_to_cpu(uci.WearInfo);
+	nb_erases++;
+
+	/* wrap (almost impossible with current flash) or free block */
+	if (nb_erases == 0)
+		nb_erases = 1;
+
+	/* check the "freeness" of Erase Unit before updating metadata
+	 * FixMe:  is this check really necessary ? since we have check the
+	 *         return code after the erase operation.
+	 */
+	if (check_free_sectors(nftl, instr->addr, nftl->EraseSize, 1) != 0)
+		goto fail;
+
+	uci.WearInfo = le32_to_cpu(nb_erases);
+	if (nftl_write_oob(mtd, block * nftl->EraseSize + SECTORSIZE +
+			   8, 8, &retlen, (char *)&uci) < 0)
+		goto fail;
+	return 0;
 fail:
 	/* could not format, update the bad block table (caller is responsible
 	   for setting the ReplUnitTable to BLOCK_RESERVED on failure) */
-- 
2.19.1

