Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755784AbeDICdg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 22:33:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:4901 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756309AbeDICcu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 22:32:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,426,1517904000";
   d="scan'208";a="215038550"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/3] perf version: some follow-up updates
Date: Mon,  9 Apr 2018 18:26:46 +0800
Message-Id: <1523269609-28824-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Remove -DNO_LIBPERL and use -DHAVE_LIBPERL_SUPPORT in C code.

2. Remove -DNO_LIBPYTHON and use -DHAVE_LIBPYTHON_SUPPORT in C code.

3. Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT.

4. Don't print "libaudit" line if HAVE_SYSCALL_TABLE_SUPPORT is available
   and add a line for HAVE_SYSCALL_TABLE_SUPPORT.

Jin Yao (3):
  perf script: Use HAVE_LIBXXX_SUPPORT to replace NO_LIBXXX
  perf: Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT
  perf version: Print status for syscall_table

 tools/perf/Makefile.config              | 2 +-
 tools/perf/builtin-help.c               | 2 +-
 tools/perf/builtin-script.c             | 4 ++--
 tools/perf/builtin-version.c            | 3 +++
 tools/perf/perf.c                       | 4 ++--
 tools/perf/util/generate-cmdlist.sh     | 2 +-
 tools/perf/util/syscalltbl.c            | 6 +++---
 tools/perf/util/trace-event-scripting.c | 4 ++--
 8 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.7.4
