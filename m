Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934818AbeCBXl4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:41:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934731AbeCBXlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:41:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A549604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: timur@codeaurora.org, agustinv@codeaurora.org
Subject: [RFC V2 0/3] perf stat: improvements for handling of multiple PMUs
Date: Fri,  2 Mar 2018 18:41:29 -0500
Message-Id: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds some simple improvements to the way perf stat
handles PMUs that have multiple instances by:

1. Adding glob-like matching in addition to the prefix-based matching
   introduced previously (patch 1).
2. Adding the ability to recover the PMU names when printing the events
   separately with the --no-merge option (patch 2).
3. Restoring auto-merge for events created by prefix or glob-like match
   (patch 3). Note that this still keeps the behavior that disables
   auto-merging of legacy symbolic events (e.g. cycles).

V2:

- Updated the documentation to explain prefix and glob matching of PMU
  names, and event auto-merging.
- Added sample output to the third patch.

Agustin Vega-Frias (3):
  perf, tools: Support wildcards on pmu name in dynamic pmu events
  perf, tools: Display pmu name when printing unmerged events in stat
  perf pmu: Auto-merge PMU events created by prefix or glob match

 tools/perf/Documentation/perf-list.txt |  8 +++++++-
 tools/perf/Documentation/perf-stat.txt | 16 ++++++++++++++++
 tools/perf/builtin-stat.c              | 29 ++++++++++++++++++++++++++++-
 tools/perf/util/evsel.c                |  1 +
 tools/perf/util/evsel.h                |  1 +
 tools/perf/util/parse-events.c         | 21 ++++++++++-----------
 tools/perf/util/parse-events.h         |  2 +-
 tools/perf/util/parse-events.l         |  2 +-
 tools/perf/util/parse-events.y         |  7 ++++---
 9 files changed, 69 insertions(+), 18 deletions(-)

--
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
