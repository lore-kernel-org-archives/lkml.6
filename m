Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1EAC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29802084D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBIMn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:43:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:43:56 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19ChQaM2629863
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:43:26 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19ChP752629859;
        Sat, 9 Feb 2019 04:43:25 -0800
Date:   Sat, 9 Feb 2019 04:43:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-fa4e819bbca9939c54e87ba994a6a9bffd0247df@git.kernel.org>
Cc:     jolsa@redhat.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        will.deacon@arm.com, schwidefsky@de.ibm.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        mark.rutland@arm.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, hpa@zytor.com, suzuki.poulose@arm.com,
        acme@redhat.com, heiko.carstens@de.ibm.com
Reply-To: gregkh@linuxfoundation.org, jolsa@redhat.com, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          schwidefsky@de.ibm.com, will.deacon@arm.com, mingo@kernel.org,
          ast@kernel.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, heiko.carstens@de.ibm.com, acme@redhat.com,
          suzuki.poulose@arm.com, hpa@zytor.com,
          mathieu.poirier@linaro.org, adrian.hunter@intel.com,
          mark.rutland@arm.com
In-Reply-To: <20190131184714.20388-6-mathieu.poirier@linaro.org>
References: <20190131184714.20388-6-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf arm cs-etm: Use event attributes to send sink
 information to kernel
Git-Commit-ID: fa4e819bbca9939c54e87ba994a6a9bffd0247df
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

Commit-ID:  fa4e819bbca9939c54e87ba994a6a9bffd0247df
Gitweb:     https://git.kernel.org/tip/fa4e819bbca9939c54e87ba994a6a9bffd0247df
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Thu, 31 Jan 2019 11:47:12 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

perf arm cs-etm: Use event attributes to send sink information to kernel

The communication of sink information for a trace session doesn't work
when more than on CPU is involved in the scenario due to the static
nature of sysfs.  As such communicate the sink information to each event
by using the perf_event::attr:config2 attribute.  The information sent
to the kernel is an hash of the sink's name, which is unique in a
system.

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
Link: http://lkml.kernel.org/r/20190131184714.20388-6-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..4f31cf0d1e6d 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -5,6 +5,7 @@
  */
 
 #include <api/fs/fs.h>
+#include <linux/bits.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/coresight-pmu.h>
@@ -22,6 +23,7 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
@@ -60,10 +62,48 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
+				struct perf_evsel *evsel)
+{
+	char msg[BUFSIZ], path[PATH_MAX], *sink;
+	struct perf_evsel_config_term *term;
+	int ret = -EINVAL;
+	u32 hash;
+
+	if (evsel->attr.config2 & GENMASK(31, 0))
+		return 0;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
+			continue;
+
+		sink = term->val.drv_cfg;
+		snprintf(path, PATH_MAX, "sinks/%s", sink);
+
+		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
+		if (ret != 1) {
+			pr_err("failed to set sink \"%s\" on event %s with %d (%s)\n",
+			       sink, perf_evsel__name(evsel), errno,
+			       str_error_r(errno, msg, sizeof(msg)));
+			return ret;
+		}
+
+		evsel->attr.config2 |= hash;
+		return 0;
+	}
+
+	/*
+	 * No sink was provided on the command line - for _now_ treat
+	 * this as an error.
+	 */
+	return ret;
+}
+
 static int cs_etm_recording_options(struct auxtrace_record *itr,
 				    struct perf_evlist *evlist,
 				    struct record_opts *opts)
 {
+	int ret;
 	struct cs_etm_recording *ptr =
 				container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
@@ -92,6 +132,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!cs_etm_evsel)
 		return 0;
 
+	ret = cs_etm_set_sink_attr(cs_etm_pmu, cs_etm_evsel);
+	if (ret)
+		return ret;
+
 	if (opts->use_clockid) {
 		pr_err("Cannot use clockid (-k option) with %s\n",
 		       CORESIGHT_ETM_PMU_NAME);
