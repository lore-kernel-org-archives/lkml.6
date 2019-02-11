Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0358AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAD621B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbfBKNck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:32:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:23488 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfBKNck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:32:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 05:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="143279694"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2019 05:32:37 -0800
Received: from [10.125.252.196] (abudanko-mobl.ccr.corp.intel.com [10.125.252.196])
        by linux.intel.com (Postfix) with ESMTP id AB53D5800C6;
        Mon, 11 Feb 2019 05:32:34 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3 0/3] admin-guide: extend perf-security with resource
 control, data categories and privileged users
Organization: Intel Corp.
To:     Jonatan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <784bbe0d-56c1-bd63-1879-b7db988e40c0@linux.intel.com>
Date:   Mon, 11 Feb 2019 16:32:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The patch set extends the first version of perf-security.rst documentation
file [1], [2], [3] with the following topics:

1) perf_events/Perf resource limits and control management that describes
   RLIMIT_NOFILE and perf_event_mlock_kb settings for processes conducting
   performance monitoring;

2) categories of system and performance data that can be captured by
   perf_events/Perf with explicit designation of process sensitive data;

3) possible steps to create perf_event/Perf privileged users groups for 
   the current implementations of perf_events syscall API [4] and Perf tool;

---
Alexey Budankov (4):
  perf-security: document perf_events/Perf resource control
  perf-security: document collected perf_events/Perf data categories
  perf-security: elaborate on perf_events/Perf privileged users
  perf-security: wrap paragraphs on 72 columns

 Documentation/admin-guide/perf-security.rst | 253 +++++++++++++++-----
 1 file changed, 193 insertions(+), 60 deletions(-)

---
Changes in v3:
- added two more paragraphs on open fds and memory allocation
- applied comments and corrected typos

Changes in v2:
- addressed comments for v1
- added fourth patch implementing 72 columns paragraph width

---
[1] https://marc.info/?l=linux-kernel&m=153736008310781&w=2
[2] https://lkml.org/lkml/2018/5/21/156
[3] https://lkml.org/lkml/2018/11/27/604
[4] http://man7.org/linux/man-pages/man2/perf_event_open.2.html
