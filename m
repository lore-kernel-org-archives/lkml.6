Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4562C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B70920877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B70920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeJEAI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:08:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:13247 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbeJEAI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:08:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 10:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,340,1534834800"; 
   d="scan'208";a="97449403"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2018 10:11:34 -0700
Received: from [10.252.2.114] (abudanko-mobl.ccr.corp.intel.com [10.252.2.114])
        by linux.intel.com (Postfix) with ESMTP id 0128E5801E6;
        Thu,  4 Oct 2018 10:11:29 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andi Kleen <ak@linux.intel.com>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com>
 <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
 <20180928204930.GC32651@tassilo.jf.intel.com>
 <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
 <20180928205907.GD32651@tassilo.jf.intel.com>
 <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
 <20180928212757.GE32651@tassilo.jf.intel.com>
 <22155f49-2f57-73b8-6e89-ddd8a127967b@linux.intel.com>
 <alpine.DEB.2.21.1810011741070.32062@nanos.tec.linutronix.de>
 <905796f8-4704-66a8-ee0a-ac8aba90b179@linux.intel.com>
 <CAG48ez3y7Q0DCkVH6PgGncwEKuD-OHLp7pTBNb=S1OXYhte-Nw@mail.gmail.com>
Organization: Intel Corp.
Message-ID: <fe49c9b5-88fb-c827-9262-1931bcf80b6c@linux.intel.com>
Date:   Thu, 4 Oct 2018 20:11:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez3y7Q0DCkVH6PgGncwEKuD-OHLp7pTBNb=S1OXYhte-Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03.10.2018 20:01, Jann Horn wrote:
> On Mon, Oct 1, 2018 at 10:53 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
<SNIP>
>> 3. Every time an event for ${PMU} is created over perf_event_open():
>>    a) the calling thread's euid is checked to belong to ${PMU}_users group
>>       and if it does then the event's fd is allocated;
>>    b) then traditional checks against perf_event_pranoid content are applied;
>>    c) if the file doesn't exist the access is governed by global setting
>>       at /proc/sys/kernel/perf_even_paranoid;
> 
> You'll also have to make sure that this thing in kernel/events/core.c
> doesn't have any bad effect:
> 
>     /*
>     * Special case software events and allow them to be part of
>     * any hardware group.
>     */
> 
> As in, make sure that you can't smuggle in arbitrary software events
> by attaching them to a whitelisted hardware event.

Yes, makes sense. Please see and comment below.

> 
<SNIP>
>> Security analysis for uncore IMC, QPI/UPI, PCIe PMUs is still required
>> to be enabled for fine grain control.
> 
> And you can't whitelist anything that permits using sampling events
> with arbitrary sample_type.
> 

It appears that there is a dependency on the significance of data that PMUs captures 
for later analysis. Currently there are following options for data being captured 
(please correct or extend if something is missing from the list below):

1) Monitored process details:
   - system information on a process as a container (of threads, memory data and 
     IDs (e.g. open fds) from process specific namespaces and etc.);
   - system information on threads as containers (of execution context details);
2) Execution context details:
   - memory addresses;
   - memory data;
   - calculation results;
   - calculation state in HW;
3) Monitored process and execution context telemetry data, used for building 
   various performance metrics and can come from:
   - user mode code and OS kernel;
   - various parts of HW e.g. core, uncore, peripheral and etc.

Group 2) is the potential leakage source of sensitive process data so if a PMU, 
at some mode, samples execution context details then the PMU, working in that mode, 
is the subject for *access* and *scope* control.

On the other hand if captured data contain only the monitored process details 
and/or associated execution telemetry, there is probably no sensitive data leakage 
thru that captured data.

For example, if cpu PMU samples PC addresses overtime, e.g. for providing 
hotspots-by-function profile, then this requires to be controlled as from access as 
from scope perspective, because PC addresses is execution context details that 
can contain sensitive data.

