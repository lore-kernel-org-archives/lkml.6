Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D120AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB28020821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfAIJUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:20:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:13930 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfAIJUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:20:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:20:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="105163006"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2019 01:20:11 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] perf thread-stack: x86 retpolines
Date:   Wed,  9 Jan 2019 11:18:29 +0200
Message-Id: <20190109091835.5570-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some patches to improve the exported call graph, primarily to deal
with x86 retpolines.


Adrian Hunter (6):
      perf tools: Fix split_kallsyms_for_kcore for trampoline symbols
      perf thread-stack: Tidy thread_stack__push_cp() usage
      perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables
      perf thread-stack: Represent jmps to the start of a different symbol
      perf thread-stack: Improve thread_stack__no_call_return()
      perf thread-stack: Hide x86 retpolines

 tools/perf/scripts/python/export-to-postgresql.py |   2 +-
 tools/perf/scripts/python/export-to-sqlite.py     |   2 +-
 tools/perf/util/symbol.c                          |   2 +
 tools/perf/util/thread-stack.c                    | 235 ++++++++++++++++++----
 tools/perf/util/thread-stack.h                    |   3 +
 5 files changed, 208 insertions(+), 36 deletions(-)


Regards
Adrian
