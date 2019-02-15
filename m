Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69636C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4249E2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfBOJvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:51:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfBOJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:51:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9phVS1121985
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:51:44 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9phxE1121982;
        Fri, 15 Feb 2019 01:51:43 -0800
Date:   Fri, 15 Feb 2019 01:51:43 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-aa4df30db52293c146b1851b88021d0bc2dd3b89@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, mingo@kernel.org, jolsa@kernel.org,
        acme@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, hpa@zytor.com
Reply-To: jolsa@kernel.org, tglx@linutronix.de, acme@redhat.com,
          peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190213123246.4015-9-jolsa@kernel.org>
References: <20190213123246.4015-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf header: Remove unused 'cpu_nr' field  from
 'struct cpu_topo'
Git-Commit-ID: aa4df30db52293c146b1851b88021d0bc2dd3b89
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

Commit-ID:  aa4df30db52293c146b1851b88021d0bc2dd3b89
Gitweb:     https://git.kernel.org/tip/aa4df30db52293c146b1851b88021d0bc2dd3b89
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 13 Feb 2019 13:32:44 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:09 -0300

perf header: Remove unused 'cpu_nr' field  from 'struct cpu_topo'

Not used at all.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f1508adefc16..61ce197c5362 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -563,7 +563,6 @@ static int write_cmdline(struct feat_fd *ff,
 	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
 
 struct cpu_topo {
-	u32 cpu_nr;
 	u32 core_sib;
 	u32 thread_sib;
 	char **core_siblings;
@@ -679,7 +678,6 @@ static struct cpu_topo *build_cpu_topology(void)
 		goto out_free;
 
 	tp = addr;
-	tp->cpu_nr = nr;
 	addr += sizeof(*tp);
 	tp->core_siblings = addr;
 	addr += sz;
