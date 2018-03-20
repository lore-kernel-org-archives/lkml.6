Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCTGVT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:21:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33383 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCTGVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:21:16 -0400
Date: Mon, 19 Mar 2018 23:18:54 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bc229c21f2c79ef0f7b30d3a2fce8c2886ffa6c7@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, dsahern@gmail.com, mingo@kernel.org,
        peterz@infradead.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        acme@redhat.com, jmario@redhat.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, dsahern@gmail.com,
        peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org, acme@redhat.com,
        namhyung@kernel.org, jmario@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180309101442.9224-7-jolsa@kernel.org>
References: <20180309101442.9224-7-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf c2c report: Call calc_width() only for
 displayed entries
Git-Commit-ID: bc229c21f2c79ef0f7b30d3a2fce8c2886ffa6c7
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

Commit-ID:  bc229c21f2c79ef0f7b30d3a2fce8c2886ffa6c7
Gitweb:     https://git.kernel.org/tip/bc229c21f2c79ef0f7b30d3a2fce8c2886ffa6c7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 9 Mar 2018 11:14:39 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:53:13 -0300

perf c2c report: Call calc_width() only for displayed entries

There's no need to calculate column widths for entries that are not
going to be displayed.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 43ce55550c9d..821112e8ba97 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1873,12 +1873,11 @@ static int resort_cl_cb(struct hist_entry *he)
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_hists = c2c_he->hists;
 
-	calc_width(c2c_he);
-
 	if (display && c2c_hists) {
 		static unsigned int idx;
 
 		c2c_he->cacheline_idx = idx++;
+		calc_width(c2c_he);
 
 		c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort);
 
