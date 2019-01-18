Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC1C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6BC2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfARRv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:51:59 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:45799 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727940AbfARRv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:51:59 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 593D61C35A3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:51:57 +0000 (GMT)
Received: (qmail 30679 invoked from network); 18 Jan 2019 17:51:57 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 18 Jan 2019 17:51:57 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 01/22] mm, compaction: Shrink compact_control
Date:   Fri, 18 Jan 2019 17:51:15 +0000
Message-Id: <20190118175136.31341-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190118175136.31341-1-mgorman@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isolate and migrate scanners should never isolate more than a pageblock
of pages so unsigned int is sufficient saving 8 bytes on a 64-bit build.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 536bc2a839b9..5564841fce36 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -185,8 +185,8 @@ struct compact_control {
 	struct list_head freepages;	/* List of free pages to migrate to */
 	struct list_head migratepages;	/* List of pages being migrated */
 	struct zone *zone;
-	unsigned long nr_freepages;	/* Number of isolated free pages */
-	unsigned long nr_migratepages;	/* Number of pages to migrate */
+	unsigned int nr_freepages;	/* Number of isolated free pages */
+	unsigned int nr_migratepages;	/* Number of pages to migrate */
 	unsigned long total_migrate_scanned;
 	unsigned long total_free_scanned;
 	unsigned long free_pfn;		/* isolate_freepages search base */
-- 
2.16.4

