Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BF2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE7F20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE7F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeLAC4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLAC4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:56:32 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4D5320834;
        Fri, 30 Nov 2018 15:46:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gSl0A-0005xT-Qm; Fri, 30 Nov 2018 10:46:46 -0500
Message-Id: <20181130154403.150474900@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 10:44:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/9] tools/lib/traceevent: More udpates to make libtraceevent into a library
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnaldo and Jiri,

Here's more patches to get us a step closer to having a legitimate
standalone library for libtraceevent. I'm currently reviewing man
pages, which I want finished before we call it done.

Please pull this tree (based on current tip/perf/core) or apply
the patches.

Thanks!

-- Steve


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
tip/perf/core

Head SHA1: 1a1dbb61ee77226e9097bfe307219abf5df8e4cd


Tzvetomir Stoyanov (9):
      tools/lib/traceevent: Implemented new API tep_get_ref()
      tools/lib/traceevent: Added support for pkg-config
      tools/lib/traceevent: Install trace-seq.h API header file
      tools/lib/traceevent, tools/perf: Rename struct tep_event_format to struct tep_event
      tools/lib/traceevent: Rename tep_free_format() to tep_free_event()
      tools/perf: traceevent API cleanup, remove __tep_data2host*()
      tools/lib/traceevent: traceevent API cleanup
      tools/lib/traceevent: Introduce new libtracevent API: tep_override_comm()
      tools/lib/traceevent: Add sanity check to is_timestamp_in_us()

----
 tools/lib/traceevent/Makefile                      |  27 +-
 tools/lib/traceevent/event-parse-api.c             |   8 +-
 tools/lib/traceevent/event-parse-local.h           |  13 +-
 tools/lib/traceevent/event-parse.c                 | 283 ++++++++++++---------
 tools/lib/traceevent/event-parse.h                 |  78 +++---
 tools/lib/traceevent/libtraceevent.pc.template     |  10 +
 tools/lib/traceevent/parse-filter.c                |  42 +--
 tools/lib/traceevent/plugin_function.c             |   2 +-
 tools/lib/traceevent/plugin_hrtimer.c              |   4 +-
 tools/lib/traceevent/plugin_kmem.c                 |   2 +-
 tools/lib/traceevent/plugin_kvm.c                  |  14 +-
 tools/lib/traceevent/plugin_mac80211.c             |   4 +-
 tools/lib/traceevent/plugin_sched_switch.c         |   4 +-
 tools/perf/builtin-trace.c                         |   2 +-
 tools/perf/util/evsel.h                            |   4 +-
 tools/perf/util/header.c                           |   2 +-
 tools/perf/util/python.c                           |   4 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   6 +-
 .../util/scripting-engines/trace-event-python.c    |   8 +-
 tools/perf/util/trace-event-parse.c                |  16 +-
 tools/perf/util/trace-event-read.c                 |   4 +-
 tools/perf/util/trace-event.c                      |   8 +-
 tools/perf/util/trace-event.h                      |  16 +-
 23 files changed, 317 insertions(+), 244 deletions(-)
 create mode 100644 tools/lib/traceevent/libtraceevent.pc.template
