Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeCIKPB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:15:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751237AbeCIKO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:14:59 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 6/9] perf c2c report: Call calc_width only for displayed entries
Date: Fri,  9 Mar 2018 11:14:39 +0100
Message-Id: <20180309101442.9224-7-jolsa@kernel.org>
In-Reply-To: <20180309101442.9224-1-jolsa@kernel.org>
References: <20180309101442.9224-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to calculate column width on entries
that are not going to be displayed.

Link: http://lkml.kernel.org/n/tip-l4k7dpiaj0b67t73nh8rszlf@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
 
-- 
2.13.6
