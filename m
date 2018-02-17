Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBQLkP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:40:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33759 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeBQLkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:40:14 -0500
Date: Sat, 17 Feb 2018 03:29:55 -0800
From: tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-d2785de15f1bd42d613d56bbac5a007e7293b874@git.kernel.org>
Cc: yao.jin@linux.intel.com, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        hpa@zytor.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org
Reply-To: peterz@infradead.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, hpa@zytor.com, mathieu.poirier@linaro.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, yao.jin@linux.intel.com
In-Reply-To: <1518467557-18505-4-git-send-email-mathieu.poirier@linaro.org>
References: <1518467557-18505-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf auxtrace arm: Fixing uninitialised variable
Git-Commit-ID: d2785de15f1bd42d613d56bbac5a007e7293b874
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

Commit-ID:  d2785de15f1bd42d613d56bbac5a007e7293b874
Gitweb:     https://git.kernel.org/tip/d2785de15f1bd42d613d56bbac5a007e7293b874
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Mon, 12 Feb 2018 13:32:37 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:40 -0300

perf auxtrace arm: Fixing uninitialised variable

When working natively on arm64 the compiler gets pesky and complains
that variable 'i' is uninitialised, something that breaks the
compilation.  Here no further checks are needed since variable
'found_spe' can only be true if variable 'i' has been initialised as
part of the for loop.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1518467557-18505-4-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 2323581..fa639e3 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -68,7 +68,7 @@ struct auxtrace_record
 	bool found_spe = false;
 	static struct perf_pmu **arm_spe_pmus = NULL;
 	static int nr_spes = 0;
-	int i;
+	int i = 0;
 
 	if (!evlist)
 		return NULL;
