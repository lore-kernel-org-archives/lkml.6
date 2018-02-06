Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeBFS2z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:28:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753234AbeBFS1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:27:48 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 00/17] perf tools: Assorted fixes
Date: Tue,  6 Feb 2018 19:17:56 +0100
Message-Id: <20180206181813.10943-1-jolsa@kernel.org>
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
Jiri Olsa (17):
      perf report: Ask ordered events for --tasks option
      perf record: Put new line after target override warning
      perf script: Add --show-round-event to display PERF_RECORD_FINISHED_ROUND
      tools lib api fs: Add filename__read_xll function
      tools lib api fs: Add sysfs__read_xll function
      tools lib symbol: Skip non-address kallsyms line
      perf tools: Free root_dir in machine__init error path
      perf tools: Move kernel mmap name into struct machine
      perf tools: Don't search for active kernel start in __machine__create_kernel_maps
      perf tools: Generalize machine__set_kernel_mmap function
      perf tools: Use machine__set_kernel_mmap instead of map_groups__fixup_end
      perf tools: Rename __map_groups__fixup_end to map_groups__fixup_end
      perf tools: Remove machine__load_kallsyms function
      perf tools: Do not create kernel maps in sample__resolve
      perf tools: Check if we read regular file in dso__load
      perf tests: Fix dwarf unwind for stripped binaries
      perf tools: Fix comment for sort__* compare functions

 tools/lib/api/fs/fs.c                    |  44 ++++++++++++++++++++++++++++--------
 tools/lib/api/fs/fs.h                    |   2 ++
 tools/lib/symbol/kallsyms.c              |   4 ++++
 tools/perf/Documentation/perf-script.txt |   3 +++
 tools/perf/builtin-record.c              |   2 +-
 tools/perf/builtin-report.c              |   1 +
 tools/perf/builtin-script.c              |  17 ++++++++++++++
 tools/perf/tests/dwarf-unwind.c          |  46 +++++++++++++++++++++++++-------------
 tools/perf/tests/vmlinux-kallsyms.c      |   2 +-
 tools/perf/util/build-id.c               |  10 +++------
 tools/perf/util/event.c                  |  16 +------------
 tools/perf/util/machine.c                | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
 tools/perf/util/machine.h                |   6 +----
 tools/perf/util/sort.c                   |   7 ++++--
 tools/perf/util/symbol-elf.c             |   2 +-
 tools/perf/util/symbol.c                 |  20 ++++++-----------
 tools/perf/util/symbol.h                 |   2 +-
 17 files changed, 180 insertions(+), 151 deletions(-)
