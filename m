Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC18C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC5D20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC5D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeILVYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:24:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:2102 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbeILVYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:24:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 09:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,365,1531810800"; 
   d="scan'208";a="89415370"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2018 09:19:27 -0700
Received: from [10.252.21.7] (abudanko-mobl.ccr.corp.intel.com [10.252.21.7])
        by linux.intel.com (Postfix) with ESMTP id 91AFE580332;
        Wed, 12 Sep 2018 09:19:23 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC 0/4] perf: Per PMU access controls (paranoid setting)
To:     Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
 <27559444-ca88-2c04-c85c-613116e9e51f@linux.intel.com>
 <3361d8e1-50a0-2404-78cb-b83ca345b565@ursulin.net>
Organization: Intel Corp.
Message-ID: <ff85317a-ae72-8081-2c4d-e0567304ea0d@linux.intel.com>
Date:   Wed, 12 Sep 2018 19:19:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3361d8e1-50a0-2404-78cb-b83ca345b565@ursulin.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12.09.2018 11:41, Tvrtko Ursulin wrote:
> 
> On 12/09/18 07:52, Alexey Budankov wrote:
>>
>> Hi,
>>
>> Is there any plans or may be even progress on that so far?
> 
> It's hanging in the back of my mind. AFAIR after last round there was a build failure or two to fix on more exotic (to me) hardware, and Jiri Olsa provided a tools/perf snippet supporting the feature.
> 
> But essentially I haven't done any work on it since due not seeing the route to upstream. :( In other words, will someone review it and will that r-b make it have a chance of getting into some tree. If I had a clear statement from someone with authority in these aspects I would progress it, but otherwise it felt like it's not going anywhere.

Got you, Tvrtko, thanks!

Folks, are there any concerns still remain? design, review, testing?

Please let us known of any required assistance to move it forward.

Thanks,
Alexey

> 
> Regards,
> 
> Tvrtko
> 
> 
>> Thanks,
>> Alexey
>>
>> On 26.06.2018 18:36, Tvrtko Ursulin wrote:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>>
>>> For situations where sysadmins might want to allow different level of
>>> access control for different PMUs, we start creating per-PMU
>>> perf_event_paranoid controls in sysfs.
>>>
>>> These work in equivalent fashion as the existing perf_event_paranoid
>>> sysctl, which now becomes the parent control for each PMU.
>>>
>>> On PMU registration the global/parent value will be inherited by each PMU,
>>> as it will be propagated to all registered PMUs when the sysctl is
>>> updated.
>>>
>>> At any later point individual PMU access controls, located in
>>> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
>>> fine grained access control.
>>>
>>> Discussion from previous posting:
>>> https://lkml.org/lkml/2018/5/21/156
>>>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: x86@kernel.org
>>>
>>> Tvrtko Ursulin (4):
>>>    perf: Move some access checks later in perf_event_open
>>>    perf: Pass pmu pointer to perf_paranoid_* helpers
>>>    perf: Allow per PMU access control
>>>    perf Documentation: Document the per PMU perf_event_paranoid interface
>>>
>>>   .../sysfs-bus-event_source-devices-events     |  14 +++
>>>   arch/powerpc/perf/core-book3s.c               |   2 +-
>>>   arch/x86/events/intel/bts.c                   |   2 +-
>>>   arch/x86/events/intel/core.c                  |   2 +-
>>>   arch/x86/events/intel/p4.c                    |   2 +-
>>>   include/linux/perf_event.h                    |  18 ++-
>>>   kernel/events/core.c                          | 104 +++++++++++++++---
>>>   kernel/sysctl.c                               |   4 +-
>>>   kernel/trace/trace_event_perf.c               |   6 +-
>>>   9 files changed, 123 insertions(+), 31 deletions(-)
>>>
>>
> 
