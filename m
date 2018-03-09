Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeCIIxo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:53:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33619 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbeCIIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:53:41 -0500
Date: Fri, 9 Mar 2018 00:53:22 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-915b4e27f1d32b3c7de4874ac1e3fe1f801151ca@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, dsahern@gmail.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, namhyung@kernel.org, mingo@kernel.org,
        hpa@zytor.com, jolsa@kernel.org
Reply-To: tglx@linutronix.de, namhyung@kernel.org, mingo@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        jolsa@kernel.org, hpa@zytor.com
In-Reply-To: <20180307155020.32613-5-jolsa@kernel.org>
References: <20180307155020.32613-5-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Remove progname from struct record
Git-Commit-ID: 915b4e27f1d32b3c7de4874ac1e3fe1f801151ca
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  915b4e27f1d32b3c7de4874ac1e3fe1f801151ca
Gitweb:     https://git.kernel.org/tip/915b4e27f1d32b3c7de4874ac1e3fe1f801151ca
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:05 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:43 -0300

perf record: Remove progname from struct record

It's no longer used.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 31d4d70e2f6a..b81494587120 100644
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
