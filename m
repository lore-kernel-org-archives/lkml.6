Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967983AbeBOM0k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:26:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967889AbeBOM0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:26:39 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv3 0/9] perf tool: Assorted fixes
Date: Thu, 15 Feb 2018 13:26:26 +0100
Message-Id: <20180215122635.24029-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending assorted general fixes that queued
up in my other branches.

v3 changes:
  - reworked machine__create_kernel_maps to take into account
    kernel modules based on Namhyung's comments
  - fixed dso__load changes to take into account namespace switch
  - add perf test 1 fix

v2 changes:
  - rebased on current perf/core
  - detailed changelog for patch 1
  - using zfree instead of free in patch 2
  - using machine__set_mmap_name function name

Also available in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (9):
      tools lib symbol: Skip non-address kallsyms line
      perf tools: Check if we read regular file in dso__load
      perf tools: Free root_dir in machine__init error path
      perf tools: Move kernel mmap name into struct machine
      perf tools: Generalize machine__set_kernel_mmap function
      perf tools: Don't search for active kernel start in __machine__create_kernel_maps
      perf tools: Remove machine__load_kallsyms function
      perf tools: Do not create kernel maps in sample__resolve
      perf tests: Use arch__compare_symbol_names to compare symbols

 tools/lib/symbol/kallsyms.c         |   4 ++++
 tools/perf/tests/vmlinux-kallsyms.c |   4 ++--
 tools/perf/util/build-id.c          |  10 +++------
 tools/perf/util/event.c             |  16 +-------------
 tools/perf/util/machine.c           | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------
 tools/perf/util/machine.h           |   6 +-----
 tools/perf/util/symbol.c            |  13 +++++-------
 7 files changed, 87 insertions(+), 111 deletions(-)
