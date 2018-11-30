Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C5FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D67C20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmQbOmQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D67C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeLALA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:00:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34094 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLAK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:58:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so3545884plz.1;
        Fri, 30 Nov 2018 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=hmQbOmQkV6ljdW0TaOvMcRuzEZsaozfPkRaLYJNXP8OepQ0Pr4eJVIeLZg6G+hs83q
         s8hd5fcqPW+j1gKTRiEMFBLqSN5SO6pgrMU4xI5Wj4+VL0vyhhyM0JbQYL144J+Jzu7B
         wAgTxsPzGtE3bpSybq+O2OEvYElzu2/H5M1rnrc/9quHagXlcLd5ind+qThxTJl9LO58
         GQe7DHH/oIKKo9gSnAB7dM7BpX3tuaFcwNRABuWBef8w+ccFWvxEU1y3lSgZR8emtK/H
         /6xgFb1EZDnxuOQzgM0YLeSO7fxRS14xzNoiVmD5EfgceCgCL/CFwJQcMvwRwGoyc4vq
         fMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mJ+hAWBjzYrtG9eKN+9slhswn7Xi2CuWuxj5q13heRo=;
        b=iaKk0GlKFGjuII5JE3ptIw39oFMilKC8kFzuPbiCug5BOsIZoHM1IV1uUJTXqjyBOJ
         e61aGp77SW07x9XtBYuvTuEV0A+StaAM1cWlnBv8J81/AHLMYylCfK/xjZJ3QlSMPQJs
         lufTo4hcrdaqNQWYPLGftm0JT43kx9POgi4/+ZUiLC+eZCv9VX6IG8e6mxenCuX7YON4
         7GoNwTpbjsFjuqN0IY+J37Eyv6eH7eTsey3Ohv1v73CLkpG1nofSK3x1Y1kRCHaDdMHY
         N/Yy8FegdzeF0w7g7lsZEljgZ90qPf0M4GZKlaZ5EEbM1eFctzv1fYQUEwC7XkmLTUoF
         ti4A==
X-Gm-Message-State: AA+aEWbyZ1Y8EOHOMGZ4yINUWlFfv6vIhIqyoioAjTNlk0lPl3R8AehN
        aB7GUDIjnPrJwSWvvTp0lcs=
X-Google-Smtp-Source: AFSGD/VOpQF0o+6Mj+f52Cq4C/T7vYULCIVPoix+FJuUnhfn14yXLmHtp1Gule8leO0iG/cws37LAw==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr7694021plp.109.1543621674246;
        Fri, 30 Nov 2018 15:47:54 -0800 (PST)
Received: from castle.tfbnw.net ([2620:10d:c090:180::1:2b61])
        by smtp.gmail.com with ESMTPSA id e188sm9556742pfg.130.2018.11.30.15.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:47:53 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 1/7] cgroup: rename freezer.c into legacy_freezer.c
Date:   Fri, 30 Nov 2018 15:47:39 -0800
Message-Id: <20181130234745.6756-2-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130234745.6756-1-guro@fb.com>
References: <20181130234745.6756-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freezer.c will contain an implementation of cgroup v2 freezer,
so let's rename the v1 freezer to avoid naming conflicts.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 kernel/cgroup/Makefile                        | 2 +-
 kernel/cgroup/{freezer.c => legacy_freezer.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename kernel/cgroup/{freezer.c => legacy_freezer.c} (100%)

diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index bfcdae896122..8d5689ca94b9 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o
 
-obj-$(CONFIG_CGROUP_FREEZER) += freezer.o
+obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/legacy_freezer.c
similarity index 100%
rename from kernel/cgroup/freezer.c
rename to kernel/cgroup/legacy_freezer.c
-- 
2.17.2

