Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbeCIIeL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:34:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCIIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:34:10 -0500
Date: Fri, 9 Mar 2018 00:33:53 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4jo2puz0empkoou6bbq460tl@git.kernel.org>
Cc: hpa@zytor.com, eranian@google.com, tglx@linutronix.de,
        wangnan0@huawei.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jolsa@kernel.org, dsahern@gmail.com,
        adrian.hunter@intel.com, namhyung@kernel.org
Reply-To: tglx@linutronix.de, eranian@google.com, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        wangnan0@huawei.com, dsahern@gmail.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cgroup: Remove misplaced __maybe_unused
Git-Commit-ID: a6adc9bdf59c77ea4efb844c27f25361f0399586
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

Commit-ID:  a6adc9bdf59c77ea4efb844c27f25361f0399586
Gitweb:     https://git.kernel.org/tip/a6adc9bdf59c77ea4efb844c27f25361f0399586
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 09:31:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:25 -0300

perf cgroup: Remove misplaced __maybe_unused

The 'opt' parameter in parse_cgroups() _is_ used. The original patch
used '__used' that was even more confusing :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 023695d96ee0 ("perf tool: Add cgroup support")
Link: https://lkml.kernel.org/n/tip-4jo2puz0empkoou6bbq460tl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 5dd9b5ea314d..2e2aa6c86107 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -153,7 +153,7 @@ void close_cgroup(struct cgroup_sel *cgrp)
 	}
 }
 
-int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
+int parse_cgroups(const struct option *opt, const char *str,
 		  int unset __maybe_unused)
 {
 	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
