Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BFDECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBD52064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBD52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJSQZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:25:48 -0400
Received: from mailrelay101.isp.belgacom.be ([195.238.20.128]:36165 "EHLO
        mailrelay101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbeJSQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:25:10 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AVNSS8RVy3n3tBeXVVEq3LzixWWjV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbR2Et8tkgFKBZ4jH8fUM07OQ7/i/HzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9wIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KptVRTmijoINyQh/W/XlMJ+kaxVrhGmqRN9zY7Ze52ZOOZkc6/BZ94WWX?=
 =?us-ascii?q?ZNU8BMXCJBGIO8aI4PAvIBM+lCtIb9pkEBrR2jDgesHuPg1CJHiWHs3a07z+?=
 =?us-ascii?q?shEhzN0QsuH90Uq3vUos74NLwRUeG1yqnH0ynDY+lN1jjj8YXFdA0qr/KUXb?=
 =?us-ascii?q?9ocsfcy1MjGgLEg1mKq4HoOymZ2vkOvmWV6edrSPihhHQ9qw5rpzii3sIsio?=
 =?us-ascii?q?7UiY0L0l3E7iB5wJotJd2/VU57fcaoEJtOuCGeMIt7WsciQ2Z0tykgzr0GuZ?=
 =?us-ascii?q?m7fDMWyJg9wx7fbOCIfJKM4h3+U+aRJC13hHNjeL6nhhay91avyvHkW8S30l?=
 =?us-ascii?q?tGtCtIn9jWun0P0xHf8NWLR/hz80u53DaAzQHT6uVKIUAukqrbLoYswrAqmZ?=
 =?us-ascii?q?UIv0TOBTT2mEb2ja+QaEok5vKk5P/5bbn+vJ+TK5d0ih3iMqQpgsGwG+c4Mh?=
 =?us-ascii?q?ALX2WA/eS81bvj/VD2QblTgP02lbTZsJbHKssBuq65AghV0oA55xa4FTem38?=
 =?us-ascii?q?wSnWMbI1JdZBKHk4/pNknMIP/iDfewmU6skDR1yPDdJbDuHo7NImLfn7fkYL?=
 =?us-ascii?q?Zx8VBTxxcuzdpH/ZJbFqkBIO7vWk/2rNHXEhg5PBGuzOv8FNp9zZkSVn6KAq?=
 =?us-ascii?q?+EKq/dr0KH5v83KemWeIAVoCr9K+Qi5/P2iX85mFkdfbSm3JcOZnC4BelpLF?=
 =?us-ascii?q?uHYXXyhtcMCnkKvgUgQ+zwklGCUiBcZ2y0X60i4jE3EoWmDZ3MRoq1mryOwD?=
 =?us-ascii?q?+7HoFKZmBBEl2MFXbod4OZW/YDcS6SIdFukiYCVbe/T48szg+utADkxLp9NO?=
 =?us-ascii?q?bU+TMXtYjl1Ndr4+3fjxYy9SZ7D86FyWGCU3l0nn8URz8xxK1/r1ZyxUyN0a?=
 =?us-ascii?q?VjmPxYFtxS5/VXXQcmL5LT1PJ1WJjOXVfIfc+MYFKnRMi2RD82U9Q9ysMPZE?=
 =?us-ascii?q?A7HM+t3T7Z2C//LbYflrWNTLIu/67RxXn6JI4pxX/M2oE6jEggT9cJP2Dw1f?=
 =?us-ascii?q?03zBTaG4OcyxbRrK2tb6lJhCM=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AZAACMkslb/7dPQldjGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUgUBAQELAYEIfIFTEiiMbI1+AYhQjgmBejgBhDoEAgKFAyI1DA0?=
 =?us-ascii?q?BAwEBAgEBAgFsKII2IoJiBicvIxBROR4ZgyGBdRGnWjODfYYnhyyEOoFBP4E?=
 =?us-ascii?q?RiF2FDQKeQQmGIYpLAhWBQI5pLJdrAjSBVU0gGIMngiYXjhw9MIEDAT0BijI?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2AZAACMkslb/7dPQldjGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYEIfIFTEiiMbI1+AYhQjgmBejgBhDoEAgKFAyI1DA0BAwEBAgEBAgFsK?=
 =?us-ascii?q?II2IoJiBicvIxBROR4ZgyGBdRGnWjODfYYnhyyEOoFBP4ERiF2FDQKeQQmGI?=
 =?us-ascii?q?YpLAhWBQI5pLJdrAjSBVU0gGIMngiYXjhw9MIEDAT0BijIBAQ?=
Received: from 183.79-66-87.adsl-dyn.isp.belgacom.be (HELO localhost.localdomain) ([87.66.79.183])
  by relay.skynet.be with ESMTP; 19 Oct 2018 10:20:07 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     akpm@linux-foundation.org
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fabf@skynet.be
Subject: [PATCH 2/7 linux-next] coda: destroy mutex in put_super()
Date:   Fri, 19 Oct 2018 10:19:28 +0200
Message-Id: <1539937173-26260-3-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1539937173-26260-1-git-send-email-fabf@skynet.be>
References: <1539937173-26260-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we can safely destroy vc_mutex at the end of umount process.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/coda/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index dd819c1..69bb64d 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -244,6 +244,7 @@ static void coda_put_super(struct super_block *sb)
 	vcp->vc_sb = NULL;
 	sb->s_fs_info = NULL;
 	mutex_unlock(&vcp->vc_mutex);
+	mutex_destroy(&vcp->vc_mutex);
 
 	pr_info("Bye bye.\n");
 }
-- 
2.4.11

