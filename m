Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46F20861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A46F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeIFR6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:58:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56649 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:58:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DMlPD305959
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:22:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DMlKr305956;
        Thu, 6 Sep 2018 06:22:47 -0700
Date:   Thu, 6 Sep 2018 06:22:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-35386233fcf78f20cb8a51199518da9f81eca280@git.kernel.org>
Cc:     peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de,
        andi@firstfloor.org, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, alexander.shishkin@linux.intel.com
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org,
          andi@firstfloor.org, tglx@linutronix.de, peterz@infradead.org,
          namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          dsahern@gmail.com
In-Reply-To: <20180830063252.23729-5-jolsa@kernel.org>
References: <20180830063252.23729-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Use local config arg for scale in
 create_perf_stat_counter()
Git-Commit-ID: 35386233fcf78f20cb8a51199518da9f81eca280
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

Commit-ID:  35386233fcf78f20cb8a51199518da9f81eca280
Gitweb:     https://git.kernel.org/tip/35386233fcf78f20cb8a51199518da9f81eca280
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:13 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:21 -0300

perf stat: Use local config arg for scale in create_perf_stat_counter()

Use the local 'scale' member in the 'struct perf_stat_config' argument
instead of the global 'stat_config' variable, to make the function
independent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 84dbac526925..47789558899a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -240,7 +240,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel,
 	struct perf_event_attr *attr = &evsel->attr;
 	struct perf_evsel *leader = evsel->leader;
 
-	if (stat_config.scale) {
+	if (config->scale) {
 		attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
 				    PERF_FORMAT_TOTAL_TIME_RUNNING;
 	}
