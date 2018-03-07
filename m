Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934002AbeCGPuh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:50:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933386AbeCGPuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:32 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 04/19] perf record: Remove progname from struct record
Date: Wed,  7 Mar 2018 16:50:05 +0100
Message-Id: <20180307155020.32613-5-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's no longer used.

Link: http://lkml.kernel.org/n/tip-hczns6cc36ktu7zgtw7cdu8h@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b2ebd9b3feba..68caf54aa191 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -71,7 +71,6 @@ struct record {
 	struct auxtrace_record	*itr;
 	struct perf_evlist	*evlist;
 	struct perf_session	*session;
-	const char		*progname;
 	int			realtime_prio;
 	bool			no_buildid;
 	bool			no_buildid_set;
@@ -861,8 +860,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	int fd;
 
-	rec->progname = argv[0];
-
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
 	signal(SIGINT, sig_handler);
-- 
2.13.6
