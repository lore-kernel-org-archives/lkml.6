Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2B40EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0425208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0425208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754622AbeFMVZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:25:01 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45454 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935929AbeFMVYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 187AF18198DC4;
        Wed, 13 Jun 2018 23:24:09 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 14/14] ubi: Remove experimental stigma from Fastmap
Date:   Wed, 13 Jun 2018 23:23:44 +0200
Message-Id: <20180613212344.11608-15-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've hold up this a way too long. Over the last two years Fastmap gained
many users which made it possible to sort out the last issues.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index 43d131f5ae10..4de5e4e8d4ab 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -57,12 +57,9 @@ config MTD_UBI_BEB_LIMIT
 	  Leave the default value if unsure.
 
 config MTD_UBI_FASTMAP
-	bool "UBI Fastmap (Experimental feature)"
+	bool "UBI Fastmap"
 	default n
 	help
-	   Important: this feature is experimental so far and the on-flash
-	   format for fastmap may change in the next kernel versions
-
 	   Fastmap is a mechanism which allows attaching an UBI device
 	   in nearly constant time. Instead of scanning the whole MTD device it
 	   only has to locate a checkpoint (called fastmap) on the device.
@@ -74,6 +71,8 @@ config MTD_UBI_FASTMAP
 	   images are still usable with UBI implementations without
 	   fastmap support. On typical flash devices the whole fastmap fits
 	   into one PEB. UBI will reserve PEBs to hold two fastmaps.
+	   While Fastmap is considered correct it weakens UBI wrt. robustness,
+	   a full scan of the MTD allows UBI to react better to bad flashes.
 
 	   If in doubt, say "N".
 
-- 
2.13.6

