Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C459C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A7D21919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBIMh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:37:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:37:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CbJ2b2628882
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:37:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CbJGW2628878;
        Sat, 9 Feb 2019 04:37:19 -0800
Date:   Sat, 9 Feb 2019 04:37:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-7bbh3kk0h5mywvfqm64nhv28@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, jolsa@kernel.org
Reply-To: namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests pmu: Add missing headers
Git-Commit-ID: e9dacd63a1857b8d72c6f2b231868e0246eee391
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

Commit-ID:  e9dacd63a1857b8d72c6f2b231868e0246eee391
Gitweb:     https://git.kernel.org/tip/e9dacd63a1857b8d72c6f2b231868e0246eee391
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 29 Jan 2019 12:23:44 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf tests pmu: Add missing headers

It needs the definitions for PATH_MAX and snprintf, was getting it
by luck from headers it included and that are now being sanitized.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7bbh3kk0h5mywvfqm64nhv28@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 7bedf8608fdd..14a78898d79e 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -4,7 +4,9 @@
 #include "util.h"
 #include "tests.h"
 #include <errno.h>
+#include <stdio.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 
 /* Simulated format definitions. */
 static struct test_format {
