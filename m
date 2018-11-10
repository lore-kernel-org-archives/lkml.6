Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC4C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8074620840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtJVDTpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8074620840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeKJRg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 12:36:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45206 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeKJRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 12:36:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id p17-v6so1957359pfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sa0VAYLhPUDYaT2zeotQJbKOsfN6FojgkHaFLgVP+HA=;
        b=QtJVDTpOJn3dKhJEsLRHuHW9oa2Qlz6UrEH6ShB84vzzm+F0Ad8xSSQ1WCrjpceVy/
         pria+Ox7KKI2mRq32XVtli4Z/tSrpPCuP/W9eNWPVY/lswE7kG11c4ejjYQ2CWzLf+Gl
         RCV3pGbLN8RwIW+/9KjjHcotFNjbCKiieC5m2LC1CF6XrrDxun3nIjxDMHjPf4PRMjwG
         C9EiQ/5Z6YLIwnBF7LIFvP4NdGRRGh9Y3+YK9UtgV1DWdOZL4X0RxfGobQHZ/u9lcQS/
         HcDLEo67lbSIodf6Do69NxqwfppQc6z/LNtbfK6j1QAGghBqQP8jeS40lS9WQmucRpE7
         eBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sa0VAYLhPUDYaT2zeotQJbKOsfN6FojgkHaFLgVP+HA=;
        b=geUhiOjkPXpacNXUe3HVbVqgnz/NHWiK7q7jJScu5UECfhI8J80MUfRFUAOdXBHjbW
         0emMJtnrNBJG9IKy4hMQV7PhZ1LMk6ahHkKcn8vnd5zSqCB1ej3rXsP93olAah7iM5Ii
         HQ7FCgElV6lA/NsCVSx5YHvHTPMPrHnRlGGjsIzTmi8UzY2lm/pZizdQZZ8r3dszhpGr
         g18Ig7aHWqYU1bQJrSpot5TbkbZp/XP7UBJvX3V41y2GYH3ckuIGBztVpXPJq6c8OMta
         nVqbJ5NHLfheqH9LkskUt1EtZOVsJ2S0OrQH/K7zxfli7ajFOKKDl6uXCrwhupsLE0w7
         ujnw==
X-Gm-Message-State: AGRZ1gLGYsH41Ce41L/cMMD+4ZgDXdmkzO94pUnEbiTLJhTW2+SOG+LQ
        i1pq4DsEDTMclpU0napaigk=
X-Google-Smtp-Source: AJdET5dGLyE/KlRq8nKfrSvR4S0HxwxADiwHql2aQmuDIhAoLXrUREEPgAohkeKMJazYniBzWTkGmA==
X-Received: by 2002:a65:4946:: with SMTP id q6mr3213603pgs.201.1541836343561;
        Fri, 09 Nov 2018 23:52:23 -0800 (PST)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id k68-v6sm11804035pfj.13.2018.11.09.23.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 23:52:23 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Make some variables static
Date:   Sat, 10 Nov 2018 15:52:02 +0800
Message-Id: <20181110075202.61172-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables are local to the source and do not
need to be in global scope, so make them static.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f622fc858d7a..9d0cd2d0515f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -38,7 +38,7 @@
  * (default: 6ms * (1 + ilog(ncpus)), units: nanoseconds)
  */
 unsigned int sysctl_sched_latency			= 6000000ULL;
-unsigned int normalized_sysctl_sched_latency		= 6000000ULL;
+static unsigned int normalized_sysctl_sched_latency	= 6000000ULL;
 
 /*
  * The initial- and re-scaling of tunables is configurable
@@ -58,8 +58,8 @@ enum sched_tunable_scaling sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_L
  *
  * (default: 0.75 msec * (1 + ilog(ncpus)), units: nanoseconds)
  */
-unsigned int sysctl_sched_min_granularity		= 750000ULL;
-unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
+unsigned int sysctl_sched_min_granularity			= 750000ULL;
+static unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
 
 /*
  * This value is kept at sysctl_sched_latency/sysctl_sched_min_granularity
@@ -81,8 +81,8 @@ unsigned int sysctl_sched_child_runs_first __read_mostly;
  *
  * (default: 1 msec * (1 + ilog(ncpus)), units: nanoseconds)
  */
-unsigned int sysctl_sched_wakeup_granularity		= 1000000UL;
-unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
+unsigned int sysctl_sched_wakeup_granularity			= 1000000UL;
+static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
-- 
2.17.1

