Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED2BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7151E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7151E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbeKTBhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:37:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:23618 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbeKTBhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:37:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 07:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="109368805"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2018 07:13:22 -0800
Received: from [10.252.27.191] (abudanko-mobl.ccr.corp.intel.com [10.252.27.191])
        by linux.intel.com (Postfix) with ESMTP id 83752580460;
        Mon, 19 Nov 2018 07:13:17 -0800 (PST)
Subject: Re: [PATCH v1 2/2]: Documentation/admin-guide: introduce
 perf-security.rst file
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jonatan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-doc@vger.kernel.org
References: <0ac97cd0-4773-fff6-7d4e-74c4a1f076c4@linux.intel.com>
 <a44df303-d962-c1a4-4fe0-6bad887ebcdc@linux.intel.com>
 <20181119103337.GZ9761@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2a4e0b60-ba52-2d79-ec7d-d9b75f0ae5a1@linux.intel.com>
Date:   Mon, 19 Nov 2018 18:13:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181119103337.GZ9761@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 19.11.2018 13:33, Peter Zijlstra wrote:
> On Mon, Nov 19, 2018 at 08:42:52AM +0300, Alexey Budankov wrote:
>>
>> Implement initial version of perf-security.rst documentation file 
>> initially covering security concerns related to PCL/Perf performance 
>> monitoring in multiuser environments.
> 
> Ditch the PCL thing. That's not a term used anywhere in the kernel.

Ok. Which is the proper wording to reference to Perf kernel subsystem?

> 
> Also:
> 
>> +PCL/Perf unprivileged users
>> +---------------------------
>> +
>> +PCL/Perf *scope* and *access* control for unprivileged processes is governed by
>> +perf_event_paranoid [2]_ setting:
>> +
>> +**-1**:
>> +     Impose no *scope* and *access* restrictions on using PCL performance
>> +     monitoring. Per-user per-cpu perf_event_mlock_kb [2]_ locking limit is
>> +     ignored when allocating memory buffers for storing performance data.
>> +     This is the least secure mode since allowed monitored *scope* is
>> +     maximized and no PCL specific limits are imposed on *resources*
>> +     allocated for performance monitoring.
>> +
>> +**>=0**:
>> +     *scope* includes per-process and system wide performance monitoring
>> +     but excludes raw tracepoints and ftrace function tracepoints monitoring.
>> +     CPU and system events happened when executing either in user or
>> +     in kernel space can be monitored and captured for later analysis.
>> +     Per-user per-cpu perf_event_mlock_kb locking limit is imposed but
>> +     ignored for unprivileged processes with CAP_IPC_LOCK [6]_ capability.
>> +
>> +**>=1**:
>> +     *scope* includes per-process performance monitoring only and excludes
>> +     system wide performance monitoring. CPU and system events happened when
>> +     executing either in user or in kernel space can be monitored and
>> +     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
>> +     locking limit is imposed but ignored for unprivileged processes with
>> +     CAP_IPC_LOCK capability.
>> +
>> +**>=2**:
>> +     *scope* includes per-process performance monitoring only. CPU and system
>> +     events happened when executing in user space only can be monitored and
>> +     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
>> +     locking limit is imposed but ignored for unprivileged processes with
>> +     CAP_IPC_LOCK capability.
>> +
>> +**>=3**:
>> +     Restrict *access* to PCL performance monitoring for unprivileged processes.
>> +     This is the default on Debian and Android [7]_ , [8]_ .
> 
> that ** crud is unreadable.

It can be avoided without missing the sense.

"two asterisks: **text** for strong emphasis (boldface)". 

Thanks,
Alexey

> 
> http://lkml.kernel.org/r/094556ca-ea87-9c4a-2115-600d2833fb2a@darmarit.de
> 
