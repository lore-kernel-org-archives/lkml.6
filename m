Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754406AbeCRRwM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 13:52:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36635 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754153AbeCRRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 13:52:10 -0400
X-Google-Smtp-Source: AG47ELsWYms3/queYBqjMVGhPMmLjtfQz+S9bgvGD92W6mwF3WNCvRvkYxrZN6MJRk+bPx4Iv1cYTw==
Date: Sun, 18 Mar 2018 23:21:23 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: Replace typedef with struct
Message-ID: <20180318175122.GA15004@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using typedef for a structure type is not suggested in Linux kernel
coding style guidelines. Hence, occurrence of typedefs has been
removed.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/mtd/ssfdc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 95f0bf9..8bae672 100644
--- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -54,15 +54,15 @@ SumSector	2,000	4,000	8,000	16,000	32,000	64,000	128,000	256,000
 SectorSize	512	512	512	512	512	512	512	512
 **/
 
-typedef struct {
+struct chs_entry {
 	unsigned long size;
 	unsigned short cyl;
 	unsigned char head;
 	unsigned char sec;
-} chs_entry_t;
+};
 
 /* Must be ordered by size */
-static const chs_entry_t chs_table[] = {
+static const struct chs_entry chs_table[] = {
 	{ MiB(  1), 125,  4,  4 },
 	{ MiB(  2), 125,  4,  8 },
 	{ MiB(  4), 250,  4,  8 },
-- 
2.7.4
