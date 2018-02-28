Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeB1Qzp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:55:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39580 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933998AbeB1P5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:57:34 -0500
X-Google-Smtp-Source: AH8x2254+5MzjcmxafNGUoKp2q7s2bp/9xDWQd+GM5g+KVlU17dw9C2EStQJskeH6Xou3/mgTLxGvg==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: remove unused variable
Date: Wed, 28 Feb 2018 16:57:24 +0100
Message-Id: <1519833444-28160-2-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519833444-28160-1-git-send-email-javier@cnexlabs.com>
References: <1519833444-28160-1-git-send-email-javier@cnexlabs.com>
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
index cd663855ee88..b85cdedb5f48 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1082,7 +1082,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	int nr_bb = 0;
 	u64 off;
 	int bit = -1;
 	int emeta_secs;
@@ -1098,8 +1097,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 		bitmap_or(line->map_bitmap, line->map_bitmap, l_mg->bb_aux,
 							lm->sec_per_line);
 		line->sec_in_line -= geo->clba;
-		if (bit >= lm->emeta_bb)
-			nr_bb++;
 	}
 
 	/* Mark smeta metadata sectors as bad sectors */
-- 
2.7.4
