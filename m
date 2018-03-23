Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeCWXNZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:13:25 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38734 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeCWXNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:13:22 -0400
X-Google-Smtp-Source: AG47ELtn9QjCaz1e456DZZRJ5MD8JGJEKr5l6UqNcdLag7YzBRmw72NmksrYxLmotVcgJ7ZF1iN1bA==
From: Tejun Heo <tj@kernel.org>
To: lizefan@huawei.com, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, guro@fb.com,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/8] cgroup: Rename kernel/cgroup/stat.c to kernel/cgroup/rstat.c
Date: Fri, 23 Mar 2018 16:13:06 -0700
Message-Id: <20180323231313.1254142-2-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180323231313.1254142-1-tj@kernel.org>
References: <20180323231313.1254142-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stat is too generic a name and ends up causing subtle confusions.
It'll be made generic so that controllers can plug into it, which will
make the problem worse.  Let's rename it to something more specific -
cgroup_rstat for cgroup recursive stat.

First, rename kernel/cgroup/stat.c to kernel/cgroup/rstat.c.  No
content changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/Makefile            | 2 +-
 kernel/cgroup/{stat.c => rstat.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename kernel/cgroup/{stat.c => rstat.c} (100%)

diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index 2be89a00..bfcdae8 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y := cgroup.o stat.o namespace.o cgroup-v1.o
+obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o
 
 obj-$(CONFIG_CGROUP_FREEZER) += freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
diff --git a/kernel/cgroup/stat.c b/kernel/cgroup/rstat.c
similarity index 100%
rename from kernel/cgroup/stat.c
rename to kernel/cgroup/rstat.c
-- 
2.9.5
