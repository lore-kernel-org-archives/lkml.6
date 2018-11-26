Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7823C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A906C20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A906C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeKZTuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:50:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:51482 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeKZTuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:50:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 00:57:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="89218240"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2018 00:57:17 -0800
Received: from [10.125.252.8] (abudanko-mobl.ccr.corp.intel.com [10.125.252.8])
        by linux.intel.com (Postfix) with ESMTP id 062695803C2;
        Mon, 26 Nov 2018 00:57:13 -0800 (PST)
To:     Jonatan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3 0/2] Documentation/admin-guide: introduce perf-security.rst
 file and extend perf_event_paranoid documentation
Organization: Intel Corp.
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Message-ID: <6cfb235a-59bc-48f0-3425-59c5b6431b12@linux.intel.com>
Date:   Mon, 26 Nov 2018 11:57:11 +0300
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
to permit and manage access to Perf Events (perf_events) / Perf tool 
(Perf) [2],[3] performance monitoring for multiple users perf-security.rst 
document suggested by Thomas Gleixner is introduced [4] that:

a) states perf_events/Perf access security concerns for multi user environment
b) refers to base Linux access control and management principles
c) extends documentation of possible perf_event_paranoid knob settings 

The file serves as single knowledge source for perf_events/Perf security and 
access control related matter according to decisions, discussion and  
PoC prototype previously made here [5],[6].

The file can later be extended with information describing:

a) perf_events/Perf usage models and its security implications
b) perf_events/Perf user interface, its changes and related security implications
c) security related implications of monitoring by a specific perf_events PMU [2]

---
Alexey Budankov (2):
  Documentation/admin-guide: introduce perf-security.rst file
  Documentation/admin-guide: update admin-guide index.rst

 Documentation/admin-guide/index.rst         |  1 +
 Documentation/admin-guide/perf-security.rst | 77 +++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/admin-guide/perf-security.rst

---
Changes in v3:
- toning down of the markup for "scope, access and resource"
- adding definite article for "Linux implementation"
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
