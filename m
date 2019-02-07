Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241E32175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBGNX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:23:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:44431 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfBGNX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:23:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 05:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="136627754"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2019 05:23:27 -0800
Received: from [10.125.252.152] (abudanko-mobl.ccr.corp.intel.com [10.125.252.152])
        by linux.intel.com (Postfix) with ESMTP id AA9E05800E0;
        Thu,  7 Feb 2019 05:23:23 -0800 (PST)
To:     Jonatan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 0/3] admin-guide: extend perf-security with resource
 control, data categories and privileged users
Organization: Intel Corp.
Message-ID: <fd896eec-7833-f23a-ad2f-95005dca5fff@linux.intel.com>
Date:   Thu, 7 Feb 2019 16:23:22 +0300
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

 Documentation/admin-guide/perf-security.rst | 247 +++++++++++++++-----
 1 file changed, 187 insertions(+), 60 deletions(-)

---
Changes in v2:
- addressed comments for v1
- added fourth patch implementing 72 columns paragraph width

---
[1] https://marc.info/?l=linux-kernel&m=153736008310781&w=2
[2] https://lkml.org/lkml/2018/5/21/156
[3] https://lkml.org/lkml/2018/11/27/604
[4] http://man7.org/linux/man-pages/man2/perf_event_open.2.html
