Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbeCYPin (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 11:38:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44725 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbeCYPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 11:38:41 -0400
X-Google-Smtp-Source: AG47ELuquxecWmubL7mwQI+jvhVtl125yb0ZvRH3sMBQBClATaoULrQk2IkLZkWSMn3qXzhBbmU9Lg==
Date: Sun, 25 Mar 2018 21:07:43 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: Use DIV_ROUND_UP()
Message-ID: <20180325153743.GA16063@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel.h macro DIV_ROUND_UP performs the computation
(((n) + (d) - 1) / (d)) but is perhaps more readable.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/mtd/ftl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index a048429..61d5cf8 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -425,8 +425,8 @@ static int prepare_xfer(partition_t *part, int i)
     }
 
     /* Write the BAM stub */
-    nbam = (part->BlocksPerUnit * sizeof(uint32_t) +
-	    le32_to_cpu(part->header.BAMOffset) + SECTOR_SIZE - 1) / SECTOR_SIZE;
+    nbam = DIV_ROUND_UP(part->BlocksPerUnit * sizeof(uint32_t) +
+			le32_to_cpu(part->header.BAMOffset), SECTOR_SIZE);
 
     offset = xfer->Offset + le32_to_cpu(part->header.BAMOffset);
     ctl = cpu_to_le32(BLOCK_CONTROL);
-- 
2.7.4
