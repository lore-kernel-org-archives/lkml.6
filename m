Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D66ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CE52080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CE52080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeKAHDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:03:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeKAHDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:03:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM388V2558785
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:03:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM37p82558782;
        Wed, 31 Oct 2018 15:03:07 -0700
Date:   Wed, 31 Oct 2018 15:03:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-oqgsz2bq4kgrnnajrafcdhie@git.kernel.org>
Cc:     dsahern@gmail.com, yao.jin@linux.intel.com, wangnan0@huawei.com,
        acme@redhat.com, peterz@infradead.org, hpa@zytor.com,
        namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com, davem@davemloft.net,
        kan.liang@intel.com
Reply-To: linux-kernel@vger.kernel.org, ak@linux.intel.com,
          tglx@linutronix.de, davem@davemloft.net, adrian.hunter@intel.com,
          kan.liang@intel.com, hpa@zytor.com, dsahern@gmail.com,
          yao.jin@linux.intel.com, acme@redhat.com, peterz@infradead.org,
          wangnan0@huawei.com, namhyung@kernel.org, mingo@kernel.org,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Allow disabling the overwrite mode
Git-Commit-ID: 4e303fbe2d95806c875f5ebfcb3d980e20b4bd83
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

Commit-ID:  4e303fbe2d95806c875f5ebfcb3d980e20b4bd83
Gitweb:     https://git.kernel.org/tip/4e303fbe2d95806c875f5ebfcb3d980e20b4bd83
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Oct 2018 15:55:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 30 Oct 2018 11:46:23 -0300

perf top: Allow disabling the overwrite mode

In ebebbf082357 ("perf top: Switch default mode to overwrite mode") we
forgot to leave a way to disable that new default, add a --overwrite
option that can be disabled using --no-overwrite, since the code already
in such a way that we can readily disable this mode.

This is useful when investigating bugs with this mode like the recent
report from David Miller where lots of unknown symbols appear due to
disabling the events while processing them which disables all record
types, not just PERF_RECORD_SAMPLE, which makes it impossible to resolve
maps when we lose PERF_RECORD_MMAP records.

This can be easily seen while building a kernel, when there are lots of
short lived processes.

Reported-by: David Miller <davem@davemloft.net>
Acked-by: Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
Link: https://lkml.kernel.org/n/tip-oqgsz2bq4kgrnnajrafcdhie@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 5 +++++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 114fda12aa49..d4be6061fe1c 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -242,6 +242,11 @@ Default is to monitor all CPUS.
 --hierarchy::
 	Enable hierarchy output.
 
+--overwrite::
+	This is the default, but for investigating problems with it or any other strange
+	behaviour like lots of unknown samples, we may want to disable this mode by using
+	--no-overwrite.
+
 --force::
 	Don't do ownership validation.
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d21d8751e749..214fad747b04 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1372,6 +1372,8 @@ int cmd_top(int argc, const char **argv)
 		    "Show raw trace event output (do not use print fmt or plugins)"),
 	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
+	OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
+		    "Use a backward ring buffer, default: yes"),
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
 			"number of thread to run event synthesize"),
