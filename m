Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeB1CRF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:17:05 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:37726 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbeB1CRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:17:04 -0500
From: Jiang Biao <jiang.biao2@zte.com.cn>
To: richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH] fs/ubifs: constify struct ubifs_lprops in scan_for_leb_for_idx
Date: Wed, 28 Feb 2018 10:13:57 +0800
Message-Id: <1519784037-105472-1-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-02-28 10:17:00,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-02-28 10:16:48,
        Serialize complete at 2018-02-28 10:16:48
X-MAIL: mse01.zte.com.cn w1S2GuYs023533
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify struct ubifs_lprops in scan_for_leb_for_idx to be
consistent with other references.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 fs/ubifs/find.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
index 2dcf3d4..9571616 100644
--- a/fs/ubifs/find.c
+++ b/fs/ubifs/find.c
@@ -632,7 +632,7 @@ static int scan_for_idx_cb(struct ubifs_info *c,
  */
 static const struct ubifs_lprops *scan_for_leb_for_idx(struct ubifs_info *c)
 {
-	struct ubifs_lprops *lprops;
+	const struct ubifs_lprops *lprops;
 	struct scan_data data;
 	int err;
 
-- 
2.7.4
