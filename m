Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeCTGaE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:30:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59391 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeCTGaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:30:03 -0400
Date: Mon, 19 Mar 2018 23:29:54 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-26e4711fc8352252f474a02429d7495652c4aef7@git.kernel.org>
Cc: tmricht@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        schwidefsky@de.ibm.com, hpa@zytor.com, tglx@linutronix.de,
        heiko.carstens@de.ibm.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, heiko.carstens@de.ibm.com,
        acme@redhat.com, schwidefsky@de.ibm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        tmricht@linux.vnet.ibm.com
In-Reply-To: <20180312103807.45069-2-tmricht@linux.vnet.ibm.com>
References: <20180312103807.45069-2-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Make function perf_stat_evsel_id_init
 static
Git-Commit-ID: 26e4711fc8352252f474a02429d7495652c4aef7
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

Commit-ID:  26e4711fc8352252f474a02429d7495652c4aef7
Gitweb:     https://git.kernel.org/tip/26e4711fc8352252f474a02429d7495652c4aef7
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Mon, 12 Mar 2018 11:38:07 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:56:17 -0300

perf stat: Make function perf_stat_evsel_id_init static

Function perf_stat_evsel_id_init() has global linkage but is only used
in util/stat.c. Make it static.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180312103807.45069-2-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat.c | 2 +-
 tools/perf/util/stat.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 32235657c1ac..a0061e0b0fad 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -92,7 +92,7 @@ static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 };
 #undef ID
 
-void perf_stat_evsel_id_init(struct perf_evsel *evsel)
+static void perf_stat_evsel_id_init(struct perf_evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
 	int i;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 2f44e386a0e8..8f56ba4fd258 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -128,8 +128,6 @@ bool __perf_evsel_stat__is(struct perf_evsel *evsel,
 #define perf_stat_evsel__is(evsel, id) \
 	__perf_evsel_stat__is(evsel, PERF_STAT_EVSEL_ID__ ## id)
 
-void perf_stat_evsel_id_init(struct perf_evsel *evsel);
-
 extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
 
