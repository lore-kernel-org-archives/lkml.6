Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D2E6C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D381208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D381208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbeFNGXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:23:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeFNGXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:23:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6LEF9763718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:21:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6LDBI763715;
        Wed, 13 Jun 2018 23:21:13 -0700
Date:   Wed, 13 Jun 2018 23:21:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-f7fa827f5f432a0b1f34e10fc49da93aeef9f817@git.kernel.org>
Cc:     eranian@google.com, namhyung@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, dsahern@gmail.com, jolsa@kernel.org,
        milian.wolff@kdab.com, frederic@kernel.org, mingo@kernel.org,
        andi@firstfloor.org, acme@redhat.com, hpa@zytor.com
Reply-To: peterz@infradead.org, namhyung@kernel.org, eranian@google.com,
          jolsa@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, dsahern@gmail.com,
          alexander.shishkin@linux.intel.com, frederic@kernel.org,
          milian.wolff@kdab.com, hpa@zytor.com, andi@firstfloor.org,
          acme@redhat.com, mingo@kernel.org
In-Reply-To: <20180606221513.11302-3-jolsa@kernel.org>
References: <20180606221513.11302-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix error index for pmu event parser
Git-Commit-ID: f7fa827f5f432a0b1f34e10fc49da93aeef9f817
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

Commit-ID:  f7fa827f5f432a0b1f34e10fc49da93aeef9f817
Gitweb:     https://git.kernel.org/tip/f7fa827f5f432a0b1f34e10fc49da93aeef9f817
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 7 Jun 2018 00:15:05 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 15:50:14 -0300

perf tools: Fix error index for pmu event parser

For events we provide specific error message we need to set error column
index, PMU parser is missing that, adding it.

Before:

  $ perf stat -e cycles,krava/cycles/ kill
  event syntax error: 'cycles,krava/cycles/'
                       \___ Cannot find PMU `krava'. Missing kernel support?

After:

  $ perf stat -e cycles,krava/cycles/ kill
  event syntax error: 'cycles,krava/cycles/'
                              \___ Cannot find PMU `krava'. Missing kernel support?

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 155d2570274f..da8fe57691b8 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -227,11 +227,16 @@ event_def: event_pmu |
 event_pmu:
 PE_NAME opt_pmu_config
 {
+	struct parse_events_state *parse_state = _parse_state;
+	struct parse_events_error *error = parse_state->error;
 	struct list_head *list, *orig_terms, *terms;
 
 	if (parse_events_copy_term_list($2, &orig_terms))
 		YYABORT;
 
+	if (error)
+		error->idx = @1.first_column;
+
 	ALLOC_LIST(list);
 	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
 		struct perf_pmu *pmu = NULL;
