Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B88C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FC02658D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FC02658D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeFZGyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:54:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeFZGyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:54:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6rlTt1591209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:53:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6rlrI1591206;
        Mon, 25 Jun 2018 23:53:47 -0700
Date:   Mon, 25 Jun 2018 23:53:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-16ddcfbf7f3d07aa781e26b39f2c28636a4ed2fd@git.kernel.org>
Cc:     mingo@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, dsahern@gmail.com, kim.phillips@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        jolsa@kernel.org
Reply-To: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
          jolsa@kernel.org, heiko.carstens@de.ibm.com,
          brueckner@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          tmricht@linux.ibm.com, schwidefsky@de.ibm.com,
          peterz@infradead.org, kim.phillips@arm.com, dsahern@gmail.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          namhyung@kernel.org
In-Reply-To: <20180611093422.1005-2-jolsa@kernel.org>
References: <20180611093422.1005-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests: Add valid callback for parse-events
 test
Git-Commit-ID: 16ddcfbf7f3d07aa781e26b39f2c28636a4ed2fd
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

Commit-ID:  16ddcfbf7f3d07aa781e26b39f2c28636a4ed2fd
Gitweb:     https://git.kernel.org/tip/16ddcfbf7f3d07aa781e26b39f2c28636a4ed2fd
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 11 Jun 2018 11:34:22 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:36 -0300

perf tests: Add valid callback for parse-events test

Adding optional 'valid' callback for events tests in parse-events
object, so we don't try to parse PMUs, which are not supported.

Following line is displayed for skipped test:

  running test 52 'intel_pt//u'... SKIP

Committer note:

Use named initializers in the struct evlist_test variable to avoid
breaking the build on centos:5, 6 and others with a similar gcc:

  cc1: warnings being treated as errors
  tests/parse-events.c: In function 'test_pmu_events':
  tests/parse-events.c:1817: error: missing initializer
  tests/parse-events.c:1817: error: (near initialization for 'e.type')

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20180611093422.1005-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 9751e7563a45..61211918bfba 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1309,6 +1309,11 @@ static int test__checkevent_config_cache(struct perf_evlist *evlist)
 	return 0;
 }
 
+static bool test__intel_pt_valid(void)
+{
+	return !!perf_pmu__find("intel_pt");
+}
+
 static int test__intel_pt(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__first(evlist);
@@ -1375,6 +1380,7 @@ struct evlist_test {
 	const char *name;
 	__u32 type;
 	const int id;
+	bool (*valid)(void);
 	int (*check)(struct perf_evlist *evlist);
 };
 
@@ -1648,6 +1654,7 @@ static struct evlist_test test__events[] = {
 	},
 	{
 		.name  = "intel_pt//u",
+		.valid = test__intel_pt_valid,
 		.check = test__intel_pt,
 		.id    = 52,
 	},
@@ -1690,6 +1697,11 @@ static int test_event(struct evlist_test *e)
 	struct perf_evlist *evlist;
 	int ret;
 
+	if (e->valid && !e->valid()) {
+		pr_debug("... SKIP");
+		return 0;
+	}
+
 	evlist = perf_evlist__new();
 	if (evlist == NULL)
 		return -ENOMEM;
@@ -1716,10 +1728,11 @@ static int test_events(struct evlist_test *events, unsigned cnt)
 	for (i = 0; i < cnt; i++) {
 		struct evlist_test *e = &events[i];
 
-		pr_debug("running test %d '%s'\n", e->id, e->name);
+		pr_debug("running test %d '%s'", e->id, e->name);
 		ret1 = test_event(e);
 		if (ret1)
 			ret2 = ret1;
+		pr_debug("\n");
 	}
 
 	return ret2;
@@ -1801,7 +1814,7 @@ static int test_pmu_events(void)
 	}
 
 	while (!ret && (ent = readdir(dir))) {
-		struct evlist_test e;
+		struct evlist_test e = { .id = 0, };
 		char name[2 * NAME_MAX + 1 + 12 + 3];
 
 		/* Names containing . are special and cannot be used directly */
