Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A811FC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D45520831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D45520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392500AbeKVRwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:52:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41505 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733310AbeKVRwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:52:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM7DbNM3692333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:13:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM7DaKu3692330;
        Wed, 21 Nov 2018 23:13:36 -0800
Date:   Wed, 21 Nov 2018 23:13:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-eb08d006054e7e374592068919e32579988602d4@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        hpa@zytor.com, tmricht@linux.vnet.ibm.com, anton@samba.org,
        namhyung@kernel.org, mingo@kernel.org
Reply-To: anton@samba.org, tmricht@linux.vnet.ibm.com, hpa@zytor.com,
          mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          yao.jin@linux.intel.com, ravi.bangoria@linux.ibm.com
In-Reply-To: <20181115095533.16930-1-ravi.bangoria@linux.ibm.com>
References: <20181115095533.16930-1-ravi.bangoria@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Use perf_evsel__is_clocki() for clock
 events
Git-Commit-ID: eb08d006054e7e374592068919e32579988602d4
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

Commit-ID:  eb08d006054e7e374592068919e32579988602d4
Gitweb:     https://git.kernel.org/tip/eb08d006054e7e374592068919e32579988602d4
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Thu, 15 Nov 2018 15:25:32 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 22:39:57 -0300

perf stat: Use perf_evsel__is_clocki() for clock events

We already have function to check if a given event is either
SW_CPU_CLOCK or SW_TASK_CLOCK. Utilize it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: yuzhoujian@didichuxing.com
Link: http://lkml.kernel.org/r/20181115095533.16930-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 8ad32763cfff..f0a8cec55c47 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -212,8 +212,7 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 
 	count *= counter->scale;
 
-	if (perf_evsel__match(counter, SOFTWARE, SW_TASK_CLOCK) ||
-	    perf_evsel__match(counter, SOFTWARE, SW_CPU_CLOCK))
+	if (perf_evsel__is_clock(counter))
 		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
