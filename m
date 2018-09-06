Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46D4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E1E2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E1E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeIFSBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:01:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34831 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:01:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DQ0AU307881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:26:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DQ0Z3307878;
        Thu, 6 Sep 2018 06:26:00 -0700
Date:   Thu, 6 Sep 2018 06:26:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-73d586c3917d5109bb547c16d90d0eb97203986a@git.kernel.org>
Cc:     acme@redhat.com, andi@firstfloor.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de
Reply-To: namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, dsahern@gmail.com,
          linux-kernel@vger.kernel.org, andi@firstfloor.org,
          acme@redhat.com
In-Reply-To: <20180830063252.23729-11-jolsa@kernel.org>
References: <20180830063252.23729-11-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add 'struct perf_stat_config' argument
 to perf_stat_synthesize_config()
Git-Commit-ID: 73d586c3917d5109bb547c16d90d0eb97203986a
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

Commit-ID:  73d586c3917d5109bb547c16d90d0eb97203986a
Gitweb:     https://git.kernel.org/tip/73d586c3917d5109bb547c16d90d0eb97203986a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:19 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Add 'struct perf_stat_config' argument to perf_stat_synthesize_config()

Add a 'struct perf_stat_config' argument to perf_stat_synthesize_config(),
so we could synthesize arbitrary config.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0a358c2e1a93..d0d19a5ffa85 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -402,7 +402,8 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static int perf_stat_synthesize_config(bool attrs)
+static int perf_stat_synthesize_config(struct perf_stat_config *config,
+				       bool attrs)
 {
 	int err;
 
@@ -435,7 +436,7 @@ static int perf_stat_synthesize_config(bool attrs)
 		return err;
 	}
 
-	err = perf_event__synthesize_stat_config(NULL, &stat_config,
+	err = perf_event__synthesize_stat_config(NULL, config,
 						 process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize config.\n");
@@ -606,7 +607,7 @@ try_again:
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(is_pipe);
+		err = perf_stat_synthesize_config(&stat_config, is_pipe);
 		if (err < 0)
 			return err;
 	}
