Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeBQLbx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:31:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36989 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeBQLbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:31:52 -0500
Date: Sat, 17 Feb 2018 03:19:25 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c3dec27b7f70a9ad5f777d943d51ecdfcd9824d0@git.kernel.org>
Cc: tglx@linutronix.de, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        jolsa@kernel.org, namhyung@kernel.org, acme@redhat.com
Reply-To: peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org,
        acme@redhat.com, tglx@linutronix.de, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180206181813.10943-3-jolsa@kernel.org>
References: <20180206181813.10943-3-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Put new line after target override
 warning
Git-Commit-ID: c3dec27b7f70a9ad5f777d943d51ecdfcd9824d0
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

Commit-ID:  c3dec27b7f70a9ad5f777d943d51ecdfcd9824d0
Gitweb:     https://git.kernel.org/tip/c3dec27b7f70a9ad5f777d943d51ecdfcd9824d0
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 6 Feb 2018 19:17:58 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 10:09:23 -0300

perf record: Put new line after target override warning

There's no new-line after target-override warning, now:

  $ perf record -a --per-thread
  Warning:
  SYSTEM/CPU switch overriding PER-THREAD^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.705 MB perf.data (2939 samples) ]

with patch:

  $ perf record -a --per-thread
  Warning:
  SYSTEM/CPU switch overriding PER-THREAD
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.705 MB perf.data (2939 samples) ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 16ad2ffb822c ("perf tools: Introduce perf_target__strerror()")
Link: http://lkml.kernel.org/r/20180206181813.10943-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bf4ca74..9072672 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1803,7 +1803,7 @@ int cmd_record(int argc, const char **argv)
 	err = target__validate(&rec->opts.target);
 	if (err) {
 		target__strerror(&rec->opts.target, err, errbuf, BUFSIZ);
-		ui__warning("%s", errbuf);
+		ui__warning("%s\n", errbuf);
 	}
 
 	err = target__parse_uid(&rec->opts.target);
