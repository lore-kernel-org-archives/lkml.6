Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeEVPIT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:08:19 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:51490 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeEVPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:08:02 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mtd: cmdlinepart: Update comment for introduction of OFFSET_CONTINUOUS
Date: Tue, 22 May 2018 17:07:53 +0200
Message-Id: <1527001673-16318-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment about offset zero was not updated when changing behavior:
  - Automatic offset calculation is indicated by OFFSET_CONTINUOUS,
  - Zero really means offset zero.

Fixes: b175d03dd2072836 ("[PATCH] mtd cmdlinepart: allow zero offset value")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/cmdlinepart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/cmdlinepart.c b/drivers/mtd/cmdlinepart.c
index fbd5affc0acfe3fe..3ea44cff9b759e3c 100644
--- a/drivers/mtd/cmdlinepart.c
+++ b/drivers/mtd/cmdlinepart.c
@@ -190,7 +190,10 @@ static struct mtd_partition * newpart(char *s,
 		extra_mem = (unsigned char *)(parts + *num_parts);
 	}
 
-	/* enter this partition (offset will be calculated later if it is zero at this point) */
+	/*
+	 * enter this partition (offset will be calculated later if it is
+	 * OFFSET_CONTINUOUS at this point)
+	 */
 	parts[this_part].size = size;
 	parts[this_part].offset = offset;
 	parts[this_part].mask_flags = mask_flags;
-- 
2.7.4
