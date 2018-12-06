Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BCFC67838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8598720989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131754;
	bh=9PExCkeCqfWX4hf5RMtzarSgLbDWYs+8EzgW7AIjmtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DeeKI3yW3ixpWBIq1C+F0AohjuYvWXG0e/6PcVC7ojNZop2Sizdd7mYVadQFejMjS
	 MiKsPay2byfYvXCjZZwZqqnT2Z3W0Lv5YhLgKhTMXORupyPtdYX/NVhR7NqLNpk0sE
	 +Qe4iehOSsjaiEtFDJTDehMktEoXITzwJGRZOZmw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8598720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeLFV3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:29:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeLFV3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:10 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19A562146F;
        Thu,  6 Dec 2018 21:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131749;
        bh=9PExCkeCqfWX4hf5RMtzarSgLbDWYs+8EzgW7AIjmtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zrgqjk1Z29mTi6J/9zu/i9bfU7b6oDLJXJcmuYbHqk3+pklk3RmVkvOD2xTyK+//H
         rMoNtPWQ0AZcckeTRvfq0Ro9RKl9+1yRm2CZ5x8Rlga5e/OEv3FC/V1Y1460xePL2x
         ujfO0vOGG8ZvR+9sgGGSQoM9JXgNcz03jeyd+Ul0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/75] perf tools Documentation: Fix diverse typos
Date:   Thu,  6 Dec 2018 18:25:26 -0300
Message-Id: <20181206212602.20474-40-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

In this particular case, it affects documentation, so may be interesting
to cherry pick as it is information that is presented to the user.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt   | 2 +-
 tools/perf/Documentation/perf-report.txt | 2 +-
 tools/perf/Documentation/perf-stat.txt   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 667c14e56031..138fb6e94b3c 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -172,7 +172,7 @@ like cycles and instructions and some software events.
 Other PMUs and global measurements are normally root only.
 Some event qualifiers, such as "any", are also root only.
 
-This can be overriden by setting the kernel.perf_event_paranoid
+This can be overridden by setting the kernel.perf_event_paranoid
 sysctl to -1, which allows non root to use these events.
 
 For accessing trace point events perf needs to have read access to
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index ed2bf37ab132..1a27bfe05039 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -252,7 +252,7 @@ OPTIONS
 	          Usually more convenient to use --branch-history for this.
 
 	value can be:
-	- percent: diplay overhead percent (default)
+	- percent: display overhead percent (default)
 	- period: display event period
 	- count: display event count
 
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b10a90b6a718..4bc2085e5197 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -50,7 +50,7 @@ report::
 	  /sys/bus/event_source/devices/<pmu>/format/*
 
 	Note that the last two syntaxes support prefix and glob matching in
-	the PMU name to simplify creation of events accross multiple instances
+	the PMU name to simplify creation of events across multiple instances
 	of the same type of PMU in large systems (e.g. memory controller PMUs).
 	Multiple PMU instances are typical for uncore PMUs, so the prefix
 	'uncore_' is also ignored when performing this match.
@@ -277,7 +277,7 @@ echo 0 > /proc/sys/kernel/nmi_watchdog
 for best results. Otherwise the bottlenecks may be inconsistent
 on workload with changing phases.
 
-This enables --metric-only, unless overriden with --no-metric-only.
+This enables --metric-only, unless overridden with --no-metric-only.
 
 To interpret the results it is usually needed to know on which
 CPUs the workload runs on. If needed the CPUs can be forced using
-- 
2.19.2

