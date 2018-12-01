Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0C7C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511D620867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511D620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLAPU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 10:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbeLAPU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 10:20:26 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ABAD20867;
        Sat,  1 Dec 2018 04:08:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gSwaK-0000FF-54; Fri, 30 Nov 2018 23:08:52 -0500
Message-Id: <20181201040807.154099010@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 23:08:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/6] tools/lib/traceevent: Some more library updates
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo and Jiri,

Here's another set of patches to get us closer to having a legitimate
standalone library for libtraceevent. There's still a lot of man pages
to come, but I need to continue reviewing them.

Please pull this tree (based on current tip/perf/core) or apply
the patches.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
tip/perf/core

Head SHA1: 5b2e18a71601544c4ae95e9ed1f953f3883714f5


Tzvetomir Stoyanov (6):
      tools/lib/traceevent: Initialize host_bigendian at tep_handle allocation
      tools/lib/traceevent: Rename struct cmdline to struct tep_cmdline
      tools/lib/traceevent: Changed return logic of trace_seq_printf() and trace_seq_vprintf() APIs
      tools/lib/traceevent: Changed return logic of tep_register_event_handler() API
      tools/lib/traceevent: Rename tep_is_file_bigendian() to tep_file_bigendian()
      tools/lib/traceevent: Remove tep_data_event_from_type() API

----
 tools/lib/traceevent/event-parse-api.c   |  4 +--
 tools/lib/traceevent/event-parse-local.h |  4 +--
 tools/lib/traceevent/event-parse.c       | 62 +++++++++++++++-----------------
 tools/lib/traceevent/event-parse.h       | 16 +++++----
 tools/lib/traceevent/plugin_kvm.c        |  2 +-
 tools/lib/traceevent/trace-seq.c         | 17 ++++++---
 6 files changed, 56 insertions(+), 49 deletions(-)
