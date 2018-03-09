Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeCIItY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:49:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbeCIItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:49:21 -0500
Date: Fri, 9 Mar 2018 00:49:14 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-15d599a25c7649807a2b66f7100efcf030665068@git.kernel.org>
Cc: tglx@linutronix.de, jolsa@redhat.com, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org, acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        jolsa@redhat.com
In-Reply-To: <1520431349-30689-6-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-6-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt/bts: In auxtrace_record__init_intel()
 evlist is never NULL
Git-Commit-ID: 15d599a25c7649807a2b66f7100efcf030665068
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  15d599a25c7649807a2b66f7100efcf030665068
Gitweb:     https://git.kernel.org/tip/15d599a25c7649807a2b66f7100efcf030665068
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 7 Mar 2018 16:02:25 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:56 -0300

perf intel-pt/bts: In auxtrace_record__init_intel() evlist is never NULL

Tidy auxtrace_record__init_intel() slightly by recognizing that evlist is
never NULL.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520431349-30689-6-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/auxtrace.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 6aa3f2a38321..b135af62011c 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -37,15 +37,11 @@ struct auxtrace_record *auxtrace_record__init_intel(struct perf_evlist *evlist,
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
 
-	if (evlist) {
-		evlist__for_each_entry(evlist, evsel) {
-			if (intel_pt_pmu &&
-			    evsel->attr.type == intel_pt_pmu->type)
-				found_pt = true;
-			if (intel_bts_pmu &&
-			    evsel->attr.type == intel_bts_pmu->type)
-				found_bts = true;
-		}
+	evlist__for_each_entry(evlist, evsel) {
+		if (intel_pt_pmu && evsel->attr.type == intel_pt_pmu->type)
+			found_pt = true;
+		if (intel_bts_pmu && evsel->attr.type == intel_bts_pmu->type)
+			found_bts = true;
 	}
 
 	if (found_pt && found_bts) {
