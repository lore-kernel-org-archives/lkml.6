Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EBEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BBF21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BBF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeLFKpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:45:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:53863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFKpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:45:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 02:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,322,1539673200"; 
   d="scan'208";a="127621894"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2018 02:45:16 -0800
Received: from [10.125.252.108] (abudanko-mobl.ccr.corp.intel.com [10.125.252.108])
        by linux.intel.com (Postfix) with ESMTP id 9ACCF58014B;
        Thu,  6 Dec 2018 02:45:12 -0800 (PST)
Subject: Re: [PATCH v4 1/2] Documentation/admin-guide: introduce
 perf-security.rst file
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <feac7efa-df6f-cca1-e321-28d220bf0411@linux.intel.com>
 <b1a4fa08-482d-0fcc-c798-efb9a9894a47@linux.intel.com>
 <CAGXu5jJ_CyE5A2VUSyyi-uj4webfZM9ZOACp523p5xFhv1KCAQ@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <dcbcef5d-82ab-1f8d-5cf3-2518b8feb781@linux.intel.com>
Date:   Thu, 6 Dec 2018 13:45:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ_CyE5A2VUSyyi-uj4webfZM9ZOACp523p5xFhv1KCAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.2018 4:10, Kees Cook wrote:
> On Tue, Nov 27, 2018 at 12:15 AM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>>
>> Implement initial version of perf-security.rst documentation file
>> covering security concerns of perf_event_paranoid settings.
>>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!
-Alexey

> 
> -Kees
> 
>> ---
>> Changes in v4:
>> - added docs for perf_event related capabilities
>> Changes in v3:
>> - toning down of the markup for "scope, access and resource"
>> - adding definite article for "Linux implementation"
>> Changes in v2:
>> - reverted patches order in the set to avoid CI issue
>> - replaced old PCL referencing by PE (Perf Events)
>> - skipped >=3 setting documentation at the moment
>> ---
>>  Documentation/admin-guide/perf-security.rst | 97 +++++++++++++++++++++
>>  1 file changed, 97 insertions(+)
>>  create mode 100644 Documentation/admin-guide/perf-security.rst
>>
>> diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
>> new file mode 100644
>> index 000000000000..f73ebfe9bfe2
>> --- /dev/null
>> +++ b/Documentation/admin-guide/perf-security.rst
>> @@ -0,0 +1,97 @@
>> +.. _perf_security:
>> +
>> +Perf Events and tool security
>> +=============================
>> +
>> +Overview
>> +--------
>> +
>> +Usage of Performance Counters for Linux (perf_events) [1]_ , [2]_ , [3]_ can
>> +impose a considerable risk of leaking sensitive data accessed by monitored
>> +processes. The data leakage is possible both in scenarios of direct usage of
>> +perf_events system call API [2]_ and over data files generated by Perf tool user
>> +mode utility (Perf) [3]_ , [4]_ . The risk depends on the nature of data that
>> +perf_events performance monitoring units (PMU) [2]_ collect and expose for
>> +performance analysis. Having that said perf_events/Perf performance monitoring
>> +is the subject for security access control management [5]_ .
>> +
>> +perf_events/Perf access control
>> +-------------------------------
>> +
>> +To perform security checks, the Linux implementation splits processes into two
>> +categories [6]_ : a) privileged processes (whose effective user ID is 0, referred
>> +to as superuser or root), and b) unprivileged processes (whose effective UID is
>> +nonzero). Privileged processes bypass all kernel security permission checks so
>> +perf_events performance monitoring is fully available to privileged processes
>> +without access, scope and resource restrictions.
>> +
>> +Unprivileged processes are subject to a full security permission check based on
>> +the process's credentials [5]_ (usually: effective UID, effective GID, and
>> +supplementary group list).
>> +
>> +Linux divides the privileges traditionally associated with superuser into
>> +distinct units, known as capabilities [6]_ , which can be independently enabled
>> +and disabled on per-thread basis for processes and files of unprivileged users.
>> +
>> +Unprivileged processes with enabled CAP_SYS_ADMIN capability are treated as
>> +privileged processes with respect to perf_events performance monitoring and
>> +bypass *scope* permissions checks in the kernel.
>> +
>> +Unprivileged processes using perf_events system call API is also subject for
>> +PTRACE_MODE_READ_REALCREDS ptrace access mode check [7]_ , whose outcome
>> +determines whether monitoring is permitted. So unprivileged processes provided
>> +with CAP_SYS_PTRACE capability are effectively permitted to pass the check.
>> +
>> +Other capabilities being granted to unprivileged processes can effectively
>> +enable capturing of additional data required for later performance analysis of
>> +monitored processes or a system. For example, CAP_SYSLOG capability permits
>> +reading kernel space memory addresses from /proc/kallsyms file.
>> +
>> +perf_events/Perf unprivileged users
>> +-----------------------------------
>> +
>> +perf_events/Perf *scope* and *access* control for unprivileged processes is
>> +governed by perf_event_paranoid [2]_ setting:
>> +
>> +-1:
>> +     Impose no *scope* and *access* restrictions on using perf_events performance
>> +     monitoring. Per-user per-cpu perf_event_mlock_kb [2]_ locking limit is
>> +     ignored when allocating memory buffers for storing performance data.
>> +     This is the least secure mode since allowed monitored *scope* is
>> +     maximized and no perf_events specific limits are imposed on *resources*
>> +     allocated for performance monitoring.
>> +
>> +>=0:
>> +     *scope* includes per-process and system wide performance monitoring
>> +     but excludes raw tracepoints and ftrace function tracepoints monitoring.
>> +     CPU and system events happened when executing either in user or
>> +     in kernel space can be monitored and captured for later analysis.
>> +     Per-user per-cpu perf_event_mlock_kb locking limit is imposed but
>> +     ignored for unprivileged processes with CAP_IPC_LOCK [6]_ capability.
>> +
>> +>=1:
>> +     *scope* includes per-process performance monitoring only and excludes
>> +     system wide performance monitoring. CPU and system events happened when
>> +     executing either in user or in kernel space can be monitored and
>> +     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
>> +     locking limit is imposed but ignored for unprivileged processes with
>> +     CAP_IPC_LOCK capability.
>> +
>> +>=2:
>> +     *scope* includes per-process performance monitoring only. CPU and system
>> +     events happened when executing in user space only can be monitored and
>> +     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
>> +     locking limit is imposed but ignored for unprivileged processes with
>> +     CAP_IPC_LOCK capability.
>> +
>> +Bibliography
>> +------------
>> +
>> +.. [1] `<https://lwn.net/Articles/337493/>`_
>> +.. [2] `<http://man7.org/linux/man-pages/man2/perf_event_open.2.html>`_
>> +.. [3] `<http://web.eece.maine.edu/~vweaver/projects/perf_events/>`_
>> +.. [4] `<https://perf.wiki.kernel.org/index.php/Main_Page>`_
>> +.. [5] `<https://www.kernel.org/doc/html/latest/security/credentials.html>`_
>> +.. [6] `<http://man7.org/linux/man-pages/man7/capabilities.7.html>`_
>> +.. [7] `<http://man7.org/linux/man-pages/man2/ptrace.2.html>`_
>> +
> 
> 
> 
