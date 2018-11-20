Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A0C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D4D20989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D4D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeKUEWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbeKUEWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0919F30832D0;
        Tue, 20 Nov 2018 17:52:18 +0000 (UTC)
Received: from llong.com (ovpn-120-174.rdu2.redhat.com [10.10.120.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABA22608E5;
        Tue, 20 Nov 2018 17:52:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 4/5] sched/core: Make cpu cgroup controller bypassable
Date:   Tue, 20 Nov 2018 12:51:28 -0500
Message-Id: <1542736289-31338-5-git-send-email-longman@redhat.com>
In-Reply-To: <1542736289-31338-1-git-send-email-longman@redhat.com>
References: <1542736289-31338-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 20 Nov 2018 17:52:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the cpu cgroup controller bypassable in the default hierarchy so
that cpu controller could be activated only in those cgroups that really
need it instead of all the cgroups down to the lowest level that need it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f12225f..ba4550c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7000,6 +7000,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.dfl_cftypes	= cpu_files,
 	.early_init	= true,
 	.threaded	= true,
+	.bypassable	= true,
 };
 
 #endif	/* CONFIG_CGROUP_SCHED */
-- 
1.8.3.1

