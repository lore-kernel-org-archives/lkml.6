Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 97456C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AAA208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AAA208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964828AbeFMV0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:26:46 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45376 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935813AbeFMVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 8CDA7181A2F30;
        Wed, 13 Jun 2018 23:24:02 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 04/14] ubi: fastmap: Add UBI_FM_SB_PRESEEDED_FLG flag
Date:   Wed, 13 Jun 2018 23:23:34 +0200
Message-Id: <20180613212344.11608-5-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag indicates that the fastmap was preseeded, which means
it was created offline by a tool such as ubinize which cannot know
the whole MTD state such as real size and bad blocks.
As consequence UBI has to take special care to use that fastmap.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/ubi-media.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
index 6136a97f4844..be339fb924af 100644
--- a/drivers/mtd/ubi/ubi-media.h
+++ b/drivers/mtd/ubi/ubi-media.h
@@ -390,7 +390,11 @@ struct ubi_vtbl_record {
 #define UBI_FM_MIN_POOL_SIZE	8
 #define UBI_FM_MAX_POOL_SIZE	256
 
-#define UBI_FM_SB_FLG_MASK	0
+enum {
+	UBI_FM_SB_PRESEEDED_FLG	= 0x1,
+};
+
+#define UBI_FM_SB_FLG_MASK (UBI_FM_SB_PRESEEDED_FLG)
 
 /**
  * struct ubi_fm_sb - UBI fastmap super block
-- 
2.13.6

