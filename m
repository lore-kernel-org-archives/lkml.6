Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8670C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0652084D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBIMnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:43:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43241 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:43:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CgjCW2629809
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:42:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CgiOh2629806;
        Sat, 9 Feb 2019 04:42:45 -0800
Date:   Sat, 9 Feb 2019 04:42:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-ffe8881eb20b0452e47efe151e870b4fae8bd5d2@git.kernel.org>
Cc:     will.deacon@arm.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        namhyung@kernel.org, acme@redhat.com, ast@kernel.org,
        heiko.carstens@de.ibm.com, peterz@infradead.org,
        suzuki.poulose@arm.com, schwidefsky@de.ibm.com,
        gregkh@linuxfoundation.org, jolsa@redhat.com,
        mathieu.poirier@linaro.org, hpa@zytor.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de
Reply-To: schwidefsky@de.ibm.com, gregkh@linuxfoundation.org,
          peterz@infradead.org, suzuki.poulose@arm.com, jolsa@redhat.com,
          mathieu.poirier@linaro.org, tglx@linutronix.de, hpa@zytor.com,
          mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
          will.deacon@arm.com, namhyung@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          ast@kernel.org, acme@redhat.com, heiko.carstens@de.ibm.com
In-Reply-To: <20190131184714.20388-5-mathieu.poirier@linaro.org>
References: <20190131184714.20388-5-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf pmu: Move EVENT_SOURCE_DEVICE_PATH to PMU
 header file
Git-Commit-ID: ffe8881eb20b0452e47efe151e870b4fae8bd5d2
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

Commit-ID:  ffe8881eb20b0452e47efe151e870b4fae8bd5d2
Gitweb:     https://git.kernel.org/tip/ffe8881eb20b0452e47efe151e870b4fae8bd5d2
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Thu, 31 Jan 2019 11:47:11 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

perf pmu: Move EVENT_SOURCE_DEVICE_PATH to PMU header file

Move definition of EVENT_SOURCE_DEVICE_PATH to pmu.h so that it can be
used by other files than pmu.c

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Link: http://lkml.kernel.org/r/20190131184714.20388-5-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 2 --
 tools/perf/util/pmu.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 11a234740632..51d437f55d18 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -29,8 +29,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
-
 int perf_pmu_parse(struct list_head *list, char *name);
 extern FILE *perf_pmu_in;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index ffed23fb920a..1c12a61ed0dc 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -17,6 +17,7 @@ enum {
 };
 
 #define PERF_PMU_FORMAT_BITS 64
+#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 
 struct perf_event_attr;
 
