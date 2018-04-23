Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754490AbeDWJI2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:08:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753005AbeDWJI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:08:26 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 0/9] perf tools: Assorted fixes
Date: Mon, 23 Apr 2018 11:08:14 +0200
Message-Id: <20180423090823.32309-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending assorted general fixes that queued
up in my other branches.

Arnaldo,
I added wait4 call in the last patch and am wondering
if it will pass your all-distros-docker test ;-)
If not I'll need to put some build detection code.

Also available in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka

---
Jiri Olsa (9):
      perf check-headers.sh: Simplify arguments passing
      perf check-headers.sh: Add support to check 2 independent files
      perf stat: Keep the / modifier separator in fallback
      perf tools: Fix pmu events parsing rule
      perf tools: Disable write_backward for leader sampling group events
      perf stat: Display time in precision based on std deviation
      perf stat: Add --table option to display time of each run
      perf stat: Display length strings of each run for --table option
      perf stat: Display user and system time

 tools/perf/builtin-stat.c                        | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 tools/perf/check-headers.sh                      |  30 +++++++++++++++-------------
 tools/perf/tests/attr/test-record-group-sampling |   3 +++
 tools/perf/util/evsel.c                          |  15 +++++++++++---
 tools/perf/util/parse-events.y                   |   8 ++++----
 tools/perf/util/stat.h                           |   3 +--
 6 files changed, 146 insertions(+), 33 deletions(-)
