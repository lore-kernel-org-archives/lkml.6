Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA1BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F4721731
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F4721731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933284AbeGDGqZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:46:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeGDGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:46:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fabYH-000877-O7; Wed, 04 Jul 2018 06:46:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: nftl: remove redundant variable nb_erases
Date:   Wed,  4 Jul 2018 07:46:09 +0100
Message-Id: <20180704064609.13369-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable nb_erases is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'nb_erases' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nftlmount.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
index 27184e3874db..91b7fb326f9a 100644
--- a/drivers/mtd/nftlmount.c
+++ b/drivers/mtd/nftlmount.c
@@ -577,7 +577,7 @@ static int get_fold_mark(struct NFTLrecord *nftl, unsigned int block)
 int NFTL_mount(struct NFTLrecord *s)
 {
 	int i;
-	unsigned int first_logical_block, logical_block, rep_block, nb_erases, erase_mark;
+	unsigned int first_logical_block, logical_block, rep_block, erase_mark;
 	unsigned int block, first_block, is_first_block;
 	int chain_length, do_format_chain;
 	struct nftl_uci0 h0;
@@ -621,7 +621,6 @@ int NFTL_mount(struct NFTLrecord *s)
 
 				logical_block = le16_to_cpu ((h0.VirtUnitNum | h0.SpareVirtUnitNum));
 				rep_block = le16_to_cpu ((h0.ReplUnitNum | h0.SpareReplUnitNum));
-				nb_erases = le32_to_cpu (h1.WearInfo);
 				erase_mark = le16_to_cpu ((h1.EraseMark | h1.EraseMark1));
 
 				is_first_block = !(logical_block >> 15);
-- 
2.17.1

