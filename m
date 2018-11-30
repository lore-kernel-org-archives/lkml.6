Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D12C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB12E20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB12E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeK3LaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:30:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:19783 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3LaS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:30:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 16:22:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,296,1539673200"; 
   d="scan'208";a="96991412"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.44]) ([10.239.196.44])
  by orsmga008.jf.intel.com with ESMTP; 29 Nov 2018 16:22:54 -0800
Subject: Re: [PATCH v4 4/4] perf report: Documentation average IPC and IPC
 coverage
To:     Ingo Molnar <mingo@kernel.org>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1543505978-19808-1-git-send-email-yao.jin@linux.intel.com>
 <1543505978-19808-5-git-send-email-yao.jin@linux.intel.com>
 <20181129132746.GA8748@gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b14938e3-f318-baea-8159-5af5424d7bcf@linux.intel.com>
Date:   Fri, 30 Nov 2018 08:22:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181129132746.GA8748@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2018 9:27 PM, Ingo Molnar wrote:
> 
> * Jin Yao <yao.jin@linux.intel.com> wrote:
> 
>> Add explanations for new columns "IPC" and "IPC coverage" in perf
>> documentation.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/Documentation/perf-report.txt | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
>> index 474a494..e5a32f3 100644
>> --- a/tools/perf/Documentation/perf-report.txt
>> +++ b/tools/perf/Documentation/perf-report.txt
>> @@ -126,6 +126,14 @@ OPTIONS
>>   	And default sort keys are changed to comm, dso_from, symbol_from, dso_to
>>   	and symbol_to, see '--branch-stack'.
>>   
>> +	When the sort key symbol is specified, columns "IPC" and "IPC Coverage"
>> +	are enabled automatically. Column "IPC" reports the average IPC per function
>> +	and column "IPC coverage" reports the percentage of instructions with
>> +	sampled IPC in this function. IPC means Instruction Per Cycle. If it's low,
>> +	it indicates there may be performance bottleneck when the function is
>> +	executed, such as, memory access bottleneck. If a function has high overhead
>> +	and low IPC, it's worth further analysis for performance optimization.
> 
> Thank you for adding this!
> 
> Just a few small nits:
> 
> s/may be performance bottleneck
>   /may be a performance bottleneck
> 
> s/such as, memory access bottleneck
>   /such as a memory access bottleneck
> 
> s/it's worth further analysis for performance optimization.
>   /it's worth further analyzing it to optimize its performance.
> 
> ?
> 
> Other than that:
> 
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> 
> 	Ingo
> 

Thanks Ingo!

I will add these fixes in v5.

Thanks
Jin Yao
