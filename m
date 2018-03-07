Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934199AbeCGP56 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:57:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933829AbeCGPuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:24 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 00/19] perf tools: Assorted fixes
Date: Wed,  7 Mar 2018 16:50:01 +0100
Message-Id: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending assorted general fixes that queued
up in my other branches.

Also available in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (19):
      perf report: Fix the output for stdio events list
      perf report: Display perf.data header info
      perf record: Move machine variable down the function
      perf record: Remove progname from struct record
      perf tools: Add refcnt into struct mem_info
      perf c2c: Use mem_info refcnt logic
      perf tools: Add MEM_TOPOLOGY feature to perf data file
      perf tools: Add mem2node object
      perf tests: Add mem2node object test
      perf c2c record: Record physical addresses in samples
      perf c2c report: Make calc_width work with struct c2c_hist_entry
      perf c2c report: Call calc_width only for displayed entries
      perf c2c report: Display node for cacheline address
      perf c2c report: Add span header over cacheline data
      perf c2c report: Add cacheline address count column
      perf tools: Update tags with .cpp files
      perf build: Add llvm/clang/cxx make tests into FEATURE_TESTS_EXTRA
      perf build: Add llvm/clang make targets to FILES
      perf build: Force llvm/clang test compile output to .make.output

 tools/build/Makefile.feature          |   6 ++-
 tools/build/feature/Makefile          |  14 ++++--
 tools/include/linux/bitmap.h          |   2 +-
 tools/perf/Documentation/perf-c2c.txt |   2 +-
 tools/perf/Makefile.perf              |   6 +--
 tools/perf/builtin-c2c.c              | 249 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 tools/perf/builtin-record.c           |   7 +--
 tools/perf/builtin-report.c           |  17 +++++--
 tools/perf/tests/Build                |   1 +
 tools/perf/tests/builtin-test.c       |   4 ++
 tools/perf/tests/mem2node.c           |  73 +++++++++++++++++++++++++++
 tools/perf/tests/tests.h              |   1 +
 tools/perf/ui/browsers/hists.c        |   5 +-
 tools/perf/util/Build                 |   1 +
 tools/perf/util/env.h                 |   9 ++++
 tools/perf/util/evsel.c               |  20 ++++++--
 tools/perf/util/evsel.h               |   1 +
 tools/perf/util/header.c              | 312 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h              |   1 +
 tools/perf/util/hist.c                |   4 +-
 tools/perf/util/machine.c             |   2 +-
 tools/perf/util/mem2node.c            | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mem2node.h            |  19 +++++++
 tools/perf/util/symbol.c              |  22 ++++++++
 tools/perf/util/symbol.h              |  19 +++++--
 25 files changed, 864 insertions(+), 62 deletions(-)
 create mode 100644 tools/perf/tests/mem2node.c
 create mode 100644 tools/perf/util/mem2node.c
 create mode 100644 tools/perf/util/mem2node.h
