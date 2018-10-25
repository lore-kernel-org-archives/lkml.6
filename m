Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9C6ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8572082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8572082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mxic.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeJYPQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:16:05 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:50700 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:16:05 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id w9P6iWAT037555;
        Thu, 25 Oct 2018 14:44:36 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   masonccyang@mxic.com.tw
To:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw
Cc:     masonccyang@mxic.com.tw
Subject: [PATCH] mtd: rawnand: Add All 1.8V AC chips have a broken GET_FEATURES(TIMINGS)
Date:   Thu, 25 Oct 2018 14:44:31 +0800
Message-Id: <1540449871-7224-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540449871-7224-1-git-send-email-masonccyang@mxic.com.tw>
References: <1540449871-7224-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com w9P6iWAT037555
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>

Make sure we flag all 1.8V broken chips as not supporting this features.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_macronix.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 49c546c..3836544 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -33,6 +33,13 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
 		"MX30LF4G18AC",
 		"MX30LF4G28AC",
 		"MX60LF8G18AC",
+		"MX30UF1G18AC",
+		"MX30UF1G16AC",
+		"MX30UF2G18AC",
+		"MX30UF2G16AC",
+		"MX30UF4G18AC",
+		"MX30UF4G16AC",
+		"MX30UF4G28AC",
 	};
 
 	if (!chip->parameters.supports_set_get_features)
-- 
1.9.1

