Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeC2WHG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:07:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38988 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeC2WHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:01 -0400
X-Google-Smtp-Source: AIpwx49HzmhPkcUxNrKREfTyvcZdsIrd4h0KudJyrnYxFmdbN62eELlJYOfomlrFl4I05BmcnOwrNA==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Markus Elfring <elfring@users.sourceforge.net>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 01/37] lightnvm/pblk-gc: Delete an error message for a failed memory allocation in pblk_gc_line_prepare_ws()
Date: Fri, 30 Mar 2018 00:04:48 +0200
Message-Id: <20180329220524.30363-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-gc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 3d899383666e..31f17d6f14ee 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -147,10 +147,8 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	int ret;
 
 	invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_KERNEL);
-	if (!invalid_bitmap) {
-		pr_err("pblk: could not allocate GC invalid bitmap\n");
+	if (!invalid_bitmap)
 		goto fail_free_ws;
-	}
 
 	emeta_buf = pblk_malloc(lm->emeta_len[0], l_mg->emeta_alloc_type,
 								GFP_KERNEL);
-- 
2.11.0
