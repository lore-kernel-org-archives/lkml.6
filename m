Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeBZNVN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:21:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53735 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeBZNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:19:17 -0500
X-Google-Smtp-Source: AH8x225BgDUtlG3pHQ1MKK26rK49ws6Q2kVZJI022oZCkvN9DrGfUPtWy7Cz7v70bGbt9ktR4/dugg==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: remove unused variable
Date: Mon, 26 Feb 2018 14:18:49 +0100
Message-Id: <1519651129-17897-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable after a previous cleanup (a8112b631adb)

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ce6a7cfdba66..e6cb4317bb50 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1071,7 +1071,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	int nr_bb = 0;
 	u64 off;
 	int bit = -1;
 	int emeta_secs;
@@ -1087,8 +1086,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 		bitmap_or(line->map_bitmap, line->map_bitmap, l_mg->bb_aux,
 							lm->sec_per_line);
 		line->sec_in_line -= geo->c.clba;
-		if (bit >= lm->emeta_bb)
-			nr_bb++;
 	}
 
 	/* Mark smeta metadata sectors as bad sectors */
-- 
2.7.4
