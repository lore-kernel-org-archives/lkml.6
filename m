Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FFFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6322C222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061171;
	bh=XLFvBgO2WPUBjd3pk64TUX8NwhLDuGjs2UpDTY0W0JQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hIYdSRtmrc8wAKXlT6/W/jPOYlQeevYbdDXPul/M4BB/Vtug+Ph4XbOXwQ9qyHqx9
	 fRTj8/oL9LhQGgEcTL896rHYIC2su5d/N63eF3WU4OiH1Pxd9ojsPa42DsLVwh07ye
	 5fhmRmDZaL9RdQN9fQK58WAobpcwjjN/tIui1S9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404157AbfBMMct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:32:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388157AbfBMMct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:32:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88985AC610;
        Wed, 13 Feb 2019 12:32:48 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E454360856;
        Wed, 13 Feb 2019 12:32:46 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 00/10] perf tools: Assorted fixes
Date:   Wed, 13 Feb 2019 13:32:36 +0100
Message-Id: <20190213123246.4015-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 13 Feb 2019 12:32:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
Jiri Olsa (10):
      perf tools: Compile perf with libperf-in.o instead of libperf.a
      perf tools: Rename LIB_FILE to LIBPERF_A
      perf tools: Rename build libperf to perf
      perf tools: Fix legacy events symbol separator parsing
      perf list: Display metric expressions for --details option
      perf header: Fix wrong node write in NUMA_TOPOLOGY feature
      perf header: Get rid of write_it label
      perf header: Remove cpu_nr from struct cpu_topo
      perf tools: Add perf_topo_cpu object
      perf tools: Add perf_topo_numa object

 tools/perf/Build                                |  10 +++---
 tools/perf/Makefile.perf                        |  22 ++++++------
 tools/perf/arch/Build                           |   4 +--
 tools/perf/arch/arm/Build                       |   4 +--
 tools/perf/arch/arm/tests/Build                 |   8 ++---
 tools/perf/arch/arm/util/Build                  |   8 ++---
 tools/perf/arch/arm64/Build                     |   4 +--
 tools/perf/arch/arm64/tests/Build               |   6 ++--
 tools/perf/arch/arm64/util/Build                |  12 +++----
 tools/perf/arch/nds32/Build                     |   2 +-
 tools/perf/arch/nds32/util/Build                |   2 +-
 tools/perf/arch/powerpc/Build                   |   4 +--
 tools/perf/arch/powerpc/tests/Build             |   6 ++--
 tools/perf/arch/powerpc/util/Build              |  18 +++++-----
 tools/perf/arch/s390/Build                      |   2 +-
 tools/perf/arch/s390/util/Build                 |  12 +++----
 tools/perf/arch/sh/Build                        |   2 +-
 tools/perf/arch/sh/util/Build                   |   2 +-
 tools/perf/arch/sparc/Build                     |   2 +-
 tools/perf/arch/sparc/util/Build                |   2 +-
 tools/perf/arch/x86/Build                       |   4 +--
 tools/perf/arch/x86/tests/Build                 |  14 ++++----
 tools/perf/arch/x86/util/Build                  |  30 ++++++++--------
 tools/perf/arch/xtensa/Build                    |   2 +-
 tools/perf/arch/xtensa/util/Build               |   2 +-
 tools/perf/builtin-list.c                       |   8 ++---
 tools/perf/scripts/Build                        |   4 +--
 tools/perf/scripts/perl/Perf-Trace-Util/Build   |   2 +-
 tools/perf/scripts/python/Perf-Trace-Util/Build |   2 +-
 tools/perf/tests/parse-events.c                 |  30 ++++++++++++++++
 tools/perf/trace/beauty/Build                   |  26 +++++++-------
 tools/perf/ui/Build                             |  18 +++++-----
 tools/perf/ui/browsers/Build                    |  10 +++---
 tools/perf/ui/tui/Build                         |   8 ++---
 tools/perf/util/Build                           | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------
 tools/perf/util/c++/Build                       |   4 +--
 tools/perf/util/cputopo.c                       | 264 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h                       |  33 +++++++++++++++++
 tools/perf/util/cs-etm-decoder/Build            |   2 +-
 tools/perf/util/header.c                        | 277 +++++++++++++++++------------------------------------------------------------------------------------------------------------------------------
 tools/perf/util/intel-pt-decoder/Build          |   2 +-
 tools/perf/util/metricgroup.c                   |   8 ++++-
 tools/perf/util/metricgroup.h                   |   3 +-
 tools/perf/util/parse-events.c                  |   2 +-
 tools/perf/util/parse-events.y                  |   4 +--
 tools/perf/util/scripting-engines/Build         |   4 +--
 46 files changed, 647 insertions(+), 525 deletions(-)
 create mode 100644 tools/perf/util/cputopo.c
 create mode 100644 tools/perf/util/cputopo.h
