Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeENL1M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:27:12 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35588 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeENLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:24:34 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/8] ubi: fastmap: Add UBI_FM_SB_PRESEEDED_FLG flag
Date: Mon, 14 May 2018 13:24:16 +0200
Message-Id: <20180514112422.23988-3-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112422.23988-1-richard@nod.at>
References: <20180514112422.23988-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
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
index d25ced1285e2..5ebf40db922f 100644
--- a/drivers/mtd/ubi/ubi-media.h
+++ b/drivers/mtd/ubi/ubi-media.h
@@ -406,7 +406,11 @@ struct ubi_vtbl_record {
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
