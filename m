Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeCIIxO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:53:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36127 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCIIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:53:12 -0500
Date: Fri, 9 Mar 2018 00:52:53 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-20a8a3cf90215cebd916048e51a5bfa6c3707778@git.kernel.org>
Cc: acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, dsahern@gmail.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, jolsa@kernel.org
Reply-To: dsahern@gmail.com, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org
In-Reply-To: <20180307155020.32613-4-jolsa@kernel.org>
References: <20180307155020.32613-4-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Move machine variable down the
 function
Git-Commit-ID: 20a8a3cf90215cebd916048e51a5bfa6c3707778
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

Commit-ID:  20a8a3cf90215cebd916048e51a5bfa6c3707778
Gitweb:     https://git.kernel.org/tip/20a8a3cf90215cebd916048e51a5bfa6c3707778
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:04 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:42 -0300

perf record: Move machine variable down the function

It's used far more down to be declared on the top of the __cmd_record.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 753ffcecf254..31d4d70e2f6a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -854,7 +854,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	int status = 0;
 	unsigned long waking = 0;
 	const bool forks = argc > 0;
-	struct machine *machine;
 	struct perf_tool *tool = &rec->tool;
 	struct record_opts *opts = &rec->opts;
 	struct perf_data *data = &rec->data;
@@ -959,8 +958,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
-	machine = &session->machines.host;
-
 	err = record__synthesize(rec, false);
 	if (err < 0)
 		goto out_child;
@@ -988,6 +985,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	 * Let the child rip
 	 */
 	if (forks) {
+		struct machine *machine = &session->machines.host;
 		union perf_event *event;
 		pid_t tgid;
 
