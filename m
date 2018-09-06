Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3EBC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66052064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66052064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbeIFSB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:01:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeIFSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:01:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DPUWu307826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:25:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DPUmx307823;
        Thu, 6 Sep 2018 06:25:30 -0700
Date:   Thu, 6 Sep 2018 06:25:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-491073a6126644d3c60b677b777006deb3c0e16b@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, mingo@kernel.org, acme@redhat.com,
        andi@firstfloor.org, namhyung@kernel.org, peterz@infradead.org
Reply-To: jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          andi@firstfloor.org, acme@redhat.com, peterz@infradead.org,
          namhyung@kernel.org, dsahern@gmail.com, mingo@kernel.org
In-Reply-To: <20180830063252.23729-10-jolsa@kernel.org>
References: <20180830063252.23729-10-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Rename 'is_pipe' argument to 'attrs' in
 perf_stat_synthesize_config()
Git-Commit-ID: 491073a6126644d3c60b677b777006deb3c0e16b
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

Commit-ID:  491073a6126644d3c60b677b777006deb3c0e16b
Gitweb:     https://git.kernel.org/tip/491073a6126644d3c60b677b777006deb3c0e16b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:18 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Rename 'is_pipe' argument to 'attrs' in perf_stat_synthesize_config()

The attrs name makes more sense.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 142cff8eb12b..0a358c2e1a93 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -402,11 +402,11 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static int perf_stat_synthesize_config(bool is_pipe)
+static int perf_stat_synthesize_config(bool attrs)
 {
 	int err;
 
-	if (is_pipe) {
+	if (attrs) {
 		err = perf_event__synthesize_attrs(NULL, evsel_list,
 						   process_synthesized_event);
 		if (err < 0) {
@@ -418,7 +418,7 @@ static int perf_stat_synthesize_config(bool is_pipe)
 	err = perf_event__synthesize_extra_attr(NULL,
 						evsel_list,
 						process_synthesized_event,
-						is_pipe);
+						attrs);
 
 	err = perf_event__synthesize_thread_map2(NULL, evsel_list->threads,
 						process_synthesized_event,
