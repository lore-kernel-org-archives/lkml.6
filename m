Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7356C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0AB218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBIMcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:32:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57285 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfBIMcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:32:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CWh0L2628043
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:32:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CWhKi2628040;
        Sat, 9 Feb 2019 04:32:43 -0800
Date:   Sat, 9 Feb 2019 04:32:43 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wpa4b6x0btpnh2kjxzl9no4w@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, namhyung@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, adrian.hunter@intel.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          acme@redhat.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Add missing headers so far obtained
 indirectly
Git-Commit-ID: 2f2ae234e5afea17fa81b83c5b8d0e758a0d0703
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

Commit-ID:  2f2ae234e5afea17fa81b83c5b8d0e758a0d0703
Gitweb:     https://git.kernel.org/tip/2f2ae234e5afea17fa81b83c5b8d0e758a0d0703
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sun, 27 Jan 2019 14:08:22 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf tests: Add missing headers so far obtained indirectly

We're going to remove symbol.h from some places and this breaks
some of the perf tests, fix it by adding the required includes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wpa4b6x0btpnh2kjxzl9no4w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sample-parsing.c | 2 ++
 tools/perf/tests/sdt.c            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 0e2d00d69e6e..236ce0d6c826 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdbool.h>
 #include <inttypes.h>
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 
+#include "branch.h"
 #include "util.h"
 #include "event.h"
 #include "evsel.h"
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 5059452d27dd..8bfaa630389c 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <sys/epoll.h>
 #include <util/evlist.h>
+#include <util/symbol.h>
 #include <linux/filter.h>
 #include "tests.h"
 #include "debug.h"
