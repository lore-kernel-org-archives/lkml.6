Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A952C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52734204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52734204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeKTTtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:49:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:39640 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeKTTto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:49:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 01:21:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,256,1539673200"; 
   d="scan'208";a="109763734"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2018 01:21:37 -0800
Received: from [10.125.252.159] (abudanko-mobl.ccr.corp.intel.com [10.125.252.159])
        by linux.intel.com (Postfix) with ESMTP id 9B519580432;
        Tue, 20 Nov 2018 01:21:33 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 0/2]: Documentation/admin-guide: introduce
 perf-security.rst file and extend perf_event_paranoid documentation
Organization: Intel Corp.
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jonatan Corbet <corbet@lwn.net>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Message-ID: <86cf8ad4-7728-8d07-5b03-effd32071f32@linux.intel.com>
Date:   Tue, 20 Nov 2018 12:21:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


To facilitate informed decision making by system administrators [1]
to permit and manage access to Perf Events (PE) / Perf tool (Perf) [2],[3] 
performance monitoring for multiple users perf-security.rst document 
suggested by Thomas Gleixner is introduced [4] that:

a) states PE/Perf access security concerns for multi user environment
b) refers to base Linux access control and management principles
c) extends documentation of possible perf_event_paranoid knob settings 

The file serves as single knowledge source for PE/Perf security and 
access control related matter according to decisions, discussion and  
PoC prototype previously made here [5],[6].

The file can later be extended with information describing:

a) PE/Perf usage models and its security implications
b) PE/Perf user interface, its changes and related security implications
c) security related implications of monitoring by a specific PE PMU [2]

---
Alexey Budankov (2):
  Documentation/admin-guide: introduce perf-security.rst file
  Documentation/admin-guide: update admin-guide index.rst

 Documentation/admin-guide/index.rst         |  1 +
 Documentation/admin-guide/perf-security.rst | 76 +++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/admin-guide/perf-security.rst

---
Changes in v2:
- reverted patches order in the set to avoid CI issue
- replaced old PCL referencing by PE (Perf Events)
- skipped >=3 setting documentation at the moment

---
[1] https://marc.info/?l=linux-kernel&m=153815883923913&w=2
[2] http://man7.org/linux/man-pages/man2/perf_event_open.2.html
[3] https://perf.wiki.kernel.org/index.php/Main_Page
[4] https://marc.info/?l=linux-kernel&m=153837512226838&w=2
[5] https://marc.info/?l=linux-kernel&m=153736008310781&w=2
[6] https://lkml.org/lkml/2018/5/21/156
