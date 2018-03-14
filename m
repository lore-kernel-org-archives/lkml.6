Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeCNPgj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:36:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37686 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeCNPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:36:37 -0400
X-Google-Smtp-Source: AG47ELuWWGw5HlkgOHRPdp89PPVmVW/WsViQuB998wR3H0O87XWip8FRS4BF6zJfYjNb+Z70rOj0ng==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: computersforpeace@gmail.com, boris.brezillon@free-electrons.com,
        marek.vasut@gmail.com, richard@nod.at, cyrille.pitchen@wedev4u.fr,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH 3/3] mtd: Remove print after allocation failure
Date: Wed, 14 Mar 2018 21:05:18 +0530
Message-Id: <1521041718-32492-3-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521041718-32492-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1521041718-32492-1-git-send-email-arushisinghal19971997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prints after [k|v][m|z|c]alloc() functions are not needed, because
in case of failure, allocator will print their internal error prints
anyway.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/mtd/inftlmount.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
index 8d6bb189..6b94646 100644
--- a/drivers/mtd/inftlmount.c
+++ b/drivers/mtd/inftlmount.c
@@ -562,12 +562,8 @@ int INFTL_mount(struct INFTLrecord *s)
 
 	/* Temporary buffer to store ANAC numbers. */
 	ANACtable = kcalloc(s->nb_blocks, sizeof(u8), GFP_KERNEL);
-	if (!ANACtable) {
-		printk(KERN_WARNING "INFTL: allocation of ANACtable "
-				"failed (%zd bytes)\n",
-				s->nb_blocks * sizeof(u8));
+	if (!ANACtable)
 		return -ENOMEM;
-	}
 
 	/*
 	 * First pass is to explore each physical unit, and construct the
-- 
2.7.4
