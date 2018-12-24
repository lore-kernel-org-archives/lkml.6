Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02932C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6E52173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeLXIiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:38:23 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:50510 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeLXIiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:38:23 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 926116C62F04F176CF32;
        Mon, 24 Dec 2018 16:38:18 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBO8cAOr059116;
        Mon, 24 Dec 2018 16:38:10 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122416381705-18426314 ;
          Mon, 24 Dec 2018 16:38:17 +0800 
From:   "huang.zijiang" <huang.zijiang@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.vnet.ibm.com, mhocko@suse.com, sfr@canb.auug.org.au,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        "huang.zijiang" <huang.zijiang@zte.com.cn>
Subject: [PATCH] firmware/memmap:Modify memblock_alloc to memblock_alloc_nopanic
Date:   Mon, 24 Dec 2018 16:41:22 +0800
Message-Id: <1545640882-42009-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-24 16:38:17,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-24 16:38:10,
        Serialize complete at 2018-12-24 16:38:10
X-MAIL: mse01.zte.com.cn wBO8cAOr059116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huang.zijiang" <huang.zijiang@zte.com.cn>

memblock_alloc never returns NULL because panic never returns

Signed-off-by: huang.zijiang <huang.zijiang@zte.com.cn>
---
 drivers/firmware/memmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index d168c87..ec4fd25 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -333,7 +333,7 @@ int __init firmware_map_add_early(u64 start, u64 end, const char *type)
 {
 	struct firmware_map_entry *entry;
 
-	entry = memblock_alloc(sizeof(struct firmware_map_entry),
+	entry = memblock_alloc_nopanic(sizeof(struct firmware_map_entry),
 			       SMP_CACHE_BYTES);
 	if (WARN_ON(!entry))
 		return -ENOMEM;
-- 
1.8.3.1

