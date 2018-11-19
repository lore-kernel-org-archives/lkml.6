Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EA920831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EA920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeKTBgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:36:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:62656 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbeKTBgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:36:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 07:12:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="101468297"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2018 07:12:30 -0800
Received: from [10.252.27.191] (abudanko-mobl.ccr.corp.intel.com [10.252.27.191])
        by linux.intel.com (Postfix) with ESMTP id D4D23580032;
        Mon, 19 Nov 2018 07:12:25 -0800 (PST)
Subject: Re: [PATCH v1 1/2]: Documentation/admin-guide: update admin-guide
 index.rst
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <810bb4aa-777f-77ed-19f0-882354bdf9c7@linux.intel.com>
 <20181119100322.GA19910@kroah.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <660fcb45-bc63-0bf2-f14b-49b13b2580a0@linux.intel.com>
Date:   Mon, 19 Nov 2018 18:12:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181119100322.GA19910@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 19.11.2018 13:03, Greg KH wrote:
> On Mon, Nov 19, 2018 at 08:41:31AM +0300, Alexey Budankov wrote:
>>
>> Extend index.rst index file at admin-guide root directory with 
>> the reference to perf-security.rst file being introduced.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  Documentation/admin-guide/index.rst | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
>> index 0873685bab0f..885cc0de9114 100644
>> --- a/Documentation/admin-guide/index.rst
>> +++ b/Documentation/admin-guide/index.rst
>> @@ -75,6 +75,7 @@ configure specific aspects of kernel behavior to your liking.
>>     thunderbolt
>>     LSM/index
>>     mm/index
>> +   perf-security
> 
> You just broke the build with this patch.  They need to be ordered the
> other way around :(

Thanks for pointing that out.

The patches are now rebased according to MAINTAINERS here: 
	git://git.lwn.net/linux.git docs-next

make htmldocs SPHINXDIRS=admin-guide worked for me:
...
build succeeded, 10 warnings.
The HTML pages are in Documentation/output/admin-guide.

firefox Documentation/output/admin-guide/index.html 
shows link to the document at the end of this paragraph:

"The rest of this manual consists of various unordered guides on how to \
 configure specific aspects of kernel behavior to your liking."

Rebased changes are below for your convenience.

Thanks,
Alexey

---
 Documentation/admin-guide/index.rst         |  1 +
 Documentation/admin-guide/perf-security.rst | 83 +++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 965745d5fb9a..0a491676685e 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -76,6 +76,7 @@ configure specific aspects of kernel behavior to your liking.
    thunderbolt
    LSM/index
    mm/index
+   perf-security
 
 .. only::  subproject and html
 
diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
new file mode 100644
index 000000000000..b9564066e686
--- /dev/null
+++ b/Documentation/admin-guide/perf-security.rst
@@ -0,0 +1,83 @@
+.. _perf_security:
+
+PCL/Perf security
+=================
+
+Overview
+--------
+
+Usage of Performance Counters for Linux (PCL) [1]_ , [2]_ , [3]_ can impose a
+considerable risk of leaking sensitive data accessed by monitored processes.
+The data leakage is possible both in scenarios of direct usage of PCL system
+call API [2]_ and over data files generated by Perf tool user mode utility
+(Perf) [3]_ , [4]_ . The risk depends on the nature of data that PCL performance
+monitoring units (PMU) [2]_ collect and expose for performance analysis.
+Having that said PCL/Perf performance monitoring is the subject for security
+access control management [5]_ .
+
+PCL/Perf access control
+-----------------------
+
+For the purpose of performing security checks Linux implementation splits
+processes into two categories [6]_ : a) privileged processes (whose effective
+user ID is 0, referred to as superuser or root), and b) unprivileged processes
+(whose effective UID is nonzero). Privileged processes bypass all kernel
+security permission checks so PCL performance monitoring is fully available to
+privileged processes without *access*, *scope* and *resource* restrictions.
+Unprivileged processes are subject to full security permission check based
+on the process's credentials [5]_ (usually: effective UID, effective GID,
+and supplementary group list).
+
+PCL/Perf unprivileged users
+---------------------------
+
+PCL/Perf *scope* and *access* control for unprivileged processes is governed by
+perf_event_paranoid [2]_ setting:
+
+**-1**:
+     Impose no *scope* and *access* restrictions on using PCL performance
+     monitoring. Per-user per-cpu perf_event_mlock_kb [2]_ locking limit is
+     ignored when allocating memory buffers for storing performance data.
+     This is the least secure mode since allowed monitored *scope* is
+     maximized and no PCL specific limits are imposed on *resources*
+     allocated for performance monitoring.
+
+**>=0**:
+     *scope* includes per-process and system wide performance monitoring
+     but excludes raw tracepoints and ftrace function tracepoints monitoring.
+     CPU and system events happened when executing either in user or
+     in kernel space can be monitored and captured for later analysis.
+     Per-user per-cpu perf_event_mlock_kb locking limit is imposed but
+     ignored for unprivileged processes with CAP_IPC_LOCK [6]_ capability.
+
+**>=1**:
+     *scope* includes per-process performance monitoring only and excludes
+     system wide performance monitoring. CPU and system events happened when
+     executing either in user or in kernel space can be monitored and
+     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
+     locking limit is imposed but ignored for unprivileged processes with
+     CAP_IPC_LOCK capability.
+
+**>=2**:
+     *scope* includes per-process performance monitoring only. CPU and system
+     events happened when executing in user space only can be monitored and
+     captured for later analysis. Per-user per-cpu perf_event_mlock_kb
+     locking limit is imposed but ignored for unprivileged processes with
+     CAP_IPC_LOCK capability.
+
+**>=3**:
+     Restrict *access* to PCL performance monitoring for unprivileged processes.
+     This is the default on Debian and Android [7]_ , [8]_ .
+
+Bibliography
+------------
+
+.. [1] `<https://lwn.net/Articles/337493/>`_
+.. [2] `<http://man7.org/linux/man-pages/man2/perf_event_open.2.html>`_
+.. [3] `<http://web.eece.maine.edu/~vweaver/projects/perf_events/>`_
+.. [4] `<https://perf.wiki.kernel.org/index.php/Main_Page>`_
+.. [5] `<https://www.kernel.org/doc/html/latest/security/credentials.html>`_
+.. [6] `<http://man7.org/linux/man-pages/man7/capabilities.7.html>`_
+.. [7] `<https://lkml.org/lkml/2016/1/11/587>`_
+.. [8] `<https://android-review.googlesource.com/#/c/234743/>`_
+
