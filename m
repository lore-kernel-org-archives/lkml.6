Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeCIKOs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:14:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750937AbeCIKOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:14:46 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv2 0/9] perf tools: Assorted fixes
Date: Fri,  9 Mar 2018 11:14:33 +0100
Message-Id: <20180309101442.9224-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending assorted general fixes that queued
up in my other branches.

v2 changes:
  - rebased, some patches already taken
  - multiple fixes suggested by Arnaldo
  - new patch that frees memory_nodes in perf_env__exit

Also available in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (9):
      perf tools: Free memory nodes data
      perf tools: Add mem2node object
      perf tests: Add mem2node object test
      perf c2c record: Record physical addresses in samples
      perf c2c report: Make calc_width work with struct c2c_hist_entry
      perf c2c report: Call calc_width only for displayed entries
      perf c2c report: Display node for cacheline address
      perf c2c report: Add span header over cacheline data
      perf c2c report: Add cacheline address count column

 tools/perf/Documentation/perf-c2c.txt |   2 +-
 tools/perf/builtin-c2c.c              | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 tools/perf/tests/Build                |   1 +
 tools/perf/tests/builtin-test.c       |   4 +++
 tools/perf/tests/mem2node.c           |  75 ++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h              |   1 +
 tools/perf/util/Build                 |   1 +
 tools/perf/util/env.c                 |   4 +++
 tools/perf/util/mem2node.c            | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mem2node.h            |  19 ++++++++++
 10 files changed, 446 insertions(+), 18 deletions(-)
 create mode 100644 tools/perf/tests/mem2node.c
 create mode 100644 tools/perf/util/mem2node.c
 create mode 100644 tools/perf/util/mem2node.h
