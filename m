Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5624C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A381D20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A381D20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404909AbeKVRno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:43:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48013 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKVRnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:43:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM75TH33690994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:05:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM75Ts73690991;
        Wed, 21 Nov 2018 23:05:29 -0800
Date:   Wed, 21 Nov 2018 23:05:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mdkck6hf3fnd21rz2766280q@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de, wangnan0@huawei.com, jolsa@kernel.org,
        dsahern@gmail.com, hpa@zytor.com
Reply-To: mingo@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, dsahern@gmail.com, hpa@zytor.com,
          jolsa@kernel.org, wangnan0@huawei.com, acme@redhat.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add "_from_option" suffix to
 trace__set_filter()
Git-Commit-ID: 6a0b3abad9decb3c20e19baa3c442e1e5518546e
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

Commit-ID:  6a0b3abad9decb3c20e19baa3c442e1e5518546e
Gitweb:     https://git.kernel.org/tip/6a0b3abad9decb3c20e19baa3c442e1e5518546e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 7 Nov 2018 09:38:49 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf trace: Add "_from_option" suffix to trace__set_filter()

As we'll need that name for a new function to set filters for both
tracepoints and BPF maps for filtering pids.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mdkck6hf3fnd21rz2766280q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d86ba17fcf44..8f966c7a7d0d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3104,8 +3104,8 @@ static int trace__set_duration(const struct option *opt, const char *str,
 	return 0;
 }
 
-static int trace__set_filter_pids(const struct option *opt, const char *str,
-				  int unset __maybe_unused)
+static int trace__set_filter_pids_from_option(const struct option *opt, const char *str,
+					      int unset __maybe_unused)
 {
 	int ret = -1;
 	size_t i;
@@ -3363,7 +3363,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_STRING('t', "tid", &trace.opts.target.tid, "tid",
 		    "trace events on existing thread id"),
 	OPT_CALLBACK(0, "filter-pids", &trace, "CSV list of pids",
-		     "pids to filter (by the kernel)", trace__set_filter_pids),
+		     "pids to filter (by the kernel)", trace__set_filter_pids_from_option),
 	OPT_BOOLEAN('a', "all-cpus", &trace.opts.target.system_wide,
 		    "system-wide collection from all CPUs"),
 	OPT_STRING('C', "cpu", &trace.opts.target.cpu_list, "cpu",