However, if cpu PMU does counting of some metric value, or if software PMU reads 
value of thread active time from the OS, possibly overtime, for later building some 
rating profile, or reading of some HW counter value without attribution to any 
execution context details, that is probably not that risky as in the case of 
PC address sampling.

Uncore PMUs e.g. memory controller (IMC), interconnect (QPI/UPI) and peripheral (PCIe) 
currently only read counters values that are captured system wide by HW, and provide 
no attribution to any specific execution context details, thus, sensitive process data.

Based on that,

A) paranoid knob is required for a PMU if it can capture data from group 2)
B) paranoid knob limits scope of capturing sensitive data:
   -3 - *scope* is defined by some high level setting
   -2 - disabled - no allowed *scope*
   -1 - no restrictions - max *scope*
    0 - system wide
    1 - process user and kernel space
    2 - process user space only
C) paranoid knob has to be checked every time the PMU is going to start 
   capturing sensitive data to avoid capturing beyond the allowed scope.

PMU *access* semantics is derived from fs ACLs and could look like this:

r - read PMU architectural and configuration details, read PMU *access* settings
w - modify PMU *access* settings
x - modify PMU configuration and collect data

So levels of *access* to PMU could look like this:

root=rwx, ${PMU}_users=r-x, other=r--.

Possible examples of *scope* control settings could look like this:

1) system wide user+kernel mode CPU sampling with context switches 
   and uncore counting:

	/proc/sys/kernel/perf_event_paranoid (-2, 2): 0
	SW.paranoid  (-3, 2):(root=rwx, SW_users=r-x,other=r--): -3
	CPU.paranoid (-3, 2):(root=rwx,CPU_users=r-x,other=r--): -3
	IMC.paranoid (-3,-1):(root=rwx,IMC_users=r-x,other=r--): -3
	UPI.paranoid (-3,-1):(root=rwx,UPI_users=r-x,other=r--): -3
	PCI.paranoid (-3,-1):(root=rwx,PCI_users=r-x,other=r--): -3

2) per-process CPU sampling with context switches and uncore counting:

	/proc/sys/kernel/perf_event_paranoid (-2, 2): 1|2
	SW.paranoid  (-3, 2):(root=rwx, SW_users=r-x,other=r--): -3
	CPU.paranoid (-3, 2):(root=rwx,CPU_users=r-x,other=r--): -3
	IMC.paranoid (-3,-1):(root=rwx,IMC_users=r-x,other=r--): -1
	UPI.paranoid (-3,-1):(root=rwx,UPI_users=r-x,other=r--): -1
	PCI.paranoid (-3,-1):(root=rwx,PCI_users=r-x,other=r--): -1

3) per-process user mode CPU sampling allowed to specific ${PMU}_groups only:

	/proc/sys/kernel/perf_event_paranoid (-2, 2): -2
	SW.paranoid  (-3, 2):(root=rwx, SW_users=r-x,other=r--):  2
	CPU.paranoid (-3, 2):(root=rwx,CPU_users=r-x,other=r--):  2
	IMC.paranoid (-3,-1):(root=rwx,IMC_users=r-x,other=r--): -3
	UPI.paranoid (-3,-1):(root=rwx,UPI_users=r-x,other=r--): -3
	PCI.paranoid (-3,-1):(root=rwx,PCI_users=r-x,other=r--): -3

4) uncore HW counters monitoring, possibly overtime:

	/proc/sys/kernel/perf_event_paranoid (-2, 2): -2
	SW.paranoid  (-3, 2):(root=rwx, SW_users=r-x,other=r--): -3
	CPU.paranoid (-3, 2):(root=rwx,CPU_users=r-x,other=r--): -3
	IMC.paranoid (-3,-1):(root=rwx,IMC_users=r-x,other=r--): -1
	UPI.paranoid (-3,-1):(root=rwx,UPI_users=r-x,other=r--): -1
	PCI.paranoid (-3,-1):(root=rwx,PCI_users=r-x,other=r--): -1

Please share more thought so that it eventually could go into 
Documentation/admin-guide/perf-security.rst.

Thanks,
Alexey
