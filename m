Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbeFAQCm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:02:42 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:37200 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeFAQCN (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 1 Jun 2018 12:02:13 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, manfred@colorfullife.com,
        mhocko@kernel.org, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 5/5] lib/test_rhashtable: rhashtable_init() can no longer fail
Date: Fri,  1 Jun 2018 09:01:25 -0700
Message-Id: <20180601160125.30031-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180601160125.30031-1-dave@stgolabs.net>
References: <20180601160125.30031-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the test module as such.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/test_rhashtable.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index f4000c137dbe..a894eb0407f0 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -182,11 +182,7 @@ static void test_bucket_stats(struct rhashtable *ht, unsigned int entries)
 	struct rhashtable_iter hti;
 	struct rhash_head *pos;
 
-	err = rhashtable_walk_init(ht, &hti, GFP_KERNEL);
-	if (err) {
-		pr_warn("Test failed: allocation error");
-		return;
-	}
+	rhashtable_walk_init(ht, &hti, GFP_KERNEL);
 
 	rhashtable_walk_start(&hti);
 
-- 
2.16.3
