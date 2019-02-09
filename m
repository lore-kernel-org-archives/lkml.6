Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91290C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A072073F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBIMiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:38:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55949 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:38:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CcgXJ2628983
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:38:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19Ccfxc2628980;
        Sat, 9 Feb 2019 04:38:41 -0800
Date:   Sat, 9 Feb 2019 04:38:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-dngwaxuhfnhksawgdpo6e74n@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: jolsa@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kvm stat: Replace kvm-stat.h includes with
 forward declarations
Git-Commit-ID: 5691903a6f5223b162c0c56a03b04d46bf653ae4
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

Commit-ID:  5691903a6f5223b162c0c56a03b04d46bf653ae4
Gitweb:     https://git.kernel.org/tip/5691903a6f5223b162c0c56a03b04d46bf653ae4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 29 Jan 2019 12:42:55 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

perf kvm stat: Replace kvm-stat.h includes with forward declarations

To reduce the include header dependency tree and speed up perf builds.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dngwaxuhfnhksawgdpo6e74n@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 1 +
 tools/perf/arch/s390/util/kvm-stat.c    | 1 +
 tools/perf/arch/x86/util/kvm-stat.c     | 1 +
 tools/perf/util/kvm-stat.h              | 7 ++++---
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 596ad6aedaac..86e64c47d8ea 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -3,6 +3,7 @@
 #include "util/kvm-stat.h"
 #include "util/parse-events.h"
 #include "util/debug.h"
+#include "util/evsel.h"
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index aaabab5e2830..7e3961a4b292 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -11,6 +11,7 @@
 
 #include <errno.h>
 #include "../../util/kvm-stat.h"
+#include "../../util/evsel.h"
 #include <asm/sie.h>
 
 define_exit_reasons_table(sie_exit_reasons, sie_intercept_code);
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 081353d7b095..865a9762f22e 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include "../../util/kvm-stat.h"
+#include "../../util/evsel.h"
 #include <asm/svm.h>
 #include <asm/vmx.h>
 #include <asm/kvm.h>
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 7b1f06567521..1403dec189b4 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -3,12 +3,13 @@
 #define __PERF_KVM_STAT_H
 
 #include "../perf.h"
-#include "evsel.h"
-#include "evlist.h"
-#include "session.h"
 #include "tool.h"
 #include "stat.h"
 
+struct perf_evsel;
+struct perf_evlist;
+struct perf_session;
+
 struct event_key {
 	#define INVALID_KEY     (~0ULL)
 	u64 key;
