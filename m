Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42435C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C8220815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfBDQSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:18:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:6101 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfBDQSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:18:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 08:18:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="119875558"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 04 Feb 2019 08:18:42 -0800
Received: from [10.254.84.37] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2EC4758044E;
        Mon,  4 Feb 2019 08:18:41 -0800 (PST)
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <d1161b7f-0f2c-4219-4f6d-225f12a333a2@linux.intel.com>
 <20190204161520.GI17528@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <bd2c7d89-e020-05ba-d2d6-516e76c68a6f@linux.intel.com>
Date:   Mon, 4 Feb 2019 11:18:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204161520.GI17528@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2019 11:15 AM, Peter Zijlstra wrote:
> On Mon, Feb 04, 2019 at 10:43:41AM -0500, Liang, Kan wrote:
>>> --- a/arch/x86/events/intel/ds.c
>>> +++ b/arch/x86/events/intel/ds.c
>>> @@ -1628,6 +1628,7 @@ void __init intel_ds_init(void)
>>>    	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
>>>    	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
>>>    	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>>> +	x86_pmu.pebs_no_isolation = 1;
>>
>> We will submit the Icelake support soon (probably next week).
>> That will be a problem for Icelake.
> 
> We can have ICL set it to 0 explicitly, but explicitly setting it to 1
> _11_ times is just silly.
> 
> Also, what perfmon version will ICL have? If it were to be 5 we could
> key off of that.
>

Right, we can use perfmon version here. I will apply it in V7.

Thanks,
Kan

