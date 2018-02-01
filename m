Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBAIiS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:38:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbeBAIiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:38:16 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 0/3] perf: PEBS/period freerunning fixes
Date: Thu,  1 Feb 2018 09:38:09 +0100
Message-Id: <20180201083812.11359-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Stephan reported that we don't support period for
enabling large PEBS data, which there's no reason
for. Sending fix for that plus related perf tool
period fixes Stephan reported.

thanks,
jirka


---
Jiri Olsa (3):
      perf tools: Fix period/freq terms setup
      perf record: Fix period option handling
      x86/events/intel/ds: Add PERF_SAMPLE_PERIOD into PEBS_FREERUNNING_FLAGS

 arch/x86/events/perf_event.h |  3 ++-
 tools/perf/builtin-record.c  |  3 ++-
 tools/perf/perf.h            |  1 +
 tools/perf/util/evsel.c      | 13 ++++++++++---
 4 files changed, 15 insertions(+), 5 deletions(-)
