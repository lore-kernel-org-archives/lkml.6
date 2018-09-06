Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C360DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FD62064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FD62064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeIFSKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:10:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39095 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeIFSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:10:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DYgsx309240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:34:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DYfLF309236;
        Thu, 6 Sep 2018 06:34:41 -0700
Date:   Thu, 6 Sep 2018 06:34:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-0c538a9462953dfcde2fe961aca2cf75c2747040@git.kernel.org>
Cc:     namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, jolsa@kernel.org,
        mingo@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, andi@firstfloor.org,
        peterz@infradead.org
Reply-To: namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, dsahern@gmail.com,
          jolsa@kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          andi@firstfloor.org, peterz@infradead.org
In-Reply-To: <20180830063252.23729-27-jolsa@kernel.org>
References: <20180830063252.23729-27-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Use 'evsel->evlist' instead of
 'evsel_list' in collect_all_aliases()
Git-Commit-ID: 0c538a9462953dfcde2fe961aca2cf75c2747040
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

Commit-ID:  0c538a9462953dfcde2fe961aca2cf75c2747040
Gitweb:     https://git.kernel.org/tip/0c538a9462953dfcde2fe961aca2cf75c2747040
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:35 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:23 -0300

perf stat: Use 'evsel->evlist' instead of 'evsel_list' in collect_all_aliases()

Use 'evsel->evlist' instead of 'evsel_list' in collect_all_aliases(), to
get rid of the global 'evsel_list' variable dependency.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 46181ac492c5..11741f3a8342 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1154,10 +1154,11 @@ static void collect_all_aliases(struct perf_evsel *counter,
 				       bool first),
 			    void *data)
 {
+	struct perf_evlist *evlist = counter->evlist;
 	struct perf_evsel *alias;
 
-	alias = list_prepare_entry(counter, &(evsel_list->entries), node);
-	list_for_each_entry_continue (alias, &evsel_list->entries, node) {
+	alias = list_prepare_entry(counter, &(evlist->entries), node);
+	list_for_each_entry_continue (alias, &evlist->entries, node) {
 		if (strcmp(perf_evsel__name(alias), perf_evsel__name(counter)) ||
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
