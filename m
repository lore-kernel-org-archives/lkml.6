Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40566C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A28214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfAITUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:20:24 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43002 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728143AbfAITUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:20:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0THtvvDg_1547061291;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THtvvDg_1547061291)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jan 2019 03:14:59 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 5/5] doc: memcontrol: add description for wipe_on_offline
Date:   Thu, 10 Jan 2019 03:14:45 +0800
Message-Id: <1547061285-100329-6-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add desprition of wipe_on_offline interface in cgroup documents.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  9 +++++++++
 Documentation/cgroup-v1/memory.txt      | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0290c65..e4ef08c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1303,6 +1303,15 @@ PAGE_SIZE multiple when read back.
         memory pressure happens. If you want to avoid that, force_empty will be
         useful.
 
+  memory.wipe_on_offline
+
+        This is similar to force_empty, but it just does memory reclaim
+        asynchronously in css offline kworker.
+
+        Writing into 1 will enable it, disable it by writing into 0.
+
+        It would reclaim as much as possible memory just as what force_empty does.
+
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
diff --git a/Documentation/cgroup-v1/memory.txt b/Documentation/cgroup-v1/memory.txt
index 8e2cb1d..1c6e1ca 100644
--- a/Documentation/cgroup-v1/memory.txt
+++ b/Documentation/cgroup-v1/memory.txt
@@ -71,6 +71,7 @@ Brief summary of control files.
  memory.stat			 # show various statistics
  memory.use_hierarchy		 # set/show hierarchical account enabled
  memory.force_empty		 # trigger forced page reclaim
+ memory.wipe_on_offline		 # trigger forced page reclaim when offlining
  memory.pressure_level		 # set memory pressure notifications
  memory.swappiness		 # set/show swappiness parameter of vmscan
 				 (See sysctl's vm.swappiness)
@@ -581,6 +582,15 @@ hierarchical_<counter>=<counter pages> N0=<node 0 pages> N1=<node 1 pages> ...
 
 The "total" count is sum of file + anon + unevictable.
 
+5.7 wipe_on_offline
+
+This is similar to force_empty, but it just does memory reclaim asynchronously
+in css offline kworker.
+
+Writing into 1 will enable it, disable it by writing into 0.
+
+It would reclaim as much as possible memory just as what force_empty does.
+
 6. Hierarchy support
 
 The memory controller supports a deep hierarchy and hierarchical accounting.
-- 
1.8.3.1

