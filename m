Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C20C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9AA20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9AA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeIFRix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:38:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46143 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeIFRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:38:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D35p5301408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:03:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D34mC301405;
        Thu, 6 Sep 2018 06:03:04 -0700
Date:   Thu, 6 Sep 2018 06:03:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-969558371bf926258241727ebb994f516f2e6f61@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        dsahern@gmail.com, hpa@zytor.com, namhyung@kernel.org,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, chabbi.milind@gmail.com
Reply-To: alexander.shishkin@linux.intel.com, chabbi.milind@gmail.com,
          namhyung@kernel.org, frederic@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          dsahern@gmail.com, peterz@infradead.org, oleg@redhat.com,
          jolsa@kernel.org, tglx@linutronix.de, acme@redhat.com
In-Reply-To: <20180827091228.2878-5-jolsa@kernel.org>
References: <20180827091228.2878-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/hw_breakpoint: Enable breakpoint in
 modify_user_hw_breakpoint
Git-Commit-ID: 969558371bf926258241727ebb994f516f2e6f61
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  969558371bf926258241727ebb994f516f2e6f61
Gitweb:     https://git.kernel.org/tip/969558371bf926258241727ebb994f516f2e6f61
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 27 Aug 2018 11:12:27 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 14:49:23 -0300

perf/hw_breakpoint: Enable breakpoint in modify_user_hw_breakpoint

Currently we enable the breakpoint back only if the breakpoint
modification was successful. If it fails we can leave the breakpoint in
disabled state with attr->disabled == 0.

We can safely enable the breakpoint back for both the fail and success
paths by checking the bp->attr.disabled, which either holds the new
'requested' disabled state or the original breakpoint state.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/hw_breakpoint.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 3e560d7609fd..d6b56180827c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -523,13 +523,11 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 		perf_event_disable(bp);
 
 	err = modify_user_hw_breakpoint_check(bp, attr, false);
-	if (err)
-		return err;
 
-	if (!attr->disabled)
+	if (!bp->attr.disabled)
 		perf_event_enable(bp);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
 
