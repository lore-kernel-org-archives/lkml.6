Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeFER6Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752825AbeFERwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:22 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/46] perf tests kmod-path: Add tests for vdso32 and vdsox32
Date: Tue,  5 Jun 2018 14:50:18 -0300
Message-Id: <20180605175030.32549-35-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add tests for vdso32 and vdsox32. This will cause the overall test to
fail because __kmod_path__parse() does not handle vdso32 or vdsox32.

Fixes: 1f121b03d058 ("perf tools: Deal with kernel module names in '[]' correctly")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1528117014-30032-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/kmod-path.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index 8e57d46109de..148dd31cc201 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -127,6 +127,22 @@ int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_un
 	M("[vdso]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vdso]", PERF_RECORD_MISC_USER, false);
 
+	T("[vdso32]", true      , true     , false, false, "[vdso32]", NULL);
+	T("[vdso32]", false     , true     , false, false, NULL    , NULL);
+	T("[vdso32]", true      , false    , false, false, "[vdso32]", NULL);
+	T("[vdso32]", false     , false    , false, false, NULL    , NULL);
+	M("[vdso32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
+	M("[vdso32]", PERF_RECORD_MISC_KERNEL, false);
+	M("[vdso32]", PERF_RECORD_MISC_USER, false);
+
+	T("[vdsox32]", true      , true     , false, false, "[vdsox32]", NULL);
+	T("[vdsox32]", false     , true     , false, false, NULL    , NULL);
+	T("[vdsox32]", true      , false    , false, false, "[vdsox32]", NULL);
+	T("[vdsox32]", false     , false    , false, false, NULL    , NULL);
+	M("[vdsox32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
+	M("[vdsox32]", PERF_RECORD_MISC_KERNEL, false);
+	M("[vdsox32]", PERF_RECORD_MISC_USER, false);
+
 	/* path         alloc_name  alloc_ext  kmod   comp   name          ext */
 	T("[vsyscall]", true      , true     , false, false, "[vsyscall]", NULL);
 	T("[vsyscall]", false     , true     , false, false, NULL        , NULL);
-- 
2.14.3
