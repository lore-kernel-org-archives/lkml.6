Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B38CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1106421916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBIMiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:38:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:38:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19Cc0VD2628929
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:38:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CbxPD2628926;
        Sat, 9 Feb 2019 04:37:59 -0800
Date:   Sat, 9 Feb 2019 04:37:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-rc389o1z0htwukqv6ni1viun@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, namhyung@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, acme@redhat.com, mingo@kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org, acme@redhat.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf pmu: Remove needless evsel.h include, only
 needs one fwd decl
Git-Commit-ID: eb563d6604b0f21396e21ac73619c9a5e8ec5aee
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

Commit-ID:  eb563d6604b0f21396e21ac73619c9a5e8ec5aee
Gitweb:     https://git.kernel.org/tip/eb563d6604b0f21396e21ac73619c9a5e8ec5aee
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 29 Jan 2019 12:24:52 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf pmu: Remove needless evsel.h include, only needs one fwd decl

To reduce the header dependency tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rc389o1z0htwukqv6ni1viun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..ffed23fb920a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -6,9 +6,10 @@
 #include <linux/compiler.h>
 #include <linux/perf_event.h>
 #include <stdbool.h>
-#include "evsel.h"
 #include "parse-events.h"
 
+struct perf_evsel_config_term;
+
 enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
 	PERF_PMU_FORMAT_VALUE_CONFIG1,
