Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeBFS2m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:28:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753235AbeBFS1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:27:49 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 02/17] perf record: Put new line after target override warning
Date: Tue,  6 Feb 2018 19:17:58 +0100
Message-Id: <20180206181813.10943-3-jolsa@kernel.org>
In-Reply-To: <20180206181813.10943-1-jolsa@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Link: http://lkml.kernel.org/n/tip-62dn6rrcb2nf2a26kxj9xphr@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bf4ca749d1ac..907267206973 100644
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
-- 
2.13.6
