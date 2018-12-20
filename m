Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4597C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A2021720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297642;
	bh=5apI64+6Sx+mJIBx5Yap+WIvmEDc17D8Ke4F5krzT/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FcKHBRW3ZAqdFJc1z3wJ1s8JaGwoopWYx3L2I+dCyDlfatcuxxlQ1c2xYTlkmQfYR
	 +j++GgvBkk7J+1W5y74n87EtKz3YFSO5zYd0DCbRk7s5aMW6SPCwvYNWQ6pLrMViQl
	 biZstxuXZq+TFZTzCaMDRbtN3UCLPE2GpON2wklA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeLTJUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbeLTJUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D20521720;
        Thu, 20 Dec 2018 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297636;
        bh=5apI64+6Sx+mJIBx5Yap+WIvmEDc17D8Ke4F5krzT/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwMQv687UG+r6KQJJLF3Nk1RvWp493lPJtNDCR6qDeNh3KxBA+QfhNrO8hYsDBd4/
         3o18HfEQWDtxErviVUmREY/FT2vjhJNnWe/RHRolc1h/NP6fL6wGt2E889LnRVWVxn
         8id1sm6DIYYRRKC7nu5jOhxG0vnxq1EGpfSsmkKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 04/31] lib/rbtree-test: lower default params
Date:   Thu, 20 Dec 2018 10:18:16 +0100
Message-Id: <20181220085742.768719493@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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



