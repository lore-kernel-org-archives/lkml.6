Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeBGOsm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:48:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754011AbeBGOsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:48:41 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv2 00/10] perf tool: Assorted fixes
Date: Wed,  7 Feb 2018 15:48:28 +0100
Message-Id: <20180207144838.16823-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending assorted general fixes that queued
up in my other branches.

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
Jiri Olsa (10):
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

 tools/lib/symbol/kallsyms.c         |   4 ++++
 tools/perf/tests/vmlinux-kallsyms.c |   2 +-
 tools/perf/util/build-id.c          |  10 +++------
 tools/perf/util/event.c             |  16 +-------------
 tools/perf/util/machine.c           | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------
 tools/perf/util/machine.h           |   6 +-----
 tools/perf/util/symbol-elf.c        |   2 +-
 tools/perf/util/symbol.c            |  20 ++++++-----------
 tools/perf/util/symbol.h            |   2 +-
 9 files changed, 86 insertions(+), 123 deletions(-)
