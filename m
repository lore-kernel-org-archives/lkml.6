Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1408BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80CE2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297796;
	bh=WnvVvoDwF21WEc1jyGKGDeZJd7sUVpkVgSO17FZUFto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nCMu90mg439oW//8ijIY+IzXVkvps8vchYqkULYHk887kNI+YKmsvOhjXxqWPL7rW
	 ryWIxfK8SrOIOw7Ea8+X+LOm7TblfOOysonC1tBTG6Ufy33dUZcRr3zq4r4zaU4uuQ
	 IcU0io++pr+mxyA2YxM0oRW8BGmCg0rKoCnMKQyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeLTJXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:23:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731499AbeLTJXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FB38218D4;
        Thu, 20 Dec 2018 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297790;
        bh=WnvVvoDwF21WEc1jyGKGDeZJd7sUVpkVgSO17FZUFto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qx7la/u3cxfleJSmrtU9WYJhpHjm6RYBWJ0cEhwqZFKH9b3jTxjVlNRQpjL2e7KtT
         +hif+P9ervyTxg4dQgPcEcPku+NQlqbBMiyC+/EQdbx7ArMhVxCzVZ7eNTQID9U2qO
         XKtyDTesAOVpKBTNP5HrKZ7uiasOE9gO05K9DG6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/61] lib/rbtree-test: lower default params
Date:   Thu, 20 Dec 2018 10:18:05 +0100
Message-Id: <20181220085843.951459551@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0b548e33e6cb2bff240fdaf1783783be15c29080 ]

Fengguang reported soft lockups while running the rbtree and interval
tree test modules.  The logic for these tests all occur in init phase,
and we currently are pounding with the default values for number of
nodes and number of iterations of each test.  Reduce the latter by two
orders of magnitude.  This does not influence the value of the tests in
that one thousand times by default is enough to get the picture.

Link: http://lkml.kernel.org/r/20171109161715.xai2dtwqw2frhkcm@linux-n805
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/interval_tree_test.c | 4 ++--
 lib/rbtree_test.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index 409383463879..bababcf7ffdd 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -11,10 +11,10 @@
 	MODULE_PARM_DESC(name, msg);
 
 __param(int, nnodes, 100, "Number of nodes in the interval tree");
-__param(int, perf_loops, 100000, "Number of iterations modifying the tree");
+__param(int, perf_loops, 1000, "Number of iterations modifying the tree");
 
 __param(int, nsearches, 100, "Number of searches to the interval tree");
-__param(int, search_loops, 10000, "Number of iterations searching the tree");
+__param(int, search_loops, 1000, "Number of iterations searching the tree");
 __param(bool, search_all, false, "Searches will iterate all nodes in the tree");
 
 
diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index e83331aa1b7f..afedd3770562 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -11,7 +11,7 @@
 	MODULE_PARM_DESC(name, msg);
 
 __param(int, nnodes, 100, "Number of nodes in the rb-tree");
-__param(int, perf_loops, 100000, "Number of iterations modifying the rb-tree");
+__param(int, perf_loops, 1000, "Number of iterations modifying the rb-tree");
 __param(int, check_loops, 100, "Number of iterations modifying and verifying the rb-tree");
 
 struct test_node {
-- 
2.19.1



